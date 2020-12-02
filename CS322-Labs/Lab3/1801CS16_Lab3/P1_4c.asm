; Program to find Factorial of a number

.MODEL SMALL
.STACK 64
.DATA

NUM DW 0005H

.CODE
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
	    LEA SI,NUM 		;load address of num into SI
	    LEA DI,NUM+100H	;load memory location NUM+100H into DI
	    MOV CX,[SI];	;Move value at SI, given number to CX
		MOV AX,0001;	;Initialize AX with 1
		MOV DX,0000;	;Initialize DX with 0
	
LOOP1 :	MUL CX			;Multiply AX with current value of CX
		DEC CX			;Decrement CX
		JNZ LOOP1		;If CX is non zero loop again

		MOV [DI],AX;	;Move value in AX to memory location stored in DI
		MOV [DI+1],DX;	;Move value in DX to DI+1
		HLT

		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point