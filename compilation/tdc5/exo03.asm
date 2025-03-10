section .text
global _start
extern show_registers
extern show_stack

my_putchar:
    sub rsp, 8
    mov byte [rsp], dil
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 8
    ret

_start:
    mov dil, 'b'
    call my_putchar
    mov rax, 60
    xor rdi, rdi
    syscall
