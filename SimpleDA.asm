.model small
.code
    org 100h       ; ORG directive for COM file

start:
    mov ax, 13h     ; Set video mode (320x200 pixels, 256 colors)
    int 10h

draw_snake:
    mov ah, 0ch     ; Set pixel color
    mov al, 02h     ; Color (green)
    mov bh, 0       ; Page number
    mov cx, x_pos   ; X position
    mov dx, y_pos   ; Y position
    int 10h

    ; Move the snake
    mov ah, 0       ; Get keypress
    int 16h
    cmp ah, 4ch     ; Right arrow key
    je  move_right
    cmp ah, 48h     ; Up arrow key
    je  move_up
    cmp ah, 50h     ; Down arrow key
    je  move_down
    cmp ah, 4bh     ; Left arrow key
    je  move_left

    ; Move the snake based on the current direction
    cmp direction, 6
    je  move_right
    cmp direction, 8
    je  move_up
    cmp direction, 2
    je  move_down
    cmp direction, 4
    je  move_left

move_right:
    add word ptr [x_pos], 1   ; Increment word at x_pos
    mov direction, 6
    jmp draw_snake

move_up:
    sub word ptr [y_pos], 1   ; Decrement word at y_pos
    mov direction, 8
    jmp draw_snake

move_down:
    add word ptr [y_pos], 1   ; Increment word at y_pos
    mov direction, 2
    jmp draw_snake

move_left:
    sub word ptr [x_pos], 1   ; Decrement word at x_pos
    mov direction, 4
    jmp draw_snake

    int 20h           ; Exit program

.data
    x_pos dw 10    ; Initial X position of the snake
    y_pos dw 10    ; Initial Y position of the snake
    direction db 6 ; Initial direction (6 = right)
