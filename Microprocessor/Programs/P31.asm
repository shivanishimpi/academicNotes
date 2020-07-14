
.model small

;	SIMULATION OF COPY COMMAND OF DOS
.data
        MES_1           DB 13,10,'ENTER THE SOURCE FILE NAME : $'
        MES_3           DB 13,10,'ENTER THE DESTINATION, FILE : $'
        MES_4           DB 13,10,'THE FILE IS COPIED : $'
        MES_2           DB 13,10,'UNSUCCESSFUL $'

	FNAME1	DB 80		; Source buffer
			DB 0
			DB 80 DUP (0)
	FNAME2	DB 80
			DB 0
			DB 80 DUP (0)
        HANDLE1 DW ?
	HANDLE2 DW ?
	BUFF 		DB 2048 DUP (0)
	SAVE_AX	DW 0
.code
BEGIN : MOV     AX,@data        ; Initialise data segment
	MOV	DS,AX
	MOV	AH,09H
	MOV	DX,OFFSET MES_1	; Display message 1
	INT	21H
	MOV	AH,0AH
	LEA	DX,FNAME1	; Read source file name from
	INT	21H		; Key board
	MOV	SI,DX
	MOV	BL,[SI+1]
	ADD	SI,02H
	MOV	BYTE PTR[SI+BX],00H
	MOV	AH,09H
	MOV	DX,OFFSET MES_3	; Display message 3
	INT	21H
	MOV	AH,0AH
	LEA	DX,FNAME2	; Read destination file name
	INT	21H		; From key board
	SUB	BH,BH		; Clear BX
	MOV	SI,DX
	MOV	BL,[SI+1]
	ADD	SI,02H
	MOV	BYTE PTR[SI+BX],00H
				; Open the source file
	MOV	AH,3DH
	MOV	AL,02H
	MOV	DX,OFFSET FNAME1[2]
	INT	21H
	JC	UNS
	MOV	HANDLE1,AX
				; Create the destination file
	MOV	AH,3CH
	MOV	CX,0
	MOV	DX,OFFSET FNAME2[2]
	INT	21H
	JC	UNS
	MOV	HANDLE2,AX
				; Read the source file
ME :	MOV	AH,3FH
	MOV	BX,HANDLE1
	MOV	DX,OFFSET BUFF
	MOV	CX,1024
	INT	21H
	JC	UNS
	MOV	SAVE_AX,AX
	CMP	AX,0
	JE	DONE
				; Write to destination file
	MOV	AH,40H
	MOV	BX,HANDLE2
	MOV	DX,OFFSET BUFF
	MOV	CX,SAVE_AX
	INT	21H
	JC	UNS
	JMP	ME
				; Close the files
	MOV	AH,3EH
	MOV	BX,HANDLE1
	INT	21H
	MOV	BX,HANDLE2
	INT	21H
	JMP	DONE
				; Error message
UNS :	MOV	AH,09H
	MOV	DX,OFFSET MES_2
	INT	21H
	JMP	TER
DONE :	MOV	AH,09H
	MOV	DX,OFFSET MES_4
	INT	21H
TER :	MOV	AH,4CH		; Terminate
	INT	21H
        END     BEGIN
        

