.model tiny
.code
org 100h
_start:
jmp begin

print_mask proc near
	cld
	mov	ax, 0b800h
	mov	es, ax
	mov	di, 0
	mov ah, 00h
	mov al, 03h
	int 10h
	xor	ax, ax
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
	ret
print_mask endp

change_point proc near ; victim seems like 999 or 099 or 009 in ax
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
	ret
change_point endp

change_speed proc near ; seems like 999 or 099 or 009 in ax
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
	ret
change_speed endp

int2str16onedigit proc near ; victim in bl, res in dl
	mov cl, bl
	mov dl, bl
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
	ret
int2str16onedigit endp

begin proc near
call print_mask
call change_point
call change_speed
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h
ret
begin endp
end _start