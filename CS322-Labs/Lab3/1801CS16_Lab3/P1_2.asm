;P1_2: Write an  assembly language program to  find  average  of  the  given set of 16 bit  number  numbers


.MODEL SMALL
.STACK 64
.DATA

SZ   DW 8                       ;size of array
ARR  DW 12,15,14,5,6,7,8,9      ;array elements
AVG	 DW ?						;difference to be stored

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		MOV CX,SZ 		;store size in CX as a counter      
		MOV BX,CX       ;store size for division
		LEA SI,ARR	    ;load address of start of array to SI
		MOV AX,0000 	;initialze AX with zero

LOOP1:	ADD AX,[SI]		;Add current element to AX
		INC SI 			;Increment SI
		INC SI
		DEC CX			;Decrement Counter CX
		JNZ LOOP1		;if CX is non zero go to LOOP

		DIV BX			;Divide AX with BX to get average
		MOV AVG,AX		;Move it to AVG
		HLT
		
		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point