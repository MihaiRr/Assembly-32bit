bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data ; 3*[20*(b-a+2)-10*c]/5 ; a,b,c -byte, d -word
    a db 2;
    b db 1;
    c db 1;
    d dw 1;

; our code starts here
segment code use32 class=code
    start:
        mov eax,0
        mov ebx,0 
        mov ecx, 0
        mov edx, 0
        mov al, [b]
        sub al, [a]
        add al, 2
        mov bl, 20
        imul bl; ax= 20*(b-a+2)
        
        mov bx, ax; bx= ax= 20*(b-a+2)
        
        mov ax, 0
        mov al, [c]
        mov cl, 10
        imul cl; ax= 10*c
        
        sub bx, ax;  bx=[20*(b-a+2)-10*c]
        
        mov ax, bx; ax =[20*(b-a+2)-10*c]
        mov bx, 3
        imul bx; dx:ax = 3*[20*(b-a+2)-10*c]
        
        push dx
        push ax
        pop eax ; eax= 3*[20*(b-a+2)-10*c]
        
        mov bx, 5
        idiv bx; 
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
