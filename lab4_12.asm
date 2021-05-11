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
    A db 3,4,1,2,-3,-4
    len_a EQU $-A ; len_a = 7
    
    B db -2,3,1,-3,4,-8,9,-9    
    len_b EQU $-B ; len_b = 8
    
    R  times len_a db 0 ;  sir rezultat
; our code starts here

;12. Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele pare si negative din cele 2 siruri.  

segment code use32 class=code
    start:
        
        mov ecx,len_a
        
        mov esi,0 ; 
        mov edi,0 ; 
        
        Repeta: 
    
           
            MOV eax,0
            MOV al,[A+esi] 
            cmp al,0
            JGE pozitive            
            JL negative
        
            negative:
                cbw     
                mov bl,2 
                idiv bl ;al cat si ah rest
                cmp ah,0
                JE par
                JNE not_par
            
                par:
                    mov al,[A+esi]
                    mov [R+edi],al
                    inc esi
                    inc edi
                    jmp end_repeta
                not_par:
                    inc esi
        ;JMP final
            pozitive:
          
                inc esi
                end_repeta:
                    
                    loop Repeta
                
                
                
        mov ecx,len_b
        
        mov esi,0 ; 
        ;mov edi,0 ; 
        
        Repeta1: 
    
            ;first elem
            MOV eax,0
            MOV al,[B+esi] ; 
            cmp al,0
            JGE pozitive1            
            JL negative1
        
            negative1:
                cbw ;     
                mov bl,2 
                idiv bl 
                cmp ah,0
                JE parB
                JNE not_parB
            
                parB:
                    mov al,[B+esi]
                    mov [R+edi],al
                    inc esi
                    inc edi
                    jmp end_repeta1
                not_parB:
                    inc esi
                    jmp end_repeta1
        
            pozitive1:
                inc esi
          
    
    
    
        end_repeta1:
            LOOP Repeta1
        
            
        
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
