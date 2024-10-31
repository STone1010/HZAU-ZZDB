assume cs:code

code segment
start:
;保存中断程序 
mov ax,cs
mov ds,ax
mov si,offset do0
mov ax,0
mov es,ax
mov di,200h
mov cx,offset do0end-offset do0
cld
rep movsb

;设置中断向量表
mov ax,0
mov es,ax
mov word ptr es:[0*4],200h
mov word ptr es:[0*4+2],0
call divide_overflow

;触发除法错误
mov ax,4c00h
int 21h

divide_overflow:
	mov ax,0ffffh
	mov bl,1h
	div bl
	ret

do0: 
jmp short do0start
db"overflow!"

do0start:
	mov ax,cs
	mov ds,ax
	mov si,202h;设置ds:si指向字符串
	
	mov ax,0b800h
	mov es,ax
	mov di,12*160+36*2;设置es：di指向中间显存位置；
	
	mov cx,9
  s:mov al,[si]
	mov es:di,al
	inc si
	add di,2
	loop s
mov ax,4c00h
int 21h

do0end:nop
code ends
end start	
