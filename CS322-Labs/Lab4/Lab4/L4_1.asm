.model small
.stack 64
.data
a db 03h 

.code
 main:mov dl , '*'   ; ascii for '*' (2ah)
      mov ah , 02h
      int 21h
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
