.model tiny
.386
.data
conf1          db      '1-9    = TO CHANGE SPEED MODE OF FALLING'
conf2          db      'arrows = TO MOVE THE FIGURE'
conf3          db      's      = TO STOP'
conf4          db      'w      = TO PAUSE'
conf5          db      'space  = TO DROP THE FIGURE'
conf6          db      'a/s    = TO TURN THE FIGURE LEFT/RIGHT'
conf7          db      'q/e    = TO DECREASE/INCREASE SPEED OF FALLING'
conf8          db      'n      = TO START NEW GAME'
conf9          db      'b      = TO END'
.code
org 100h
_start:
jmp     begin

print_conf      proc near					; print the configuration screen
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
print_conf		endp

print_si_string	proc near			; res - printing
    push    ax						; offset in si, length in cx, place in di
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

    call    print_conf

@@2:
    xor     ah,     ah
    int     16h
    cmp     ah,     1
    jne     @@2
    int     19h
ret
begin   endp
end     _start