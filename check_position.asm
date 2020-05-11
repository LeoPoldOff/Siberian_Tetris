model	tiny
.386
.data

game_field:
	dw		0000h
	dw		0000h
	dw		0FFFFh
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

current_position:
		dw		0000h
		dw		0001h
		dw		0002h
		dw		0003h
	
saved_position:
		dw		9999h
		dw		8888h
		dw		7777h
		dw		5555h

current_rotate	dw		4 							;	1-straight, 	2-right, 	3-overturned, 	4-left
		
saved_rotate	dw		2

output_msg      db      '			'
number          db      '           '

table_figures:
	rotate_straight:
		figure_square	dw	0cc00h
		figure_dot 		dw	08000h
		figure_2dots	dw	0c000h
		figure_3dots	dw 	0e000h
		figure_triangle	dw	0c800h
		figure_g 		dw	0c880h
		figure_backg	dw	0c440h
		figure_pyramid	dw	04e00h
		figure_s 		dw	06c00h
		figure_backs	dw	0c600h
		figure_4dots	dw	0f000h
	rotate_right:
		right_figure_square		dw	0cc00h
		right_figure_dot 		dw	08000h
		right_figure_2dots		dw	08800h
		right_figure_3dots		dw 	08880h
		right_figure_triangle	dw	0c400h
		right_figure_g 			dw	0e200h
		right_figure_backg		dw	02e00h
		right_figure_pyramid	dw	08c80h
		right_figure_s 			dw	08c40h
		right_figure_backs		dw	04c80h
		right_figure_4dots		dw	08888h
	rotate_overturned:
		overturned_figure_square	dw	0cc00h
		overturned_figure_dot 		dw	08000h
		overturned_figure_2dots		dw	0c000h
		overturned_figure_3dots		dw 	0e000h
		overturned_figure_triangle	dw	04c00h
		overturned_figure_g 		dw	044c0h
		overturned_figure_backg		dw	088c0h
		overturned_figure_pyramid	dw	0e400h
		overturned_figure_s 		dw	06c00h
		overturned_figure_backs		dw	0c600h
		overturned_figure_4dots		dw	0f000h
	rotate_left:
		left_figure_square		dw	0cc00h
		left_figure_dot 		dw	08000h
		left_figure_2dots		dw	08800h
		left_figure_3dots		dw 	08880h
		left_figure_triangle	dw	08c00h
		left_figure_g 			dw	08e00h
		left_figure_backg		dw	00e800h
		left_figure_pyramid		dw	04c40h
		left_figure_s 			dw	08c40h
		left_figure_backs		dw	04c80h
		left_figure_4dots		dw	08888h

.code
org	100h
locals


_start:
    jmp     begin

begin:
	lea		ax,		[left_figure_square]
	mov		bx,		018Fh
	call	buffer_equalizer
	
    jmp     exit



; | input
; ax - pointer on new configuration
; bx - left upper border
; | output
; bx - new left upper border position
buffer_equalizer		proc near
	push	ax
	push	cx
	push	dx
	push	si

	mov		si,		ax
	lodsw

	mov		cx,		ax							;	Сохраним указатель на конфигурацию
	mov		dx,		bx							;	Сохраним текущий адрес ЛВУ
	shr		dx,		4							;	Получим номер строки
	call	get_height_configuration			;	Получим требуемое количество строчек
	add		ax,		dx
	cmp		ax,		24							;	Сравним
	jge		equ_height

	bfequ_continue:
		mov		ax,		cx
		mov		dx,		bx
		shl		dx,		12
		shr		dx,		12
		call	get_width_configuration
		add		ax,		dx
		cmp		ax,		16
		jge		equ_width
	jmp		bfeqret

	equ_height:									;	Если мало высоты
		mov		si,		24		

		mov		ax,		cx						;	Готовимся к вызову
		call	get_height_configuration
		sub		si,		ax
		
		shl		si,		4						;	Устанавливаем строку в нужном месте
		shl		bx,		12						;	Удаляем в текущем адресе номер строки
		shr		bx,		12
		add		bx,		si						;	Устанавливаем строку в готовом адресе

		jmp		bfequ_continue
	
	equ_width:
		mov		si,		16

		mov		ax,		cx						;	Готовимся к вызову
		call	get_width_configuration
		sub		si,		ax
		
		shr		bx,		4	
		shl		bx,		4
		add		bx,		si						;	Устанавливаем строку в готовом адресе
	bfeqret:
		pop		si
		pop		dx
		pop		cx
		pop		ax
		ret
