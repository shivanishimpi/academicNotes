// arrange a block of data in ascending order

.MODEL SMALL 
.DATA 
 BLOCK DB 18H, 17H, 16H, 32H, 02H
 CNT_COMP DB 04H; Number of Comparisons In One Iteration
 CNT_ITER DB 04H; Number of Iterations 
.CODE
START: 
 MOV AX,@DATA
 MOV DS,AX
 MOV CL,CNT_ITER 
NXT_ITER:
 LEA BX,BLOCK; load effective address
 MOV CH,CNT_COMP; 
NXT_COMP:
 MOV AL,[BX]; load byte in al
 INC BX; Point to the next byte
 CMP AL,[BX]; Compare two byes
 JC SKIP_SWAP; if borrow (i.e. first byte is less than next byte) skip  
 ;swapping and go to next comparison
 MOV AH,[BX]; Swap position
 MOV [BX],AL; Swap position
 MOV [BX-1],AH; Swap position 
SKIP_SWAP:
 DEC CH; decrement comparison count
 JNZ NXT_COMP; if comparison count is zero go to next iteration 
DEC CNT_COMP
DEC CL
JNZ NXT_ITER 
 MOV AH,4CH 
 INT 21H 
ENDSTART 

