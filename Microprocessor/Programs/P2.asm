.model small
.stack 100
.data
	No1 		DB 63H 	; First number storage
	No2 		DB 2EH 	; Second number storage
	Avg	 	DB ? 	; Average of two numbers
.code
START: 	MOV AX,@data		; [ Initialises
	MOV DS,AX		;  data segment ]
	MOV AL,NO1 		; Get first number in AL
	ADD AL,NO2 		; Add second to it
	ADC AH,00H		; Put carry in AH
	SAR AX,1		; Divide sum by 2
	MOV Avg,AL 		; Copy result to memory
	END START


