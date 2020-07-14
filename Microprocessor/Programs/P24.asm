
NAME LCM
PAGE 60,80
TITLE program to find LCM of two 16-bit unsigned numbers
.MODEL SMALL
.STACK 64
.DATA
		NUMBERS 	DW 0020, 0015
		LCM 		DW 2 DUP (?)
.CODE
START: 				MOV AX,@DATA 		; [Initialize
				MOV DS,AX 		; data segment]
				MOV DX,0
				MOV AX,NUMBERS 		; Get the first number
				MOV BX,NUMBERS+2 	; Get the second number
BACK: 		PUSH AX 				; [ Save the
				PUSH DX 		;   first number]
				DIV BX 			; Divide if by second number
				CMP DX,0		; Check if remainder = 0
				JE EXIT 		; if remainder = 0 then exit
				POP DX
				POP AX 				
				ADD AX,NUMBERS 		; First number + first number
				JNC SKIP
				INC DX
SKIP: 		JMP BACK 				; Goto BACK
EXIT: 		POP LCM+2 				; [ Get
				POP LCM 		;   the LCM ]
				MOV AH,4CH 		; [ Terminate and
				INT 21H 		;   Exit to DOS ]
				END START


