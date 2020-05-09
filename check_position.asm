model	tiny
.data

game_field:
	dw		0000h
	dw		0001h
	dw		0002h
	dw		0003h
	dw		0004h
	
	dw		0005h
	dw		0006h
	dw		0007h
	dw		0008h
	dw		0009h
	
	dw		000Ah
	dw		000Bh
	dw		000Ch
	dw		000Dh
	dw		000Eh
	
	dw		0FFFFh
	dw		0010h
	dw		0011h
	dw		0012h
	dw		0013h
	
	dw		0014h
	dw		0015h
	dw		0016h
	dw		0017h
	dw		0018h

current_position:
		dw		00FCh
		dw		00FDh
		dw		00FEh
		dw		0FFFFh
	
saved_position:
		dw		9999h
		dw		8888h
		dw		7777h
		dw		5555h

current_rotate	dw		4 							;	1-straight, 	2-right, 	3-overturned, 	4-left
		
saved_rotate	dw		2

output_msg      db      '			'
number          db      '           '

.code
org	100h
locals


_start:
    jmp     begin

begin:
	mov		cx,		00F2h
	call	transform_address
	mov		ax,		cx
	call	num2buf
	call	print_string
	
	cycle_1:			
			xor		ah,		ah
			int		16h									; читаем с клавиатуры символ
			cmp		ah,		1h
			je   	cycle_1
			
	mov		cx,		00F2h
	call	move_pointer
	call	num2buf
	call	print_string
	
	cycle_2:			
			xor		ah,		ah
			int		16h									; читаем с клавиатуры символ
			cmp		ah,		1h
			je   	cycle_2
	
	call	check_position
	call	num2buf
    cycle:
			call	print_string
			
			xor		ah,		ah
			int		16h									; читаем с клавиатуры символ
			cmp		ah,		1h
			je   	cycle
    jmp     exit


; | input
; output_msg - input string
; | output
; print in console
print_string                proc near
    push    ax
    push    cx
    push    es
    push    di
    push    si

    mov     ax,     0b800h
    mov     es,     ax
    mov     di,     660
    xor     ax,     ax
    mov     cx,     11
    mov     si,     offset output_msg

    loop_1:
        lodsb
        mov     ah,     7
        stosw
        loop loop_1

    pop     si
    pop     di
    pop     es
    pop     cx
    pop     ax
    ret
print_string                endp


; | input
; read buffer
; | output
; ax - 0 (not intersection), 1 - exist intersection 
check_position				proc near
	push	bx
	push	cx
	push	si
	
	xor		ax,		ax
	xor		cx,		cx
	xor		bx,		bx
	lea		si,		[current_position]
	checker_loop:									;	Для каждой клеточки поля
		cmp		bx,		4						
		jge		checker_ret
		inc		bx
		
		lodsw	
		mov		cx,		ax
		mov		ax,		0							;	Предполагаем, что всё-таки нам не повезло и клеточка заезжает на поле
		cmp		cx,		0FFFFh						;	Если дальше то
		je		checker_ret
		
		call	move_pointer						;	Получаем соответствующую точке строку игрового поля
		
		call	transform_address					;	Получаем удобный для сравнения адрес точки
		and		cx,		ax
		
		mov		ax,		1
		cmp		cx,		0
		jne		checker_ret							;	Не повезло - выходим
		xor		ax,		ax
		jmp		checker_loop						;	Продолжаем работу
	
	checker_ret:
		pop		si
		pop		cx
		pop		bx
	ret
check_position				endp


; | input
; cx - address
; | output
; ax - value in game_field
move_pointer			proc near
	push	bx
	push	si
	
	lea		si,		[game_field]					;	Вытаскиваем адрес игрового поля
	mov		bx,		cx
	shr		bx,		4								;	Младшие байты отвечают за положение внутри строчки
	
	move_pointer_loop:
		cmp		bx,		0
		je		move_pointer_ret
		lea		si,		[si + 2]					;	Сдвигаем на два байта указатель, столько раз, сколько надо
		dec		bx
		jmp		move_pointer_loop
		
	move_pointer_ret:
		lodsw										;	Читаем из буфера
		pop		si
		pop		bx
		ret
		
move_pointer			endp


; | input
; cx - address
; | output
; cx - transformed address
transform_address		proc near
	push	dx
	
	shl		cx,		12
	shr		cx,		12
	
	xor		dx,		dx
	mov 	dx,		1000000000000000b				;	Для успешного использования операции AND, нужно инвертировать позицию
	
	loop_addr_transform:
		shr		dx,		1
		loop	loop_addr_transform
	
	mov		cx,		dx	
	addr_tranform_ret:
		pop		dx
		ret
transform_address		endp


; | input
; ax - number
; | output
; output_msg
num2buf proc near
    push    bx
    push    cx
    push 	dx
    push    es
    push    di
    push    si

    mov     si,     offset output_msg
    mov cx, 5

    loopn2b:
    	cmp ax, 0
    	xor dx, dx
    	mov bx, 10
    	div bx
    	push ax
    	mov ax, dx
    	call int2str16onedigit
    	pop dx
    	push ax
    	mov ax, dx
    	loop loopn2b

	pop ax
	mov		[si],	ax
	pop ax
	mov		[si + 1],	ax
	pop ax
	mov		[si + 2],	ax
	pop ax
	mov		[si + 3],	ax
	pop ax
	mov		[si + 4],	ax

    pop     si
    pop     di
    pop     es
    pop		dx
    pop     cx
    pop		bx
    ret
num2buf endp

int2str16onedigit proc near ; num in al, res in al
	push bx
	push cx
	push dx

	mov cl, al
	mov dl, al
	shr cl, 4
	and dl, 0fh
	add cl, 30h
	add dl, 30h
	cmp cl, 39h
	jg @@4
@@6:
	cmp dl, 39h
	jg @@5
	jmp @@7
@@4:
	add cl, 7h
	jmp @@6
@@5:
	add dl, 7h
@@7:
	mov al, dl

	pop dx
	pop cx
	pop bx
	ret
int2str16onedigit endp


exit:
    db 		0eah
    dw 		7c00h,		0
    org 766
    dw 0aa55h

end _start