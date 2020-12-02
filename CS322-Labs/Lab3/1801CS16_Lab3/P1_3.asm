;P1_3:Write a program to find largest and smallest among an array of numbers and print the difference between them


.MODEL SMALL
.STACK 64
.DATA

SZ   DB 8                       ;size of array
ARR  DB 12,15,14,5,6,7,8,9      ;array elements
DIFF DB ?						;difference to be stored

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		MOV CL,SZ 		;store size in CL      
		LEA SI,ARR	    ;load address of start of array to SI
		MOV AL,[SI]		;Move First element to AL
		MOV BL,[SI]		;Move First element to AL

MIN :   CMP AL,[SI]		;Compare AL with current element
		JC MAX			;if AL is smaller go to MAX
		MOV AL,[SI]		;else mov that element to AL

MAX :	CMP BL,[SI]		;Compare BL with current element 
		JNC LOOP1		;if BL is larger go to LOOP1
		MOV BL,[SI]		;elese mov that element to BL

LOOP1 : INC SI 			;Increment SI to position of next element in the array
		DEC CX			;Decrement counter(CX)
		JNZ MIN 		;If CX is non zero go to MIN
		SUB BL,AL		;subtract smallest from largest
		MOV DIFF,BL		;move it to DIFF
		HLT
		
		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point