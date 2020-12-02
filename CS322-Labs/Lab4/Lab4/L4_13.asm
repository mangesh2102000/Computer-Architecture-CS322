;TITLE "ARROWS TO
;INT 16h AH = 00h - read keystroke
;Return: AL = character read from standard input

.model small
.stack 64
.data
ENTER_KEY equ 0Dh
ESC_KEY equ 1Bh ; exit
U_KEY equ 48h
D_KEY equ 50h
L_KEY equ 4Bh
R_KEY equ 4Dh

.code
    main:   mov ax , @DATA
    mov ds , ax
    mov bx , ESC_KEY
    mov cx , 0
    
    readUntilESC:

    mov ah , 07h
    int 21h
   
    cmp al , U_KEY
    je U2w
    
    cmp al , D_KEY
    je D2z
    
    cmp al , L_KEY
    je L2a
    
    cmp al , R_KEY
    je R2d
    
    cmp al , ESC_KEY
    jne readUntilESC ; loop until ESC
    jmp Exit
    
    ; swap values for ASCII
    U2w:
    mov dl , 77h
    jmp printChar
    
    D2z:
    mov dl , 7Ah
    jmp printChar
    
    L2a:
    mov dl , 61h
    jmp printChar
   
   R2d:
    mov dl , 64h
    jmp printChar
    
    ; print char and go back to main loop
    printChar:
    mov ah , 02h
    int 21h
    jmp readUntilESC
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
