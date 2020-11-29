//write a 8086 assembly language program to add two 8-bit numbers and store result in memory

.MODEL SMALL
.DATA
N1 DB 13H
N2 DB 4AH
RESULT DW ?
.CODE
START:
MOV AX,@DATA
MOV DS,AX
MOV AL,N1
ADD AL,N2
MOV AH,00
ADC AH,00
MOV RESULT,AX
MOV AH,4CH
INT 21H
END START
