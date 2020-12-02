
.model small ;specify small memory model

.stack 200h ;specify a stack size of 512 bytes

.data
esc_key db 1bh ;byte variable with ascii code for ESC key
old_key db ? ;byte variable to hold last pressed key
.code
start:
	mov ax,@data ;set-up ds to be able to access our data
	mov ds,ax
read_key:
	mov ah,0 ;Invoke BIOS interrupt 16h, service 0
	int 16h ;to read input from keyboard
	cmp al,esc_key ;escape key pressed?
	je exit ;if so, exit program
	cmp al,old_key ;same key pressed?
	je read_key ;if so, don't print it
	mov old_key,al ;otherwise, store entered key
	mov ah,0eh ;Invoke BIOS interrupt 10h, service 14
	int 10h ;to print character on teletype mode
	jmp read_key ;re-start the whole thing
	
exit:				 ;notice that we get here only if esc key
	mov ax,4c00h ;Invoke DOS interrupt 21h, service 4ch
	int 21h ;to exit program
	end start ;tell assembler to finish