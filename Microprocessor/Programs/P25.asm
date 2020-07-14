
.model small
.stack 100
.data
     	CR	EQU 0AH
	LF	EQU 0DH
        MES_1   DB              CR,LF,'ENTER 4-DIGIT FIRST HEX NO',CR,LF, '$'
        MES_2   DB              CR,LF,'ENTER 4-DIGIT SECOND HEX NO',CR,LF, '$'
        MES_3   DB              CR,LF,'INPUT IS INVALID BCD $'
        MES_4   DB              CR,LF,'THE HCF IS :  $'
        MULTI	DW		 1,10,100,1000
        RESULT  DW (00)
        DIVISOR  DW (00)
        DIVIDEND DW (00)


        INP1    DB 05
		DB 00
                DB 05 DUP(0)

        INP2    DB 05
		DB 00
                DB 05 DUP(0)
.code     
MAIN :  MOV     AX,@data         ; Initialise data segment
	MOV	DS,AX
	MOV	AH,09H
	MOV	DX,OFFSET MES_1	; Display
	INT	21H
        LEA     DX,INP1
        MOV     AH,0AH
        INT     21H

	MOV	AH,09H
        MOV     DX,OFFSET MES_2 ; Display
	INT	21H
        LEA     DX,INP2
        MOV     AH,0AH
        INT     21H
        MOV     CH,02H
        LEA     BX,INP1
  AGAIN:INC     BX
        INC     BX
        XOR     DI,DI
        MOV     CL,04
  BACK: MOV     AL,[BX+DI]
        CMP     AL,39H
        JG      NEXT
        SUB     AL,30H
        JMP     SKIP
 NEXT:  SUB     AL,37H
 SKIP:  MOV     [BX+DI],AL

        INC     DI
        DEC     CL
        JNZ     BACK
        LEA     BX,INP2
        DEC     CH
        JNZ     AGAIN

        MOV     CL,4
        LEA     BX,INP1
        INC     BX
        INC     BX
        MOV     AH,[BX+0]
        SAL     AH,CL
        AND     AH,0F0H
        MOV     AL,[BX+1]
        OR      AH,AL
        MOV     AL,[BX+2]
        SAL     AL,CL
        AND     AL,0F0H
        MOV     DH,[BX+3]
        OR      AL,DH
        MOV     RESULT,AX

        MOV     CL,4
        LEA     BX,INP2
        INC     BX
        INC     BX
        MOV     AH,[BX+0]
        SAL     AH,CL
        AND     AH,0F0H
        MOV     AL,[BX+1]
        OR      AH,AL
        MOV     AL,[BX+2]
        SAL     AL,CL
        AND     AL,0F0H
        MOV     DH,[BX+3]
        OR      AL,DH

        CMP     AX,RESULT
        JNC     NEXT1
        MOV     DIVISOR,AX
        MOV     CX,RESULT
        MOV     DIVIDEND,CX
        JMP     SKIP1
NEXT1:
        MOV     DIVIDEND,AX
        MOV     CX,RESULT
        MOV     DIVISOR,CX
SKIP1:  MOV     DX,0
        MOV     AX,DIVIDEND
        DIV     DIVISOR
        CMP     DX,0
        MOV     CX,DIVISOR
        MOV     DIVISOR,DX
        MOV     DIVIDEND,CX
        JNZ     SKIP1
        MOV     AH,09H
        LEA     DX,MES_4
        INT     21H

       ADD     CL,30H
       MOV     DL,CL
       MOV     AH,02H
       INT     21H




	MOV	AH,4CH		; Terminate
	INT	21H
        END     MAIN
        END

