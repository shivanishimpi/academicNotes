
.model small
.stack 100
.data
TITLE	REVERSE THE WORDS IN STRING
M1      			DB 10,13, 'ENTER THE STRING:$'
M2      			DB 10,13, 'THE REVERSE STRING :$'
BUFF				DB 80
				DB 0
				DB 80 DUP(0)
COUNTER1			DW 0
COUNTER2			DW 0
.code
START:  MOV             AX,@data
	MOV		DS,AX
	MOV		AH,09H		; Display message M1.
	MOV		DX,OFFSET M1
	INT		21H
	MOV		AH,0AH
	LEA		DX,BUFF		; I/P the string.
	INT		21H
	MOV		AH,09H
	MOV		DX,OFFSET M2	; Display message M2
	INT		21H
	LEA		BX,BUFF
	INC		BX
	MOV		CH,00H		; Take character count in DI
	MOV		CL,BUFF + 1
	MOV		DI,CX
BACK:	MOV		DL,[BX + DI]	; Point to the last character
	MOV		AH,02H		; Get the character
	INT		21H		; Display the character
	DEC		DI		; Decrement count
	JNZ		BACK		; Repeat until count is 0
EXIT:	MOV		AH,4CH		; Terminate
	INT		21H
        END     START
        

