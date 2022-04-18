
.PHONY: clean all builddir iso
# export PATH = "/usr/local/bin:/usr/bin:/usr/local/sbin:/opt/cuda/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/cross/bin/"

CPPFLAGS=
CFLAGS=
asmobjects = boot.o multiboot2.o
hppfiles = 
cppfiles =
cfiles = main.o
objects = $(hppfiles) $(cppfiles) $(asmobjects) $(cfiles)

all: iso

builddir:
	@mkdir build 2>/dev/null || true

$(hppfiles): %.o: %.cpp %.hpp
	@i686-elf-g++ -c $< -o $@ $(CPPFLAGS)

$(cppfiles): %.o: %.cpp
	@i686-elf-g++ -c $< -o $@ $(CPPFLAGS)

$(asmobjects): %.o: %.asm
	@nasm -f elf32 $< -o $@

$(cfiles): %.o: %.c
	@i686-elf-gcc -c $< -o $@ $(CFLAGS)

kernel: builddir $(objects)
	@i686-elf-ld -T linker.ld -o build/kernel $(objects) 
	# @strip build/kernel

iso: kernel
	@mkdir -p build/iso/boot/grub
	@cp build/kernel build/iso/boot/
	@cp grub.cfg build/iso/boot/grub/
	@grub-mkrescue -o build/my-kernel.iso build/iso/

run: iso
	qemu-system-x86_64                             \
	-accel kvm                       			   \
	-cpu host                                  	   \
	-m 128                                         \
	-no-reboot                                     \
	-drive format=raw,media=cdrom,file=build/my-kernel.iso    \
	-serial stdio                                  \
	-smp 1                                         \
	-usb                                           \
	-vga std

debug: iso
	qemu-system-x86_64   -s -S                     \
	-accel kvm                       			   \
	-cpu host                                      \
	-m 128                                         \
	-no-reboot                                     \
	-drive format=raw,media=cdrom,file=build/my-kernel.iso    \
	-serial stdio                                  \
	-smp 1                                         \
	-usb                                           \
	-vga std
clean:
	@rm -rf build
	@rm -rf *.o kernel *.iso
