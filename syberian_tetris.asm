model	tiny
.386
.data

victory1       db      '!YOU`RE OUR NEW WINNER!'
victory2       db      '!!!TRUE SIBERIAN VICTORY!!!'
gameOver1      db      '!GAME OVER!'
gameOver2      db      '!!!I KNOW YOU CAN DO IT BETTER!!!'

menu1          db      '   /\       TTTTTT  EEEEEE  TTTTTT  RRRRR    IIIIII   SSSS  '; 23 698
menu2          db      '  /||\        TT    EE        TT    RR   RR    II    SS   SS'; 38 844
menu3          db      ' //||\\       TT    EEEEEE    TT    RR RR      II      S    '; 30, 1012
menu4          db      '   ||         TT    EE        TT    RR   R     II  SS   SS  '; 30, 1012
menu5          db      'SIBERIAN      TT    EEEEEE    TT    RR   RR  IIIIII  SSSS   '; 30, 1012
menu6          db      'NEW GAME'
menu7          db      'KEY CONFIGURATION' 
menu8          db      'CAPTIONS'
menu9          db      'EXIT'
menu10         db      'MAY 2020'
menu11         db      'L@G inc.'
dotChoicer     db      '*'
space          db      ' '
cap1           db      'Hello, Siberian Player!(press any key)'; 23 698
cap2           db      'Your game was BRILLIANT and AMAZING!!!'; 38 844
cap3           db      'We`re hoping to see you again.'; 30, 1012
cap4           db      'This pale copy of Tetris was developed by'; 34 1168
cap5           db      'L@G inc.' ; 9 1352
cap6           db      'DEVELOPERS:'; 11 1510
cap7           db      '@D-rection' ; 10 1670
cap8           db      '@LeoPoldOff'; 11 1830
cap9           db      '@AgaFFon'; 8 1990
cap10          db      'Thank you for playing'; 21 2140
cap11          db      '$$$THE COOLEST TETRIS IN THE JUNGLE$$$'; 38 2284
conf1          db      '1-9    = TO CHANGE SPEED MODE OF FALLING'
conf2          db      'arrows = TO MOVE THE FIGURE'
conf3          db      's      = TO STOP'
conf4          db      'w      = TO PAUSE'
conf5          db      'space  = TO DROP THE FIGURE'
conf6          db      'a/d    = TO TURN THE FIGURE LEFT/RIGHT'
conf7          db      'q/e    = TO DECREASE/INCREASE SPEED OF FALLING'
conf8          db      'n      = TO START NEW GAME'
conf9          db      'b      = TO END'

choice         dw      1; 1-new game, 2-config, 3-capt, 4-exit

pointsBuf 			dw 		7

output_msg      db      '54321'
game_field:
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h
	dw		0000h

current_position:
		dw		0170h
		dw		0171h
		dw		0172h
		dw		0173h
	
saved_position:
		dw		9999h
		dw		8888h
		dw		7777h
		dw		5555h

current_figure	dw 		11
; 1 - square
; 2 - dot
; 3 - two dots
; 4 - three dots
; 5 - triangle
; 6 - g
; 7 - back g
; 8 - pyramid
; 9 - s
; 10 - back s
; 11 - four dots
next_figure 	dw 		11
current_color	dw 		1
; 1 - red
; 2 - orange
; 3 - yellow
; 4 - green
; 5 - blue
; 6 - purple
; 7 - brown

next_color 		dw 		5
current_rotate	dw		1 		; 1-straight, 2-right, 3-overturned, 4-left		
saved_rotate	dw		1		; 1-straight, 2-right, 3-overturned, 4-left

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


	; Блок с используемыми буферами
	theend	db		0			
	buf		db		10 dup (0)					;	Зарезервировали 10 байт и поместили туда 0
	bufend:										;	Метка
		head	dw		offset buf
		tail	dw		offset buf
	
	exit_flag	db		0
	tick	db	0
	pause	db	0
	speed	db	008h

.code
org	100h
locals


_start:
    jmp     begin

change_vectors		proc near
	push	ax
	push	si
	push	di
	push	ds

	xor		ax, 	ax						
	mov		ds, 	ax						;	Закидываем смещение в ds. Используем чуть позже

	mov		si, 	36						;	В 36 и 38 байте хранится вектор: (адрес, сегмент) обработчика клавиатуры
	mov		di, 	offset old9				;	Сохраняем старые указатели в old9
	movsw
	movsw
											
											;	В 32 и 34 байте хранится вектор: (адрес, сегмент) обработчика таймера
	mov		di, 	offset old8				;	Сохраняем старые указатели в old8
	mov		si, 	32
	movsw
	movsw

	cli										;	Атомарная операция которая что-то делает
	mov		ax, 	offset int9
	mov		ds:36, 	ax						;	Закидываем адрес 
	mov		ax, 	cs						
	mov		ds:38, 	ax						;	Закидываем сегмент
	mov		ax, 	offset int8
	mov		ds:32, 	ax						;	Закидываем адрес
	mov		ax, 	cs
	mov		ds:34, 	ax						;	Закидываем сегмент
	sti										;	Теперь обработчики делают то, что мы написали в этой программе

	pop		ds
	pop		di
	pop		si
	pop		ax

	ret
change_vectors endp


restore_vectors		proc near
	push	ax
	push 	si
	push	di
	push 	es
	push	ds

	xor		ax, 	ax
	mov		es,		ax
	push	cs
	pop		ds

	mov		si, 	offset old9				;	Устанавливаем указатель на старый обработчик 
	mov		di, 	36						;	Указываем адрес

	cli										;	Возвращаем всё на место
	movsw
	movsw
	sti										;	Вернули

	mov		si, 	offset old8				;	Устанавливаем указатель	
	mov		di, 	32						;	Указываем адрес

	cli										;	Возвращаем всё на место
	movsw
	movsw
	sti										;	Вернули

	pop		ds
	pop		es
	pop		di
	pop		si
	pop		ax
	ret
restore_vectors endp


; | input
; empty
; | output
; al - scancode последней нажатой клавиши
read_buf	proc near						;	Чтение из буфера
	push	bx

	mov		bx, 	head
	mov		al, 	byte ptr ds:[bx]
	inc		bx
	cmp		bx, 	offset bufend
	jnz		@@1
	mov		bx, 	offset buf
@@1:
	mov		head, 	bx

	pop		bx
	ret
read_buf endp


; | input
; ax - сканкод нажатой клавиши
; | output
; Помещаем в буфер сканкод
write_buf	proc near						;	Задаём процедуру записи в кольцевой буфер
	push	di								;	Сохраняем в стек нужные регистры
	push	bx
	push	bp
	
	mov		di,		 cs:tail				;	???
	mov		bx, 	di
	inc		di
	cmp		di, 	offset bufend
	jnz		@@1								;	Если мы были на последнем байте буфера, переходим на первый
	mov		di, 	offset buf
@@1:
	mov		bp, 	di
	cmp		di, 	cs:head					;	Если буфер переполнен - ничего не делаем
	jz		@@9
	mov		di,		bx
	mov		byte ptr cs:[di], 	al			
	mov		cs:tail,	 bp					;	Производим запись и сдвигаем указатели
@@9:										;	Успешно что-то записали в буфер
	pop		bp
	pop		bx
	pop		di
	ret
write_buf endp


int9 proc near								;	Предположительно здесь лежит обработчик нажатий на клавиши
	push	ax
	in		al,		60h						;	Читаем в al с 60h порта сканкод последней нажатой клавиши
	call	write_buf						;	Записываем результат в кольцевой буфер
	in		al, 	61h						;	Эм, 61h управляет работой другими устройствами, в том числе клавой
	mov		ah,		al						;	Сохраняем, что лежало в 61h порту
	or		al,		80h						;	al = al OR [значение, которое лежит в порте ввода/вывода]
	out		61h, 	al						;	Устанавливает в 1 бит 7 порта 61h, разрешая дальнейшую работу клавиатуры
	mov		al,		ah						;	Восстанавливаем al
	out		61h,	al						;	Возвращает этот бит в исходное состояние
	mov		al,		20h
	out		20h,	al						;	Записывает в порт 20h значение 20h для правильного завершения обработки аппаратного прерывания
	pop	ax
	iret									;	Возврат из прерывания при 16-битном размере операнда 
int9 endp
old9	dw		0,	 0


int8	proc near							;	Модифицируем обработчик прерывания на таймере
	push	ax
	push	si
	push	di
											
	xor		ax,		ax						;	Читаем из tick
	lea		si,		[tick]
	lodsb

	inc		ax								;	Увеличиваем значение счётчика
	lea		di,		[tick]
	stosb									;	Складываем увеличение счётчика обратно
	xor		ax,		ax

	lea		si,		[pause]
	lodsb

	cmp		al,		0						;	Обработка паузы
	jne		@@231
	
	call	count_rest
	cmp		ax,		0						;	В зависимости от скорости происходит сдвиг вниз
	je		@@down_shift

	jmp		@@231							;	Отправляемся на выход
@@down_shift:
	call	down_shift	
@@231:
	call	tick_equalizer
	pop		di
	pop		si
	pop		ax
	db		0eah
	old8	dw	0, 0							;	Откат изменений
