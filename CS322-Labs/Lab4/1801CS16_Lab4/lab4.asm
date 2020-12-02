; 	NAME : CHANDRAWANSHI MANGESH SHIVAJI 
; 	ROLL NO. :  1801CS16
;   CS322 - COMPUTER ARCHITECHTURE LAB 4

; DEFINED VARIABLES FOR BORDER GENERATION

LEFT EQU 0
TOP EQU 2
ROW EQU 20
COL EQU 60
RIGHT EQU LEFT + COL
BOTTOM EQU TOP + ROW

.MODEL SMALL
.STACK 64

.DATA

Welcome_MSG DB "Welcome to the Game : CATCH THE FRUIT !!",0

INSTRUCTIONS DB 0AH,0DH,"Use w-up, s-down, a-left, d-right to control the direction of the snake",0AH,0DH,"Use q to quit the game",0AH,0DH,"Press Enter to start$"

End_MSG DB " Game Over !! ",0

Score_MSG DB " Score : ",0

HEAD  DB  '^',20,10
BODY  DB  '+',20,11, 315 DUP(0)
segmentcount DB 1						;TO STORE CURRENT LENGTH OF THE SNAKE
Fruitactive DB 1 						;CHECK WHETHER FRUIT IS ACTIVE IN BOX OR NOT
Fruitx DB 8 			 				;ROW NUMBER OF FRUIT
Fruity DB 8								;COL NUMBER OF FRUIT
GameOver DB 0							
Quit DB 0		
Delaytime DB 5							;FOR MOVEMENT OF THE SNAKE IF VALUE IS SMALL SNAKE WILL MOVE FASTER 

.CODE

MAIN PROC FAR
	 MOV AX,@DATA
	 MOV DS,AX
	 
	 MOV AX,0B800H
	 MOV ES,AX

	 ; CLEAR THE SCREEN AND SET VIDEO MODE 
	 MOV AX,0003H
	 int 10H

	 ; DISPLAY WELCOME MESSAGE
	 LEA BX,Welcome_MSG
	 MOV DX,00H
	 CALL DISPLAY_STRING

	 ; DISPLAY INSTRUCTIONS TO START THE GAME
	 LEA DX,INSTRUCTIONS
	 MOV AH,09H
	 INT 21H

	 MOV AH,07H
	 INT 21H

	 ; CLEAR THE SCREEN TO PRINT BORDERS
	 MOV AX,0003H
	 INT 10H

	 CALL PRINT_BORDERS

	 ; MAINLOOP CODE TO KEEP THE GAME RUNNING 
	 ; ACTS ACCORDING THE INPUT PROVIDED BY THE USER

MAINLOOP :
	 CALL DELAY

	 LEA BX,Welcome_MSG
	 MOV DX,00
	 CALL DISPLAY_STRING

	 CALL SNAKE
	 CMP GameOver,1
	 JE GAME_OVER_MAINLOOP

	 CALL KEYBOARD_FUNCTIONS
	 CMP Quit,1
	 JE GAME_OVER_MAINLOOP
	 CALL CREATE_FRUIT
	 CALL DRAW

	 JMP MAINLOOP

	 ; IF SNAKE HAS DIED OR USER PRESSED QUIT , END THE GAME
GAME_OVER_MAINLOOP:
	 MOV AX,0003H
	 INT 10H
	 MOV Delaytime,30
	 MOV DX,0000H
	 LEA BX,End_MSG
	 CALL DISPLAY_STRING
	 CALL DELAY
	 JMP EXIT_MAINLOOP

	 ; CLEAR THE SCREEN AND EXIT GAME
EXIT_MAINLOOP:
 	 MOV AX,0003H
 	 INT 10H
 	 MOV AX,4C00H
 	 INT 21H

; DELAY FUNCTION TO MANAGE THE SPEED OF THE SNAKE
; USES 1A INTERRUPT 

DELAY PROC
	 MOV AH,00
	 INT 1AH
	 MOV BX,DX
