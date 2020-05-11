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
.code
org 100h
_start:
jmp     begin

print_menu 	proc near
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

print_si_string	proc near
    push    ax
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

    call    print_menu

@@2:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@2
    int     19h
ret
begin   endp
end     _start