buffer_equalizer		endp


; | input
; ax - configuration
; | ouput
; ax - height
get_height_configuration		proc near
	push	bx
	push	cx

	mov		bx,		ax
	shl		bx,		12
	shr		bx,		12
	cmp		bx,		0
	jne		h4ret

	mov		bx,		ax
	shr		bx,		4
	shl		bx,		12
	shr		bx,		12
	cmp		bx,		0
	jne		h3ret

	mov		bx,		ax
	shr		bx,		8
	shl		bx,		12
	shr		bx,		12
	cmp		bx,		0
	jne		h2ret

	jmp		h1ret

	h4ret:
		mov		ax,		4
		jmp		gthghtrt

	h3ret:
		mov		ax,		3
		jmp		gthghtrt

	h2ret:
		mov		ax,		2
		jmp		gthghtrt
	h1ret:
		mov		ax,		1
	gthghtrt:
		pop		cx
		pop		bx
		ret
get_height_configuration		endp


; | input
; ax - configuration
; | ouput
; ax - width
get_width_configuration		proc near
	push	bx
	push	cx
	push	dx
	push	si

	mov		bx,		ax
	shl		bx,		12
	shr		bx,		12

	mov		cx,		ax
	shr		cx,		4
	shl		cx,		12
	shr		cx,		12

	mov		si,		ax
	shr		si,		12
	shl		si,		12
	shr		si,		12

	mov		dx,		ax
	shr		dx,		8
	shl		dx,		12
	shr		dx,		12

	mov		ax,		dx
	call	function_or_for_four
	cmp		dx,		1
	je		gtwdth_4

	mov		dx,		ax
	shr		dx,		1
	shr		bx,		1
	shr		cx,		1
	shr		si,		1
	
	mov		ax,		dx
	call	function_or_for_four
	cmp		dx,		1
	je		gtwdth_3

	mov		dx,		ax
	shr		dx,		1
	shr		bx,		1
	shr		cx,		1
	shr		si,		1

	mov		ax,		dx
	call	function_or_for_four
	cmp		dx,		1
	je		gtwdth_2

	jmp		gtwdth_1

	gtwdth_4:
		mov		ax,		4
		jmp		gtwdth_ret
	gtwdth_3:
		mov		ax,		3
		jmp		gtwdth_ret
	gtwdth_2:
		mov		ax,		2
		jmp		gtwdth_ret
	gtwdth_1:
		mov		ax,		1
	gtwdth_ret:
		pop		si
		pop		dx
		pop		cx
		pop		bx
		ret
get_width_configuration		endp


;| input
; bx
; cx
; dx
; si
; | output
; dx - 0 or 1
function_or_for_four		proc near
	push	bx
	push	cx
	push	si
	
	shl		bx,		15
	shr		bx,		15

	shl		cx,		15
	shr		cx,		15

	shl		dx,		15
	shr		dx,		15

	shl		si,		15
	shr		si,		15

	cmp		bx,		1
	je		fnctnrffr_1

	cmp		cx,		1
	je		fnctnrffr_1

	cmp		dx,		1
	je		fnctnrffr_1

	cmp		si,		1
	je		fnctnrffr_1

	jmp		fnctnrffr_0

	fnctnrffr_1:
		mov		dx,		1
		jmp		fnctnrffr_ret
	fnctnrffr_0:
		mov		dx,		0
	fnctnrffr_ret:
		pop		si
		pop		cx
		pop		bx
		ret
