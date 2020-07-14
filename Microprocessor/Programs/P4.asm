.model small
.stack 100
.data
       ARRAY    DB 63H,32H,45H,75H,12H,42H,09H,14H,56H,38H ; Array of ten numbers
       SER_NO   DB 09H    	; Number to be searched
       SER_POS  DB ?      	; Position of the searched number
.code
START: 	MOV AX,@data		; [ Initialises
        MOV DS,AX               ;  data segment ]
        MOV ES,AX
        MOV CX,000AH            ; Initialise counter
        LEA DI,ARRAY            ; Initialise base pointer for array
        MOV AL,SER_NO           ; Get the number to be searched in AL
        CLD                     ; Clear direction flag
        REPNE SCAS ARRAY        ; Repeat until match occurs or CX = 0
        MOV AL,10               ; [ Find the searched number position in the array
        SUB AL,CL               ;   if SER_POS is 0 number is not in array; otherwise
        MOV SER_POS,AL          ;   SER_POS gives the position of number in the array ]
        END START