JMP_DELAY:
	 INT 1AH
	 SUB DX,BX
	 CMP DL,Delaytime
	 JL JMP_DELAY
	 RET
DELAY ENDP

; FUNTION TO GENERATE THE FRUIT IF IT IS CAPTURED BY SNAKE 
; CHECKS FOR POSITION Fruitx,Fruity BEFORE REGENERATING

CREATE_FRUIT PROC
	 MOV CH,Fruity
	 MOV CL,Fruitx

RECREATE:
	 CMP Fruitactive,1
	 JE RET_FRUITACTIVE

	 MOV AH,00
	 INT 1AH
	 PUSH DX
	 MOV AX,DX
	 XOR DX,DX
	 XOR BH,BH
	 MOV BL,ROW
	 DEC BL
	 DIV BX
	 MOV Fruity,DL
	 INC Fruity

	 POP AX
	 MOV BL,COL
	 DEC DL
	 XOR BH,BH
	 XOR DX,DX
	 DIV BX
	 MOV Fruitx,DL
	 INC Fruitx

	 CMP Fruitx,CL
	 JNE NEXT
	 CMP Fruity,CH
	 JNE NEXT
	 JMP RECREATE

NEXT: 
	 MOV AL,Fruitx
	 ROR AL,1
	 JC RECREATE

     ADD Fruity,TOP
     ADD Fruitx,LEFT

     MOV DH,Fruity
     MOV DL,Fruitx
     CALL READ_CHAR

     CMP BL,'+'
     JE RECREATE
     CMP BL,'^'
     JE RECREATE
     CMP BL,'v'
     JE RECREATE
     CMP BL,'<'
     JE RECREATE
     CMP BL,'>'
     JE RECREATE

RET_FRUITACTIVE:
	 RET

CREATE_FRUIT ENDP

; DUNCTION TO DISPLAY A SINGLE DIGIT 

DISPLAY_DIG PROC
	ADD DL,'0'
	MOV AH,02H
	INT 21H
	RET
DISPLAY_DIG ENDP

; FUNTION TO DISPLAY THE NUMBER STORED IN AX 

DISPLAY_NUM PROC
	 TEST AX,AX
	 JZ RET_Z
	 XOR DX,DX
	 MOV BX,10
	 DIV BX
	 PUSH DX
	 CALL DISPLAY_NUM
	 POP DX
	 CALL DISPLAY_DIG
	 RET

RET_Z:
	 MOV AH,02
	 RET
DISPLAY_NUM ENDP

; FUNCTION TO SET THE CURSOR POSITION AT THE PRESCRIBED LOCATION 
; DX CONTAINS ROW,COL 
; AX,BX AND DX REGISTERS ARE USED

SET_CURSORPOS PROC
	MOV AH,02H
	PUSH BX
	MOV BH,0
	INT 10H
	POP BX
	RET
SET_CURSORPOS ENDP

; FUNCTION TO WRITE THE CURRENT SCORE ON THE SCREEN, DRAW THE SNAKE AND THE FRUIT
; IT USES THE LENGTH OF THE SNAKE TO DETERMINE THE SCORE

DRAW PROC
 	 LEA BX,Score_MSG
 	 MOV DX,0109
 	 CALL DISPLAY_STRING

 	 ADD DX,7
 	 CALL SET_CURSORPOS
 	 MOV AL,segmentcount
 	 DEC AL
 	 XOR AH,AH
 	 CALL DISPLAY_NUM

 	 LEA SI,HEAD
DRAW_LOOP:
	 MOV BL,DS:[SI]
	 TEST BL,BL
	 JZ EXIT_DRAW
	 MOV DX,DS:[SI+1]
	 CALL WRITE_CHAR
	 ADD SI,3
	 JMP DRAW_LOOP

EXIT_DRAW:
	 MOV BL,'P'
	 MOV DH,Fruity
	 MOV DL,Fruitx
	 CALL WRITE_CHAR
	 MOV Fruitactive,1

	 RET
