
Title 8086 ALP to convert uppercase to lowercase.
.model small
.code
START:  MOV AH,07H	
        INT 21H
        .IF AL >='A' && AL <='Z'
        ADD AL,20H
        .ENDIF
        MOV AH,02
        MOV DL,AL
        INT 21H
        MOV AH,4CH
        INT 21H
        END START
        END
