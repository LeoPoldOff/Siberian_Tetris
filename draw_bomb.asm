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