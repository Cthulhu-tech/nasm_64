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

convert:

mov bl, [res + esi]
dec cl
rol bl, cl
inc cl
add dl, bl
inc esi

loop convert

	mov ch,0        ; кол-во опвторений / кол-во разрядов
	mov al, dl      ; выводим 127
	mov bl, 10      ; делитель 2, чтобы получить двоичку
m1	                ; цикл деления на 10 числа в al
    inc ch          ; увеличиваем на 1 кол-во разрядов
    div bl          ; делим на 10, чтобы получить остаток
	mov dl,ah       ; сохраняем остаток от деления на 10 в dl
	push dx         ; записываем его в стек
	mov cl, al      ; сохраняем целове от деления на 10 в cl
	mov ah,0        ; обнуляем ah, где лежал остаток
    cmp al,0        ; сравниваем целое с 0
    jne m1          ; если не 0, то продолжаем деление
	
	
	
m2	                ; цикл вывода на экран
    mov eax,'0'     ; "обнуляем" eax
    mov [msg_2],eax   ; заносим в адрес сообщения '0'(или 48)
    pop dx          ; возвращаем последний остаток из стека в dx
    push cx         ; помещаем значение кол-ва делений в стек
	mov ax, [msg_2]   ; помещаем в eax адрес кода нуля
	sub eax, 48     ; вычитаем из него 48 (код ноля)
	add al,dl       ; прибавляем к нему остаток
	add ax, 48     ; прибавляем 48 (код ноля). Получаем новый код остатка
	mov [msg_2],ax   ; записываем его по адресу сообщения
	
	;вывод на консоль
	mov	edx, msg_len_2   ;message length
	mov	ecx, msg_2    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	
	pop cx          ; восстанавливаем из стека счетчик разрядов
    dec ch          ; уменьшаем его
    cmp ch,0        ; сравниваем с 0
    jne m2          
	mov	eax, 1
	int	0x80

exit:
nop
mov eax, 1
mov ebx, 0
int 80H

section .data

array_1 db 1, 1, 1
len_arr_1 equ $ - array_1

array_2 db 1, 1, 1
len_arr_2 equ $ - array_2

res db 0, 0, 0, 0
len_res equ $ - res

msg_1 db "000", 0xa
msg_len_1 equ $ - msg_1

msg_2 db '', 0xa
msg_len_2 equ $ - msg_2
