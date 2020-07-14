
.model small
.data
        M1      DB 10, 13, 'Enter the total number of elememts in the array : $'
        M2      DB 10, 13, 'The sorted array is : ',0dh,0ah,'$'
        M3      DB 10, 13, '$'
        ARRAY   DB 100 DUP(0)
.code
START:  MOV AX, @data
        MOV DS,  AX
        MOV AH,  09H           ; Display message M1
	MOV DX,  OFFSET M1
        INT 21H
        MOV AH, 01H            ; input the number of elements in the array
        INT 21H
        SUB AL,30H
        MOV BH,AL
        MOV BL,AL
        XOR DI,DI
        MOV CL,4
  BACK:
        MOV AH,  09H           ; Carrige return and next line
        MOV DX,  OFFSET M3
        INT 21H

        MOV AH,01
	INT 21H
        SUB AL,30H
        SAL AL,CL
        MOV CH,AL
        MOV AH,01
	INT 21H
        SUB AL,30H
        OR CH,AL

        MOV [ARRAY+DI],CH
        INC DI
        DEC BL
        JNZ BACK

        MOV CH,BH
AGAIN1: MOV DI,0
AGAIN:  MOV DL,[ARRAY+DI]
        CMP DL,[ARRAY+DI+1]
        JBE SKIP
        MOV AH,[ARRAY+DI+1]
        MOV [ARRAY+DI],AH
        MOV [ARRAY+DI+1],DL
SKIP:   INC DI
        MOV AH,0
        MOV AL,BH
        DEC AL
        CMP AX,DI
        JNZ AGAIN        
        DEC CH
        JNZ AGAIN1

        MOV AH,  09H           ; Display message M1
        MOV DX,  OFFSET M2
        INT 21H

        MOV BL,BH
        XOR DI,DI
 BACK1:
        MOV AH,  09H           ; Carrige return and next line
        MOV DX,  OFFSET M3
        INT 21H

        MOV DL,[ARRAY+DI]
        AND DL,0F0H
        SAR DL,CL
        ADD DL,30H
        MOV AH,02
	INT 21H
        MOV DL,[ARRAY+DI]
        AND DL,0FH
        ADD DL,30H
        MOV AH,02
	INT 21H
        INC DI
        DEC BL
        JNZ BACK1

TER:   MOV AH,  4CH
        INT  21H
        END START
