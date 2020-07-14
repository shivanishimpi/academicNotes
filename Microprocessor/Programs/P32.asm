
.model small

TITLE PROGRAM TO DRAW  CONCENTRIC RECTANGLES
.data
	MES_1	DB 13,10,'ENTER THE NUMBER OF RECTANGLES $'
	MES_2	DB 13,10,'INPUT IS INVALID NUMBER $'
COLMIN DW  0100
ROWMIN DW 0050
COLMAX DW 0516
ROWMAX		DW 0198
.code
START : MOV     AX,@data         ; Initialise data segment
	MOV	DS,AX
	MOV	AH,09H
	MOV	DX,OFFSET MES_1
	INT	21H	
	MOV	AH,01H		;  Input from keyboard
	INT	21H
	SUB	AL,30H		; ASCII to hex
	MOV	BL,AL
	MOV	BH,00H
	CMP	BH,07H
	JLE	COP
	MOV	AH,09H
	MOV	DX,OFFSET MES_2
	INT	21H
	JMP	LOP
COP :	MOV	AH,00H		; Set to graphics mode
	MOV	AL,06H
	INT	10H
AGAIN :	MOV	DX,ROWMIN	; Initialise row
	MOV	CX,COLMIN	; Initialise column
GO2 :	MOV	AH,0CH		; Write pixel
	MOV	AL,01H
	MOV	BH,00H
	INT	10H
	INC	CX		; Increment column
	CMP	CX,COLMAX
	JNZ	GO2
NET :	MOV	AH,0CH		; Write pixel
	MOV	AL,01H
	MOV	BH,00H
	INT	10H
	INC	DX
	CMP	DX,ROWMAX
	JNZ	NET
MAP :	MOV	AH,0CH		; Write pixel
	MOV	AL,01H
	INT	10H
	DEC	CX
	CMP 	CX,COLMIN
	JNZ 	MAP
SO :	MOV	AH,0CH 		; Write pixel
	MOV 	AL,01H
	MOV	BH,00H
	INT	10H
	DEC	DX
	CMP	DX,ROWMIN	; Decrement row
	JNZ	SO
	ADD	COLMIN,0AH	; New dimensions
	ADD	ROWMIN,05H
	SUB	COLMAX,0AH
	SUB	ROWMAX,05H
	MOV	AX,ROWMAX
	CMP	AX,ROWMIN	; Limits no of rectangles if
	JLE	LOP		; Height of the rectangle is
	DEC	BL		; Too small
	JNZ	AGAIN
LOP :	MOV	AH,01H
	INT	21H		; Show output until key press
	MOV	AH,00H		; Mode graphics to text
	MOV	AL,03H
	INT	10H
	MOV	AH,4CH		; Terminate
	INT	21H
        END     START

