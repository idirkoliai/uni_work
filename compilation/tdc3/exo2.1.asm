section .data
seq_numbers: dq -1, 2, 6, 3, 4, 22, 10, 0
length    equ $ - seq_numbers

section .text
global _start
extern show_registers
extern show_stack

_start:
    xor r12, r12
    xor r13, r13
    xor r14, r14
    sub rsp, 32
    mov rbx, 0
    mov r14, seq_numbers
    mov qword [rsp + 8], rbx  ; sum
    mov rbx, qword [r14 + 0]
    mov qword [rsp + 16], rbx ;min
    mov qword [rsp + 24], rbx ;max
    mov rax, length  
    sub rax, 8      
    xor rdx, rdx    
    mov rbx,8 
    idiv rbx 
    mov rbx , rax     
    call show_registers   
    mov qword [rsp], rbx     ; length
    pop rbx
    call show_registers
    push rbx
    mov r12, 0
    call show_stack
    loop:
        cmp r12, qword [rsp] ; r12 < length
        je end
        mov r13, qword [r14 + r12*8]
        add qword [rsp + 8], r13
        cmp r13, qword [rsp + 16]
        jl min
        cmp r13, qword [rsp + 24]
        jg max
        jmp next
        min:
            mov qword [rsp + 16], r13
            jmp next
        max:
            mov qword [rsp + 24], r13
        next:
            inc r12
            jmp loop
    end:
    pop rbx
    pop r12
    pop r13
    pop r14
    call show_stack
    call show_registers
    mov rax, 60  
    mov rdi, 0
    syscall
