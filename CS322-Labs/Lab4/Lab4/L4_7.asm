;Read a character from keyboard
;AH = 01h - READ CHARACTER FROM STANDARD INPUT, WITH ECHO
;Return: AL = character read

.model small
.stack 64
.data
a db 03h 

.code
    main: mov ah , 01h
         int 21h
     
         mov ah , 02h
         mov dl , al
    	int 21h    
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