int8 endp


tick_equalizer			proc near				;	Обнуляем таймер
	push	si
	push	di
	push	ax

	xor		ax,		ax
	lea		si,		[tick]
	lodsb

	cmp		ax,		180
	jne		to_exit

	lea		di,		[tick]
	xor		ax,		ax
	stosb

	to_exit:
		pop		ax
		pop		di
		pop		si
		ret
tick_equalizer			endp


; | input
; read buffers
; | output
; ax - result
count_rest			proc near
	push	bx
	push	dx
	push	si

	lea		si,		[speed]
	lodsb									;	Получаем текущую скорость

	mov		bx,		ax

	lea		si,		[tick]
	lodsb									;	Получаем текущий удар

	xor		dx,		dx
	div		bx

	mov		ax,		dx						;	Сохраняем его

	pop		si
	pop		dx
	pop		bx
	ret
count_rest			endp


; | input
; al - scancode key
; | output
; buffers
game_model			proc near
	push	bx
	push	cx
	push	si
	push	di

	cmp		al,		01h
	je		gm_exit

	cmp		al,		0Ah
	jbe		gm_speed_changes

	cmp		al,		0C8h
	je		gm_move_up

	cmp		al,		0CBh
	je		gm_move_left

	cmp		al,		0D0h
	je		gm_move_down

	cmp		al,		0CDh
	je		gm_move_right

	cmp		al,		01Fh
	je		gm_stop

	cmp		al,		011h
	je		gm_pause

	cmp		al,		039h
	je		gm_drop

	cmp		al,		01Eh
	je		gm_rotate_left

	cmp		al,		20h
	je		gm_rotate_right

	cmp		al,		010h
	je		gm_speed_minus

	cmp		al,		012h
	je		gm_speed_plus

	cmp		al,		011h
	je		gm_new_game

	jmp		gmmdl_ret

	gm_speed_changes:
		dec		al
		mov		ah,		0

		xor		bx,		bx
		mov		bl,		10
		sub		bl,		al
		mov		al,		bl

		mov		bl,		2
		mul		bl

		lea		di,		[speed]
		stosb
		call	print_speed

		jmp		gmmdl_ret

	gm_move_up:
		mov		ax,		3
		call	move_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_move_left:
		mov		ax,		1
		call	move_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_move_down:
		mov		ax,		0
		call	move_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_move_right:
		mov		ax,		2
		call	move_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_stop:
		mov		ax,		2
		lea		di,		[pause]
		stosb
		jmp		gmmdl_ret

	gm_pause:
		lea		si,		[pause]
		lodsb
		cmp		al,		0
		je		_to_pause

		mov		ax,		0
		lea		di,		[pause]
		stosb
		jmp		gmmdl_ret

		_to_pause:
			mov		ax,		1
			lea		di,		[pause]
			stosb
			jmp		gmmdl_ret

	gm_drop:
		call	move_down
		lea		si,		[current_position]
		lodsw
		mov		bx,		ax
		lea		si,		[saved_position]
		lodsw
		cmp		ax,		bx
		jne		gm_drop
		
		call	down_shift
		jmp		gmmdl_ret


	gm_rotate_left:
		mov		ax,		0
		call	rotate_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_rotate_right:
		mov		ax,		1
		call	rotate_figure
		call	draw_field_and_cur_pos
		jmp		gmmdl_ret

	gm_speed_minus:
		lea		si,		[speed]
		lodsb

		dec		ax
		dec		ax

		lea		di,		[speed]
		stosb

		call	print_speed
		jmp		gmmdl_ret

	gm_speed_plus:
		lea		si,		[speed]
		lodsb

		inc		ax
		inc		ax

		lea		di,		[speed]
		stosb

		call	print_speed
		jmp		gmmdl_ret
	gm_new_game:
		lea		di,		[exit_flag]	
		mov		ax,		3
		stosb
		jmp		gmmdl_ret
	gm_exit:
		lea		di,		[exit_flag]	
		mov		ax,		2
		stosb
	gmmdl_ret:
		pop		di
		pop		si
		pop		cx
		pop		bx
		ret
game_model			endp


down_shift			proc near
	push	ax
	push	bx
	push	cx
	push	si

	call	move_down

	lea		si,		[current_position]
	lodsw
	mov		bx,		ax

	lea		si,		[saved_position]
	lodsw

	cmp		ax,		bx
	jne		dwnsft_ret

	call	integrate_figure     
	call	search_lines 		 
	call	create_new_figure 
	call	randomizer

	call	check_position
	cmp		ax,		0
	je     	dwnsft_ret
	
	mov		al,		2
	lea		di,		[exit_flag]
	stosb

	dwnsft_ret:
		call	draw_field_and_cur_pos
		call	draw_next_figure	
		pop		si
		pop		cx
		pop		bx
		pop		ax
		ret
down_shift			endp


; | input
; empty. read buffer
; | output
; 
; change buffers
randomizer			proc near
	push	ax
	push	bx
	push	si
	push	di
	push	dx

	mov		di,		0
	
	bomb_checker:
	cmp		di,		3
	je		bomb_bomb_bomb

	mov		ax,		0
	int		1ah

	mov		ax,		dx
	mov		bx,		dx
	xor		dx,		dx

	mov		cx,		12					;	Получаем фигуру
	div		cx
	
	inc		di
	cmp		ax,		11
	je		bomb_checker

	bomb_bomb_bomb:

	mov		cx,		dx

	mov		ax,		bx					;	Получаем цвет
	xor		dx,		dx
	mov		bx,		7
	div		bx

	mov		bx,		dx
	mov		ax,		cx
	inc		ax
	lea		di,		[next_figure]
	stosw

	mov		ax,		bx
	inc		ax
	lea		di,		[next_color]
	stosw

	pop		dx
	pop		di
	pop		si
	pop		bx
	pop		ax
	ret
randomizer			endp


create_new_figure		proc near
	push	si
	push	di
	push	ax
	push	bx

	lea		si,		[next_figure]
	lea		di,		[current_figure]
	movsw

	lea		si,		[next_color]
	lea		di,		[current_color]
	movsw

	mov		ax,		1
	lea		di,		[current_rotate]
	stosw

	lea		si,		[current_figure]
	lodsw
	dec		ax

	cmp		ax,		11
	je		bomb_has_been_planted

	lea		si,		[figure_square]
	add		si,		ax
	add		si,		ax
	mov		ax,		si
	mov		bx,		08h
	call	from_pattern
	jmp		crtnw_ret

	bomb_has_been_planted:
		lea		ax,		[figure_dot]
		mov		bx,		08h
		call	from_pattern

	crtnw_ret:
		pop		bx
		pop		ax
		pop		di
		pop		si
		ret
create_new_figure		endp


; | input
; buffers pause
; |output
; buffers pause
stop_menu			proc near
	push	ax
	push	bx
	push	si
	push	di

	cmp		al,		01Fh						;	Если СТОП - то только по n выходим
	jne		stop_menu_ret

	xor		ax,		ax
	lea		di,		[pause]
	stosb

	stop_menu_ret:
		pop		di
		pop		si
		pop		bx
		pop 	ax
		ret
stop_menu			endp



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
		cmp		bx,		17h
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
		call	check_bottom
		cmp		ax,		1
		je		checker_false

		mov		ax,		cx
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
; ax - res
; 0 = OK, 1 = Bad
check_bottom			proc near
	shr		ax,		4
	cmp		ax,		24
	je		chchbtm_1

	mov		ax,		0
	jmp		chchbtm_ret

	chchbtm_1:
		mov		ax,		1	
	chchbtm_ret:
		ret
check_bottom			endp



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



; ====================================================================================================================================
; ====================================================================================================================================
; ====================================================================================================================================



ScreenClear proc near                       ; полная чистка экрана
        push    ax
        mov     ax,     03h
        int 10h
        pop     ax
        ret
ScreenClear endp


draw_glass proc near                         ; рисуем стакан
        push    ax
        push    bx
        push    cx
        push    dx
        push    es
        push    di

        mov     cx,     24
        mov     ax,     0b800h
        mov     es,     ax
        mov     di,     44

    _loop_glass_1:                             ; рисуем 24 строки с вертикальными границами
        cmp     cx,     0
        je      _last_glass_str  
        mov     ah,     08h
        mov     al,     word_buf
        stosw
        add     di,     64
        stosw
        add     di,     92
        dec     cx
        jmp _loop_glass_1

    _last_glass_str:                              ; рисуем последнюю строку (нижнюю границу)
        mov     al,     0DBh ;0C8h            ; левый уголок
        stosw
        mov     cx,     32
        mov     al,     0DBh ;0CDh            ; горизонтальная нижняя граница

    _loop_glass_2:
        stosw
        loop _loop_glass_2
        mov     al,     0DBh ;0BCh            ; правый уголок
        stosw

    _exit:
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
        word_buf db     0DBh ;0C7h            ; вертикальная граница
draw_glass endp


