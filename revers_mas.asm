section .data
    mas db 0,1,2,3,4,5,6,7,8,9
    msg db '',0xa
    msgLength equ $ - msg
section .text
    global _start:
_start:
    mov esi, 9 ;ДЛИНА МАССИВА
loops:
    Call stack
    mov edx, msgLength ;ДЛИНА MSG
    mov ecx, msg ;САМО СООБЩЕНИЕ
    mov ebx, 1
    mov eax, 4
    int 80h
    cmp esi, -1 ;ЕСЛИ НЕ КОНЕЦ МАССИВА ТО ПОВТОРЯЕМ ДЕЙСТВИЕ С ВЫВОДОМ ИНАЧЕ ПЕРЕХОДИМ К EXIT И ЗАВЕРШАЕМ ПРОГРАММУ
    jne loops
    jmp exit
stack:
    mov ecx, [mas + esi] ;ОБРАЩЕНИЕ К МАССИВУ
    add ecx, 48 ; ДОБАВЛЯЕМ ДЛЯ НОРМАЛЬНОГО ВЫВОДА 48
    mov [msg],ecx ;ЗАНОСИМ ЧИСЛО В MSG 
    dec esi ; УМЕНЬШАЕМ СЧЕТЧИК В ESI РЕГИСТРЕ
    ret
exit: 
    nop
    mov eax, 1
    mov ebx, 0
    int 80H
