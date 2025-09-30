; boot.asm
BITS 16
ORG 0x7C00

start:
    cli                 ; disable interrupts

    ; Setting up segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00      ; stack below bootloader (just a safe place)

    call clearscreen
    call movecursor
    mov si, msg
    call print

hang:
    jmp hang            ; infinite loop

clearscreen:
    mov ah, 0x06        ; scroll window up
    mov al, 0           ; number of lines to scroll (0 = clear entire screen)
    mov bh, 0x07        ; attribute (white on black)
    mov cx, 0x0000      ; upper-left corner
    mov dx, 0x184F      ; lower-right corner (24 rows x 80 cols)
    int 0x10
    ret

movecursor:
    mov dh, 0           ; row
    mov dl, 0           ; column
    mov bh, 0           ; page
    mov ah, 0x02        ; set cursor position
    int 0x10
    ret

print:
    .print_loop:
        lodsb           ; load byte at DS:SI into AL, increment SI
        cmp al, 0
        je .done
        mov ah, 0x0E    ; teletype output
        mov bh, 0       ; page
        int 0x10
        jmp .print_loop
    .done:
    ret

msg: db "Here's a bootloader, and my first step towards TRYING to create an operating system haha XD", 0

; Fill boot sector to 512 bytes
times 510-($-$$) db 0
dw 0xAA55

