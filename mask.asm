.model tiny
.386

.data
seed			dw 		0
seed2			dw		0
output_msg      db      '12345'
game_field:
	dw		1111h
	dw		2222h
	dw		3333h
	dw		0ffffh
	dw		5555h
	dw		0000h
	dw		7777h
	dw		8888h
	dw		9999h
	dw		0000h
	dw		1111h
	dw		0ffffh
	dw		3333h
	dw		4444h
	dw		5555h
	dw		7777h
	dw		8888h
	dw		9999h
	dw		0000h
	dw		1111h
	dw		2222h
	dw		3333h
	dw		4444h
	dw		5555h
	dw		0ffffh

current_position:
		dw		018eh
		dw		018eh
		dw		018eh
		dw		018eh
	
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

next_figure 	dw 		0

current_color	dw 		1
; 1 - red
; 2 - orange
; 3 - yellow
; 4 - green
; 5 - blue
; 6 - purple
; 7 - brown

current_rotate	dw		1 		; 1-straight, 2-right, 3-overturned, 4-left
		
saved_rotate	dw		2 		; 1-straight, 2-right, 3-overturned, 4-left

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
org 100h
_start:
jmp		begin

rotate_figure 	proc near 						; rotate current figure
	push 	bx
	push 	cx
	push 	dx

	lea 	bx, 	current_rotate				; save current 
	mov 	dx, 	[bx]
	lea 	bx, 	saved_rotate
	mov 	[bx], 	dx
	cmp 	ax, 	0
	je 		_toLeft
	jmp 	_toRight

_toLeft:										; rotate to left
	cmp 	dx, 	1
	je 		_carrymin
	dec 	dx
	mov 	bx, 	current_rotate
	mov 	[bx], 	dx
	jmp 	_ch

_toRight:										; rotate to right
	cmp 	dx, 	4
	je 		_carrymax
	inc 	dx
	mov 	bx, 	current_rotate
	mov 	[bx], 	dx
	jmp 	_ch

_carrymin:										; if left so 1 becames 4
	mov 	bx, 	current_rotate
	mov 	ax, 	4
	mov 	[bx], 	ax
	jmp 	_ch

_carrymax:
	mov 	bx, 	current_rotate				; if right so 4 becames 1
	mov 	ax, 	1
	mov 	[bx], 	ax

_ch:
	call can_here
	cmp 	ax, 	0
	je 		_rollbackRotate
	; call 	from_pattern
	; call 	check_position
	cmp 	ax, 	1
	je 		_rollbackRotateAndPosition

	pop 	dx
	pop 	cx
	pop 	bx
	ret


_rollbackRotate:								; rollback rotate from save
	lea 	bx, 	saved_rotate
	mov 	dx, 	[bx]
	lea 	bx, 	current_rotate
	mov 	[bx], 	dx

	pop 	dx
	pop 	cx
	pop 	bx
	ret

_rollbackRotateAndPosition:						; rollback rotate and position from saved
	lea 	bx, 	saved_rotate
	mov 	dx, 	[bx]
	lea 	bx, 	current_rotate
	mov 	[bx], 	dx
	call 	restore_configuration
	pop 	dx
	pop 	cx
	pop 	bx
	ret

rotate_figure 	endp

can_here		proc near 			; res like 1 or 0 in ax
	push 	bx						; res asks "can we draw current without crossing walls?"
	push 	cx
	push 	dx

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
	cmp 	bx, 	18h
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
	cmp 	bx, 	18h
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
	cmp 	bx, 	17h
	jge 	_false
	jmp 	_true

; ========================

_triangle:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	18h
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
	cmp 	bx, 	17h
	jge 	_false
	jmp 	_true

_g24:
	cmp 	ax, 	0Eh
	jge 	_false
	cmp 	bx, 	18h
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
	cmp 	bx, 	18h
	je 		_false
	jmp 	_true

_pyramid24:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	17h
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
	cmp 	bx, 	18h
	je 		_false
	jmp 	_true

_s24:
	cmp 	ax, 	0fh
	je 		_false
	cmp 	bx, 	17h
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
	cmp 	bx, 	16h
	jge 	_false
	jmp 	_true

_true:
	mov 	ax, 	1
	pop 	dx
	pop 	cx
	pop 	bx
	ret

_false:
	mov 	ax, 	0
	pop 	dx
	pop 	cx
	pop 	bx
	ret
can_here		endp

search_lines	proc near
	push 	ax
	push 	bx
	push 	cx
	push 	dx

	lea 	bx,		game_field		; link to game_field in bx
	mov 	cx, 	25				; num of loops
	mov 	dx, 	1				; str counter
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
	; mov 	ax, 	[bx + 48]

	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret
search_lines	endp

shift_down 		proc near		; number of entire line in ax
	push	ax
	push 	bx
	push 	cx
	push 	dx

	; mov 	ax,		25			;<======== for testing
	mov 	cx, 	ax
	dec 	cx
	push 	cx					; loop number in to stack
	mov 	bx, 	2
	mul 	bx
	sub 	ax, 	2			; shift to entire line in massive in ax
	lea 	bx, 	game_field
	add 	bx, 	ax 			; link to entire line in bx

	pop 	cx
	shiftLoop:					; move lines down one by one
		mov 	ax, 	[bx - 2]
		mov 	[bx], 	ax
		dec 	bx
		dec 	bx
		loop 	shiftLoop

	lea 	bx, 	game_field
	mov 	ax, 	0000h 		; make first str in game_field empty
	mov 	[bx], 	ax

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
	; mov 	ax, 	[bx + 48]

	pop 	dx
	pop 	cx
	pop 	bx
	pop 	ax
	ret
