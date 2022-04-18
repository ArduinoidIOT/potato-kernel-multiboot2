.section .text
.global start
.type start, @function 

start:
        cli                      
        mov $stack_top, %esp
        call main
        hlt  

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:
