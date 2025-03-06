section .data
    seq_numbers: dw 1, 2, 6, 3, 4, 5, 6,10, 7, 8, 9, 0
    seq_numbers_len: equ $-seq_numbers
section .text
    global _start
    extern show_registers
    _start:
        mov r12,seq_numbers_len
        sub r12,2
        mov r13,0
        loop:
            sub r12,2
            cmp r12,0
            jl exit
            mov bx ,word [seq_numbers+r12]
            cmp rbx,r13
            jg greater
            jmp show
            greater:
                mov r13,rbx
                show:
                call show_registers
                jmp loop
        exit:
            mov rax, 60
            mov rdi, 0
            syscall

