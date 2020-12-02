;filename   lab5.asm
;	Objective: To implement the GNOME sort algorithm for sorting given list of 32-bit integers (other than 0) 
;            in non-decreasing order.
;	    Input: Size of the array followed by list of integers present in the array
;     Output: Sorted list of given integers


MAX_SIZE   EQU   1000

%include "io.mac"

.DATA
prompt_msg   db  "Enter elements of the array ( Enter zero to terminate the input. ) : ",0
output_msg   db  "Sorted List of given integers : ",0
end_msg   db  "Terminate the program ? (Y/N) ",0

.UDATA
array       resw  MAX_SIZE     ; input array for integers

.CODE
	  global   _start
_start:
      PutStr prompt_msg 	 ; request input numbers
      nwln
      mov     EBX,array      ; EBX := array pointer
      mov     ECX,MAX_SIZE    ; CX := array size
      sub     EDX,EDX          ; number count := 0

read_loop:
      GetLInt EAX            ; read input number
      cmp     EAX,0          ; if the number is zero
      je      stop_reading   ; no more numbers to read
      mov     [EBX],EAX      ; copy the number into array
      add     EBX,4          ; EBX points to the next element
      inc     EDX             ; increment number count
      loop    read_loop      ; reads a max. of MAX_SIZE numbers

stop_reading:
	    cmp     EDX,0          ; Check if count of total input numbers is zero
	    je 	  end_iteration    ; if yes, end this iteration

      push    EDX            ; push array size onto stack
      push    array          ; place array pointer on stack
	
	    call GnomeSort

	    PutStr  output_msg     ; display sorted input numbers
      nwln
      mov     EBX,array      ; store starting pointer of array in EBX register
      mov     CX,DX          ; CX := number count
print_loop:
      PutLInt  [EBX]         ; Print current element
      nwln                   ; Print new line        
      add     EBX,4          ; Increment pointer to next element 
      loop    print_loop     ; Loop till CX is non zero

end_iteration:
      PutStr  end_msg		     ; ask user to terminate program 
      GetCh   AL 			       ; store input char into AL
      cmp 	  AL,'N'         ; compare accordingly and decide 
      je 	  _start		       ; to start again or end program
done:
      .EXIT      

.CODE
GnomeSort: 
    pushad				           ;store registers on stack for later restoration    
    mov EBP,ESP			           ;move stack pointer to base pointer 
   
    ;EBP + 36   is the array
    ;EBP + 40   is the number of integers in the array 
    mov ECX, [EBP+40]          ;setting ECX to the number of integers
    mov ESI, [EBP+36]          ;ESI is the array
    xor EAX, EAX               ;Setting EAX to 0, it'll be our iterator(i)
   
    MainLoop:        
        cmp EAX, ECX           ;If 'i' >= the number of integers, exit the loop
        jge EndLoop    
       
        cmp EAX, 0             ;If 'i' == 0, move to the next element
        je IncreaseCounter
                     
        mov EBX, [ESI]         ;EBX = array[i]
        mov EDX, [ESI-4]       ;EDX = array[i-1]
        cmp EDX, EBX           ;If array[i-1] <= array[i], it means they are
        jle IncreaseCounter    ;sorted, so move to the next element  
       
        ;else, swap array[i-1] with array[i]
        push DWORD [ESI]
        push DWORD [ESI-4]   
        pop DWORD [ESI]
        pop DWORD [ESI-4]
    
        sub ESI, 4              ;Move to the previous element in the array
        dec EAX                 ;and decrease 'i'
       
    BackToMainLoop:
        jmp MainLoop            ;Loop back to the top
       
    IncreaseCounter:
        inc EAX                 ;and increasing 'i'
        add ESI, 4              ;Moving to the next element in the array
        jmp BackToMainLoop
   
    EndLoop:
   
    popad					; Restoring the registers
    ret 6					; return and clear parameters