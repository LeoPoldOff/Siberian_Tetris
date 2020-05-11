model tiny
.386
.code
org 100h

begin:
    jmp short _start
    nop
_start:
    call draw_glass
    call    draw_field
    call draw_cur_pos


@@2:
	    xor	    ah,     ah
	    int	16h
	    cmp	    ah,     1
	    jne	    @@2
	    int 19h


game_field:
	    dw		0000h
		dw		0000h
		dw		0020h
		dw		0030h
	    dw		0FFFFh
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
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
        word_buf db     0DBh ;0C7h            ; вертикальная граница
draw_glass endp


current_position:
		dw		0017h
		dw		0027h
		dw		0018h
		dw		0028h


current_color	dw 		3
; 1 - red
; 2 - brown
; 3 - yellow
; 4 - green
; 5 - blue
; 6 - purple
; 7 - cyan


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
        push    bx
        push    cx
        push    dx

        lea     bx,     current_position
        mov     cx,     4
    _loop_cur_pos:              
        mov     ax,     [bx]
        cmp     ax,     0FFFFh
        je      _ret

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
        mov     al,     0DBh
        mov     di,     cx
        stosw
        stosw
        
        pop     cx
        add     bx,     2
        loop    _loop_cur_pos
    _ret:
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
draw_cur_pos endp





draw_field proc near                                  ; рисует игровое поле
        push    ax                              ; использует draw_str и drawer
        push    bx
        push    cx
        push    dx                               
        cld
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
            je      _print_symb
            add     dx,     4
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _conty
            dec     cx
            jmp     _str_loop
        _print_symb:
            call    drawer
            pop     ax
            shl     ax,     1
            cmp     cx,     0
            je      _conty
            dec     cx
            jmp     _str_loop
        
        _conty:
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