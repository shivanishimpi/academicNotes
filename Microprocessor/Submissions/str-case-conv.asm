.MODEL SMALL
.STACK 100H
.DATA
LSTR DB 'cookie $'
USTR DB 20 DUP('$')
.CODE
MOV AX , @DATA
MOV DS , AX
MOV AH , 09H
LEA DX , LSTR
INT 21H
MOV AH , 2
MOV DL, 0DH
INT 21H
MOV DL 0AH
INT 21H
LEA SI, LSTR
LEA DI, USTR
UP:
MOV AL,[SI]
CMP AL, '$'
JE EX
SUB AL, 20H
MOV [DI], AL
INC SI
INC DI
JMP UP
EX:
MOV AH, 09H
LEA DX, USTR
INT 21H
MOV AH, 4CH
INT 21H
END
