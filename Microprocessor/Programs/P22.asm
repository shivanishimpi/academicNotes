
.model small
.data
	M1 		DB 	10, 13, 'ENTER THE STRING : $'
	M2 		DB 	10, 13, 'THE LOWERCASE STRING : $'
	BUFF 		DB 	80
			DB 	0
			DB 	80 DUP (0)
.code
        START :         MOV AX,@data
			MOV DS,  AX
			MOV AH,  09H 		; Display message1
			MOV DX,  OFFSET M1
			INT  21H
			MOV AH, 0AH 		; input the string
			LEA DX,  BUFF
			INT 21H
			MOV AH,  09H
			MOV DX,  OFFSET M2 	; Display message M2
                        INT 21H
			MOV CH,  00H
                        MOV CL,  BUFF + 1       ; Take character count in DI
                        LEA BX, BUFF+2
                        MOV DI,  00H
	BACK : 		MOV DL,  [BX + DI] 	; point to the first character
			ADD DL,  20H 		; convert to lowercase
			MOV AH,  02H 		;
			INT 21H 		; Display the character
			INC DI 			;
			DEC CX 			; Decrement character counter
			JNZ BACK 		; check if zero
			MOV AH,  4CH 		; Return to DOS
			INT 21H
			END START 

