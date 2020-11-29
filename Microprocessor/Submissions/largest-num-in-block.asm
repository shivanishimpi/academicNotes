//find largest number in given memory block of size N bytes.

.MODEL SMALL
.DATA
STRING DB 22H,56H,93H,0A4H,56H,0B6H,07H,8H,69H,19H LARGEST_NO DB ? ; Space to store Largest number CNT_COMP DB 9 ; Count for comparisons = N-1
.CODE
START:
 MOV AX,@DATA
 MOV DS,AX
 LEA SI,STRING; Load base address of data block
 MOV AL,[SI]; Load first byte in AL
 MOV LARGEST_NO,AL ; Load First Byte In LARGEST_NO
 INC SI; SI Points to Second Byte
NXT_COMP:
 LODSB; Load byte pointed by SI to AL (Load String Byte)
 CMP LARGEST_NO,AL; Compare byte with previous largest number found
 JNC OVER; Go to next if less than previous largest byte
 MOV LARGEST_NO,AL ; else copy this number as largest number found yet
OVER:
 DEC CNT_COMP; Decrement comparison count
 JNZ NXT_COMP; If count is zero stop else go to next comparison
 MOV AH,4CH; Terminate Program
 INT 21H; Terminate Program
END START
