section .text
global _start
_start:
    mov esi, 0
    mov ecx, len_arr_1

_add_two_array:

    mov eax, 0
    add al, [array_1 + esi]
    add al, [array_2 + esi]
    inc esi
    mov [res + esi], ax
    loop _add_two_array

mov esi, len_res - 1

_check:
    Call update

    dec esi
    cmp esi, -1
    jne _check
    jmp output_set

update:
    mov ebx, 2
    cmp [res + esi], bl 
    jge return

    ret
    
return:

    sub [res + esi], bl
    mov ebx, 1
    add [res + esi - 1], bl
    ret

output_set:
    mov esi, 0
    mov ecx, len_res

output:

    push ecx
    
    mov ecx, [res + esi]
    inc esi
    add ecx, 48
    mov [msg], ecx
    mov edx, msg_len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

pop ecx

    loop output

exit:
    nop
    mov eax, 1
    mov ebx, 0
    int 80H

section .data

array_1 db 1, 1, 0
len_arr_1 equ $ - array_1

array_2 db 0, 1, 1
len_arr_2 equ $ - array_2

res db 0, 0, 0, 0
len_res equ $ - res

msg db '', 0xa
msg_len equ $ - msg