shift_down 	endp

get_position 	proc near 				; res, coordinates of up left 
										; corner of current_position, in ax
	push 	bx
	push 	cx
	push 	dx

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
	
	pop 	dx
	pop 	cx
	pop 	bx
	ret
get_position 	endp

restore_configuration 	proc near			; transport saved position & rotate
	push 	ax								;to current position and rotate
	push 	bx

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

	; lea 	bx, 	current_position  		<==== testing
	; mov 	ax, 	[bx]
	; mov 	ax, 	[bx + 2]
	; mov 	ax, 	[bx + 4]
	; mov 	ax, 	[bx + 6]

	; lea 	bx, 	current_rotate
	; mov 	ax, 	[bx]              		<==== testing


	pop 	bx
	pop 	ax
	ret
restore_configuration 	endp

saved_configuration 	proc near 			; transport current position & configuration
	push 	ax								; to saved position and configuration
	push 	bx								; the same as restore_configuration but on the other side

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

	; lea 	bx, 	saved_position  		<==== testing
	; mov 	ax, 	[bx]
	; mov 	ax, 	[bx + 2]
	; mov 	ax, 	[bx + 4]
	; mov 	ax, 	[bx + 6]

	; lea 	bx, 	saved_rotate
	; mov 	ax, 	[bx]            		<==== testing

	pop 	bx
	pop 	ax
	ret
saved_configuration 	endp

clear_screen 	proc near 					; clean game_field
	push 	ax
	push 	bx
	push 	cx
	push 	si

	lea 	bx, 	game_field				; link to game_field in bx
	mov 	ax, 	0000h 					; empty str in ax
	mov 	cx, 	25						; 25 loops

	clearLoop:
		mov 	[bx], 	ax 					; make empty str
		add 	bx, 	2					; link to nest str
		loop 	clearLoop

	pop 	si
	pop 	cx
	pop 	bx
	pop 	ax
	ret
clear_screen 	endp

calculate_configuration 	proc near	
; figure num in ax, rotate in buf current_rotate, res(start byte of configuration) in ax
; figure numered like in table
	push    bx
    push    cx
    push 	dx
    push    es
    push    di
    push    si
    
	mov 	si, 	offset current_rotate
	mov 	bx, 	[si]					; link to current_rotate in bx
	mov 	dx, 	ax 						; figure num in dx
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

	; cld									; code to paint
	; mov 	ax,		0b800h					; should be at least once in code
	; mov	es, 	ax 						; make third video mode
	; mov	di, 	0
	; mov 	ah, 	00h
	; mov 	al, 	03h
	; int 	10h
	; xor	ax, 	ax
	mov		ah, 	0Eh
	mov 	al, 	050h
	stosw
	mov 	al, 	04fh
	stosw
	mov 	al, 	049h
	stosw
	mov 	al, 	04eh
	stosw
	mov 	al, 	092h
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

	push 	dx
	push 	cx
	push 	bx
	push 	ax
	ret
print_mask endp

change_point 	proc near 			; seems like 999 or 099 or 009 in ax
	push 	bx						; print three-digit num from ax after "Points:"
	push 	cx
	push 	dx

	mov 	ax, 	001
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx

	mov 	bx, 	ax
	call 	int2str16onedigit
	mov 	di, 	16
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw
	pop 	bx
	call 	int2str16onedigit
	mov 	di, 	18
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw
	pop 	bx
	call 	int2str16onedigit
	mov 	di, 	20
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw

	pop 	dx
	pop 	cx
	pop 	bx
	ret
change_point 	endp

change_speed 	proc near 			; seems like 999 or 099 or 009 in ax
	push 	bx						; print three-digit num from ax after "Speed:"
	push 	cx
	push 	dx

	mov 	ax, 	300
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx
	xor 	dx, 	dx
	mov 	bx, 	10
	div 	bx
	push 	dx

	mov 	bx, 	ax
	call 	int2str16onedigit
	mov 	di, 	176
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw
	pop 	bx
	call 	int2str16onedigit
	mov 	di, 	178
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw
	pop 	bx
	call 	int2str16onedigit
	mov 	di, 	180
	mov		ah, 	0eh
	mov 	al, 	dl
	stosw

	pop 	dx
	pop 	cx
	pop 	bx
	ret
change_speed 	endp

int2str16onedigit 	proc near 		; num in al, res in al
	push 	bx							; make 10 num from 16 num
	push 	cx
	push 	dx

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

    mov     si,     offset output_msg	; you can change buffer
    mov 	cx, 	3					; you can change how many digits to print

    loopn2b:
    	cmp 	ax, 	0
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

	pop 	ax
	mov		[si],	ax
	pop 	ax
	mov		[si + 1],	ax
	pop 	ax
	mov		[si + 2],	ax
	pop 	ax
	mov		[si + 3],	ax
	pop 	ax
	mov		[si + 4],	ax

    pop     si
    pop     di
    pop     es
    pop		dx
    pop     cx
    pop		bx
    ret
num2buf 	endp

figure_generator 	proc near			; make new figure num in next_figure
	xor 	dx, 	dx
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

	ret
figure_generator	endp

begin 	proc near
	cld
	mov		ax, 	0b800h
	mov		es, 	ax
	mov		di, 	0
	mov 	ah, 	00h
	mov 	al, 	03h
	int 	10h
	xor		ax, 	ax
	mov 	si,		1
	mov 	di, 	11

@@2:
	xor		ah,		ah
	int		16h
	cmp		ah, 	1
	jne		@@2
	int 	19h
ret
begin 	endp
end 	_start