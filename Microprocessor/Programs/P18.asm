
.model small
.stack 100
.data
        MS1     DB 10,13,'ENTER THE NO.:$'
        MS2     DB 10,13,'THE FACTORIAL IS : $'
	NUM	DW 0
        ANS     DW 0
.code
START:  MOV     DX,@data        ; Initialisation
	MOV	DS,DX
ERROR:	LEA	DX,MS1
	MOV	AH,09H		; Output MS1
	INT	21H
	MOV	AH,01H		; Input no with echo
	INT	21H
	CMP	AL, 30H		; If zero display 1
	JE	DISPLY2		
	CMP	AL,30H		; If < 30 then input
	JB	ERROR		; Next no
	CMP	AL, 39H		; If >39 then input
	JA	ERROR		; Next no
	SUB	AL, 30H		;Convert to HEX
	MOV	AH, 00H
	SUB	SP,0004H	; Space in stack for
	PUSH	AX		; Factorial
	CALL	FACTO
	ADD	SP, 0002	; After execution
	POP	AX		; Of facto space for
	POP	DX		; Result
	MOV	BX, 0010	; Convert HEX to BCD
	MOV	CX, 0006	; Max input no is 9
BACK:	DIV	BX		; To get remainder
	OR	DX, 0030H	; Convert to ASCII
	PUSH	DX
	XOR	DX, DX		; Clear DX
	LOOP	BACK
	LEA	DX, MS2		; Output MS2
	MOV	AH, 09
	INT	21H
	MOV	CX, 0006
DISPLY1:	POP	DX
	MOV	AH, 02H		; Output factorial
	INT	21H
	LOOP	DISPLY1
	JMP	LAST
DISPLY2:	MOV	AH, 09
	LEA	DX, MS2		; Display factorial of
        INT     21H             ; Zero = 1
	MOV	AH, 02H
	MOV	DL, 31H
	INT	21H
LAST:	MOV	AH,4CH		; Terminate the program.
	INT	21H
FACTO   PROC    
	PUSHF
	PUSH	AX
	PUSH	DX
	PUSH	BP
	MOV	BP, SP		; Point BP at TOS
	MOV	AX,[BP + 10]	; Copy no from stack to
	CMP	AX,0001H	; AX & if no not = 1 then go on
	JNE	GO_ON		; To compute factorial
	MOV	WORD PTR[BP + 12],0001H
				; Else load FFACT
	MOV	WORD PTR [BP + 14],0000H
				; 0 and 1 in stack
	JMP	EXIT
GO_ON:	SUB	SP, 0004H	; Space for preliminary
	DEC	AX		; Factorial
	PUSH	AX
	CALL	FACTO
	MOV	BP, SP
	MOV	AX, [BP+2]	; Last (N - 1)! from stack to AX
	MUL	WORD PTR [BP+16]; Multiply by previous N
	MOV	[BP + 18], AX	; Copy new facto to stack
	MOV	[BP + 20], DX
	ADD	SP, 0006H	; Point SP at pushed REGR
EXIT :	POP	BP
	POP	DX
	POP	AX
	POPF
	RET
FACTO	ENDP
       	END	START
        

