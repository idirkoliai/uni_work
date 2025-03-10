section .text
global  _start
extern  show_registers
extern  show_stack

my_putchar:
    push rbp
    mov  rbp, rsp

    mov rcx, rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rsp, rbp
    pop rbp
    ret

my_getchar:
    push rbp
    mov  rbp, rsp

    sub rsp, 8
    mov rax, 0
    mov rdi, 0
    mov rsi, rsp
    mov rdx, 1
    syscall
    mov rax, rsp

    mov rsp, rbp
    pop rbp
    ret

my_getint :
    push rbp
    mov  rbp, rsp

    xor rcx, rcx
          push rax
        push rcx
        call my_getchar
        mov  rdi, 'a'
        call my_putchar
        pop  rcx
        pop  rax
    loop:
  
        cmp  rax, '0'
        jl   end
        cmp  rax, '9'
        jg   end
        sub  rax, 48
        imul rcx, 10
        add  rcx, rax
        jmp  loop
    end:
    mov rax, rcx

    mov rsp, rbp
    pop rbp
    ret

_start:
    xor  rdi, rdi
    ;test my_getchar
    call my_getchar
    ;test my_putchar
    mov  rdi, rax
    call my_putchar
    ;test my_getint
    ; call my_getint
     ;mov  rbx, rax
     ;call show_registers
    
    mov rax, 60
    xor rdi, rdi
    syscall