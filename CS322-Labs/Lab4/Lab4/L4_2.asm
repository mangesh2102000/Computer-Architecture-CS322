.model small
.stack 64
.data
a db 03h 

.code
  main:
      mov bx , 1ah     ; char counter
      mov cx , bx     ;
      mov dl , 41h    ; ascii value to display
  
  next_char:          ; displays next char
      mov ah , 02h
      int 21h
      inc dl
      dec cx
      jnz next_char
  
  exit:    
      mov ah, 4ch
     int 21h
      end main
     .end
