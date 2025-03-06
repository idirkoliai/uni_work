section .data
    a dd 10      
    b dd 20     
section .text
    global swap
    global _start
    extern show_registers
    extern show_stack

mult :
    xor rbx, rbx
    cmp rsi, 0
    je end
    push rdi
    dec rsi
    call mult
    pop rdi
    add rbx, rdi
    end:
        ret


_start:

    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor rbx, rbx
    mov rdi, 5
    mov rsi, 3
    call mult
    call show_registers
    mov rax, 60
    mov rdi, 0
    syscall
