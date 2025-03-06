; registers.asm
; registres, chevauchements
section .text
global _start
extern show_registers
_start:
	mov rbx, 2
	mov r12, 10
	mov r13, 0
	mov r14, 0
	call show_registers
	add rbx, r12
	call show_registers
	add bl, 2
	call show_registers
	mov ebx, 256
	call show_registers
    mov rax, 0
	mov al,  bh
	mov r13, rax
	call show_registers
	add bh, 1
	call show_registers
	mov rax, 60
	mov rdi, 0
	syscall
