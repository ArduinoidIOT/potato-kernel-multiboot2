bits 32
default rel

section .text
extern kernel_main
global start

start:
        cli                      ;block interrupt
        mov esp, stack_space     ;set stack pointer
        push ebx
        push eax
        call kernel_main
        hlt


section .bss
resb 8192                        ;8KB for stack
stack_space: