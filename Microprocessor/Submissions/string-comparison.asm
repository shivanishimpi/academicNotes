//This program uses CMPSB (Compare String Byte) instruction for comparing two
strings byte by byte. Before using CMPSB instruction, SI must point to source string and DI must point to another string. First lengths of two strings compared, if not equal means strings are not equal. Both strings are compared byte by byte. After each comparison zero flag is checked for equality of bytes from two strings. Strings are declared equal if they have same length and all byte by byte comparison sets ZERO flag

PRINT MACRO MES; Macro to display string
 MOV AH, 09H
 LEA DX, MES
 INT 21H
ENDM
.MODEL SMALL
.DATA
 MSG1 DB 10, 13, "ENTER STRING 1: $"
 MSG2 DB 10, 13, "ENTER STRING 2: $"
 MSG3 DB 10, 13, "EQUAL $"
 MSG4 DB 10, 13, "UNEQUAL $"
 BUFF1 DB 25 DUP('$')
 BUFF2 DB 25 DUP('$')
.CODE
START:
 MOV AX, @DATA; Initialize DS and ES
 MOV DS, AX;
 MOV ES, AX;
 ; Step 1: Take string1 from user
 PRINT MSG1
 MOV AH, 0AH
 LEA DX, BUFF1
 INT 21H
 ; Step 2: Take string2 from user
 PRINT MSG2
 MOV AH, 0AH; Accept Second String
 LEA DX, BUFF2
 INT 21H
 ; Step 3: Compare length of two strings
 MOV CL, BUFF1+1 ; No of characters read in first string
 MOV CH, BUFF2+1 ; No of characters read in second string
 CMP CH, CL; Compare length of two strings
 JNZ SKIP_COMP
 ; Step 4: Compare string char by char if length is equal
 MOV CH, 00
 MOV CL, BUFF1+1 ; Number of characters
 LEA SI, BUFF1+2; SI points to first string
 LEA DI, BUFF2+2; DI points to second string
 CLD; Auto increment mode SI & DI
 REPE CMPSB; Compare string char by char
 JNZ SKIP_COMP; if chars are not same go to SKIP_COMPARING
 PRINT MSG3
 JMP STOP
SKIP_COMP:
 PRINT MSG4
STOP:
 MOV AH, 4CH
 INT 21H
END START
