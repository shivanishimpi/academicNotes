
; This program displays the entered
; character (A-Z or a-z) in UPPER_CASE
.model small
.stack 100
.code
;-------------------------------------------------------------
  Extrn key_in:far
  Extrn dis_char:far
;-------------------------------------------------------------
start:  call key_in
        cmp al,'Z'
        jbe skip
        sub al,20H
skip:   call dis_char
        mov ah,4ch
        int 21h
        end start
        end
