bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
extern exit,printf,scanf,gets,getchar    

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 
import gets msvcrt.dll
import getchar msvcrt.dll 

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;6. Read a string and read two characters. Replace all occurrences of second character with first character. Print on screen the resulted string. 
;Ex:  s = ana are 7 mere si 5 pere, c1 = T si c2 = e => d = ana arT 7 mTrT si 5 pTrT 

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s resb 50
    rez resb 50
    formatString db '%s', 0
    formatChar db '%c', 0
    char1 resb 1
    char2 resb 1
    readStrFormat db 'Input string:', 0 
    printStrFormat db 'String read:%s ' ,0
    char1Format db 'Input first character:',0
    char2Format db 'Input second character:',0
    bothCharFormat db 'Characters read: %c %c ', 0
    resultFormat  db 'Result after computations :%s ',0
    
    newLine db 10,0

; our code starts here
segment code use32 class=code
    start:
        
        ;format for reading string
        push dword readStrFormat
        call [printf]
        add esp,4*1
        
       ;reading string       
        push dword s
        call [gets]
        add esp, 4*1
        
        ;printing string
        push dword s
        push printStrFormat
        call [printf]
        add esp, 4*2
        
 
        push dword newLine
        call [printf]
        add esp, 4*1 
        
        ;format for char1
        push char1Format
        call [printf]
        add esp,4*1
        
        ;reading char1
        push dword char1
        push dword formatChar
        call [scanf]
        add esp, 4*2
        call [getchar]
        
        ;format for char2
        push char2Format
        call [printf]
        add esp,4*1
        
        ;reading char2
        push dword char2
        push dword formatChar
        call [scanf]
        add esp, 4*2
        call [getchar]
             
        
        ; printing char1 and char2
        push dword [char2]
        push dword [char1]
        push dword bothCharFormat
        call [printf]
        add esp, 4*3
        
        push dword newLine
        call [printf]
        add esp, 4*1
        
        mov ecx, 50 ; maximum char in string
        mov esi, 0 ; for 
        mov bl,[char1]
        
        repeta:
            mov al, [s+esi]  
            cmp al, [char2]
            JE replace
            JNE next
                replace:
                    mov [rez+esi],bl
                    inc esi
                jmp end_repeta
                next:
                    mov dl,[s+esi]
                    mov [rez+esi],dl
                    inc esi
                    
                
                    end_repeta:
    loop repeta
    
        
        push dword rez
        push resultFormat
        call [printf]
        add esp, 4*2
        
        
        
  


        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
