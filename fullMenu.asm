.model tiny
.386
.data
menu1          db      '   /\       TTTTTT  EEEEEE  TTTTTT  RRRRR    IIIIII   SSSS  '; 23 698
menu2          db      '  /||\        TT    EE        TT    RR   RR    II    SS   SS'; 38 844
menu3          db      ' //||\\       TT    EEEEEE    TT    RR RR      II      S    '; 30, 1012
menu4          db      '   ||         TT    EE        TT    RR   R     II  SS   SS  '; 30, 1012
menu5          db      'SIBERIAN      TT    EEEEEE    TT    RR   RR  IIIIII  SSSS   '; 30, 1012
menu6          db      'NEW GAME'
menu7          db      'KEY CONFIGURATION' 
menu8          db      'CAPTIONS'
menu9          db      'EXIT'
menu10         db      'MAY 2020'
menu11         db      'L@G inc.'
dotChoicer     db      '*'
space          db      ' '
cap1           db      'Hello, Siberian Player!(press any key)'; 23 698
cap2           db      'Your game was BRILLIANT and AMAZING!!!'; 38 844
cap3           db      'We`re hoping to see you again.'; 30, 1012
cap4           db      'This pale copy of Tetris was developed by'; 34 1168
cap5           db      'L@G inc.' ; 9 1352
cap6           db      'DEVELOPERS:'; 11 1510
cap7           db      '@D-rection' ; 10 1670
cap8           db      '@LeoPoldOff'; 11 1830
cap9           db      '@AgaFFon'; 8 1990
cap10          db      'Thank you for playing'; 21 2140
cap11          db      '$$$THE COOLEST TETRIS IN THE JUNGLE$$$'; 38 2284
conf1          db      '1-9    = TO CHANGE SPEED MODE OF FALLING'
conf2          db      'arrows = TO MOVE THE FIGURE'
conf3          db      's      = TO STOP'
conf4          db      'w      = TO PAUSE'
conf5          db      'space  = TO DROP THE FIGURE'
conf6          db      'a/d    = TO TURN THE FIGURE LEFT/RIGHT'
conf7          db      'q/e    = TO DECREASE/INCREASE SPEED OF FALLING'
conf8          db      'n      = TO START NEW GAME'
conf9          db      'b      = TO END'

choice         dw      1; 1-new game, 2-config, 3-capt, 4-exit

pointsBuf           dw      7

game_field:
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h
    dw      0000h

current_position:
        dw      0170h
        dw      0171h
        dw      0172h
        dw      0173h
    
saved_position:
        dw      9999h
        dw      8888h
        dw      7777h
        dw      5555h

current_figure  dw      11
; 1 - square
; 2 - dot
; 3 - two dots
; 4 - three dots
; 5 - triangle
; 6 - g
; 7 - back g
; 8 - pyramid
; 9 - s
; 10 - back s
; 11 - four dots
next_figure     dw      11
current_color   dw      1
; 1 - red
; 2 - orange
; 3 - yellow
; 4 - green
; 5 - blue
; 6 - purple
; 7 - brown

next_color      dw      5
current_rotate  dw      1       ; 1-straight, 2-right, 3-overturned, 4-left     
saved_rotate    dw      1       ; 1-straight, 2-right, 3-overturned, 4-left

table_figures:
    rotate_straight:
        figure_square   dw  0cc00h
        figure_dot      dw  08000h
        figure_2dots    dw  0c000h
        figure_3dots    dw  0e000h
        figure_triangle dw  0c800h
        figure_g        dw  0c880h
        figure_backg    dw  0c440h
        figure_pyramid  dw  04e00h
        figure_s        dw  06c00h
        figure_backs    dw  0c600h
        figure_4dots    dw  0f000h
    rotate_right:
        right_figure_square     dw  0cc00h
        right_figure_dot        dw  08000h
        right_figure_2dots      dw  08800h
        right_figure_3dots      dw  08880h
        right_figure_triangle   dw  0c400h
        right_figure_g          dw  0e200h
        right_figure_backg      dw  02e00h
        right_figure_pyramid    dw  08c80h
        right_figure_s          dw  08c40h
        right_figure_backs      dw  04c80h
        right_figure_4dots      dw  08888h
    rotate_overturned:
        overturned_figure_square    dw  0cc00h
        overturned_figure_dot       dw  08000h
        overturned_figure_2dots     dw  0c000h
        overturned_figure_3dots     dw  0e000h
        overturned_figure_triangle  dw  04c00h
        overturned_figure_g         dw  044c0h
        overturned_figure_backg     dw  088c0h
        overturned_figure_pyramid   dw  0e400h
        overturned_figure_s         dw  06c00h
        overturned_figure_backs     dw  0c600h
        overturned_figure_4dots     dw  0f000h
    rotate_left:
        left_figure_square      dw  0cc00h
        left_figure_dot         dw  08000h
        left_figure_2dots       dw  08800h
        left_figure_3dots       dw  08880h
        left_figure_triangle    dw  08c00h
        left_figure_g           dw  08e00h
        left_figure_backg       dw  00e800h
        left_figure_pyramid     dw  04c40h
        left_figure_s           dw  08c40h
        left_figure_backs       dw  04c80h
        left_figure_4dots       dw  08888h


    ; Блок с используемыми буферами
    theend  db      0           
    buf     db      10 dup (0)                  ;   Зарезервировали 10 байт и поместили туда 0
    bufend:                                     ;   Метка
        head    dw      offset buf
        tail    dw      offset buf
    
    exit_flag   db      0
        
    old9    dw      0,   0                      ;no
    tick    db  0
    pause   db  0
    speed   db  008h