color_choice proc near                          ; выбирает цвет для current_position
        push    bx                              ; использует current_color
        lea     bx,     current_color
        mov     ax,     [bx]

        cmp     ax,     1
        je      _red
        cmp     ax,     2
        je      _brown
        cmp     ax,     3
        je      _yellow
        cmp     ax,     4
        je      _green
        cmp     ax,     5
        je      _blue
        cmp     ax,     6
        je      _purple
        cmp     ax,     7
        je      _cyan

    _red:
        mov     ah,     04h
        jmp     _go_on
    _brown:
        mov     ah,     06h
        jmp     _go_on
    _yellow:
        mov     ah,     0eh
        jmp     _go_on
    _green:
        mov     ah,     02h
        jmp     _go_on
    _blue:
        mov     ah,     01h
        jmp     _go_on
    _purple:
        mov     ah,     05h
        jmp     _go_on
    _cyan:
        mov     ah,     03h
        jmp     _go_on
    
    _go_on:
        pop     bx
        ret
color_choice endp


draw_cur_pos proc near                       ; рисует текущую фигуру
        push    ax                           ; использует current_position и current_color
        push    bx                           ; и current_figure тоже
        push    cx
        push    dx
        push    es
        push    di
        push    si

        lea     bx,     current_position
        mov     cx,     4
    _loop_cur_pos:              
        mov     ax,     [bx]
        cmp     ax,     0FFFFh
        je      _drcp_ret

        push    cx
        push    ax
        shr     ax,     4
        mov     cx,     ax
        mov     ax,     160
        mul     cx
        add     ax,     46
        mov     cx,     ax                          ; в cx - координата 

        pop     ax
        shl     ax,     12
        shr     ax,     12
        push    cx
        mov     cx,     4
        mul     cx
        pop     cx                      ; т.к. квадрат - это 2 клетки
        add     cx,     ax
        
        mov     dx,     0b800h          ; место указано в dx
        mov     es,     dx

        call    color_choice            ; выбор цвета в отдельной ф-ции
                                        ; (иначе ругается на слишком длинные джампы)
        push    ax
        push    bx
        lea     bx,     current_figure
        mov     ax,     [bx]

        cmp     ax,     12
        je      _draw_bomb
        jmp     _dr

    _draw_bomb:
        mov     al,     02h
        mov     ah,     0Ch
        mov     di,     cx
        stosw
        stosw
        pop     bx
        pop     ax
        jmp     _pre_fin

    _dr:
        pop     bx
        pop     ax
        mov     al,     0DBh
        mov     di,     cx
        stosw
        stosw
        
    _pre_fin:
        pop     cx
        add     bx,     2
        loop    _loop_cur_pos
    _drcp_ret:
        pop     si
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
draw_cur_pos endp




draw_field proc near                                  ; рисует игровое поле
        push    ax                              ; использует draw_str и draw_one_sqare
        push    bx
        push    cx
        push    dx        
        push    es     
        push    di
        push    si                  

        ;call    draw_glass                      ; вызов отрисовки стакана (можно убрать в любое другое место)

        mov     dx,     46                      ; отрисовка первой строки
        lea     bx,     game_field              
        mov     ax,     [bx]
        mov     cx,     15

        call    draw_str                        

        mov     cx,     23
    _loop_draw:                                 ; отрисовка остальных строк
        add     dx,     96
        add     bx,     2
        mov     ax,     [bx]
        push    cx
        mov     cx,     15

        call    draw_str

        pop     cx
        loop    _loop_draw

        pop     si
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
    ret

draw_field endp


draw_str proc near                              ; рисует строку из квадратов
        push    ax                              ; каждый квадрат занимает 2 клетки
        push    cx                              ; использует draw_one_sqare

    _str_loop:
            push    ax                          
            shr     ax,     15
            shl     ax,     15
            cmp     ax,     8000h
            je      _print_symb
            add     dx,     4
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _conty
            dec     cx
            jmp     _str_loop
        _print_symb:
            call    draw_one_sqare
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _conty
            dec     cx
            jmp     _str_loop
        
        _conty:

            pop     cx
            pop     ax
            ret
draw_str endp


draw_one_sqare proc near                        ; рисует квадрат из 2х прямоугольников в указанном месте
        push    es
        push    di

        push    dx                   ; используется в draw_str
        mov     dx,     0b800h          ; место указано в dx
        mov     es,     dx
        pop     dx
        mov     ah,     0ah
        mov     al,     0DBh
        mov     di,     dx
        stosw
        add     dx,     2
        stosw
        add     dx,     2

        pop     di
        pop     es
        ret
draw_one_sqare endp


draw_field_and_cur_pos proc near
		call	clear_glass
        call    draw_field
        call    draw_cur_pos
        ret
draw_field_and_cur_pos endp

clear_glass proc near                       ; чистит экран в пределах стакана (закрашивает черным)
        push    ax 
        push    bx
        push    cx
        push    dx        
        push    es     
        push    di
        push    si                  


        mov     di,     46
        mov     cx,     32
        mov     dx,     0b800h
        mov     es,     dx
        mov     ah,     00h
        mov     al,     0DBh
    _clear_glass_loop_1:
        stosw
        loop    _clear_glass_loop_1

        mov     cx,     23
    _clear_glass_step_2:
        add     di,     96
        push    cx
        mov     cx,     32
    _clear_glass_loop_2:
        stosw
        loop    _clear_glass_loop_2

        pop     cx
        loop    _clear_glass_step_2

        pop     si
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
    ret
clear_glass endp

draw_next_figure proc near          ; доп - рисует следующую фигуру
        push    ax                  ; справа от игрового поля
        push    bx                  ; использует next_figure и next_color
        push    cx
        push    dx
        push    es
        push    di
        push    si

        mov     cx,     12
        mov     ax,     0b800h
        mov     es,     ax
        mov     di,     124
        mov     ah,     0Eh
        mov     al,     15h     ;02h - идеальный вариант
    _draw_frame_1:
        stosw
        loop    _draw_frame_1

        mov     cx,     4
    _draw_frame_2:
        add     di,     136
        stosw
        stosw
        add     di,     16
        stosw
        stosw
        loop    _draw_frame_2

        mov     cx,     12
        add     di,     136
    _draw_frame_3:
        stosw
        loop    _draw_frame_3


    _draw_black:
        sub     di,     660
        mov     al,     0DBh
        mov     ah,     00h
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        add     di,     144
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        add     di,     144
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        add     di,     144
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        sub     di,     496
        jmp     _draw_figure_step_1

    _draw_figure_step_1:                    ; выбираем цвет

        lea     bx,     next_color
        mov     ax,     [bx]

        cmp     ax,     1
        je      _red_next
        cmp     ax,     2
        je      _brown_next
        cmp     ax,     3
        je      _yellow_next
        cmp     ax,     4
        je      _green_next
        cmp     ax,     5
        je      _blue_next
        cmp     ax,     6
        je      _purple_next
        cmp     ax,     7
        je      _cyan_next

    _red_next:
        mov     ch,     04h
        jmp     _draw_figure_step_2
    _brown_next:
        mov     ch,     06h
        jmp     _draw_figure_step_2
    _yellow_next:
        mov     ch,     0eh
        jmp     _draw_figure_step_2
    _green_next:
        mov     ch,     02h
        jmp     _draw_figure_step_2
    _blue_next:
        mov     ch,     01h
        jmp     _draw_figure_step_2
    _purple_next:
        mov     ch,     05h
        jmp     _draw_figure_step_2
    _cyan_next:
        mov     ch,     03h
        jmp     _draw_figure_step_2

    
    _draw_figure_step_2:                        ; выбираем фигуру

      ;  sub     di,     660
        lea     bx,     next_figure
        mov     ax,     [bx]

        cmp     ax,     1
        je      _square_next

        cmp     ax,     2
        je      _dot_next

        cmp     ax,     3
        je      _two_dots_next

        cmp     ax,     4
        je      _three_dots_next

        cmp     ax,     5
        je      _triangle_next

        cmp     ax,     6
        je      _g_next

        cmp     ax,     7
        je      _back_g_next

        cmp     ax,     8
        je      _pyramid_next

        cmp     ax,     9
        je      _s_next

        cmp     ax,     10
        je      _back_s_next

        cmp     ax,     11
        je      _four_dots_next

        cmp     ax,     12
        je      _bomb_next

    _square_next:
        add     di,     164
        mov     ah,     ch
        mov     al,     0DBh     ;02h - идеальный вариант
        stosw
        stosw
        stosw
        stosw
        add     di,     152
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret   

    _dot_next:
        add     di,     164
        add     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        jmp     _next_fig_ret

    _two_dots_next:
        add     di,     164
        mov    ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret

    _three_dots_next:
        add     di,     162
        mov     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret

    _triangle_next:
        add     di,     164
        mov     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        add     di,     152
        stosw
        stosw
        jmp     _next_fig_ret

    _g_next:
        add     di,     164
        mov     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        add     di,     152
        stosw
        stosw
        add     di,     156
        stosw
        stosw
        jmp     _next_fig_ret

    _back_g_next:
        add     di,     164
        mov     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        add     di,     156
        stosw
        stosw
        add     di,     156
        stosw
        stosw
        jmp     _next_fig_ret

    _pyramid_next:
        add     di,     166
        mov     ah,     ch
        mov     al,     0DBh     ;02h - идеальный вариант
        stosw
        stosw
        add     di,     152
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret   

    _s_next:
        add     di,     166
        mov     ah,     ch
        mov     al,     0DBh     ;02h - идеальный вариант
        stosw
        stosw
        stosw
        stosw
        add     di,     148
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret   

    _back_s_next:
        add     di,     162
        mov     ah,     ch
        mov     al,     0DBh     ;02h - идеальный вариант
        stosw
        stosw
        stosw
        stosw
        add     di,     156
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret   

    _four_dots_next:
        add     di,     160
        mov     ah,     ch
        mov     al,     0DBh
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        stosw
        jmp     _next_fig_ret

    _bomb_next:
        add     di,     164
        mov     al,     02h
        mov     ah,     0Ch
        stosw
        stosw
        jmp     _next_fig_ret
    
    _next_fig_ret:
        pop     si
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
draw_next_figure endp


