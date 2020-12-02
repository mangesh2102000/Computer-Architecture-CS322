; Program To find the no of even & odd nos. from given array of nos.

.MODEL SMALL
.STACK 64
.DATA

SZ       DB 8                       ;size of array
ARR      DB 12,13,14,5,6,7,8,9      ;array elements
CNTODD	 DB ?						;cnt of odd numbers
CNTEVEN	 DB ?						;cnt of even numbers

.CODE
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
	    LEA SI,ARR 		;load address of num into SI
		MOV BX,0000		;Initialize BX with 0
		LEA DI,SZ
		MOV CL,[DI]   	;Initialize CX with size of array
	
LOOP1:  MOV AL,[SI]     ;Load data into Accumulator
        AND AL,01H      ;AND with 01H
        JZ 	GO      	;If AND is 0, Jump to EVEN
        INC BL          ;Increment BL (stores cnt of odd)
        JMP NEXT        ;Jump to next
GO	:   INC BH          ;Increment BH (stores snt of even)
NEXT:   INC SI          ;Increment SI
        DEC CL			;Decrement CL
        JNZ LOOP1       ;Loop until CL is non zero
		HLT

		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point