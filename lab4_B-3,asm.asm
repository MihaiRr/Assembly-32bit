bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 11223344h, 11A2334Ch
    len_a equ ($-a)/4
    b1 times len_a db -1 ; inf
    b2 times len_a db -1 ; sup
; our code starts here
segment code use32 class=code
    start:
        ; B prob 4
        mov ecx, 0
        mov cx,len_a
    
        
        mov esi,0 ; pt parcurgere a
        mov edi,0 ; pt sir1/2
        
        loop_sir1:
            MOV eax,0
            MOV al,[a+esi] 
            MOV [b1 + edi],al
            add esi, 2
            add edi, 1
        loop loop_sir1
        
        mov ecx, 0
        mov cx,len_a
        
        mov esi,3 
        mov edi,0
        
        loop_sir2:
            MOV eax,0
            MOV al,[a+esi] 
            MOV [b2 + edi],al
            add esi,2
            add edi,1
        loop loop_sir2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