; ====================================================================================================================================
; ====================================================================================================================================
; ====================================================================================================================================



integrate_figure	proc near				; changes game_field depending
	push 	ax
	push 	bx
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	lea		si,		[current_figure]
	lodsb
	cmp		al,		12
	je		lolly_bomb
	jmp		_ddddd

	lolly_bomb:
		call	clear_gamefield
		jmp		_exitIntegrate

	_ddddd:
	lea 	bx, 	current_position		
	mov 	ax, 	[bx]
	cmp 	ax, 	0ffffh
	je 		_nextCurrent
	mov 	bx, 	10h
	xor 	dx, 	dx
	div 	bx
	push 	dx								; str in ax, column in dx
	mov 	bx, 	2
	mul 	bx

	lea 	bx, 	game_field
	add 	bx, 	ax 						; link to needed str in bx
	pop 	dx								; column in dx
	push 	bx

	mov 	cx, 	16
	mov 	ax, 	08000h
	mov 	bx, 	0
	strLoop:								; loop finding and changing bit we need
		cmp 	dx, 	bx
		jg 		_nextCol 					; wrong column
		pop 	bx
		mov 	cx, 	[bx]
		add 	cx, 	ax
		mov 	[bx], 	cx
		mov 	ax, 	[bx]
		jmp 	_nextCurrent

	_nextCol:								; ax/2, inc bx
		push 	cx
		push 	dx
		xor 	dx, 	dx
		mov 	cx, 	2
		div 	cx
		pop 	dx
		pop 	cx
		inc 	bx
		loop 	strLoop

_nextCurrent:								; second current_position, same work
	lea 	bx, 	current_position
	mov 	ax, 	[bx + 2]
	cmp 	ax, 	0ffffh
	je 		_nextCurrent1
	mov 	bx, 	10h
	xor 	dx, 	dx
	div 	bx
	push 	dx
	mov 	bx, 	2
	mul 	bx
	
	lea 	bx, 	game_field
	add 	bx, 	ax 							; link to needed str in bx
	pop 	dx
	push 	bx

	mov 	cx, 	16
	mov 	ax, 	08000h
	mov 	bx, 	0
	strLoop1:
		cmp 	dx, 	bx
		jg 		_nextCol1
		pop 	bx
		mov 	cx, 	[bx]
		add 	cx, 	ax
		mov 	[bx], 	cx
		mov 	ax, 	[bx]
		jmp 	_nextCurrent1

	_nextCol1:
		push 	cx
		push 	dx
		xor 	dx, 	dx
		mov 	cx, 	2
		div 	cx
		pop 	dx
		pop 	cx
		inc 	bx
		loop 	strLoop1

_nextCurrent1:									; third current_position, the same work
	lea 	bx, 	current_position
	mov 	ax, 	[bx + 4]
	cmp 	ax, 	0ffffh
	je 		_nextCurrent2
	mov 	bx, 	10h
	xor 	dx, 	dx
	div 	bx
	push 	dx
	mov 	bx, 	2
	mul 	bx
	
	lea 	bx, 	game_field
	add 	bx, 	ax 							; link to needed str in bx
	pop 	dx
	push 	bx

	mov 	cx, 	16
	mov 	ax, 	08000h
	mov 	bx, 	0
	strLoop2:
		cmp 	dx, 	bx
		jg 		_nextCol2
		pop 	bx
		mov 	cx, 	[bx]
		add 	cx, 	ax
		mov 	[bx], 	cx
		mov 	ax, 	[bx]
		jmp 	_nextCurrent2

	_nextCol2:
		push 	cx
		push 	dx
		xor 	dx, 	dx
		mov 	cx, 	2
		div 	cx
		pop 	dx
		pop 	cx
		inc 	bx
		loop 	strLoop2

_nextCurrent2:									; fourth current_position, the same work
	lea 	bx, 	current_position
	mov 	ax, 	[bx + 6]
	cmp 	ax, 	0ffffh
	je 		_exitIntegrate
	mov 	bx, 	10h
	xor 	dx, 	dx
	div 	bx
	push 	dx
	mov 	bx, 	2
	mul 	bx
	
	lea 	bx, 	game_field
	add 	bx, 	ax 							; link to needed str in bx
	pop 	dx
	push 	bx

	mov 	cx, 	16
	mov 	ax, 	08000h
	mov 	bx, 	0
	strLoop3:
		cmp 	dx, 	bx
		jg 		_nextCol3
		pop 	bx
		mov 	cx, 	[bx]
		add 	cx, 	ax
		mov 	[bx], 	cx
		mov 	ax, 	[bx]

		pop 	di
		pop 	si
		pop 	es
		pop 	ds
		pop 	dx
		pop 	cx
		pop 	bx
		pop 	ax
		ret 									; exit

	_nextCol3:
		push 	cx
		push 	dx
		xor 	dx, 	dx
		mov 	cx, 	2
		div 	cx
		pop 	dx
		pop 	cx
		inc 	bx
		loop 	strLoop3

_exitIntegrate:
	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret 		

integrate_figure	endp

rotate_figure 	proc near 						; rotate current figure
	push 	bx									; rotate side in ax
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	mov 	bx, 	ax
	call 	saved_configuration

	call 	get_position
	push 	ax 									; left up in stack

	mov 	ax, 	bx
	cmp 	ax, 	0
	je 		_toLeft
	jmp 	_toRight

_toLeft:										; rotate to left
	lea 	bx, 	current_rotate
	mov 	dx, 	[bx]
	cmp 	dx, 	1
	je 		_carrymin
	dec 	dx
	lea 	bx, 	current_rotate
	mov 	[bx], 	dx
	jmp 	_ch

_toRight:										; rotate to right
	lea 	bx, 	current_rotate
	mov 	dx, 	[bx]
	cmp 	dx, 	4
	je 		_carrymax
	inc 	dx
	lea 	bx, 	current_rotate
	mov 	[bx], 	dx
	jmp 	_ch

_carrymin:										; if left so 1 becames 4
	lea 	bx, 	current_rotate
	mov 	ax, 	4
	mov 	[bx], 	ax
	jmp 	_ch

_carrymax:
	lea 	bx, 	current_rotate				; if right so 4 becames 1
	mov 	ax, 	1
	mov 	[bx], 	ax

_ch:
	call 	calculate_configuration
	pop 	bx
	call	buffer_equalizer
	call 	from_pattern
	call 	check_position
	cmp 	ax, 	1
	je 		_rollbackRotate

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	ret


_rollbackRotate:								; rollback rotate from save
	call 	restore_configuration

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	ret

rotate_figure 	endp

can_here		proc near 			; res like 1 or 0 in ax
	push 	bx						; res asks "can we draw current without crossing walls?"
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	call 	get_position			; taking data
	mov 	bx, 	10h
	xor 	dx, 	dx
	div 	bx
	push 	ax
	push 	dx
	lea 	bx, 	current_figure
	mov 	cx,		[bx]
	lea 	bx, 	current_rotate
	mov 	dx, 	[bx]
	pop 	ax
	pop 	bx 						
									; column in ax, str in bx
									; figure in cx, rotate in dx
	cmp 	cx, 	1				; what figure we have
	je 		_square
	cmp 	cx, 	2
	je 		_true
	cmp 	cx, 	3
	je 		_twoDots
	cmp 	cx, 	4
	je 		_threeDots
	cmp 	cx, 	5
	je 		_triangle
	cmp 	cx, 	6
	je 		_g
	cmp 	cx, 	7
	je 		_g
	cmp 	cx, 	8
	je 		_pyramid
	cmp 	cx, 	9
	je 		_s
	cmp 	cx, 	10
	je 		_s
	cmp 	cx, 	11
	je 		_fourDots

; ==========================

_square:							; checking
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	17h
	je 		_false
	jmp 	_true

; ==========================

_twoDots:							; what rotate we have
	cmp 	dx, 	1
	je 		_twoDots13
	cmp 	dx, 	3
	je 		_twoDots13
	cmp 	dx, 	2
	je 		_twoDots24
	cmp 	dx, 	4
	je 		_twoDots24

_twoDots13:							; checking 1 or 3 rotate 
	cmp 	ax, 	0fh
	je 		_false
	jmp 	_true

