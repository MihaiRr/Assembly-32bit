bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data  ; 
a db 2
b db 3
c db 1
d dw 4

; our code starts here
segment code use32 class=code ;–a*a + 2*(b-1) – d
    start:
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0
        
        mov al, 0; al=0 | 
        sub al, [a]; al=-a
        imul byte[a] ; ax=-a*a
        
        mov cx, ax; cx=ax;
        
        mov al, [b]
        sub al, 1
        mov bl, 2
        imul bl; ax= 2*(b-1)
        
        add ax,cx;
        sub ax, [d]; ax=–a*a + 2*(b-1) – d
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
