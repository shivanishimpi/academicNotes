
NAME Insertion Sort
TITLE Sorting of numbers in ascending order 
.MODEL SMALL
.STACK 100
.DATA
	NUM DW 0052H,0014H,0068H,0038H
.CODE
START:	MOV AX,@DATA	; [Initialise 
	MOV DS,AX	;  data segment ]
	MOV DX,2	; Value in DX indicates the location of
			; number to be inserted
LOOP2:	MOV CX,DX		
	DEC CX		; Value in CX indicated the maximum 
			; number of comparisons required to insert 							; the element in the correct position
	MOV SI,CX		; [As numbers are 16-bit they are at 
				;  an offset of 2, i.e. 0,2,4,6 from
	ADD SI,SI		;  location A. Thus SI is loaded with
				;  CX * 2 ]
	MOV AX,NUM[SI]		; Get the number
LOOP1:	CMP NUM[SI-2],AX	; Compare it with previous number 
	JBE NEXT		; if previous number is below or
 				; equal go to NEXT
	MOV DI,NUM[SI-2]	; [ Insert the number
	MOV NUM[SI],DI		;   in proper position ]
	DEC SI			; [ Adjust pointer by
	DEC SI			;   decrementing SI twice ]
	DEC CX			; Decrement comparison counter
	JNZ LOOP1		; If not zero, repeat
NEXT:	MOV NUM[SI],AX		; Insert the number in proper position
	INC DX			; Points to next number to be
				; inserted
	CMP DX,4		; Check if all numbers are inserted
	JBE LOOP2		; If not continue
	MOV AH,4CH		; [ Terminate and
	INT 21H			;	Exit to DOS ]
	END START


