
.MODEL SMALL
.DATA
MES1 DB 10,13,'HERE IS THE LIST OF ALPHBETS',10,13,'$'
.CODE
START:  MOV AX,@DATA            ; [ Initialise
        MOV DS,AX               ;    data segment ]
        MOV AH,09H
        LEA DX,MES1
        INT 21H                 ; Display message
        MOV DL,'A'
        .REPEAT        
        MOV AH,02H
        INT 21H                 ; Display character
        INC DL
        .UNTIL DL > 'Z'
        MOV AH,4CH              ; [ Exit to
        INT 21H                 ;   DOS  ]
        END START
        END
