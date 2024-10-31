assume cs:codesg

datasg segment
	db"ALL thE BeSt.",0
datasg ends

codesg segment	
begin:

mov ax,datasg
mov	ds,ax
mov si,0
call letterc

mov ax,4c00h
int 21h

letterc:
	mov cl,ds:[si]
	mov ch,0
	jcxz ok
	cmp cl,61h
	jb s0
	sub cl,20h
    mov ds:[si],cl 
s0:
inc si
jmp letterc
	
ok:
	ret

codesg ends
end begin
