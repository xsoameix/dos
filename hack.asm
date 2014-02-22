code segment
     assume cs:code,ds:code
     org 100h

start: jmp def

mes      db  'Lien Chiang[101502536]'
old_int9 dw  ?,?
mes_len  equ offset old_int9-offset mes

new_int9 proc
         push ax
         push bx
         push cx
         push dx
         push di
         push es
         push ds

         mov ax,0B800h
         mov es,ax
         mov di,0

         in al,60h
         push ax

         in al,61h
         or al,80h
         out 61h,al
         and al,7fh
         out 61h,al

         mov al,20h
         out 20h,al

         ; if (key.pressed and
         ;     key.code == ctrl + shift + 6)
         ;   i = 0
         ;   while i < mes_len
         ;     vga[i].char = mes[i]
         ;     vga[i].color = dark_red
         ;     i += 1
         ;   end
         ; end
         pop ax
         test al,10000000b
         jnz bye

         cmp al,7
         jne bye

         sti
         mov ah,12h
         int 16h
         test al,7
         jz bye
         jnp bye

         mov cx,0
ruby:
         mov bx,offset mes
         add bx,cx
         mov al,byte ptr cs:[bx]
         mov bx,cx
         shl bx,1
         add bx,7B6h
         lea di,[bx]
         stosb
         cmp cx,5
         jl python
         cmp cx,0Ah
         jg python
         mov al,4
         lea di,[bx]
         inc di
         stosb
python:
         inc cx
         cmp cx,mes_len
         jl ruby
bye:
         pop ds
         pop es
         pop di
         pop dx
         pop cx
         pop bx
         pop ax
         jmp dword ptr cs:[old_int9]
new_int9 endp

def:
         ; save int 9 ptr
         mov ax,3509h
         int 21h
         mov [old_int9],bx
         mov [old_int9+2],es

         ; modify int 9 ptr
         mov ax,2509h
         mov dx,offset new_int9
         int 21h

         ; exit
         mov dx,offset def
         int 27h
code ends

end start
