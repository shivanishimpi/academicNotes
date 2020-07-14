
.MODEL SMALL
.DATA
PASS DB 'ABC'
MES1 DB 10,13,'ENTER 3 CHARACTER PASSWORD $'
MES2 DB 10,13,'PASSWORD IS CORRECT $'
MES3 DB 10,13,'PASSWORD IS WRONG $'
.CODE
START:  MOV AX,@DATA                    ;[ Initialise
        MOV DS,AX                       ;  data segment ]
        MOV AH,09H
        LEA DX,MES1
        INT 21H                         ; Display message
        MOV CL,00                       ; Clear count
        MOV DL,00H                      ; Clear number of match
        XOR DI,DI                       ; Intialise pointer
        .WHILE CL != 3                  ; Check if count = 3 if not Continue
                MOV AH,07H
                INT 21H                 ; Read character
                LEA BX,PASS             ; [ Set pointer 
                MOV AH,[BX+DI]          ;   to password ]
                .IF AL==AH              ; Compare read character with password
                        ADD DL,01       ; Increament match count if match occurs
                .ENDIF
                INC DI                  ; Increment pointer
                INC CL                  ; Increment counter
        .ENDW
        .IF DL == 3                     ; [ if match count = 3
                MOV AH,09H              ;   display message
                LEA DX,MES2             ;   password is correct ]
                INT 21H
         .ELSE                          ; [ if match count <> 3
                MOV AH,09H              ;   display message
                LEA DX,MES3             ;   password is wrong ]
                INT 21H
         .ENDIF
        MOV AH,4CH                      ; [ Exit to
        INT 21H                         ;   DOS  ]
        END START
        END
