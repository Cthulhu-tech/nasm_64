section .text
    global _start


_start:
    mov ecx , 12
    
ml: 
    mov eax, 0
    
il:
    inc ch
    dec ecx
    add eax, [arr+ebx]
    mov ah, 0
    inc ebx
    cmp ch, 6 ; делитель массива
        jne il
    mov ch, 0
    push ecx ; push для сохранения в стеке
    push ebx
    call write ;вызов с возвратом
    pop ebx
    pop ecx
    cmp ecx, 0
        jne ml
        
    mov	eax, 1
	int	0x80

write: 
    mov ecx, 0
    mov ebx, 10
    
    
m1:	                ; цикл деления на 10 числа в al
    inc ch          ; увеличиваем на 1 кол-во разрядов
    div bl          ; делим на 10, чтобы получить остаток
	mov dl,ah       ; сохраняем остаток от деления на 10 в dl
	push dx         ; записываем его в стек
	mov cl, al      ; сохраняем целове от деления на 10 в cl
	mov ah,0        ; обнуляем ah, где лежал остаток
    cmp al,0        ; сравниваем целое с 0
    jne m1          ; если не 0, то продолжаем деление
	
m2:	                ; цикл вывода на экран
    mov eax,'0'     ; "обнуляем" eax
    mov [msg],eax   ; заносим в адрес сообщения '0'(или 48)
    pop dx          ; возвращаем последний остаток из стека в dx
    push cx         ; помещаем значение кол-ва делений в стек
	mov ax, [msg]   ; помещаем в eax адрес кода нуля
	sub eax, 48     ; вычитаем из него 48 (код ноля)
	add al,dl       ; прибавляем к нему остаток
	add ax, 48     ; прибавляем 48 (код ноля). Получаем новый код остатка
	mov [msg],ax   ; записываем его по адресу сообщения
	
	;вывод на консоль
	mov	edx, len    ;message length
	mov	ecx, msg    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	
	pop cx          ; восстанавливаем из стека счетчик разрядов
    dec ch          ; уменьшаем его
    cmp ch,0        ; сравниваем с 0
    jne m2  
    ret
	
section	.data

arr db 8,1,1,4,5,6, ;25 или I ascii - 73 | 73 - 48 = 25
    db 16,5,4,3,2,2  ;32 или P ascii - 80 | 80 - 48 = 32
    
lenArr equ $ - arr

msg db '',0xa
len equ $ - msg
