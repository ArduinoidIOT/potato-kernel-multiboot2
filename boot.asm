bits 32

section .text
extern main
global start

start:
        cli                      ;block interrupt
        mov esp, stack_space     ;set stack pointer
        call main
        hlt                    ;halt the CPU


section .bss
resb 8192                        ;8KB for stack
stack_space:

section .data
cpu_vendor: 
db "CPU vendor: "
cpu_info:
resb 12