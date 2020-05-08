.model tiny
.code
org 100h

begin:
    jmp short _start
    nop
_start:
    cld
    mov ax, 0b800h
    mov es, ax
    call PrintField
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h


ScreenClear proc
        mov     ax,     03h
        int 10h
        ret
ScreenClear endp


PrintField proc
        push    ax
        push    bx
        push    cx
        push    dx

        call ScreenClear
        mov     cx,     24
        mov     ax,     0b800h
        mov     es,     ax
        mov     di,     60

    _loop1:
        cmp     cx,     0
        je      _last  
        mov     ah,     0ah
        mov     al,     word_buf
        stosw
        add     di,     36
        stosw
        add     di,     120
        dec     cx
        jmp _loop1

    _last:
        mov     al,     0C8h
        stosw
        mov     cx,     18
        mov     al,     0CDh

    _loop2:
        stosw
        loop _loop2
        mov     al,     0BCh
        stosw

    _exit:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
        word_buf db     0C7h
PrintField endp

org	766
dw	0aa55h
end begin