; "PASS OK/FAIL"
;INT 16h AH = 00h - read keystroke
;Return: AL = character read from standard input

.model small
.stack 64
.data
ENTER_KEY equ 0Dh
CHARS dw 010h
PassOkay db 0Dh , 0Ah ,"Password OKAY" , 0Dh , 0Ah , "$"
PassFail db 0Dh , 0Ah ,"Password FAIL" , 0Dh , 0Ah , "$"

.code
  main: mov ax , @DATA
    mov ds , ax
    mov bx , ENTER_KEY
    mov cx , 0
    
    readUntilEnter:
    mov ah , 00h
    int 16h
    
    cmp bl , al ; pressed ENTER ?
    je CheckLength
    
    mov ah , 02h
    mov dl , 2Ah
    int 21h
    
    inc cx
    cmp cx , CHARS
    jle readUntilEnter ; loop for 16 times
    
    CheckLength:
    cmp cx , CHARS
    jl PassOK
    
    PassWrong:
    lea dx , PassFail
    mov ah , 09h
    int 21h
    jmp Exit
    
    PassOK:
    lea dx , PassOkay
    mov ah , 09h
    int 21h
 
 exit:  
      mov ah, 4ch
      int 21h
      end main
     .end
