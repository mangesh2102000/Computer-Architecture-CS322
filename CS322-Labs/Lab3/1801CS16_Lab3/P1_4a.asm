;Program to count number of 1's in a byte 

.MODEL SMALL
.STACK 64
.DATA

NUM  DB 28       ;Given number
CNT	 DB ?		 ;count to be stored

	.CODE 
MAIN	PROC 	FAR		;this is the program entry point
		MOV	AX,@DATA	;load the data segment address
		MOV	DS,AX		;assign value to DS
		SUB BL,BL		;clear BL to keep number of 1s
		MOV DL,8		;counter to rotate total 8 times
		MOV AL,NUM      ;store NUM value in AL

LOOP1 : ROL AL,1		;rotate it once
		JNC GO          ;if Carry Flag = 0, go to GO
		INC BL 			;if Carry Flag = 1, add one to count
GO : 	DEC DL			;Decrease counter
		JNZ LOOP1		;if counter(DL) is non zero loop again
		MOV CNT,BL		;Move count of 1's to CNT
		HLT
		
		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point


