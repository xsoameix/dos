code segment
     assume cs:code,ds:code
     org 100h

start: jmp begin
old_int0 dw  ?,?
mes      db  'divide 0.$'

new_int0 proc
         ; enable next int
         sti

         ; fix the stack
         mov bx,sp
         add word ptr ss:[bx],div_len
         mov bx,0ffffh

         ; divide 0 !
         push ax
         push dx
         mov dx,offset mes
         mov ah,9
         int 21h
         pop dx
         pop ax

         iret
new_int0 endp

division proc
addr_d:  div bl
addr_n:  cmp bx,0ffffh
div_len  equ offset addr_n-offset addr_d
division endp

begin:   ; get int 0 ptr, save it
         mov ax,3500h
         int 21h
         mov [old_int0],bx
         mov [old_int0+2],es

         ; modify the int 0 ptr
         mov dx,offset new_int0
         mov ax,2500h
         int 21h

         ; div 0
         mov ax,10h
         mov bl,0
         div bl

         ; recover the int 0 ptr
         push ds
         mov dx,word ptr [old_int0]
         mov ds,word ptr [old_int0+2]
         mov ax,2500h
         int 21h
         pop ds

         ; exit
         mov ax,4c00h
         int 21h
code ends

end start
