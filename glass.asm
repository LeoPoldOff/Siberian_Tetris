.model tiny
.code
org 100h

begin:
    jmp short _start
    nop
_start:

    call    draw_field


@@2:
	    xor	    ah,     ah
	    int	16h
	    cmp	    ah,     1
	    jne	    @@2
	    int 19h


game_field:
	    dw		1111h
	    dw		6666h
	    dw		2222h
	    dw		3333h
	    dw		2222h
	    dw		1111h
	    dw		4444h
	    dw		5555h
	    dw		6666h
	    dw		7777h
	    dw		8888h
	    dw		9999h
	    dw		4444h
	    dw		5555h
	    dw		6666h
	    dw		7777h
	    dw		8888h
	    dw		9999h
	    dw		1111h
	    dw		6666h
	    dw		2222h
	    dw		3333h
	    dw		2222h
	    dw		1111h
        




ScreenClear proc near                       ; полная чистка экрана
        mov     ax,     03h
        int 10h
        ret
ScreenClear endp


draw_glass proc near                         ; рисуем стакан
        push    ax
        push    bx
        push    cx
        push    dx

        call ScreenClear
        mov     cx,     24
        mov     ax,     0b800h
        mov     es,     ax
        mov     di,     44

    _loop1:                             ; рисуем 24 строки с вертикальными границами
        cmp     cx,     0
        je      _last  
        mov     ah,     08h
        mov     al,     word_buf
        stosw
        add     di,     64
        stosw
        add     di,     92
        dec     cx
        jmp _loop1

    _last:                              ; рисуем последнюю строку (нижнюю границу)
        mov     al,     0DBh ;0C8h            ; левый уголок
        stosw
        mov     cx,     32
        mov     al,     0DBh ;0CDh            ; горизонтальная нижняя граница

    _loop2:
        stosw
        loop _loop2
        mov     al,     0DBh ;0BCh            ; правый уголок
        stosw

    _exit:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
        word_buf db     0DBh ;0C7h            ; вертикальная граница
draw_glass endp


draw_field proc near                                  ; рисует игровое поле
        push    ax                              ; использует draw_str и drawer
        push    bx
        push    cx
        push    dx                               
        cld
        call    draw_glass                      ; вызов отрисовки стакана (можно убрать в любое другое место)

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

        pop     dx
        pop     cx
        pop     bx
        pop     ax
    ret

draw_field endp


draw_str proc near                              ; рисует строку из квадратов
    _str_loop:                                  ; каждый квадрат занимает 2 клетки
            push    ax                          ; использует drawer
            shr     ax,     15
            shl     ax,     15
            cmp     ax,     8000h
            je      _print
            add     dx,     4
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _cont
            dec     cx
            jmp     _str_loop
        _print:
            call    drawer
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _cont
            dec     cx
            jmp     _str_loop
        
        _cont:
            ret
draw_str endp


drawer proc near                        ; рисует квадрат из 2х прямоугольников в указанном месте
        push    dx                      ; используется в draw_str
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
        ret
drawer endp


dw	0aa55h
end begin