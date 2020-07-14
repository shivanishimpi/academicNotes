
TITLE Performs addition or subtraction

;--------------------------------------------------------------------

; This macro does addition or subtraction according to operator
as macro no1,no2,op     ; defines macro
mov al,no1              ; loads first number in al
if op eq 1              ; checks for operand
sub al,no2              ; if op = 1 does subtraction
endif
if op eq 2              ; checks for operand
add al,no2              ; if op = 0 does addtion
endif
endm                    ; end macro

;--------------------------------------------------------------------

; This macro read number from keyboard
numin macro buff,msg    ; defines macro
local next              ;[ 
local go1               ;  define
local next1             ;  local
local go2               ;  variables ]
        mov ah,09h
        lea dx,msg
        int 21h         ; display message 
        mov ah,0ah
        lea dx,buff     ; read numbers in unpacked ASCII format
        int 21h         ; and store them in buff
        mov al,buff+2   ; [  
        cmp al,39h         
        ja next            
        sub al,30h         
        jmp go1         ;   read
next:   sub al,37h      ;   unpacked
go1:    mov cl,04       ;   ASCII
        sal al,cl       ;   numbers
        mov bl,al       ;   and
        mov al,buff+3   ;   pack
        cmp al,39h      ;   them
        ja next1
        sub al,30h
        jmp go2
next1:  sub al,37h
go2:    add al,bl       ;         ]
endm                    ; end macro
;--------------------------------------------------------------------

; This macro converts number into its ASCII code and displays it
display macro           ; defines macro
local skip              ; [ define
local go                ;   local variables ]
        cmp al,09h
        ja skip         ; [ Convert
        add al,30h      ;   number
        jmp go          ;   to its
  skip: add al,37h      ;   ASCII code ]
  go:   mov dl,al
        mov ah,02
        int 21h         ; display the number on video screen
endm                    ; end macro
;--------------------------------------------------------------------

.model small
.stack 100

;--------------------------------------------------------------------

.data

msg1 db 10,13,'Number1 : $'
msg2 db 10,13,'Number2 : $'
msg3 db 10,13,'The operation is (A or S): $'
msg4 db 10,13,'The Result is : $'
num1 db ?
num2 db ?
op   db ?
buffer db 3 
       db 0
       db 3 dup(0)

;--------------------------------------------------------------------

.code

start:  mov ax,@data            ; [ initialise
        mov ds,ax               ;   data segment ]
        numin  buffer,msg1      ; reads first number
        mov num1,al             ; save it in variable num1 
        numin  buffer,msg2      ; reads second number
        mov num2,al             ; save it in variable num2 

        mov ah,09h
        lea dx,msg3
        int 21h                 ; display message
        mov ah,07h
        int 21h                 ; reads operation

        cmp al,'S'              ; [  
        jne donext              ;   check for
        as num1,num2,1          ;   operation
        jmp skip2               ;   and do 
donext: as num1,num2,2          ;   accordingly ]
skip2:  mov bl,al               ; save the result

        mov ah,09h
        lea dx,msg4
        int 21h                 ; display message

        mov al,bl               ; [ 
        mov cl,4                ;   display
        sar al,cl               ;   most significant
        and al,0fh              ;   digit
        display                 ;          ]
        mov al,bl               ; reload the result
        and al,0fh              ; [ display least  
        display                 ;   significant digit ]
        mov ah,4ch                  
        int 21h                 ; exit to DOS    
        end start
        end

;--------------------------------------------------------------------
