
.model small
;	SIMULATION OF TYPE COMMAND OF DOS
.data
        ERROR   DB 13,10,'UNSUCCESSFUL : $'
        MES_1   DB 13,10,'ENTER FNAME : ',0ah,0dh, '$'
        MES_2   DB 13,10, 'FILE IS TYPED $'
	FNAME	DB 22		; Buffer for type command
		DB 0
		DB 22 DUP (0)
	BUFF	DB 2048 DUP (0)
	HANDLE DW ?		; Buffer for HANDLE
.code
BEGIN : MOV     AX,@data        ; Initialise data SEGMENT
	MOV	DS,AX
	MOV 	AH,09H
	LEA	DX,MES_1	;  Display message
	INT	21H
	MOV	AH,0AH		; Enter file name
	LEA	DX,FNAME
	INT	21H
	MOV	SI,DX		; Make ASCIIZ
	MOV	BL,[SI+1]
	ADD	SI,02H
	MOV	BYTE PTR[SI+BX],00H
				; Open the file
	MOV	AH,3DH		; Open file to type
	MOV	AL,02H
	MOV	DX,OFFSET FNAME[2]
	INT	21H
	JC	UNS
	MOV	HANDLE,AX	; Store handle
	XOR	SI,SI
ME :	MOV	AH,3FH		; Read file
	MOV	BX,HANDLE
	MOV	CX,512
	LEA	DX, BUFF
	INT	21H
	JC	UNS
	MOV	SI,AX
	MOV	AH,40H		; Write file
	MOV	BX,0001
	MOV	CX,SI
	LEA	DX,BUFF
	INT	21H
	CMP	CX,512
	JE	ME
	MOV	AH,3EH		; Close file
	MOV	BX,HANDLE
	INT	21H
	JMP	AWAIT
UNS :	MOV	AH,09H
	MOV	DX,OFFSET ERROR
	INT	21H
AWAIT :	MOV	AH,09H
	MOV	DX,OFFSET MES_2	; File is typed
	INT	21H
	MOV	AH,4CH		; Terminate
	INT	21H
        END     BEGIN
        END

