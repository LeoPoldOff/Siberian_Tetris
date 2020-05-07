.model tiny

.data
output_msg      db      '     '
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
	mov ax, 608
	call num2buf
	call print_string
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h
ret
begin endp
end _start