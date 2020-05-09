.model tiny
.386

.data
output_msg      db      '     '
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
	dw		0012h

current_position:
		dw		0228h
		dw		0207h
		dw		0116h
		dw		0155h
	
saved_position:
		dw		9999h
		dw		8888h
		dw		7777h
		dw		5555h

current_rotate	dw		4 ; 1-straight, 2-right, 3-overturned, 4-left
		
saved_rotate	dw		2 ; 1-straight, 2-right, 3-overturned, 4-left

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
jmp begin

get_position proc near ; res, coordinates of up left corner of current_position, in ax
	push bx
	push cx
	push dx

	lea bx, current_position ; link to current_position
	mov ax, [bx]
	xor dx, dx
	mov cx, 10h ; to have column in dx, str in ax
	div cx
	push ax
	push dx

	mov ax, [bx + 2] ; second element of current_position to ax
	xor dx, dx
	mov cx, 10h ; to have column in dx, str in ax
	div cx
	pop cx
	pop bx

	cmp ax, bx
	jle _lessequalstr
	jmp _greaterstr

_lessequalstr:
	push ax
	cmp dx, cx
	jle _lessequalcolumn
	jmp _greatercolumn

_greaterstr:
	push bx
	cmp dx, cx
	jle _lessequalcolumn
	jmp _greatercolumn

_lessequalcolumn:
	push dx
	jmp _round2

_greatercolumn:
	push cx

; in stack the most little column/the most little str from 1 and 2 in current_position
_round2: ; the same comparison with 3 in current_position
	lea bx, current_position
	mov ax, [bx + 4]
	xor dx, dx
	mov cx, 10h ; to have column in dx, str in ax
	div cx
	pop cx
	pop bx

	cmp ax, bx
	jle _lessequalstr1
	jmp _greaterstr1

_lessequalstr1:
	push ax
	cmp dx, cx
	jle _lessequalcolumn1
	jmp _greatercolumn1

_greaterstr1:
	push bx
	cmp dx, cx
	jle _lessequalcolumn1
	jmp _greatercolumn1

_lessequalcolumn1:
	push dx
	jmp _round3

_greatercolumn1:
	push cx

; in stack the most little column/the most little str from 1, 2 and 3 in current_position
_round3: ; the same comparison with 4 in current_position
	lea bx, current_position
	mov ax, [bx + 6]
	xor dx, dx
	mov cx, 10h ; to have column in dx, str in ax
	div cx
	pop cx
	pop bx

	cmp ax, bx
	jle _lessequalstr2
	jmp _greaterstr2

_lessequalstr2:
	push ax
	cmp dx, cx
	jle _lessequalcolumn2
	jmp _greatercolumn2

_greaterstr2:
	push bx
	cmp dx, cx
	jle _lessequalcolumn2
	jmp _greatercolumn2

_lessequalcolumn2:
	push dx
	jmp _result

_greatercolumn2:
	push cx

_result:
	pop bx
	pop ax
	mov dx, 10h
	mul dx
	add ax, bx
; coordinates of up left corner in aax
	
	pop dx
	pop cx
	pop bx
	ret
get_position endp

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
saved_configuration endp

clear_screen proc near 		; clean game_field
	push ax
	push bx
	push cx
	push si

	lea bx, game_field		; link to game_field in bx
	mov ax, 0000h 			; empty str in ax
	mov cx, 25				; 25 loops

	clearLoop:
		mov [bx], ax 		; make empty str
		add bx, 2			; link to nest str
		loop clearLoop

	pop si
	pop cx
	pop bx
	pop ax
	ret
clear_screen endp

calculate_configuration proc near	
; figure num in ax, rotate in buf current_rotate, res(start byte of configuration) in ax
; figure numered like in table
	push    bx
    push    cx
    push 	dx
    push    es
    push    di
    push    si
    
	mov si, offset current_rotate
	mov bx, [si]						; link to current_rotate in bx
	mov dx, ax 							; figure num in dx
	cmp bx, 1							; check what rotate
	je _up
	cmp bx, 2
	je _right
	cmp bx, 3
	je _down
	cmp bx, 4
	je _left

_up:									; if straight rotate
	cmp dx, 1
	mov ax, offset figure_square
	je _ret
	cmp dx, 2
	mov ax, offset figure_dot
	je _ret
	cmp dx, 3
	mov ax, offset figure_2dots
	je _ret
	cmp dx, 4
	mov ax, offset figure_3dots
	je _ret
	cmp dx, 5
	mov ax, offset figure_triangle
	je _ret
	cmp dx, 6
	mov ax, offset figure_g
	je _ret
	cmp dx, 7
	mov ax, offset figure_backg
	je _ret
	cmp dx, 8
	mov ax, offset figure_pyramid
	je _ret
	cmp dx, 9
	mov ax, offset figure_s
	je _ret
	cmp dx, 10
	mov ax, offset figure_backs
	je _ret
	cmp dx, 11
	mov ax, offset figure_4dots
	je _ret

_right:									; if right rotate
	cmp dx, 1
	mov ax, offset right_figure_square
	je _ret
	cmp dx, 2
	mov ax, offset right_figure_dot
	je _ret
	cmp dx, 3
	mov ax, offset right_figure_2dots
	je _ret
	cmp dx, 4
	mov ax, offset right_figure_3dots
	je _ret
	cmp dx, 5
	mov ax, offset right_figure_triangle
	je _ret
	cmp dx, 6
	mov ax, offset right_figure_g
	je _ret
	cmp dx, 7
	mov ax, offset right_figure_backg
	je _ret
	cmp dx, 8
	mov ax, offset right_figure_pyramid
	je _ret
	cmp dx, 9
	mov ax, offset right_figure_s
	je _ret
	cmp dx, 10
	mov ax, offset right_figure_backs
	je _ret
	cmp dx, 11
	mov ax, offset right_figure_4dots
	je _ret

