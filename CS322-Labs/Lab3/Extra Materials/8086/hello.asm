.model small 
.stack 100h   
.data
   message   db  "Hello world, I'm learning Assembly $"
.code
start:  mov   ax, @data  
	mov   ds, ax  
	mov   ah, 09      
	lea   dx, message    
	int   21h
	mov   ax,4c00h  
	int   21h
        end start
       .end




































