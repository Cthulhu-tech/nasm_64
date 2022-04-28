section	.text
	global _start
_start:
    mov esi, array_1
    mov ecx, len_arr_1

stack_push_1:   	
    lodsb
    push ax
    loop stack_push_1
    
mov esi, 0
mov ecx, len_arr_2

_add_two_array:
    
    pop ax
    add ax, [array_2 + esi]
    inc esi
    mov [res + esi], ax
    loop _add_two_array

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


section	.data

array_1 db 1, 1, 1
len_arr_1 equ $ - array_1

array_2 db 1, 1, 1
len_arr_2 equ $ - array_2

res db 0, 0, 0, 0
len_res equ $ - res

msg	db	'', 0xa
msg_len	equ	$ - msg