function_or_for_four		endp		


; | input
; ax - pattern
; bx - left upper corner
; | output
; change buffer current_position
from_pattern			proc near
	push	cx
	push	dx
	push	si
	push	di

	add		bx,		30h
	mov		si,		ax
	lodsw
	lea		di,		[current_position]

	xor		cx,		cx
	from_pattern_loop:
		cmp		cx,		4
		je		frptrn_checker
		inc		cx

		mov		dx,		ax						;	ax - нам нужен

		shl		dx,		12
		shr		dx,		12						;	в dx оставляем младшие 4 бита

		cmp		dx,		8						;	Рисуем 4й бит
		jge		frmptrn_4_bit

		frmptrn_continue_3_bit:
			shl		dx,		13
			shr		dx,		13
			inc		bx							;	Увеличиваем адрес
			cmp		dx,		4					;	Рисуем 3й бит
			jge		frmptrn_3_bit

		frmptrn_continue_2_bit:
			shl		dx,		14
			shr		dx,		14
			inc		bx							;	Увеличиваем адрес
			cmp		dx,		2					;	Рисуем 2й бит
			jge		frmptrn_2_bit

		frmptrn_continue_1_bit:
			shl		dx,		15
			shr		dx,		15
			inc		bx							;	Увеличиваем адрес
			cmp		dx,		1					;	Рисуем 1й бит
			jge		frmptrn_1_bit
		

		frmptrn_continue:		

		sub		bx,		13h
		shr		ax,		4
		jmp		from_pattern_loop

	frmptrn_4_bit:
		push	ax
		mov		ax,		bx
		stosw
		pop		ax
		jmp		frmptrn_continue_3_bit

	frmptrn_3_bit:
		push	ax
		mov		ax,		bx
		stosw
		pop		ax
		jmp		frmptrn_continue_2_bit

	frmptrn_2_bit:
		push	ax
		mov		ax,		bx
		stosw
		pop		ax
		jmp		frmptrn_continue_1_bit

	frmptrn_1_bit:
		push	ax
		mov		ax,		bx
		stosw
		pop		ax
		jmp		frmptrn_continue

	frptrn_checker:
		lea		bx,		[saved_position]		;	Фигура может состоять из меньше, чем 4х точек. Остальные следует обнулить.
		cmp		di,		bx
		je		frptrn_ret
		mov		ax,		0FFFFh
		stosw
		jmp		frptrn_checker

	frptrn_ret:
		pop		di
		pop		si
		pop		dx
		pop		cx
		ret
from_pattern			endp



; | input
; ax - direction
; 0 = down, 1 = left, 2 = right, 3 = up
; | outpit
; change current_position
move_figure				proc near
	cmp		ax,		0							;	case-switch блок
	je		mvdwn
	cmp		ax,		1
	je		mvlft
	cmp		ax,		2
	je		mvrght
	cmp		ax,		3
	je		mvup

	mvdwn:										;	Вызов соответствующих функций
		call	move_down
		jmp		mvfgr
	mvlft:
		call	move_left
		jmp		mvfgr
	mvrght:
		call	move_right
		jmp		mvfgr
	mvup:
		call	move_up
	mvfgr:
		ret
move_figure				endp


; | input
; read buffers
; | output
; empty
move_up					proc near
	push	ax
	push	bx
	push	cx
	push	si
	push	di

	call	saved_configuration					;	Сохраняем текущее положение, на случай неудачи

	mov		cx,		4
	lea		si,		[current_position]
	lea		di,		[current_position]

	loop_move_up:								;	Двигаем каждый элемент current_position
		lodsw									;	Получаем адрес

		cmp		ax,		0FFFFh					;	Если пусто, то дальше тоже пусто
		je		chresup
		
		mov		bx,		ax
		shr		bx,		4
		cmp		bx,		0
		je		resconup						;	Если есть элемент с нулевой строчкой - всей фигуре выше не подняться
		
		dec		bx
		shl		bx,		4
		shl		ax,		12
		shr		ax,		12
		add		ax,		bx
		stosw									;	Поднимаем фигуру

		loop	loop_move_up
			
	chresup:
		call	check_position
		cmp		ax,		0
		je		mvupret							;	Проверяем, что получившая фигура не пересекает нигде нижнюю
	resconup:
		call	restore_configuration
	mvupret:
		pop		di
		pop		si
		pop		cx
		pop		bx
		pop		ax
		ret
