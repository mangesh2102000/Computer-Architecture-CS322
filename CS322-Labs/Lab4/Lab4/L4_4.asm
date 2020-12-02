.model small
.stack 64
.data
a db 03h 

.code
    main:
        mov bx , 03h    ; char counter
        mov cx , 03h    ; line counter
        
        print_line:
            push cx         ; save how many lines left
            mov cx , bx     ; load char counter
            mov dl , 041h   ; ascii for 'A'
            
        print_char:     
            mov ah , 02h
            int 21h
            inc dl          ; next char
            dec cx          ; char counter
            jnz print_char  ;
    
        ; endline
        mov dl , 0ah        ; CR
        int 21h
        mov dl , 0dh        ; LF
        int 21h
            
        add bx , 03h        ; increse chars amount to display    
        pop cx              ; load line counter
        dec cx              ; decrase line counter by 1    
    	jnz print_line
  exit:    
      mov ah, 4ch
     int 21h
      end main
     .end
