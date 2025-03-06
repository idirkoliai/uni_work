; little_endian.asm
section .data
section .text
global _start
extern show_registers
extern square
_start:
    xor rbx, rbx
    xor r12, r12
    xor r13, r13
    xor r14, r14
    mov rdi,-6
    call square
    call show_registers
    mov rax,60
    mov rdi,0
    syscall
    