DRAW ENDP

; FUNCTION TO READ WHICH KEY IS PRESSED BY THE USER 
; DL CONTAINS THE ASCII CHAR CORRESPONDING TO THE KEY PRESSED
; IF NO KEY IS PRESSED IT CONTAINS 0
; USES DX AND AX REGISTERS

READ_KEY PROC
	 MOV AH,01H
	 INT 16H
	 JNZ KEY 
	 XOR DL,DL
	 RET
KEY:
	 MOV AH,00H
	 INT 16H
	 MOV DL,AL
	 RET

READ_KEY ENDP

; FUNCTION DECODING USER INPUTS FROM THE KEYBOARD

KEYBOARD_FUNCTIONS PROC
	 CALL READ_KEY
	 CMP DL,0
	 JE NEXT_14

	 ; CHECK WHICH KEY WAS PRESSED AND ACCORDINGLY CHANGE THE DIRECTION OF HEAD

	 CMP DL,'w'
	 JNE NEXT_11
	 CMP HEAD,'v'
	 JE NEXT_14
	 MOV HEAD,'^'
	 RET

NEXT_11:
	 CMP DL,'s'
	 JNE NEXT_12
	 CMP HEAD,'^'
	 JE NEXT_14
	 MOV HEAD,'v'
	 RET

NEXT_12:
	 CMP DL,'a'
	 JNE NEXT_13
	 CMP HEAD,'>'
	 JE NEXT_14
	 MOV HEAD,'<'
	 RET

NEXT_13:
	 CMP DL,'d'
	 JNE NEXT_14
	 CMP HEAD,'<'
	 JE NEXT_14
	 MOV HEAD,'>'

NEXT_14:
	 CMP DL,'q'
	 JE QUIT_KEYBOARD_FUNCTIONS
	 RET

QUIT_KEYBOARD_FUNCTIONS:
	 INC Quit
	 RET

KEYBOARD_FUNCTIONS ENDP

; FUNCTION TO DETERMINE THE SIZE AND DIRECTION OF SNAKE

SNAKE PROC

	 MOV BX, OFFSET HEAD	 	 ; PRESERVE HEAD LOCATION IN BX
	 
	 ; CODE TO DETERMINE WHERE THE HEAD SHOULD POINT
	 XOR AX,AX
	 MOV AL,[BX]
	 PUSH AX
	 INC BX
	 MOV AX,[BX]
	 INC BX
	 INC BX
	 XOR CX,CX
S1:
	 MOV SI,[BX]
	 TEST SI,[BX]
	 JZ OUTSIDE
	 INC CX
	 INC BX
	 MOV DX,[BX]
	 MOV [BX],AX
	 MOV AX,DX
	 INC BX
	 INC BX
	 JMP S1

OUTSIDE:
	 ; AL CONTAINS THE DIECTION OF HEAD FOR THE SNAKE
	 POP AX
	 PUSH DX
	 LEA BX,HEAD
	 INC BX
	 MOV DX,[BX]

	 ; SHIFT THE HEAD IN THE PROPER DIRECTION
	 CMP AL,'<'
	 JNE NEXT_1
	 DEC DL
	 DEC DL
	 JMP DONE_CHECK_HEAD
NEXT_1:
	 CMP AL,'>'
	 JNE NEXT_2
	 INC DL
	 INC DL
	 JMP DONE_CHECK_HEAD
NEXT_2:
	 CMP AL,'^'
	 JNE NEXT_3
	 DEC DH
	 JMP DONE_CHECK_HEAD
NEXT_3:
	 INC DH

