bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    ;s dd 0abaaababh, 0abaaaaaah 
    s dd 1234abcdh, 1a2b3c4dh, 0abcd1234h
    ls equ ($-s)/4
    d times ls*4 db -1
    aux dd 0
    aux2 dd 0
    k dw 5

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, 0
        mov edi, 0
        mov ecx, ls
        
        repeatS:
            mov [aux], ecx
            mov ecx, 4 ; ecx = 4 bcs dd has 4 bytes, we need to check all 4
            repeatTakeByte:
                mov bl, byte[s+esi]
                mov [aux2], ecx
                mov ecx, 8 ; 1 byte = 8 bits
                mov al, 0
                repeatCalcBits:
                    rol bl, 1
                    jc incCounter ; check if cf = 1
                    jnc continue ; no => nothing
                    incCounter: ; yes => al++
                        inc al
                    continue:
                    clc
                loop repeatCalcBits
                
                mov ecx, [aux2]
                cbw
                cmp ax, [k]
                jle addToResultedArray
                jge justContinue
                addToResultedArray:
                    mov [d+edi], bl
                    inc edi
                justContinue:
                inc esi
            loop repeatTakeByte
            mov ecx, [aux]
        
        loop repeatS
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
