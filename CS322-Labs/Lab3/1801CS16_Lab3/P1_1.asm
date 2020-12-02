;P1_1:Write an  assembly language program to  find sum of 10 random  numbers.

.MODEL SMALL
.STACK 64
.DATA

SZ   DB 10                      	;size of array
ARR  DB 1,2,12,15,14,5,6,7,8,9      ;array elements
SUM	 DB ?							;difference to be stored

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		LEA SI,ARR      ;load Memory Location of First element into SI 
		LEA DI,SZ
		MOV CL,[DI]   	;Initialize CX with size of array (Here,10)
		MOV AL,00		;Initialize AL to zero
		
LOOP1:	ADD AL,[SI] 	;Add data into accumulator
		INC SI  		;Increment pointer to array element
		DEC CL 			;Decrement counter
		JNZ LOOP1   	;Loop again if CX is non zero
		MOV SUM,AL      ;Store the answer in SUM
		HLT
		MOV AH,4CH
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point
 