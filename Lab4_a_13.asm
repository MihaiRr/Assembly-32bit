bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A db 2, 1, 3, 3, 4, 2, 6 
    len_a EQU $-A ; 
    B db 4, 5, 7, 6, 2, 1 
    len_b EQU $-B ; 
    rez  times (len_a + len_b) db -1 ;  

; our code starts here
segment code use32 class=code
    start:
        ; 13. Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele pare ale lui A.  
        ;Exemplu: 
        ;A: 2, 1, 3, 3, 4, 2, 6 
        ;B: 4, 5, 7, 6, 2, 1 
        ;R: 1, 2, 6, 7, 5, 4, 2, 4, 2, 6 
        
        mov ecx,len_b
        
        mov esi,len_b-1 ; pt parcurgere b
        mov edi,0 ; pt rez
        
        Repeta:
            MOV eax,0
            MOV al,[B+esi] ; al=1
            mov [rez+edi],al
            dec esi
            inc edi
            jmp Final
        Final:
        Loop Repeta
        
        mov ecx,len_a
        
        mov esi,0 ; pt parcurgere a
        
        Repeta_a:
            MOV eax,0
            MOV al,[A+esi] ; al=2
            cbw ; ax = 2  
            mov bl,2 ; pt pare
            idiv bl ; ax/bl => al cat si ah rest
            cmp ah,0
            JE par
            JNE not_par
                par:
                    mov al,[A+esi]
                    mov [rez+edi],al
                    inc esi
                    inc edi
                    jmp Final_a
                not_par:
                    inc esi
        Final_a:
            Loop Repeta_a
            
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