_twoDots24:							; checking 2 or 4 rotate 
	cmp 	bx, 	17h
	je 		_false					; if not valid
	jmp 	_true					; if valid

; =========================

_threeDots:							; this and nexts the same
	cmp 	dx, 	1
	je 		_threeDots13
	cmp 	dx, 	3
	je 		_threeDots13
	cmp 	dx, 	2
	je 		_threeDots24
	cmp 	dx, 	4
	je 		_threeDots24

_threeDots13:
	cmp 	ax, 	0Eh
	jge 	_false
	jmp 	_true

_threeDots24:
	cmp 	bx, 	16h
	jge 	_false
	jmp 	_true

; ========================

_triangle:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	17h
	je 		_false
	jmp 	_true

; =======================

_g:
	cmp 	dx, 	1
	je 		_g13
	cmp 	dx, 	3
	je 		_g13
	cmp 	dx, 	2
	je 		_g24
	cmp 	dx, 	4
	je 		_g24

_g13:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	16h
	jge 	_false
	jmp 	_true

_g24:
	cmp 	ax, 	0Eh
	jge 	_false
	cmp 	bx, 	17h
	je 		_false
	jmp 	_true

; ==========================

_pyramid:
	cmp 	dx, 	1
	je 		_pyramid13
	cmp 	dx, 	3
	je 		_pyramid13
	cmp 	dx, 	2
	je 		_pyramid24
	cmp 	dx, 	4
	je 		_pyramid24

_pyramid13:
	cmp 	ax, 	0Eh
	jge 	_false
	cmp 	bx, 	17h
	je 		_false
	jmp 	_true

_pyramid24:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	16h
	jge 	_false
	jmp 	_true

; ========================

_s:
	cmp 	dx, 	1
	je 		_s13
	cmp 	dx, 	3
	je 		_s13
	cmp 	dx, 	2
	je 		_s24
	cmp 	dx, 	4
	je 		_s24

_s13:
	cmp 	ax, 	0Eh
	jge 	_false
	cmp 	bx, 	17h
	je 		_false
	jmp 	_true

_s24:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	16h
	jge 	_false
	jmp 	_true

; =======================

_fourDots:
	cmp 	dx, 	1
	je 		_fourDots13
	cmp 	dx, 	3
	je 		_fourDots13
	cmp 	dx, 	2
	je 		_fourDots24
	cmp 	dx, 	4
	je 		_fourDots24

_fourDots13:
	cmp 	ax, 	0dh
	jge 	_false
	jmp 	_true

_fourDots24:
	cmp 	bx, 	15h
	jge 	_false
	jmp 	_true

_true:
	mov 	ax, 	1
	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	ret

_false:
	mov 	ax, 	0
	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	ret
can_here		endp

search_lines	proc near 				; search and deleting entire lines
	push 	ax
	push 	bx
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di


	lea 	bx,		game_field		; link to game_field in bx
	mov 	cx, 	24				; num of loops
	mov 	dx, 	0				; str counter
	searchLoop:
		mov 	ax, 	0ffffh		; entire example
		cmp 	[bx],	ax 			; comparison of str and example
		je 		_sd					; if we need shift_down
	_back2search:
		add		bx, 	2			; next str
		inc 	dx					; inc counter
		loop searchLoop
	jmp _searchExit

_sd:
	mov  	ax, 	dx				; num of ffff str to ax
	call 	shift_down				
	jmp		_back2search

_searchExit:
	; lea 	bx, 	game_field
	; mov 	ax, 	[bx]		;<==== for testing
	; mov 	ax, 	[bx + 2]
	; mov 	ax, 	[bx + 4]
	; mov 	ax, 	[bx + 6]
	; mov 	ax, 	[bx + 8]
	; mov 	ax, 	[bx + 10]
	; mov 	ax, 	[bx + 12]
	; mov 	ax, 	[bx + 14]
	; mov 	ax, 	[bx + 16]
	; mov 	ax, 	[bx + 18]
	; mov 	ax, 	[bx + 20]		;<==== for testing
	; mov 	ax, 	[bx + 22]
	; mov 	ax, 	[bx + 24]
	; mov 	ax, 	[bx + 26]
	; mov 	ax, 	[bx + 28]
	; mov 	ax, 	[bx + 30]
	; mov 	ax, 	[bx + 32]
	; mov 	ax, 	[bx + 34]
	; mov 	ax, 	[bx + 36]
	; mov 	ax, 	[bx + 38]	
	; mov 	ax, 	[bx + 40]		;<==== for testing
	; mov 	ax, 	[bx + 42]
	; mov 	ax, 	[bx + 44]
	; mov 	ax, 	[bx + 46]

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret
search_lines	endp

shift_down     proc near    ; number of entire line in ax
  push  ax
  push   bx
  push   cx
  push   dx
  push   ds
  push   es
  push   si
  push   di


  ; mov   ax,    23      ;<======== for testing
  mov   cx,   ax
  push   cx          ; loop number in to stack
  mov   bx,   2
  mul   bx
; shift to entire line in massive in ax
  lea   bx,   game_field
  add   bx,   ax       ; link to entire line in bx

  pop   cx
  shiftLoop:          ; move lines down one by one
    mov   ax,   [bx - 2]
    mov   [bx],   ax
    dec   bx
    dec   bx
    loop   shiftLoop

  lea   bx,   game_field
  mov   ax,   0000h     ; make first str in game_field empty
  mov   [bx],   ax


  lea	si,		[speed]
  lodsb
  mov	bl,		2
  div	bl
  mov	bx,		10
  sub	bx,		ax
  mov	cx,		bx


  lea   bx,   pointsBuf
  mov   ax,   [bx]
  add	ax,		cx
  mov   [bx],   ax
  call   print_points
  cmp   ax,   999
  jbe   _shiftDownExit

_victory:
  lea   bx,   exit_flag
  mov	ax,		1
  mov   [bx],   ax

  ; mov   ax,   6      ;<==== for testing
  ; call   shift_down
  ; lea   bx,   game_field
  ; mov   ax,   [bx]    ;<==== for testing
  ; mov   ax,   [bx + 2]
  ; mov   ax,   [bx + 4]
  ; mov   ax,   [bx + 6]
  ; mov   ax,   [bx + 8]
  ; mov   ax,   [bx + 10]
  ; mov   ax,   [bx + 12]
  ; mov   ax,   [bx + 14]
  ; mov   ax,   [bx + 16]
  ; mov   ax,   [bx + 18]
  ; mov   ax,   [bx + 20]    ;<==== for testing
  ; mov   ax,   [bx + 22]
  ; mov   ax,   [bx + 24]
  ; mov   ax,   [bx + 26]
  ; mov   ax,   [bx + 28]
  ; mov   ax,   [bx + 30]
  ; mov   ax,   [bx + 32]
  ; mov   ax,   [bx + 34]
  ; mov   ax,   [bx + 36]
  ; mov   ax,   [bx + 38]  
  ; mov   ax,   [bx + 40]    ;<==== for testing
  ; mov   ax,   [bx + 42]
  ; mov   ax,   [bx + 44]
  ; mov   ax,   [bx + 46]

_shiftDownExit:
  pop   di
  pop   si
  pop   es
  pop   ds
  pop   dx
  pop   cx
  pop   bx
  pop   ax
  ret
shift_down   endp


get_position 	proc near 				; res, coordinates of up left 
										; corner of current_position, in ax
	push 	bx
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	lea 	bx, 	current_position	; link to current_position
	mov 	ax, 	[bx]
	xor 	dx, 	dx
	mov 	cx, 	10h 				; to have column in dx, str in ax
	div 	cx
	push 	ax
	push 	dx

	mov 	ax, 	[bx + 2] 			; second element of current_position to ax
	xor 	dx, 	dx
	mov 	cx, 	10h 				; to have column in dx, str in ax
	div 	cx
	pop 	cx
	pop 	bx

	cmp 	ax, 	bx
	jle 	_lessequalstr
	jmp 	_greaterstr

_lessequalstr:
	push 	ax
	cmp 	dx, 	cx
	jle 	_lessequalcolumn
	jmp 	_greatercolumn

_greaterstr:
	push 	bx
	cmp 	dx, 	cx
	jle 	_lessequalcolumn
	jmp 	_greatercolumn

_lessequalcolumn:
	push 	dx
	jmp 	_round2

_greatercolumn:
	push 	cx

; in stack the most little column/the most little str from 1 and 2 in current_position
_round2: 								; the same comparison with 3 in current_position
	lea 	bx, 	current_position
	mov 	ax, 	[bx + 4]
	xor 	dx, 	dx
	mov 	cx, 	10h 				; to have column in dx, str in ax
	div 	cx
	pop 	cx
	pop 	bx

	cmp 	ax, 	bx
	jle 	_lessequalstr1
	jmp 	_greaterstr1

_lessequalstr1:
	push 	ax
	cmp 	dx, 	cx
	jle 	_lessequalcolumn1
	jmp 	_greatercolumn1

_greaterstr1:
	push 	bx
	cmp 	dx, 	cx
	jle 	_lessequalcolumn1
	jmp 	_greatercolumn1

