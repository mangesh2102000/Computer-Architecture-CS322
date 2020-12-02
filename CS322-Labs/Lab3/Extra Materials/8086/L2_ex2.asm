;THE FORM OF AN ASSEMBLY LANGUAGE PROGRAM
;USING SIMPLIFIED SEGMENT DEFINITION
		.MODEL SMALL
		.STACK 64
		.DATA
		;
		; Place data definitions here
		;
		.CODE
MAIN		PROC	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		;
		; Place code here
		mov	ah,0	; Set mode option
		mov	al,3	; Color Text Mode
		int	10h
		mov	ah,9	; Display option
		mov	bh,0	; Page 0
		mov	al,20h	;Set space
		mov	cx,800h	; For the whole screen
		mov	bl,1fh	; Set high intensity white on blue
		int 	10h

		mov	cx,20
delay5sec:
		call 	delay
		dec	cx
		jnz	delay5sec	; Delay 5 seconds
		mov 	cx,800h
		mov	bl,2fh	; Set high intensity white on green
		int 	10h
	
		;	
		MOV	AH,4CH	;set up to
		INT	21H		;return to DOS
MAIN		ENDP			


delay		proc	near
		push 	cx
		push 	ax
		mov	cx,33144		; Delay 1/2 second
		
waitchange:
		in	al,61h
		and	al,10h
		cmp	al,ah
		je	waitchange	; wait for change
		mov	ah,al
		loop 	waitchange	; wait till cx becomes zero
		pop 	ax
		pop 	cx
		ret
delay		endp

		END	MAIN		;this is the program exit point