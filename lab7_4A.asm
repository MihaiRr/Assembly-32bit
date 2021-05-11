bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start   
extern exit,printf,scanf    

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;4. Read two numbers a and b in decimal. 
;Calculate their product and display the result in the following format: "<a> * <b> = <result>".  
;Example: "2 * 4 = 8" The value of result will be displayed in hexadecimal format. 

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    result dq 0
    formatA db 'a=', 0 ;
    formatB db 'b=', 0
    readFormat db '%d', 0
    printFormat db '%d * %d = %x', 0        
 

; our code starts here
segment code use32 class=code
    start: 
    
        push dword formatA
        call [printf]
        add esp,4*1
        
        push dword a
        push dword readFormat
        call [scanf]
        add esp,4*2
        
        push dword formatB
        call [printf]
        add esp,4*1
        
        push dword b
        push dword readFormat
        call [scanf]
        add esp,4*2
        
        mov eax,0
        mov eax,[a]
        IMUL dword[b]
        mov [result+0],eax
        mov [result+4],edx
        
        
        push dword [result] ; 
        push dword [b] 
        push dword [a] 
        push dword printFormat
        call [printf]
        add esp,4*4

        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