_lessequalcolumn1:
	push 	dx
	jmp 	_round3

_greatercolumn1:
	push 	cx

; in stack the most little column/the most little str from 1, 2 and 3 in current_position
_round3: 								; the same comparison with 4 in current_position
	lea 	bx, 	current_position
	mov 	ax, 	[bx + 6]
	xor 	dx, 	dx
	mov 	cx, 	10h 				; to have column in dx, str in ax
	div 	cx
	pop 	cx
	pop 	bx

	cmp 	ax, 	bx
	jle 	_lessequalstr2
	jmp 	_greaterstr2

_lessequalstr2:
	push 	ax
	cmp 	dx, 	cx
	jle 	_lessequalcolumn2
	jmp 	_greatercolumn2

_greaterstr2:
	push 	bx
	cmp 	dx, 	cx
	jle 	_lessequalcolumn2
	jmp 	_greatercolumn2

_lessequalcolumn2:
	push 	dx
	jmp 	_result

_greatercolumn2:
	push 	cx

_result:
	pop 	bx
	pop 	ax
	mov 	dx, 	10h
	mul 	dx
	add 	ax, 	bx
; coordinates of up left corner in aax
	
	pop 	di
	pop 	si
	pop 	es
	pop 	ds	
	pop 	dx
	pop 	cx
	pop 	bx
	ret
get_position 	endp

restore_configuration 	proc near			; transport saved position & rotate
	push 	ax								;to current position and rotate
	push 	bx
	push 	ds
	push 	es
	push 	si
	push 	di

	lea 	bx, 	saved_position			; link to saved_position in bx

	mov 	ax, 	[bx]					; first dot from saved_position in ax
	lea 	bx, 	current_position		; link to current_position in bx
	mov 	[bx], 	ax 						; restore first dot from saved_configuration to current_position
	lea 	bx, 	saved_position

	mov 	ax, 	[bx + 2]				; second dot
	lea 	bx, 	current_position
	mov 	[bx + 2], 	ax
	lea 	bx, 	saved_position

	mov 	ax, 	[bx + 4]				; third dot 
	lea 	bx, 	current_position
	mov 	[bx + 4], 	ax
	lea 	bx, 	saved_position

	mov 	ax, 	[bx + 6]				; fourth dot
	lea 	bx, 	current_position
	mov 	[bx + 6], 	ax
	lea 	bx, 	saved_position

	lea 	bx, 	saved_rotate			; link to saved_rotate in bx
	mov 	ax, 	[bx]					; saved_rotate in ax
	lea 	bx, 	current_rotate			; link to current_rotate in bx
	mov 	[bx], 	ax 						; restore current_rotate from saved_rotate

	; lea 	bx, 	current_position  		;<==== testing
	; mov 	ax, 	[bx]
	; mov 	ax, 	[bx + 2]
	; mov 	ax, 	[bx + 4]
	; mov 	ax, 	[bx + 6]

	; lea 	bx, 	current_rotate
	; mov 	ax, 	[bx]              		;<==== testing

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	bx
	pop 	ax
	ret
restore_configuration 	endp

saved_configuration 	proc near 			; transport current position & rotate
	push 	ax								; to saved position and rotate
	push 	bx								; the same as restore_configuration but on the other side
	push 	ds
	push 	es
	push 	si
	push 	di

	lea 	bx, 	current_position

	mov 	ax, 	[bx]
	lea 	bx, 	saved_position
	mov 	[bx], 	ax
	lea 	bx, 	current_position

	mov 	ax, 	[bx + 2]
	lea 	bx, 	saved_position
	mov 	[bx + 2], 	ax
	lea 	bx, 	current_position

	mov 	ax, 	[bx + 4]
	lea 	bx, 	saved_position
	mov 	[bx + 4], 	ax
	lea 	bx, 	current_position

	mov 	ax, 	[bx + 6]
	lea 	bx, 	saved_position
	mov 	[bx + 6], 	ax

	lea 	bx, 	current_rotate
	mov 	ax, 	[bx]
	lea 	bx, 	saved_rotate
	mov 	[bx], 	ax

	; lea 	bx, 	saved_position  		;<==== testing
	; mov 	ax, 	[bx]
	; mov 	ax, 	[bx + 2]
	; mov 	ax, 	[bx + 4]
	; mov 	ax, 	[bx + 6]

	; lea 	bx, 	saved_rotate
	; mov 	ax, 	[bx]            		;<==== testing

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	bx
	pop 	ax
	ret
saved_configuration 	endp

clear_gamefield 	proc near 					; clean game_field
	push 	ax
	push 	bx
	push 	cx
	push 	ds
	push 	es
	push 	si
	push 	di

	lea 	bx, 	game_field				; link to game_field in bx
	mov 	ax, 	0000h 					; empty str in ax
	mov 	cx, 	24						; 24 loops

	clearLoop:
		mov 	[bx], 	ax 					; make empty str
		add 	bx, 	2					; link to nest str
		loop 	clearLoop

	; call clear_screen	;<=================== for testing in begin
	; mov cx, 24
	; lea bx, game_field
	; loopx:
	; 	mov ax, [bx]
	; 	inc bx
	; 	inc bx
	; 	loop loopx		;<=================== for testing in begin

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	cx
	pop 	bx
	pop 	ax
	ret
clear_gamefield 	endp

calculate_configuration 	proc near	
; figure num in current_figure, rotate in buf current_rotate, res(start byte of configuration) in ax
; figure numered like in table
	push    bx
    push    cx
    push 	dx
    push    es
    push    di
    push    si
    push 	ds
    
	
	lea 	bx, 	current_figure
	mov 	ax, 	[bx]
	mov 	dx, 	ax 						; figure num in dx
	mov 	si, 	offset current_rotate
	mov 	bx, 	[si]					; link to current_rotate in bx
	cmp 	bx, 	1						; check what rotate
	je 	_up
	cmp 	bx, 	2
	je 	_right
	cmp 	bx, 	3
	je 	_down
	cmp 	bx, 	4
	je 	_left

_up:										; if straight rotate
	cmp 	dx, 	1
	mov 	ax, 	offset figure_square
	je 	_ret
	cmp 	dx, 	2
	mov 	ax, 	offset figure_dot
	je 	_ret
	cmp 	dx, 	3
	mov 	ax, 	offset figure_2dots
	je 	_ret
	cmp 	dx, 	4
	mov 	ax, 	offset figure_3dots
	je 	_ret
	cmp 	dx, 	5
	mov 	ax, 	offset figure_triangle
	je 	_ret
	cmp 	dx, 	6
	mov 	ax, 	offset figure_g
	je 	_ret
	cmp 	dx, 	7
	mov 	ax, 	offset figure_backg
	je 	_ret
	cmp 	dx, 	8
	mov 	ax, 	offset figure_pyramid
	je 	_ret
	cmp 	dx, 	9
	mov 	ax, 	offset figure_s
	je 	_ret
	cmp 	dx, 	10
	mov 	ax, 	offset figure_backs
	je 	_ret
	cmp 	dx, 	11
	mov 	ax, 	offset figure_4dots
	je 	_ret

_right:										; if right rotate
	cmp 	dx, 	1
	mov 	ax, 	offset right_figure_square
	je 	_ret
	cmp 	dx, 	2
	mov 	ax, 	offset right_figure_dot
	je 	_ret
	cmp 	dx, 	3
	mov 	ax, 	offset right_figure_2dots
	je 	_ret
	cmp 	dx, 	4
	mov 	ax, 	offset right_figure_3dots
	je 	_ret
	cmp 	dx, 	5
	mov 	ax, 	offset right_figure_triangle
	je 	_ret
	cmp 	dx, 	6
	mov 	ax, 	offset right_figure_g
	je 	_ret
	cmp 	dx, 	7
	mov 	ax, 	offset right_figure_backg
	je 	_ret
	cmp 	dx, 	8
	mov 	ax, 	offset right_figure_pyramid
	je 	_ret
	cmp 	dx, 	9
	mov 	ax, 	offset right_figure_s
	je 	_ret
	cmp 	dx, 	10
	mov 	ax, 	offset right_figure_backs
	je 	_ret
	cmp 	dx, 	11
	mov 	ax, 	offset right_figure_4dots
	je 	_ret

_down:										; if overturned rotate
	cmp 	dx, 	1
	mov 	ax, 	offset overturned_figure_square
	je 	_ret
	cmp 	dx, 	2
	mov 	ax, 	offset overturned_figure_dot
	je 	_ret
	cmp 	dx, 	3
	mov 	ax, 	offset overturned_figure_2dots
	je 	_ret
	cmp 	dx, 	4
	mov 	ax, 	offset overturned_figure_3dots
	je 	_ret
	cmp 	dx, 	5
	mov 	ax, 	offset overturned_figure_triangle
	je 	_ret
	cmp 	dx, 	6
	mov 	ax, 	offset overturned_figure_g
	je 	_ret
	cmp 	dx, 	7
	mov 	ax, 	offset overturned_figure_backg
	je 	_ret
	cmp 	dx, 	8
	mov 	ax, 	offset overturned_figure_pyramid
	je 	_ret
	cmp 	dx, 	9
	mov 	ax, 	offset overturned_figure_s
	je 	_ret
	cmp 	dx, 	10
	mov 	ax, 	offset overturned_figure_backs
	je 	_ret
	cmp 	dx, 	11
	mov 	ax, 	offset overturned_figure_4dots
	je 	_ret

