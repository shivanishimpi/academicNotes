
Title Performs addition or subtraction
.model small
.DATA
NO1 db 30h
NO2 db 20h
RESULT dw ?
.code
START:  MOV AX,@DATA
        MOV DS,AX
        MOV AH,07H
        INT 21H
        MOV BH,00
        MOV BL,NO1
        .IF AL=='+'
            ADD BL,NO2
            ADC BH,00
        .ELSE
            SUB BL,NO2
        .ENDIF
        MOV RESULT,BX
        MOV AH,4CH
        INT 21H
        END START
        END
