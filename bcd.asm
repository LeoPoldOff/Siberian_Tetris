.model tiny
.code
org 100h

begin:
    jmp short _start
    nop
_start:
   ; mov     bx,     1
   ; mov     cx,     2
   ; mov     dx,     3
    call bcd2int
@@2:
	xor	ah,ah
	int	16h
	cmp	ah, 1
	jne	@@2
	int 19h


bcd2int proc                            ; bcd-число лежит в ax
        push    bx
        push    cx
        push    dx

        xor     cx,     cx
       ; mov     ax,     01010001b      ; значение ax для проверки
        
        mov     bx,     ax
        mov     dx,     ax              ; bx - первая цифра
        shl     dx,     12
        shr     dx,     12              ; dx - вторая цифра
        shr     bx,     4

        mov     ax,     1
        call    one_mul

        mov     ax,     2
        call    one_mul

        mov     ax,     4               ; вычленяем правый бит
        call    one_mul                 ; и умножаем на нужную степень двойки

        mov     ax,     8
        call    one_mul

        mov     bx,     dx
        mov     ax,     10
        mul     cx
        mov     cx,     ax

        mov     ax,     1
        call    one_mul
        
        mov     ax,     2               ; то же самое для второй цифры
        call    one_mul

        mov     ax,     4
        call one_mul

        mov     ax,     8
        call one_mul

        mov     ax,     cx              ; переведенное тоже лежит в ax
        pop     dx
        pop     cx
        pop     bx

        ret
bcd2int endp

one_mul proc
        push    bx
        shl     bx,     15
        shr     bx,     15
        push    dx
        mul     bx
        add     cx,     ax
        pop     dx
        pop     bx
        shr     bx,     1

        ret
one_mul endp


org	766
dw	0aa55h
end begin