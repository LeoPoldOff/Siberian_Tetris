clear_glass proc near                       ; чистит экран в пределах стакана (закрашивает черным)
        push    ax 
        push    bx
        push    cx
        push    dx        
        push    es     
        push    di
        push    si                  


        mov     di,     46
        mov     cx,     32
        mov     dx,     0b800h
        mov     es,     dx
        mov     ah,     00h
        mov     al,     0DBh
    _clear_glass_loop_1:
        stosw
        loop    _clear_glass_loop_1

        mov     cx,     23
    _clear_glass_step_2:
        add     di,     96
        push    cx
        mov     cx,     32
    _clear_glass_loop_2:
        stosw
        loop    _clear_glass_loop_2

        pop     cx
        loop    _clear_glass_step_2

        pop     si
        pop     di
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
    ret
clear_glass endp