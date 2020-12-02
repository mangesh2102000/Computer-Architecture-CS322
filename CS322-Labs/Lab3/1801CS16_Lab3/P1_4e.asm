; Program To check for a Palindrome (single letter)

.MODEL SMALL
.STACK 64
.DATA

SZ       DB 7                      		   ;size of array
ARR      DB 'A','B','C','D','C','B','A'     ;array elements

.CODE
MAIN	PROC 	FAR		;this is the program entry point
		MOV AX,@DATA    ;Load Data in temp register
        MOV DS,AX       ;Load data into data into Data Segment
        LEA SI,ARR      ;Load address of first element into SI
        LEA DI,ARR+06H  ;Load address of last element into DI (i.e ARR + SZ-1)
        MOV CL,03H      ;Load half the size of ARR into CL
        MOV CH,00H		;Initialize CH to 0
       
LOOP1:  MOV AH,[SI]     ;Load data into AH
        MOV BH,[DI]     ;Load data into BH
        CMP AH,BH       ;Compare AH and BH
        JNZ GO          ;If not zero skip
        INC SI          ;Increment pointer
        DEC DI          ;Decrement pointer
        DEC CL          ;Decrement pointer
        JNZ LOOP1       ;If not zero, jump to back 
        INC CH          ;Increment CH
GO:     HLT

		MOV	AH,4CH		;set up to
		INT	21H			;return to DOS
MAIN		ENDP
		END MAIN 		;this is the program exit point

; In this if finally, CH = 01H then given array is a palindrome
