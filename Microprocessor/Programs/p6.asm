
	NAME Separate even_odd
	PAGE 52,80
	TITLE Separate even and odd numbers in the array.
.model small
.STACK 100
.data
        ARRAY    DB 12H,23H,26H,63H,25H,86H,2FH,33H,10H,35H
        ARR_ODD  DB 10 DUP (?)
        ARR_EVEN DB 10 DUP (?)
.code
START:  MOV AX,@data    ; [ Initialise
        MOV DS,AX       ;   data segment ]
        MOV CL,10       ; Initialise counter
        XOR DI,DI       ; Initialise odd_pointer
        XOR SI,SI       ; Initialise even_pointer
        LEA BP,ARRAY    ; Initialise array base_pointer
BACK:   MOV AL,DS:[BP]  ; Get the number
        AND AL,01H      ; Mask all bits except LSB
        JZ  NEXT        ; If LSB = 0 go to next
        LEA BX,ARR_ODD  ; [ Otherwise 
        MOV AH,[BX+DI]  ;   initialse pointer to odd array 
        MOV ARR_ODD,AH  ;   and save number in odd array ]
        INC DI          ; Increment odd_pointer
        JMP SKIP
NEXT:   LEA BX,ARR_EVEN ; [ Initialise pointer 
        MOV AH,[BX+SI]  ;   to even array and save number
        MOV AH,ARR_EVEN ;   in even array
        INC SI          ; Increment even_pointer

SKIP:   INC BP          ; Increment array base_pointer
        DEC CL          ; Decrement counter
        JNZ BACK        ; if not 0 go to back
        END START
