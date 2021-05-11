bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;4. Given the bytes A and B, Compute the doubleword C as follows:  
;the bits 8-15 of C have the value 0 ;
;the bits 16-23 of C are the same as the bits of B 
;the bits 24-31 of C are the same as the bits of A 
;the bits 0-7 of C have the value 1 
segment data use32 class=data
    a db 10101010b
    b db 10010010b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
    ; in ebx we have the result;
        mov ebx, 00000000000000000000000000000000b ; ebx has 32 bits of 0, so the bits 8-15 of C have the value 0
        
        or ebx,  00000000000000000000000011111111b ; the bits 0-7 of C have the value 1  
        
        
        
        mov eax, 0; facem eax 0 ca sa putem transforma byte ul b in doubleword
        mov al, [b]; punem pe al b; iar acum pe eax avem doublewordul b
        cbw
        cwd
        mov cl, 16 ; punem in cl 16, pentru a face rotatia bitilor
        rol eax, cl; rotatia bitilor spre stanga cu 16 de pozitii
        or eax, ebx ;  <-  the bits 16-23 of C are the same as the bits of B 
        
        
        
        mov eax, 0; facem eax 0 ca sa putem transforma byte ul a in doubleword
        cbw
        cwd
        mov al, [a]; punem in al [a] iar acum pe eax avem doubleword a;
        mov cl, 24; punem in cl 24 pentru a putea face rotattia bitilor;
        rol eax, cl; rotatia bitilor spre stanga cu 24 pozitii
        or eax, ebx ; <- the bits 24-31 of C are the same as the bits of A 
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
