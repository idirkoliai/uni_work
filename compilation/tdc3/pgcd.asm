; little_endian.asm
section .data
section .text
global _start
extern show_registers
_start:
    
    mov rbx,75
    mov r12,125
    xor r13,r13
    loop : 
    xor rdx,rdx
    mov rax,rbx
    idiv r12
    cmp rdx,0
    je end
    mov r14,rbx
    mov rbx,r12
    mov r12,rdx
    jmp loop
    end :
    call show_registers
    mov rax,60
    mov rdi,0
    syscall
    
