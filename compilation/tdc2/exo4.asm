section .text
global _start
extern show_registers
_start:
    xor rax, rax
    xor r12, r12
    xor r13, r13
    xor r14, r14
    mov rbx,-1
    loop:
        inc rbx
        cmp rbx,100
        jge exit
        printing:
            call show_registers
            jmp loop
    exit:
    call show_registers
	mov rax, 60
	mov rdi, 0
	syscall
