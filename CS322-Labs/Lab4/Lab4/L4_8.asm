;Read a character from keyboard
;AH=07h - DIRECT CHARACTER INPUT, WITHOUT ECHO
;Return: AL = character read from standard input

.model small
.stack 64
.data
a db 03h 

.code
    main:
    	 mov ah , 07h
        int 21h
    
        mov ah , 02h
        inc al
        mov dl , al
    int 21h  
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
