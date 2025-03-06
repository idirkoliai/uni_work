section .data
    a dd 10      
    b dd 20     
section .text
    global swap
    global _start
    extern show_registers
    extern show_stack

swap:
    push rbp
    mov rbp, rsp
    mov eax, [rdi]   
    mov ecx, [rsi]   
    mov [rdi], ecx   
    mov [rsi], eax   
    call show_stack     
    pop rbp
    ret

_start:
    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor rbx, rbx

    mov ebx, dword [a]
    mov r14d, dword [b]
    call show_registers
    call show_stack
    mov rdi, a
    mov rsi, b
    call swap
    mov ebx, [a]
    mov r14d, [b]
    call show_registers
    call show_stack

    mov rax, 60
    mov rdi, 0
    syscall
