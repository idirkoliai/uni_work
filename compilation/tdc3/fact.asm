; little_endian.asm
section .data
section .text
global _start
extern show_registers
_start:
    
    mov rbx,11
    mov r12,1

    loop :
    cmp rbx,1
    je end
    imul r12,rbx
    dec ebx
    jmp loop


    end :
    call show_registers
    mov rax,60
    mov rdi,0
    syscall
    
