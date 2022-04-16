bits 32
%define MAGIC 0x1BADB002
%define FLAGS 0x0

extern faulted_noMultiboot
extern check_multiboot

section .multiboot
    dd MAGIC
    dd FLAGS
    dd - (MAGIC + FLAGS)

section .text

check_multiboot:
        cmp eax, 0x2BADB002
        ret

