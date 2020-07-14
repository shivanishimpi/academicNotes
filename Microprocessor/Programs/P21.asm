
.model small
.data
	M1 	DB 10, 13, 'Enter the string : $'
	M2 	DB 10, 13, 'String is palindrome $'
	M3 	DB 10, 13, 'String is not palindrome $'
	BUFF 	DB 80
		DB 0
		DB 80 DUP (0)
.code
START:  MOV AX, @data
        MOV DS,  AX
        MOV AH,  09H           	; Display message M1
	MOV DX,  OFFSET M1
        INT 21H
	MOV AH,  0AH 		; input the string
	LEA  DX,  BUFF
	INT 21H
        LEA BX,  BUFF+2
        MOV CH,  00H
        MOV CL,  BUFF+1
        MOV DI,  CX
        DEC di
	SAR CL,  1
        MOV SI,  00H
BACK:  MOV AL,  [BX + DI]       ; Get the right most character
        MOV AH, [BX + SI]       ; Get the left most character
	CMP AL,  AH
	JNZ  LAST
	DEC DI
	INC SI
	DEC  CL
	JNZ  BACK
        MOV AH,  09H            ; Display message 2
	MOV DX,  OFFSET M2
	INT 21H
	JMP  TER
LAST:  MOV AH,  09H
	MOV DX,   OFFSET M3 	; Display message 3
        INT  21H
TER:   MOV AH,  4CH
        INT  21H
        END START
