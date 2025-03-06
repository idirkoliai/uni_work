section .text
global square
square:
    push rbp
    mov rbp, rsp
    mov eax, edi  
    imul eax, eax 
    mov ebx, eax
    pop rbp
    ret