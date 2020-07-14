	NAME ARRAY SUM
	PAGE 52,80
	TITLE 8086 ALP to find sum of numbers in the array
.model small
.data
        ARRAY   DB 12H,24H,26H,63H,25H,86H,2FH,33H,10H,35H
        SUM     DW 0
.code
START:  MOV AX,@data    ; [ Initialise
        MOV DS,AX       ;   data segment ]
        MOV CL,10       ; Initialise counter
        XOR DI,DI       ; Initialise pointer
        LEA BX,ARRAY    ; Initialise array base pointer
BACK:   MOV AL,[BX+DI]  ; Get the number
        MOV AH,00H      ; Make higher byte 00h
        ADD SUM,AX      ; SUM = SUM + number
        INC DI          ; Increment pointer
        DEC CL          ; Decrement counter
        JNZ BACK        ; if not 0 go to back
        MOV AH,4CH
        INT 21H
        END START
