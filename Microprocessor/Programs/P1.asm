.model small
.stack 100
.data
no1 db 63h
no2 db 2eh
result dw ?
.code
start:
mov ax,@data
mov ds,ax
mov al,no1
add al,no2
adc ah,00h
mov result,ax
end start
end
