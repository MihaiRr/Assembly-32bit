bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a –word, b – byte, c - word, d – byte
    ; (b-a)+3+d-c
    
    a dw 5
    b db 10 
    c dw 5
    d db 1
; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov ebx, 0
        ;mov ecx, 0
        ;mov edx, 0
        
        mov al, [b]
        mov ah, 0; in ax I have value of b on 16 bits
        sub ax, [a] ; b-a on ax
        
        add ax, 3 ; (b-a)+3 
        
        mov bl, [d]
        mov bh, 0 ; on bx I have value of d on 16 bits
        
        add ax,bx ; (b-a)+3+d
        
        sub ax, [c]
        
        
        
         
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
