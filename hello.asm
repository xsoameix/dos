code segment
     assume cs:code,ds:code
     org 100h
start: jmp begin
mes db 'hello world.$'
begin: mov dx,offset mes
       mov ah,9
       int 21h

       mov ax,4c00h
       int 21h
code ends
end start