_left:										; if left rotate
	cmp 	dx, 	1
	mov 	ax, 	offset left_figure_square
	je 	_ret
	cmp 	dx, 	2
	mov 	ax, 	offset left_figure_dot
	je 	_ret
	cmp 	dx, 	3
	mov 	ax, 	offset left_figure_2dots
	je 	_ret
	cmp 	dx, 	4
	mov 	ax, 	offset left_figure_3dots
	je 	_ret
	cmp 	dx, 	5
	mov 	ax, 	offset left_figure_triangle
	je 	_ret
	cmp 	dx, 	6
	mov 	ax, 	offset left_figure_g
	je 	_ret
	cmp 	dx, 	7
	mov 	ax, 	offset left_figure_backg
	je 	_ret
	cmp 	dx, 	8
	mov 	ax, 	offset left_figure_pyramid
	je 	_ret
	cmp 	dx, 	9
	mov 	ax, 	offset left_figure_s
	je 	_ret
	cmp 	dx, 	10
	mov 	ax, 	offset left_figure_backs
	je 	_ret
	cmp 	dx, 	11
	mov 	ax, 	offset left_figure_4dots
	je 	_ret

_ret:
	pop 	ds 		
	pop		si
    pop    	di
    pop     es
    pop		dx
    pop     cx
    pop		bx
	ret
calculate_configuration 	endp

print_mask 	proc near						; print "Speed:" & "Points:" in up left corner
	push 	ax
	push 	bx
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di
											; code to paint
	mov 	ax,		0b800h					; should be at least once in code
	mov		es, 	ax 						; make third video mode
	mov		di, 	0
	xor	ax, 	ax

	mov		ah, 	0Eh
	mov 	al, 	050h
	stosw
	mov 	al, 	04fh
	stosw
	mov 	al, 	049h
	stosw
	mov 	al, 	04eh
	stosw
	mov 	al, 	054h
	stosw
	mov 	al, 	053h
	stosw
	mov 	al, 	03ah
	stosw
	add 	di, 	2
	mov 	al, 	030h
	stosw

	add 	di, 	142
	mov 	al, 	053h
	stosw
	mov 	al, 	050h
	stosw
	mov 	al, 	045h
	stosw
	mov 	al, 	045h
	stosw
	mov 	al, 	044h
	stosw
	add 	di, 	2
	mov 	al, 	03ah
	stosw
	add 	di, 	2
	mov 	al, 	030h
	stosw

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret
print_mask endp

print_points 	proc near 			; num(not more than 999) in pointsBuf
	push 	ax
	push 	bx						; print three-digit num from ax after "Points:"
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	; mov 	ax, 	001		; <======= for testing
	mov 	ax,		0b800h					; should be at least once in code
	mov		es, 	ax
	lea 	bx, 	pointsBuf
	mov 	ax, 	[bx]
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx

	call 	int2str16onedigit
	mov 	di, 	16
	mov		ah, 	0eh
	stosw
	pop 	ax
	call 	int2str16onedigit
	mov 	di, 	18
	mov		ah, 	0eh
	stosw
	pop 	ax
	call 	int2str16onedigit
	mov 	di, 	20
	mov		ah, 	0eh
	stosw

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret
print_points 	endp


print_speed   proc near       ; num(not more than 999) in speed
  push   ax
  push   bx            ; print three-digit num from ax after "Speed:"
  push   cx
  push   dx
  push   ds
  push   es
  push   si
  push   di

  ; mov   ax,   300     ;<=== for testing
  mov   ax,    0b800h          ; should be at least once in code
  mov    es,   ax             ; make third video mode
  mov    di,   0
  lea   bx,   speed
  mov   ax,   [bx]
  xor   dx,   dx
  mov   bx,   10
  div   bx

  lea   bx,   speed
    mov   ax,   [bx]
    xor   dx,   dx
    mov   cx,   2
    div   cx
    mov   dx,   ax
    mov   ax,   10
    sub   ax,   dx

  push   ax
  xor   dx,   dx
  mov   bx,   10
  div   bx
  mov   ax,   0
  push   ax

  mov   ax,   0

  call   int2str16onedigit
  mov   di,   176
  mov    ah,   0eh
  stosw
  pop   ax
  call   int2str16onedigit
  mov   di,   178
  mov    ah,   0eh
  stosw
  pop   ax
  call   int2str16onedigit
  mov   di,   180
  mov    ah,   0eh
  stosw


  pop   di
  pop   si
  pop   es
  pop   ds
  pop   dx
  pop   cx
  pop   bx
  pop   ax
  ret
print_speed   endp


int2str16onedigit 	proc near 			; num in al, res in al
	push 	bx							; make str view of digit
	push 	cx
	push 	dx
	push 	ds
	push 	es
	push 	si
	push 	di

	mov 	cl, 	al
	mov 	dl, 	al
	shr 	cl, 	4
	and 	dl, 	0fh
	add 	cl, 	30h
	add 	dl, 	30h
	cmp 	cl, 	39h
	jg 		@@4
@@6:
	cmp 	dl, 	39h
	jg 		@@5
	jmp 	@@7
@@4:
	add 	cl, 	7h
	jmp 	@@6
@@5:
	add 	dl, 	7h
@@7:
	mov 	al, 	dl

	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	pop 	dx
	pop 	cx
	pop 	bx
	ret
int2str16onedigit 	endp

print_string	proc near
    push    ax
    push    cx
    push    es
    push    di
    push    si
    push 	ds

    mov     ax,     0b800h
    mov     es,     ax
    mov     di,     660
    xor     ax,     ax
    mov     cx,     5
    mov     si,     offset output_msg
    ; mov	[si + 1],	dl	

    loop_1:
        lodsb
        mov     ah,     0eh
        stosw
        loop loop_1

    pop 	ds
    pop     si
    pop     di
    pop     es
    pop     cx
    pop     ax
    ret
print_string                endp

num2buf proc near 						; num in ax, res in output_msg
    push    bx							; transport num from ax to bufer output_msg
    push    cx
    push 	dx
    push    es
    push    di
    push    si
    push 	ds

    mov     si,     offset output_msg	; you can change buffer
    mov 	cx, 	5					; you can change how many digits to print

    loopn2b:
    	cmp 	ax, 	0
    	je 		_continuenum2buf
    	xor 	dx, 	dx
    	mov 	bx, 	10
    	div 	bx
    	push 	ax
    	mov 	ax, 	dx
    	call 	int2str16onedigit
    	pop 	dx
    	push 	ax
    	mov 	ax, 	dx
    	loop 	loopn2b

_continuenum2buf:						
	pop 	ax
	mov		[si],	ax 					; change depending on how many digits
	pop 	ax
	mov		[si + 1],	ax
	pop 	ax 							; delete if less than 3
	mov		[si + 2],	ax				; delete if less than 3
	pop 	ax 							; delete if less than 4
	mov		[si + 3],	ax				; delete if less than 4
	pop 	ax 							; delete if less than 5
	mov		[si + 4],	ax 				; delete if less than 5

	pop 	ds
    pop     si
    pop     di
    pop     es
    pop		dx
    pop     cx
    pop		bx
    ret
num2buf 	endp

figure_color_generator 	proc near			; make new figure num in next_figure
	push 	ds
	push 	es
	push 	si
	push 	di
	push 	ax
	push 	bx
	push 	cx
	push 	dx

	xor 	dx, 	dx
	in 		ax, 	40h
	in 		ax, 	40h
	in 		ax, 	40h					; maske random num
	mov 	bx, 	10h
	div 	bx							; one digit random num in dx
	cmp 	dx, 	11		
	jg 		_minus5
	cmp 	dx, 	0
	je 		_plus1
	jmp 	_changingFigure

_minus5:								; if more than 11
	sub 	dx, 	5
	jmp 	_changingFigure

_plus1:									; if zero
	add 	dx, 	1

_changingFigure:						; put to next_figure
	lea 	bx, 	next_figure
	mov 	[bx], 	dx

; next_color

	xor 	dx, 	dx
	in 		ax, 	40h
	in 		ax, 	40h					; make random num
	mov 	bx, 	10h
	div 	bx							; one digit random num in dx
	cmp 	dx, 	7		
	jg 		_toBig						; if more than 7
	cmp 	dx, 	0			
	je 		_plus1X						; if 0
	jmp 	_changingColor

_toBig:							; if more than 11
		dec 	dx
		cmp 	dx, 	7
		jg 		_toBig
	jmp _changingFigure

_plus1X:									; if zero
	add 	dx, 	1

