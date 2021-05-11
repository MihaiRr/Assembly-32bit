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
    A db 2,1,3,-3,-4,2,-6
    B db 4,5,-5,7,-6,-2,1 
    len_a EQU $-A ; len_a = 7
    len_b EQU $-B ; len_b = 7
    rez  times len_a db 0 ;  sir rezultat
; our code starts here
segment code use32 class=code
    start:
        ; A prob 12
        mov ecx,len_a
        
        mov esi,0 ; pt parcurgere a
        mov edi,0 ; pt D
        
    Repeta: 
    
        ;accesare primul elem
        MOV eax,0
        MOV al,[A+esi] ; al=2
        cmp al,0
        JGE pozitive            
        JL negative
        
        negative:
            cbw ; ax = 2    
            mov bl,2 ; pt pare
            idiv bl ; ax/bl => al cat si ah rest
            cmp ah,0
            JE adaugareinRez
            JNE nuadaugareinRez
            
                adaugareinRez:
                    mov al,[A+esi]
                    mov [rez+edi],al
                    inc esi
                    inc edi
                    jmp final
                nuadaugareinRez:
                    inc esi
        JMP final
        pozitive:
            inc esi
    
    
    
    final:
    LOOP Repeta
        
        mov eax,0
        mov al,[rez + 0]
        mov al,[rez + 1]
        mov al,[rez + 2]
        mov al,[rez + 3]
        mov al,[rez + 4]
        mov al,[rez + 5]
        
            
        
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program