.code
org 100h
_start:
jmp     begin

newGame     proc near
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    lea     bx,     pointsBuf
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     choice
    mov     ax,     1
    mov     [bx],    ax

    call    clear_gamefield

    lea     bx,     current_position
    mov     ax,     0000h
    mov     [bx],   ax
    mov     [bx + 2], ax
    mov     [bx + 4], ax
    mov     [bx + 6], ax

    lea     bx,     saved_position
    mov     ax,     0000h
    mov     [bx],   ax
    mov     [bx + 2], ax
    mov     [bx + 4], ax
    mov     [bx + 6], ax

    lea     bx,     current_figure
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     next_figure
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     current_color
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     next_color
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     current_rotate
    mov     ax,     1
    mov     [bx],    ax

    lea     bx,     saved_rotate
    mov     ax,     1
    mov     [bx],    ax

    lea     bx,     theend
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     buf
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     exit_flag
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     tick
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     pause
    mov     ax,     0
    mov     [bx],    ax

    lea     bx,     speed
    mov     ax,     0
    mov     [bx],    ax


    call  ScreenClear
    call  draw_glass
    call  draw_field_and_cur_pos
    call   change_vectors

    push  cs
    pop    ds  
    ccc:
      hlt                    ;  Прерывание программное
      mov    bx,   head
      cmp    bx,   tail
      jz    ccc                ;  Если указатели хвоста и головы совпали - штош, не повезло
      call  read_buf            ;  Читаем информацию из буфера
      call  game_model
      lea    si,    [exit_flag]
      lodsw
      cmp    ax,    1
      jne    ccc

    call  restore_vectors

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
newGame     endp

print_menu 	proc near               ; print menu screen without dot
	push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  menu1
    mov     cx,     60
    mov     di,     14
    call    print_si_string

    mov     si,     offset  menu2
    mov     cx,     60
    mov     di,     174
    call    print_si_string

    mov     si,     offset  menu3
    mov     cx,     60
    mov     di,     334
    call    print_si_string

    mov     si,     offset  menu4
    mov     cx,     60
    mov     di,     494
    call    print_si_string

    mov     si,     offset  menu5
    mov     cx,     60
    mov     di,     654
    call    print_si_string

    mov     si,     offset  menu6
    mov     cx,     8
    mov     di,     1666
    call    print_si_string

    mov     si,     offset  menu7
    mov     cx,     17
    mov     di,     1978
    call    print_si_string

    mov     si,     offset  menu8
    mov     cx,     8
    mov     di,     2306
    call    print_si_string

    mov     si,     offset  menu9
    mov     cx,     4
    mov     di,     2630
    call    print_si_string

    mov     si,     offset  menu10
    mov     cx,     8
    mov     di,     3746
    call    print_si_string

    mov     si,     offset  menu11
    mov     cx,     8
    mov     di,     3906
    call    print_si_string

	pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_menu 	endp

print_dot   proc near                   ; print dot depending on buf choice
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     1664
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     1976
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     2304
    call    print_si_string

    mov     si,     offset  space        ; clean the place where was dot
    mov     cx,     1
    mov     di,     2628
    call    print_si_string

    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _ngDot
    cmp     ax,     2
    je      _configDot
    cmp     ax,     3
    je      _captDot
    jmp     _exitDot

_ngDot:                                         ; print dot near new game
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     1664
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_configDot:                                     ; print dot near configuration
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     1976
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_captDot:                                       ; print dot near caps
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     2304
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret

_exitDot:                                          ; print dit near exit
    mov     si,     offset  dotChoicer
    mov     cx,     1
    mov     di,     2628
    call    print_si_string
    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_dot   endp

chooser     proc near                   ; infinity cycle of changing
    push    ax                          ; dot place depending on pressed buttom and printing menus
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