_changingColor:						; put to next_figure
	lea 	bx, 	next_color
	mov 	[bx], 	dx

	; call figure_color_generator 	<======= for testing in begin

	; lea 	bx, 	next_figure
	; mov 	ax, 	[bx]
	; lea 	bx, 	next_color
	; mov 	ax, 	[bx]
	; call figure_color_generator
	; lea 	bx, 	next_figure
	; mov 	ax, 	[bx]
	; lea 	bx, 	next_color
	; mov 	ax, 	[bx]
	; call figure_color_generator
	; lea 	bx, 	next_figure
	; mov 	ax, 	[bx]
	; lea 	bx, 	next_color
	; mov 	ax, 	[bx]; 			<======= for testing in begin

	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	pop 	di
	pop 	si
	pop 	es
	pop 	ds
	ret
figure_color_generator	endp



newGame     proc near
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

	_forNG:

    lea     bx,     pointsBuf
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     choice
    mov     ax,     1
    mov     [bx],    ax

    call    clear_gamefield

    lea     bx,     current_position
    mov     ax,     0000h
    mov     [bx],   ax
    mov     [bx + 2], ax
    mov     [bx + 4], ax
    mov     [bx + 6], ax

    lea     bx,     saved_position
    mov     ax,     1111h
    mov     [bx],   ax
    mov     [bx + 2], ax
    mov     [bx + 4], ax
    mov     [bx + 6], ax

    lea     bx,     current_figure
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     current_color
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     current_rotate
    mov     ax,     1
    mov     [bx],    ax

    lea     bx,     saved_rotate
    mov     ax,     1
    mov     [bx],    ax

    lea     bx,     exit_flag
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     tick
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     pause
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     speed
    mov     ax,     10
    mov     [bx],    ax

	call	create_new_figure
	call	randomizer

    call  	ScreenClear
	call  	draw_glass
	call	print_mask
	call	print_points
	call	print_speed
    call  	draw_field_and_cur_pos
	call	draw_next_figure

    call   	change_vectors

    push  cs
    pop    ds 

    ccc:
		hlt                    			;  Прерывание программное

		lea    si,    [exit_flag]
		lodsb
		cmp    al,    0
		jne    gogogo


		mov    bx,   head
		cmp    bx,   tail
		jz    ccc                		;  Если указатели хвоста и головы совпали - штош, не повезло
		call  read_buf            		;  Читаем информацию из буфера
		mov		bx,		ax

		lea		si,		[pause]
		lodsb
		cmp		al,		2
		je		pause_mode_operator

		mov		ax,		bx
		call  	game_model
		jmp		ccc

		pause_mode_operator:
			mov		ax,		bx
			call	stop_menu
			jmp		ccc

	gogogo:
    call  restore_vectors

	lea     bx,     exit_flag
	mov     ax,     [bx]
	cmp     al,     1
	je      _printVictory
	cmp     al,     2
	je      _printGameOver
	cmp		al,		3
	je		_forNG
	jmp     _toMenu

	_printVictory:
	mov     ax,     03h                 ; clear screen
	int     10h
	mov     si,     offset  victory1
	mov     cx,     23
	mov     di,     1338
	call    print_si_string
	mov     si,     offset  victory2
	mov     cx,     27
	mov     di,     1654
	call    print_si_string
	jmp     _toMenu

	_printGameOver:
	mov     ax,     03h                 ; clear screen
	int     10h
	mov     si,     offset  gameOver1
	mov     cx,     11
	mov     di,     1350
	call    print_si_string
	mov     si,     offset  gameOver2
	mov     cx,     33
	mov     di,     1648
	call    print_si_string

	_toMenu:
		@@8:
		xor     ah,     ah
		int     16h
		cmp     ah,     1
		jne     @@8
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
newGame     endp

print_menu 	proc near               ; print menu screen without dot
	push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  menu1
    mov     cx,     60
    mov     di,     14
    call    print_si_string

    mov     si,     offset  menu2
    mov     cx,     60
    mov     di,     174
    call    print_si_string

    mov     si,     offset  menu3
    mov     cx,     60
    mov     di,     334
    call    print_si_string

    mov     si,     offset  menu4
    mov     cx,     60
    mov     di,     494
    call    print_si_string

    mov     si,     offset  menu5
    mov     cx,     60
    mov     di,     654
    call    print_si_string

    mov     si,     offset  menu6
    mov     cx,     8
    mov     di,     1666
    call    print_si_string

    mov     si,     offset  menu7
    mov     cx,     17
    mov     di,     1978
    call    print_si_string

    mov     si,     offset  menu8
    mov     cx,     8
    mov     di,     2306
    call    print_si_string

    mov     si,     offset  menu9
    mov     cx,     4
    mov     di,     2630
    call    print_si_string

    mov     si,     offset  menu10
    mov     cx,     8
    mov     di,     3746
    call    print_si_string

    mov     si,     offset  menu11
    mov     cx,     8
    mov     di,     3906
    call    print_si_string

	pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_menu 	endp

print_dot   proc near                   ; print dot depending on buf choice
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     1664
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     1976
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     2304
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     2628
    call    print_si_string

    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _ngDot
    cmp     ax,     2
    je      _configDot
    cmp     ax,     3
    je      _captDot
    jmp     _exitDot

_ngDot:                                         ; print dot near new game
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     1664
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_configDot:                                     ; print dot near configuration
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     1976
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_captDot:                                       ; print dot near caps
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     2304
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_exitDot:                                          ; print dit near exit
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     2628
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_dot   endp

chooser     proc near                   ; infinity cycle of changing
    push    ax                          ; dot place depending on pressed buttom and printing menus
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

@@3:
    mov     ax,     03h                 ; clear screen
    int     10h
    call    print_menu
    call    print_dot
    xor     ax,     ax
    int     16h
    cmp     ah,     048h
    je      _upDot                      ; if up was pressed
    cmp     ah,     050h
    je      _downDot                    ; if down was pressed
    cmp     ah,     1
    je      _progExit                   ; if esc was pressed
    cmp     ah,     01Ch
    je      _enter                      ; if enter was pressed
    jmp     @@3

_progExit:
    jmp	_end_of_chooser

_enter:
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _newGameEnter
    cmp     ax,     2
    je      _configurationEter
    cmp     ax,     3
    je      _captionsEnter
    jmp		_end_of_chooser

_newGameEnter:                             ; if enter near new game
    call    newGame
    jmp     @@3

_configurationEter:                         ; if enter near config
    mov     ax,     03h
    int     10h
    call    print_conf
@@4:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@4
    jmp     @@3

_captionsEnter:                             ; if enter near caps
    mov     ax,     03h
    int     10h
    call    print_caps
@@5:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@5
    jmp     @@3


_upDot:                                 ; changing buf choice
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _forFour
    dec     ax
    mov     [bx],   ax
    jmp     @@3
_forFour:
    mov     ax,     4
    mov     [bx],   ax
    jmp     @@3

_downDot:
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     4
    je      _forOne
    inc     ax
    mov     [bx],   ax
    jmp     @@3
_forOne:
    mov     ax,     1
    mov     [bx],   ax
    jmp     @@3

_end_of_chooser:

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
chooser     endp

print_caps      proc near                   ; print the caption screen
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  cap1
    mov     cx,     38
    mov     di,     684
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap2
    mov     cx,     38
    mov     di,     844
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap3
    mov     cx,     30
    mov     di,     1012
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap4
    mov     cx,     41
    mov     di,     1162
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap5
    mov     cx,     8
    mov     di,     1352
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap6
    mov     cx,     11
    mov     di,     1510
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap7
    mov     cx,     10
    mov     di,     1670
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap8
    mov     cx,     11
    mov     di,     1830
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap9
    mov     cx,     8
    mov     di,     1990
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap10
    mov     cx,     21
    mov     di,     2140
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap11
    mov     cx,     38
    mov     di,     2284
    call    print_si_string

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_caps      endp

print_conf      proc near                   ; print the configuration screen
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  conf1
    mov     cx,     40
    mov     di,     1160 ; 1120
    call    print_si_string

    mov     si,     offset  conf2
    mov     cx,     27
    mov     di,     1320
    call    print_si_string

    mov     si,     offset  conf3
    mov     cx,     16
    mov     di,     1480
    call    print_si_string

    mov     si,     offset  conf4
    mov     cx,     17
    mov     di,     1640
    call    print_si_string

    mov     si,     offset  conf5
    mov     cx,     27
    mov     di,     1800
    call    print_si_string

    mov     si,     offset  conf6
    mov     cx,     38
    mov     di,     1960
    call    print_si_string

    mov     si,     offset  conf7
    mov     cx,     46
    mov     di,     2120
    call    print_si_string

    mov     si,     offset  conf8
    mov     cx,     26
    mov     di,     2280
    call    print_si_string

    mov     si,     offset  conf9
    mov     cx,     15
    mov     di,     2440
    call    print_si_string

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_conf      endp


print_si_string	proc near           ; res - printing
    push    ax                      ; offset in si, length in cx, place in di
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     ax,     0b800h
    mov     es,     ax
    xor     ax,     ax

    loop_qwqwq1:
        lodsb
        mov     ah,     0eh
        stosw
        loop loop_qwqwq1

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_si_string                endp


begin:
	call	randomizer
	call	chooser

	_exit_game:

    db 		0eah
    dw 		7c00h,		0
    dw 		0aa55h
end _start