//write a 8086 assembly language program to add two 16-bit numbers and store result in memory.

.MODEL SMALL
.DATA
N1 DW 115DH ;first 16 bit number
N2 DW 1555H; second 16 bit number
RESULT DW ?; 16 bit result
CARRY DB ?; space for carry
.CODE
START:
MOV AX, @DATA
MOV DS, AX
MOV AX, N1
ADD AX, N2
MOV BH, 00H
ADC BH, 00H
MOV RESULT, AX
MOV CARRY, BH
MOV AH, 4CH
INT 21H
END START
