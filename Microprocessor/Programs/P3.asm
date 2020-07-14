.model small
.stack 100
.data
      ARRAY    DB 63H,32H,45H,75H,12H,42H,09H,14H,56H,38H ; Array of ten numbers
      MAX      DB 0    	; Maximum number
.code
START: 	MOV AX,@data	; [ Initialises
	MOV DS,AX	;  data segment ]
        XOR DI,DI       ; Initialise pointer
        MOV CL,10       ; Initialise counter
        LEA BX,ARRAY    ; Initialise base pointer for array
        MOV AL,MAX      ; Get maximum number
BACK:   CMP AL,[BX+DI]  ; Compare number with maximum
        JNC SKIP
        MOV DL,[BX+DI]  ; [ If number > MAX
        MOV AL,DL       ;    MAX = number ]
SKIP:   INC DI          ; Increment pointer
        DEC CL          ; Decrement counter
        JNZ BACK        ; IF count = 0 stop; otherwise go BACK
        MOV MAX,AL      ; Store maximum number
        END START
