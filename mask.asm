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
		dw		1111h
		dw		2222h
		dw		3333h
		dw		4444h
	
saved_position:
		dw		9999h
		dw		8888h
		dw		7777h
		dw		5555h

current_rotate	dw		4 ;1-straight, 2-right, 3-overturned, 4-left
		
saved_rotate	dw		2

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

restore_configuration proc near	; transport saved position & configuration
	push ax						;to current position and configuration
	push bx

	lea bx, saved_position

	mov ax, [bx]
	lea bx, current_position
	mov [bx], ax
	lea bx, saved_position

	mov ax, [bx + 2]
	lea bx, current_position
	mov [bx + 2], ax
	lea bx, saved_position

	mov ax, [bx + 4]
	lea bx, current_position
	mov [bx + 4], ax
	lea bx, saved_position

	mov ax, [bx + 6]
	lea bx, current_position
	mov [bx + 6], ax
	lea bx, saved_position

	lea bx, saved_rotate
	mov ax, [bx]
	lea bx, current_rotate
	mov [bx], ax

	; lea bx, current_position
	; mov ax, [bx]
	; mov ax, [bx + 2]
	; mov ax, [bx + 4]
	; mov ax, [bx + 6]

	; lea bx, current_rotate
	; mov ax, [bx]


	pop bx
	pop ax
	ret
restore_configuration endp

saved_configuration proc near ; transport current position & configuration
	push ax						;to saved position and configuration
	push bx

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

	; lea bx, saved_position
	; mov ax, [bx]
	; mov ax, [bx + 2]
	; mov ax, [bx + 4]
	; mov ax, [bx + 6]

	; lea bx, saved_rotate
	; mov ax, [bx]

	pop bx
	pop ax
	ret
saved_configuration endp

clear_screen proc near ; clean game_field
	push ax
	push bx
	push cx
	push si

	lea bx, game_field
	mov ax, 0000h
	mov cx, 25

	clearLoop:
		mov [bx], ax
		add bx, 2
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
	mov bx, [si]
	mov dx, ax
	cmp bx, 1
	je _up
	cmp bx, 2
	je _right
	cmp bx, 3
	je _down
	cmp bx, 4
	je _left

_up:
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

_right:
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

_down:
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

_left:
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

print_mask proc near
	push ax
	push bx
	push cx
	push dx

	; cld
	; mov	ax, 0b800h
	; mov	es, ax
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

change_point proc near ; seems like 999 or 099 or 009 in ax
	push bx
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

change_speed proc near ; seems like 999 or 099 or 009 in ax
	push bx
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

num2buf proc near ; num in ax, res in output_msg
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

begin proc near
	cld
	mov	ax, 0b800h
	mov	es, ax
	mov	di, 0
	mov ah, 00h
	mov al, 03h
	int 10h
	xor	ax, ax
	call restore_configuration
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h
ret
begin endp
end _start