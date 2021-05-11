bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;5  Given the bytes A and B, compute the doubleword C as follows:  
;Xthe bits 16-31 of C have the value 1 
;Xthe bits 0-3 of C are the same as the bits 3-6 of B  
;Xthe bits 4-7 of C have the value 0  
;Xthe bits 8-10 of C have the value 110  
;Xthe bits 11-15 of C are the same as the bits 0-4 of A  
segment data use32 class=data
    a db 01110111b
    b db 10111110b
    c resd 0
; our code starts here
segment code use32 class=code
    start:
        mov ebx, 00000000000000000000000000000000b;
        
        or ebx,  11111111111111110000000000000000b;  the bits 16-31 of C have the value 1      
        
        mov eax,0
        mov al, [b]
        and al, 01111000b
        mov cl, 3
        ror al, cl; the bits 0-3 of C are the same as the bits 3-6 of B          
        or ebx, eax; 
        
        and ebx, 11111111111111111111111000001111b; the bits 4-7 of C have the value 0  
        or ebx,  00000000000000000000011000000000b; the bits 8-10 of C have the value 110
        
        mov eax, 0
        mov al, [a]
        and al, 00001111b;
        mov cl, 11
        rol eax, cl
        or ebx, eax;the bits 11-15 of C are the same as the bits 0-4 of A
          
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
