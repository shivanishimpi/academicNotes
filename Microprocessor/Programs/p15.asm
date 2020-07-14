
; This macro displays specified number of characters
; starting from character 'A'
;------------------------------------------------------------------------------

DISP MACRO NO
MOV DL,'A'      ;; Load ASCII code of character A in DL
COUNT= 1        ;; Initialise counter = 1
WHILE  COUNT LE NO ;; Check if count is less than or equal to NO
MOV AH,02H
INT 21H            ;; Display  character on video screen
COUNT= COUNT + 1   ;; Increament count
INC DL             ;; Load next character code
ENDM               ;; End of while
ENDM               ;; End of macro

;------------------------------------------------------------------------------

.MODEL SMALL
.STACK 100
.CODE
START:
        DISP 8          ; Display first 8 characters 
        MOV AH,4CH      ; [ Exit to
        INT 21H         ;   DOS  ]
        END START
        END

;------------------------------------------------------------------------------
