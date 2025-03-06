
section .text
global _start
extern show_registers
_start:
	mov rbx,420
    mov r12,420
    call show_registers
    cmp rbx,r12
    jg greater
    je equal
    mov rax, 60
    mov rdi, -1
    jmp end
    equal:
        mov rax, 60
        mov rdi, 0
        jmp end
    greater: 
        mov rax, 60
        mov rdi, 1
    end:
	    syscall
