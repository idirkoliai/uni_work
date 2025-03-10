section .data
seq_numbers: dq -1, 2, 6, 3, 4, 22, 10, 0
length    equ $ - seq_numbers

section .text
global _start
extern show_registers
extern show_stack

_start:
    call process_sequence
    mov rax, 60  
    mov rdi, 0
    syscall

process_sequence:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    xor r12, r12
    xor r13, r13
    xor r14, r14
    mov rbx, 0
    mov r14, seq_numbers
    mov qword [rbp - 8], rbx  ; sum
    mov rbx, qword [r14 + 0]
    mov qword [rbp - 16], rbx ; min
    mov qword [rbp - 24], rbx ; max
    mov rax, length  
    sub rax, 8      
    xor rdx, rdx    
    mov rbx, 8 
    idiv rbx 
    mov rbx, rax     
    call show_registers   
    mov qword [rbp - 32], rbx ; length
    mov r12, 0
    call show_stack
    loop:
        cmp r12, qword [rbp - 32] 
        je end
        mov r13, qword [r14 + r12*8]
        add qword [rbp - 8], r13
        cmp r13, qword [rbp - 16]
        jl min
        cmp r13, qword [rbp - 24]
        jg max
        jmp next
        min:
            mov qword [rbp - 16], r13
            jmp next
        max:
            mov qword [rbp - 24], r13
        next:
            inc r12
            jmp loop
    end:
    pop rbx
    pop r12
    pop r13
    pop r14
    call show_registers
    call show_stack
    mov rsp, rbp
    pop rbp ;
    ret