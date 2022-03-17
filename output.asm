section .data

    array dd "1","2","3","4","5" ;сразу в аски код

    arraylen equ $ - array

section .text

    global _start:

_start:

    mov edx, arraylen
    mov ecx, array
    mov ebx, 1
    mov eax, 4
    int 80h

exit: 
    nop
    mov eax, 1
    mov ebx, 0
    int 80H