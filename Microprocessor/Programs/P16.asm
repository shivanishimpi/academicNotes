
DISP 	MACRO 	CHR		; Variable
	MOV AH,02H			
	FOR ARG,<CHR>		; Start of FOR
	MOV DL,ARG
	INT 21H
	ENDM			; End of FOR
	ENDM			; End of macro
.MODEL SMALL
.CODE 
START: 	DISP 	'M', 'A', 'C', 'R', 'O'
	END START


