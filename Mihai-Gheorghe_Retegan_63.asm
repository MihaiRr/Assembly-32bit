bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

extern exit,printf,scanf
import printf msvcrt.dll
import scanf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1,2,3,4,5
    len_a EQU $-a
    b db 10,10,10,10, 11
    len_b EQU $-b
    res times (len_a) db 0;

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len_a
        mov esi, 0
        mov edi, 0
        
        repeta:
            mov eax, 0
            mov ebx, 0
            mov al, [a+esi]
            mov bl, [b+esi]
            add al,bl
            mov [res+edi], al
            inc esi
            inc edi
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