move_up					endp


; | input
; read buffers
; | output
; empty
move_down					proc near
	push	ax
	push	bx
	push	cx
	push	si
	push	di

	call	saved_configuration

	mov		cx,		4
	lea		si,		[current_position]
	lea		di,		[current_position]

	loop_move_down:
		cmp		cx,		0
		je		chresdown
		dec		cx

		lodsw

		cmp		ax,		0FFFFh
		je		chresdown
		
		mov		bx,		ax
		shr		bx,		4
		cmp		bx,		18h
		je		rescondown
		
		inc		bx
		shl		bx,		4
		shl		ax,		12
		shr		ax,		12
		add		ax,		bx
		stosw

		jmp		loop_move_down
			
	chresdown:
		call	check_position
		cmp		ax,		0
		je		mvdownret
	rescondown:
		call	restore_configuration
	mvdownret:
		pop		di
		pop		si
		pop		cx
		pop		bx
		pop		ax
		ret
move_down					endp


; | input
; read buffers
; | output
; empty
move_right					proc near
	push	ax
	push	bx
	push	cx
	push	si
	push	di

	call	saved_configuration

	mov		cx,		4
	lea		si,		[current_position]
	lea		di,		[current_position]

	loop_move_right:
		lodsw

		cmp		ax,		0FFFFh
		je		chresright
		
		mov		bx,		ax
		shl		bx,		12
		shr		bx,		12
		cmp		bx,		0Fh
		jne		increment_right

		shr		ax,		4
		shl		ax,		4
		jmp		record_right	
		
		increment_right:
			inc		ax
		record_right:
			stosw

		loop	loop_move_right
			
	chresright:
		call	check_position
		cmp		ax,		0
		je		mvrightret
	resconright:
		call	restore_configuration
	mvrightret:
		pop		di
		pop		si
		pop		cx
		pop		bx
		pop		ax
		ret
move_right					endp


; | input
; read buffers
; | output
; empty
move_left					proc near
	push	ax
	push	bx
	push	cx
	push	si
	push	di

	call	saved_configuration

	mov		cx,		4
	lea		si,		[current_position]
	lea		di,		[current_position]

	loop_move_left:
		lodsw

		cmp		ax,		0FFFFh
		je		chresleft
		
		mov		bx,		ax
		shl		bx,		12
		shr		bx,		12
		cmp		bx,		0
		jne		decrement_left

		shr		ax,		4
		shl		ax,		4
		mov		bx,		0Fh
		add		ax,		bx
		jmp		record_left	
		
		decrement_left:
			dec		ax
		record_left:
			stosw

		loop	loop_move_left
			
	chresleft:
		call	check_position
		cmp		ax,		0
		je		mvleftret
	resconleft:
		call	restore_configuration
	mvleftret:
		pop		di
		pop		si
		pop		cx
		pop		bx
		pop		ax
		ret
move_left					endp



