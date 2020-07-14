
NAME Selection Sort
TITLE Sorting of numbers in desending order
.MODEL SMALL
.STACK 100
.DATA
	NUM DB 12H,45H,79H,66H
.CODE
START:	MOV AX,@DATA	; [ Initialise
	MOV DS,AX	;	 data segment ] 
	MOV BX,3	; The value in BX gives the number of
			; passes required to complete the sorting 
LOOP2:	MOV CX,BX	; The value in CX gives the number of
			; passes required in a one pass 
	MOV DI,0	; Points the first element in array 	
	MOV AL,NUM[DI]	; Get the number				
	MOV DX,DI	; Save the pointer
LOOP1:	INC DI		; Points the next element in the array
        CMP AL,NUM[DI]  ; Compare number with the next number
	JB NEXT		; If below go to NEXT 
	MOV AL,NUM[DI]	; [ Save the smallest number in AL and
	MOV DX,DI	;   save its pointer in DX ]
NEXT:	LOOP LOOP1	; Repeat until CX = 0 
	XCHG AL,NUM[DI]	; replace smallest number with the last 
        MOV SI,DX
        MOV NUM[SI],AL  ; number in the array
	DEC BX		; Decrement pass count
	JNZ LOOP2	; If pass count is not = 0, repeat
	MOV AH,4CH	; [ Terminate and
	INT 21H		;   Exit to DOS ]
	END START


