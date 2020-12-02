;Addition of two 16-bit nos

.MODEL SMALL
.STACK 64
.DATA

NUM1  DW 8514H
NUM2  DW 5362H
SUM   DW ?
CARRY DB 00H

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		MOV AX,NUM1     ;Move from NUM1 into accumulator
	    ADD AX,NUM2     ;Add NUM2 to AX
	    JNC SKIP        ;If there is no carry, skip
	    INC CARRY       ;else Increment carry
   
SKIP:   MOV SUM, AX     ;Store the answer
		HLT

		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point