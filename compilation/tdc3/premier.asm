; little_endian.asm
section .data
section .text
global _start
extern show_registers
_start:
    
    mov rbx,11
    mov rax,rbx
    xor rdx,rdx
    mov r14,2
    idiv r14
    cmp rdx,0
    je not_prime
    mov r13,rax
    inc r14
    loop : 
        cmp r14,r13
        jg prime
        mov rax,rbx
        xor rdx,rdx
        div r14
        cmp rdx,0
        je not_prime
        inc r14
        jmp loop
    prime:
        mov r12,1
        jmp end
    not_prime:
        mov r12,0
    end:
    call show_registers
    mov rax,60
    mov rdi,0
    syscall
    