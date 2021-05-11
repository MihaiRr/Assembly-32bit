bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;4. Se da un sir A de dublucuvinte. Construiti doua siruri de octeti   

;- B1: contine ca elemente partea superioara a cuvintelor superioare din A 

;- B2: contine ca elemente partea inferioara a cuvintelor inferioare din A
segment data use32 class=data
    ; ...
    a dd 11223344h, 11223344h
    len equ ($-a)/4
    b1 times len db -1 ; inferior
    b2 times len db -1 ; superior
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx,len
        
        mov esi,0 
        mov edi,0 
        
        loop_b1:
            MOV eax,0
            MOV al,[a+esi]
            MOV [b1 + edi],al
            add esi, 4
            add edi, 1
        loop loop_b1
        
        mov ecx,len       
        mov esi,3  
        mov edi,0 
        
        loop_b2:
            MOV eax,0
            MOV al,[a+esi] 
            MOV [b2 + edi],al
            add esi,4
            add edi,1
        loop loop_b2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
