;Read a character from keyboard
;INT 16h AH = 00h - read keystroke
;Return: AL = character read from standard input

.model small
.stack 64
.data
ENTER_KEY equ 0Dh

.code
  main:  mov ax , @DATA
        mov ds , ax
        mov bl , ENTER_KEY
        
        readUntilEnter:
        mov ah , 00h
        int 16h
        
        cmp bl , al
        
        mov ah , 02h
        mov dl , 2Ah
        int 21h 
        
    jne readUntilEnter
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
