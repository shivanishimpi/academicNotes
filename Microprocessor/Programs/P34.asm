
.MODEL SMALL
.DATA
	W DW ?
	X DB 10H
        Y DB 30H
	Z DB 20H
.CODE
START: 		MOV AX,@DATA 	; [Initialize 
		MOV DS,AX  	;  data segment]
		MOV AL,Y
		SUB AL,Z 	; Y - Z
		ADD AL,X 	; X + (Y - Z)
		MOV CL,X
		MUL CL 		; X * (X + Y - Z)
		MOV W,AX	; Store result
		END START
		END


