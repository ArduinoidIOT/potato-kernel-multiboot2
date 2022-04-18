bits 32
extern start
%include "multiboot2_consts.asm"
%define ARCHITECTURE MULTIBOOT_ARCHITECTURE_I386
%define HEADERLEN (multiboot_header_end - multiboot_header_start)
%define CHECKSUM - (MULTIBOOT2_HEADER_MAGIC + ARCHITECTURE + HEADERLEN)


section .multiboot2
align 16
multiboot_header_start:
dd MULTIBOOT2_HEADER_MAGIC 
dd ARCHITECTURE
dd HEADERLEN
dd CHECKSUM
align 8


entry_address_tag_start:
dw MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS
dw 0
dd (entry_address_tag_end - entry_address_tag_start)
dd start
entry_address_tag_end:


align 8

; framebuffer_tag_start:
; dw MULTIBOOT_HEADER_TAG_FRAMEBUFFER
; dw 0
; dd (framebuffer_tag_end - framebuffer_tag_start)
; dd 0
; dd 0
; dd 0
; framebuffer_tag_end:


align 8
dw 0
dw 0
dd 8
multiboot_header_end:
