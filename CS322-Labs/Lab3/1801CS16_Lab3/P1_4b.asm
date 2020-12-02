;Program to reverse given array at same location 

.MODEL SMALL
.STACK 64
.DATA

ARR  DB 12,15,14,5,6,7,8,9      ;array elements

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		MOV CX,0004		;store half the size in CX  
		LEA SI,ARR	    ;load address of start of array to SI
		MOV DI,SI
		ADD DI,0007		;Store memory location of last element in DI (Just ADD size of array - 1 to SI)

LOOP1:   MOV AL,[SI]		;Move current element to AL
		XCHG AL,[DI]	;swap element at [DL] and in AL
		MOV [SI],AL		;Move swapped element to [SI]		
		INC SI 			;Increment SI
		DEC DI			;Decrement DI
		DEC CX			;Decrement counter
		JNZ LOOP1	
		HLT

		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point


