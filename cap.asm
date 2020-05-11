.model tiny
.386
.data
cap1          db      'Hello, Siberian Player!(press a key)'; 23 698
cap2          db      'Your game was BRILLIANT and AMAZING!!!'; 38 844
cap3          db      'We`re hoping to see you again.'; 30, 1012
cap4          db      'This pale copy on Tetris developed by'; 34 1168
cap5          db      'L@G inc.' ; 9 1352
cap6          db      'DEVELOPERS:'; 11 1510
cap7          db      '@D-rection' ; 10 1670
cap8          db      '@LeoPoldOff'; 11 1830
cap9          db      '@AgaFFon'; 8 1990
cap10         db      'Thank you for playing'; 21 2140
cap11         db      '$$$THE COOLEST TETRIS IN THE JUNGLE$$$'; 38 2284

.code
org 100h
_start:
jmp     begin

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
    mov     cx,     36
    mov     di,     686
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
    mov     cx,     37
    mov     di,     1164
    call    print_si_string

    mov     ah,     0
    int     16h
    mov     si,     offset  cap5
    mov     cx,     9
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

    call    print_caps

@@2:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@2
    int     19h
ret
begin   endp
end     _start