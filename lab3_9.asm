bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;9. Given the word A and the byte B, compute the doubleword C as follows:  
;the bits 0-3 of C are the same as the bits 6-9 of A  
;the bits 4-5 of C have the value 1  
;the bits 6-7 of C are the same as the bits 1-2 of B 
;the bits 8-23 of C are the same as the bits of A 
;the bits 24-31 of C are the same as the bits of B 
segment data use32 class=data
    a dw 0111011101010111b
    b db 10111110b
    c dd

; our code starts here
segment code use32 class=code
    start:
        mov ebx, 0; 
        
        mov ax, [a]
        and ax, 0000001111000000b;
        mov cl, 6
        ror ax, cl
        or bx, ax ;the bits 0-3 of C are the same as the bits 6-9 of A 
        
        or bx, 0000000000110000b; the bits 4-5 of C have the value 1  
        
        mov dl, [a]
        and dl, 00000110b
        mov cl, 5
        rol dl, cl
        or bx, dx ;the bits 6-7 of C are the same as the bits 1-2 of B 
        
       
        mov eax, [a]
        mov cl, 8
        rol eax, cl
        or ebx, eax ;the bits 8-23 of C are the same as the bits of A
        
        mov eax, [b]
        mov cl, 24
        rol eax, cl
        or ebx, eax; ;the bits 24-31 of C are the same as the bits of B         
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
