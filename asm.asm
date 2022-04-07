section .text
    global _start


_start:
    push 11
    mov edx, 5
    mov ecx, 0
    jmp iterable

state:
    mov ecx, 0 
    mov edx, -1
    
iterable:
    pop ebx
    mov eax, [arr + ebx]
    push ebx
    
subAdd:
    sub ebx, 1
    push ebx
    add ecx, eax
    
    cmp ebx, edx
    jne iterable
    je message

    
    
message:
    add ecx, '0'
    mov [msg], ecx
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    pop ebx
    push ebx
    cmp ebx, -1
    jne state


_exit:
    mov eax, 1
    int 0x80

section .data

arr db 8,1,1,4,5,6, ;25 или I ascii - 73 | 73 - 48 = 25
    db 16,5,4,3,2,2  ;32 или P ascii - 80 | 80 - 48 = 32
    
lenArr equ $ - arr

msg db '',0xa
len equ $ - msg
