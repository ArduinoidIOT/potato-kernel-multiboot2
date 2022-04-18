
#include "multiboot2.h"


extern "C" void kernel_main (unsigned long magic, unsigned long addr)
{ 
    if (magic != MULTIBOOT2_BOOTLOADER_MAGIC) return; 
}