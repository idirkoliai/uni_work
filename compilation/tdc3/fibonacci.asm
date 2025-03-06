; little_endian.asm
section .data
section .text
global _start
extern show_registers
_start:
    xor rdx,rdx
    xor rax,rax
    mov r14,8
    mov rbx,30
    imul r14,rbx
    mov r12,0
    mov rbx,0
    mov [rsp], rbx
    inc rbx
    mov [rsp + 8], rbx
    loop :
        cmp r12, r14
        je printing
        mov r13, qword [rsp+r12*8]
        add r13 , qword [rsp + r12*8+8]
        mov qword [rsp + r12*8+16], r13
        inc r12
        jmp loop
    printing:
        xor r12,r12
        xor r13,r13
        xor rbx,rbx
        loop2:
            cmp r12, 30
            jg end
            pop r13
            call show_registers
            inc r12
            jmp loop2
    end:
    mov rax,60
    mov rdi,0
    syscall
    
