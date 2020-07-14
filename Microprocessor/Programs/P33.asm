
.model small

; PROGRAM TO TYPE DEVANAGARI CHARACTER
.data
BUFF	 	DB 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,1,1,1,1,1,1,1,1,1,1,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
		DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
COL		DW 0010H
ROW		DW 0010H
SCOL		DW 001FH
SROW		DW 001FH
.code
START : MOV     AX,@data        ; Initialise data segment
	MOV	DS,AX
	MOV	AH,00H
        MOV     AL,06H          ; Set graphics mode
	INT	10H
	MOV	DX,ROW		; Initialise row and column
	MOV	CX,COL
	XOR	SI,SI
	MOV	AH,08H		; I/P from keyboard
	INT	21H	
	CMP	AL,'P' 		; If character is P, print
	JNE	STOP 		; Otherwise terminate the
				; program
DISP :	MOV	AH,0CH		; Write pixel
	MOV	AL,BUFF [SI]
	MOV	BH,00H
	MOV	CX,COL
	MOV	DX,ROW
	INT	10H
	INC	SI
	INC	COL		; Increment column
	MOV	DI,SCOL
	CMP	COL,DI
	JNE	DISP
	SUB	COL,0FH
	INC	ROW		; Increment ROW
	MOV	BP,SROW
	CMP	ROW,BP
	JNE	DISP
	MOV	AH,08H		; I/P from keyboard
	INT	21H
STOP:   MOV     AH,00H
	MOV	AL,03H		; Change mode
	INT	10H
        MOV     AH,4CH          ; Terminate
	INT	21H
        END     START

