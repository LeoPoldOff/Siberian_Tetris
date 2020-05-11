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
conf6          db      'a/s    = TO TURN THE FIGURE LEFT/RIGHT'
conf7          db      'q/e    = TO DECREASE/INCREASE SPEED OF FALLING'
conf8          db      'n      = TO START NEW GAME'
conf9          db      'b      = TO END'

choice         dw      1; 1-new game, 2-config, 3-capt, 4-exit
.code
org 100h
_start:
jmp     begin

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

newGame         proc near                   ; link to tetris
    ret
newGame         endp

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