@@3:
    mov     ax,     03h                 ; clear screen
    int     10h
    call    print_menu
    call    print_dot
    xor     ax,     ax
    int     16h
    cmp     ah,     048h
    je      _upDot                      ; if up was pressed
    cmp     ah,     050h
    je      _downDot                    ; if down was pressed
    cmp     ah,     1
    je      _progExit                   ; if esc was pressed
    cmp     ah,     01Ch
    je      _enter                      ; if enter was pressed
    jmp     @@3

_progExit:
    int     19h

_enter:
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _newGameEnter
    cmp     ax,     2
    je      _configurationEter
    cmp     ax,     3
    je      _captionsEnter
    int     19h

_newGameEnter:                             ; if enter near new game
    ; mov     ax,     03h
    ; int     10h
    call    newGame ;do not exist !!!!!
    jmp     @@3

_configurationEter:                         ; if enter near config
    mov     ax,     03h
    int     10h
    call    print_conf
@@4:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@4
    jmp     @@3

_captionsEnter:                             ; if enter near caps
    mov     ax,     03h
    int     10h
    call    print_caps
@@5:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@5
    jmp     @@3


_upDot:                                 ; changing buf choice
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     1
    je      _forFour
    dec     ax
    mov     [bx],   ax
    jmp     @@3
_forFour:
    mov     ax,     4
    mov     [bx],   ax
    jmp     @@3

_downDot:
    lea     bx,     choice
    mov     ax,     [bx]
    cmp     ax,     4
    je      _forOne
    inc     ax
    mov     [bx],   ax
    jmp     @@3
_forOne:
    mov     ax,     1
    mov     [bx],   ax
    jmp     @@3

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
chooser     endp

print_caps      proc near                   ; print the caption screen
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  cap1
    mov     cx,     38
    mov     di,     684
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap2
    mov     cx,     38
    mov     di,     844
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap3
    mov     cx,     30
    mov     di,     1012
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap4
    mov     cx,     41
    mov     di,     1162
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap5
    mov     cx,     8
    mov     di,     1352
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap6
    mov     cx,     11
    mov     di,     1510
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap7
    mov     cx,     10
    mov     di,     1670
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap8
    mov     cx,     11
    mov     di,     1830
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap9
    mov     cx,     8
    mov     di,     1990
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap10
    mov     cx,     21
    mov     di,     2140
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap11
    mov     cx,     38
    mov     di,     2284
    call    print_si_string

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_caps      endp

print_conf      proc near                   ; print the configuration screen
    push    ax
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     si,     offset  conf1
    mov     cx,     40
    mov     di,     0
    call    print_si_string

    mov     si,     offset  conf2
    mov     cx,     27
    mov     di,     160
    call    print_si_string

    mov     si,     offset  conf3
    mov     cx,     16
    mov     di,     320
    call    print_si_string

    mov     si,     offset  conf4
    mov     cx,     17
    mov     di,     480
    call    print_si_string

    mov     si,     offset  conf5
    mov     cx,     27
    mov     di,     640
    call    print_si_string

    mov     si,     offset  conf6
    mov     cx,     38
    mov     di,     800
    call    print_si_string

    mov     si,     offset  conf7
    mov     cx,     46
    mov     di,     960
    call    print_si_string

    mov     si,     offset  conf8
    mov     cx,     26
    mov     di,     1120
    call    print_si_string

    mov     si,     offset  conf9
    mov     cx,     15
    mov     di,     1280
    call    print_si_string

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_conf      endp

clear_gamefield     proc near                   ; clean game_field
    push    ax
    push    bx
    push    cx
    push    ds
    push    es
    push    si
    push    di

    lea     bx,     game_field              ; link to game_field in bx
    mov     ax,     0000h                   ; empty str in ax
    mov     cx,     24                      ; 24 loops

    clearLoop:
        mov     [bx],   ax                  ; make empty str
        add     bx,     2                   ; link to nest str
        loop    clearLoop

    ; call clear_screen ;<=================== for testing in begin
    ; mov cx, 24
    ; lea bx, game_field
    ; loopx:
    ;   mov ax, [bx]
    ;   inc bx
    ;   inc bx
    ;   loop loopx      ;<=================== for testing in begin

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     cx
    pop     bx
    pop     ax
    ret
clear_gamefield     endp

print_si_string	proc near           ; res - printing
    push    ax                      ; offset in si, length in cx, place in di
    push    bx
    push    cx
    push    dx
    push    ds
    push    es
    push    si
    push    di

    mov     ax,     0b800h
    mov     es,     ax
    xor     ax,     ax

    loop_1:
        lodsb
        mov     ah,     0eh
        stosw
        loop loop_1

    pop     di
    pop     si
    pop     es
    pop     ds
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
print_si_string                endp

begin   proc near
    cld
    mov     ax,     0b800h
    mov     es,     ax
    mov     di,     0
    mov     ah,     00h
    mov     al,     03h
    int     10h
    xor     ax,     ax

    call    chooser

@@2:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@2
    int     19h
ret
begin   endp
end     _start