restore_configuration proc near	; transport saved position & configuration
	push ax						;to current position and configuration
	push bx

	lea bx, saved_position		; link to saved_position in bx

	mov ax, [bx]				; first dot from saved_position in ax
	lea bx, current_position	; link to current_position in bx
	mov [bx], ax 				; restore first dot from saved_configuration to current_position
	lea bx, saved_position

	mov ax, [bx + 2]			; second dot
	lea bx, current_position
	mov [bx + 2], ax
	lea bx, saved_position

	mov ax, [bx + 4]			; third dot 
	lea bx, current_position
	mov [bx + 4], ax
	lea bx, saved_position

	mov ax, [bx + 6]			; fourth dot
	lea bx, current_position
	mov [bx + 6], ax
	lea bx, saved_position

	lea bx, saved_rotate		; link to saved_rotate in bx
	mov ax, [bx]				; saved_rotate in ax
	lea bx, current_rotate		; link to current_rotate in bx
	mov [bx], ax 				; restore current_rotate from saved_rotate

	; lea bx, current_position  <==== testing
	; mov ax, [bx]
	; mov ax, [bx + 2]
	; mov ax, [bx + 4]
	; mov ax, [bx + 6]

	; lea bx, current_rotate
	; mov ax, [bx]              <==== testing


	pop bx
	pop ax
	ret
restore_configuration endp


saved_configuration proc near 	; transport current position & configuration
	push ax						; to saved position and configuration
	push bx						; the same as restore_configuration but on the other side

	lea bx, current_position

	mov ax, [bx]
	lea bx, saved_position
	mov [bx], ax
	lea bx, current_position

	mov ax, [bx + 2]
	lea bx, saved_position
	mov [bx + 2], ax
	lea bx, current_position

	mov ax, [bx + 4]
	lea bx, saved_position
	mov [bx + 4], ax
	lea bx, current_position

	mov ax, [bx + 6]
	lea bx, saved_position
	mov [bx + 6], ax

	lea bx, current_rotate
	mov ax, [bx]
	lea bx, saved_rotate
	mov [bx], ax

	; lea bx, saved_position  <==== testing
	; mov ax, [bx]
	; mov ax, [bx + 2]
	; mov ax, [bx + 4]
	; mov ax, [bx + 6]

	; lea bx, saved_rotate
	; mov ax, [bx]            <==== testing

	pop bx
	pop ax
	ret
saved_configuration 	endp


; | input
; read buffer
; | output
; ax - 0 (not intersection), 1 - exist intersection 
check_position				proc near
	push	bx
	push	cx
	push	si
	
	xor		bx,		bx
	lea		si,		[current_position]
	checker_loop:									;	Для каждой клеточки поля
		cmp		bx,		4						
		jge		checker_true
		inc		bx	
		lodsw
		cmp		ax,		0FFFFh						;	Если дальше то
		je		checker_true
		mov		cx,		ax
		call	move_pointer						;	Получаем соответствующую точке строку игрового поля
		call	transform_address					;	Получаем удобный для сравнения адрес точки
		and		al,		cl
		and		ah,		ch
		cmp		ax,		0
		jne		checker_false							;	Не повезло - выходим
		jmp		checker_loop						;	Продолжаем работу

	checker_true:
		mov		ax,		0
		jmp		checker_ret
	checker_false:
		mov		ax,		1
	checker_ret:
		pop		si
		pop		cx
		pop		bx
		ret
check_position				endp





; | input
; ax - address
; | output
; ax - value in game_field
move_pointer			proc near
	push	bx
	push	si
	lea		si,		[game_field]					;	Вытаскиваем адрес игрового поля
	mov		bx,		ax
	shr		bx,		4								;	Младшие байты отвечают за положение внутри строчки
	mov		ax,		0
	mov		al,		2
	mul		bx
	add		si,		ax	
	lodsw											;	Читаем из буфера
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
	push	bx
	
	shl		cx,		12
	shr		cx,		12
	
	xor		dx,		dx
	mov 	dx,		8000h							;	Для успешного использования операции AND, нужно инвертировать позицию
	
	loop_addr_transform:
		cmp		cx,		0
		je		tradret
		dec		cx

		shr		dx,		1
		jmp	loop_addr_transform
	
	tradret:
	mov		cx,		dx	

	pop		bx
	pop		dx
	ret
transform_address		endp


exit:
    db 		0eah
    dw 		7c00h,		0
    dw 0aa55h

end _start