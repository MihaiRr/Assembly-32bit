bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                          
;14. Given the words A and B, compute the doubleword C as follows:  

;the bits 0-5 of C are the same as the bits 3-8 of A  

;the bits 6-8 of C are the same as the bits 2-4 of B  

;the bits 9-15 of C are the same as the bits 6-12 of A  

;the bits 16-31 of C have the value 0                          
segment data use32 class=data
    a dw 1010101001010101b
    b db 0000111110100101b

; our code starts here
segment code use32 class=code
    start:
        mov ebx, 00000000000000000000000000000000b; pastram rezutatul in ebx, the bits 16-31 of C have the value 0 
        
        mov eax, 0;
        mov ax, [a]
        and ax, 0000000111111000b; izolam biti 3-8 din A
        cwd
        mov cl, 3
        ror eax, cl ; rotim bitii cautati pe pozitia 0-5
        or ebx, eax;
        
        mov eax, 0;
        mov ax, [b]
        cwd
        and ax, 0000000000011100b;
        mov cl, 4;
        rol eax, cl
        or ebx, eax; the bits 6-8 of C are the same as the bits 2-4 of B 
        
        mov eax, 0;
        mov ax, [a]
        and ax, 0001111111000000b;
        cwd
        mov cl, 3
        rol eax, cl
        or ebx, eax; the bits 9-15 of C are the same as the bits 6-12 of A  
        
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