_down:									; if overturned rotate
	cmp dx, 1
	mov ax, offset overturned_figure_square
	je _ret
	cmp dx, 2
	mov ax, offset overturned_figure_dot
	je _ret
	cmp dx, 3
	mov ax, offset overturned_figure_2dots
	je _ret
	cmp dx, 4
	mov ax, offset overturned_figure_3dots
	je _ret
	cmp dx, 5
	mov ax, offset overturned_figure_triangle
	je _ret
	cmp dx, 6
	mov ax, offset overturned_figure_g
	je _ret
	cmp dx, 7
	mov ax, offset overturned_figure_backg
	je _ret
	cmp dx, 8
	mov ax, offset overturned_figure_pyramid
	je _ret
	cmp dx, 9
	mov ax, offset overturned_figure_s
	je _ret
	cmp dx, 10
	mov ax, offset overturned_figure_backs
	je _ret
	cmp dx, 11
	mov ax, offset overturned_figure_4dots
	je _ret

_left:									; if left rotate
	cmp dx, 1
	mov ax, offset left_figure_square
	je _ret
	cmp dx, 2
	mov ax, offset left_figure_dot
	je _ret
	cmp dx, 3
	mov ax, offset left_figure_2dots
	je _ret
	cmp dx, 4
	mov ax, offset left_figure_3dots
	je _ret
	cmp dx, 5
	mov ax, offset left_figure_triangle
	je _ret
	cmp dx, 6
	mov ax, offset left_figure_g
	je _ret
	cmp dx, 7
	mov ax, offset left_figure_backg
	je _ret
	cmp dx, 8
	mov ax, offset left_figure_pyramid
	je _ret
	cmp dx, 9
	mov ax, offset left_figure_s
	je _ret
	cmp dx, 10
	mov ax, offset left_figure_backs
	je _ret
	cmp dx, 11
	mov ax, offset left_figure_4dots
	je _ret

_ret:
	pop     si
    pop     di
    pop     es
    pop		dx
    pop     cx
    pop		bx
	ret
calculate_configuration endp

print_mask proc near				; print "Speed:" & "Points:" in up left corner
	push ax
	push bx
	push cx
	push dx

	; cld							; code to paint
	; mov	ax, 0b800h				; should be at least once in code
	; mov	es, ax 					; make third video mode
	; mov	di, 0
	; mov ah, 00h
	; mov al, 03h
	; int 10h
	; xor	ax, ax
	mov	ah, 0Eh
	mov al, 050h
	stosw
	mov al, 04fh
	stosw
	mov al, 049h
	stosw
	mov al, 04eh
	stosw
	mov al, 092h
	stosw
	mov al, 053h
	stosw
	mov al, 03ah
	stosw
	add di, 2
	mov al, 030h
	stosw

	add di, 142
	mov al, 053h
	stosw
	mov al, 050h
	stosw
	mov al, 045h
	stosw
	mov al, 045h
	stosw
	mov al, 044h
	stosw
	add di, 2
	mov al, 03ah
	stosw
	add di, 2
	mov al, 030h
	stosw

	push dx
	push cx
	push bx
	push ax
	ret
print_mask endp

change_point proc near 		; seems like 999 or 099 or 009 in ax
	push bx					; print three-digit num from ax after "Points:"
	push cx
	push dx

	mov ax, 001
	xor dx, dx
	mov bx, 10
	div bx
	push dx
	xor dx, dx
	mov bx, 10
	div bx
	push dx

	mov bx, ax
	call int2str16onedigit
	mov di, 16
	mov	ah, 0eh
	mov al, dl
	stosw
	pop bx
	call int2str16onedigit
	mov di, 18
	mov	ah, 0eh
	mov al, dl
	stosw
	pop bx
	call int2str16onedigit
	mov di, 20
	mov	ah, 0eh
	mov al, dl
	stosw

	pop dx
	pop cx
	pop bx
	ret
change_point endp

change_speed proc near 			; seems like 999 or 099 or 009 in ax
	push bx						; print three-digit num from ax after "Speed:"
	push cx
	push dx

	mov ax, 300
	xor dx, dx
	mov bx, 10
	div bx
	push dx
	xor dx, dx
	mov bx, 10
	div bx
	push dx

	mov bx, ax
	call int2str16onedigit
	mov di, 176
	mov	ah, 0eh
	mov al, dl
	stosw
	pop bx
	call int2str16onedigit
	mov di, 178
	mov	ah, 0eh
	mov al, dl
	stosw
	pop bx
	call int2str16onedigit
	mov di, 180
	mov	ah, 0eh
	mov al, dl
	stosw

	pop dx
	pop cx
	pop bx
	ret
change_speed endp

int2str16onedigit proc near ; num in al, res in al
	push bx					; make 10 num from 16 num
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

print_string                proc near
    push    ax
    push    cx
    push    es
    push    di
    ; push    si

    mov     ax,     0b800h
    mov     es,     ax
    mov     di,     660
    xor     ax,     ax
    mov     cx,     4
    ; mov     si,     offset output_msg
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

num2buf proc near 		; num in ax, res in output_msg
    push    bx			; transport num from ax to bufer output_msg
    push    cx
    push 	dx
    push    es
    push    di
    push    si

    mov     si,     offset output_msg	; you can change buffer
    mov cx, 5							; you can change how many digits to print

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

begin proc near
	cld
	mov	ax, 0b800h
	mov	es, ax
	mov	di, 0
	mov ah, 00h
	mov al, 03h
	int 10h
	xor	ax, ax
	call get_position
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h
ret
begin endp
end _start