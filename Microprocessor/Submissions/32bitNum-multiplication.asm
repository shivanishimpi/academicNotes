//multiplication of 32-bit numbers

.MODEL SMALL
.DATA
X DW 4321H, 8765H; 32-bit no X=87654321H, XH=8765H XL=4321H
Y DW 5678H, 1234H; 32-bit no Y=12345678H, YH=1234H YL=5678H
Z DW 0H, 0H, 0H, 0H
.CODE
START:
 MOV AX, @DATA;Initialize Data Segment
 MOV DS, AX; Initialize Data Segment
; Step 01 : XL*YL = 4321H * 5678H = 16AC:8D78 [DX:AX]
 LEA SI, X; Load Address of X in SI
 MOV AX, [SI]; AX = XL
 MUL Y[BX]; [DX:AX] = XL * YL
 MOV Z[DI], AX; Store AX
 MOV Z[DI+2], DX; Store DX in higher word of result
; Step 02 : XH*YL = 8765H * 5678H = 2DBB:6558 [DX:AX]
 MOV AX,[SI+2]; AX = XH
 MUL Y[BX]; [DX:AX] = XH * YL
 ADD Z[DI+2],AX; Store AX
 ADC Z[DI+4],DX; Store DX with Carry in higher word of result
; Step 03 : XL*YH = 4321H*1234H = 04C5:F4B4 [DX:AX]
 MOV AX,[SI]; AX = XL
 MUL Y[BX+2]; [DX:AX] = XL*YH
 ADD Z[DI+2],AX;
 ADC Z[DI+4],DX
 ADC Z[DI+6],0H
; Step 04 : XH*YH = 8765H*4321H = 2380:E305 [DX:AX]
 MOV AX,[SI+2];AX = XH
 MUL Y[BX+2];[DX:AX] = XH*YH = 2380H:E305H
 ADD Z[di+4],ax;
 ADC Z[di+6],dx
 MOV AH, 4CH
 INT 21H
ENDSTART