DONE_CHECK_HEAD:
	 MOV [BX],DX
	 CALL READ_CHAR

	 CMP BL,'P'
	 JE ATE_FRUIT

	 ; CLEAR THE LAST SEGMENT IF FRUIT IS NOT EATEN
	 MOV CX,DX
	 POP DX
	 CMP BL,'+'					; SNAKE TOUCHED ITSELF, GAME WILL FINISH
	 JE GAME_OVER
	 MOV BL,0
	 CALL WRITE_CHAR
	 MOV DX,CX

	 ; CHECK WHETHER SNAKE IS INSIDE THE BORDERS OR NOT 
	 CMP DH,TOP
	 JE GAME_OVER
	 CMP DH,BOTTOM
	 JE GAME_OVER
	 CMP DL,LEFT
	 JE GAME_OVER
	 CMP DL,RIGHT
	 JE GAME_OVER
	 RET

GAME_OVER:
	 INC GameOver
	 RET
ATE_FRUIT:
	 MOV AL,segmentcount
	 XOR AH,AH
	 LEA BX,BODY
	 MOV CX,3
	 MUL CX
	 POP DX
	 ADD BX,AX
	 MOV BYTE PTR DS:[BX],'+'
	 MOV [BX+1],DX
	 INC segmentcount
	 MOV DH,Fruity
	 MOV DL,Fruitx
	 MOV BL,0
	 CALL WRITE_CHAR
	 MOV Fruitactive,0
	 RET
SNAKE ENDP

; FUNTION TO PRINT BORDERS FOR THE GAME
; USES MACROS DEFINED INITIALLY 
; PRINTS IN A CIRCULAR MANNER

PRINT_BORDERS PROC
	 MOV DH,TOP
	 MOV DL,LEFT
	 MOV CX,COL
	 MOV BL,'#'
X1:
	 CALL WRITE_CHAR
	 INC DL
	 LOOP X1

	 MOV CX,ROW
X2:
	 CALL WRITE_CHAR
	 INC DH
	 LOOP X2

	 MOV CX,COL
X3:		
	 CALL WRITE_CHAR
	 DEC DL
	 LOOP X3

	 MOV CX,ROW
X4:
	 CALL WRITE_CHAR
	 DEC DH
	 LOOP X4

	 RET
PRINT_BORDERS ENDP

; FUNTION TO WRITE CHAR
; DX CONTAINS ROW,COL 
; BL CONTAINS CHAR TO WRITE
; USING DI

WRITE_CHAR PROC
	 PUSH DX
	 MOV AX,DX
	 AND AX,0FF00H
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1

	 PUSH BX
	 MOV BH,160
	 MUL BH

	 POP BX
	 AND DX,0FFH
	 SHL DX,1
	 ADD AX,DX
	 MOV DI,AX
	 MOV ES:[DI],BL
	 POP DX
	 RET
WRITE_CHAR ENDP

; FUNTION TO READ CHAR
; DX CONTAINS ROW,COL 
; RETURNS CHAR AT BL
; USING DI


READ_CHAR PROC
	 PUSH DX
	 MOV AX,DX
	 AND AX,0FF00H
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1


	 PUSH BX
	 MOV BH,0A0H
	 MUL BH

	 POP BX
	 AND DX,0FFH
	 SHL DX,1
	 ADD AX,DX
	 MOV DI,AX
	 MOV BL,ES:[DI]
	 POP DX
	 RET
READ_CHAR ENDP

; FUNCTION TO DISPLAY THE STRING ON SCREEN
; DX CONTAINS ROW,COL (WHERE TO PRINT)
; BX CONTAINS OFFSET OF STRING 

DISPLAY_STRING PROC
	 PUSH DX
	 MOV AX,DX
	 AND AX,0FF00H
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1
	 SHR AX,1

	 PUSH BX
	 MOV BH,0A0H
	 MUL BH

	 POP BX
	 AND DX,0FFH
	 SHL DX,1
	 ADD AX,DX
	 MOV DI,AX
LOOP1:
	 MOV AL,[BX]
	 Test AL,AL
	 JZ EXIT_DISPLAY_STRING
	 MOV ES:[DI],AL
	 INC DI
	 INC DI
	 INC BX 
	 JMP LOOP1
EXIT_DISPLAY_STRING:
	 POP DX
	 RET

DISPLAY_STRING ENDP

MAIN ENDP
END MAIN