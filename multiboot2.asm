bits 32
%define MAGIC 0xE85250D6
%define FLAGS 0x00
%define HEADERLEN 16
%define CHECKSUM - (MAGIC + FLAGS + HEADERLEN)

section .multiboot2
dd MAGIC 
dd FLAGS
dd HEADERLEN
dd CHECKSUM