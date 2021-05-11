bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data ;(a*2+b/2+e)/(c-d)+x/a 
 a dw  2
 b db 2
 c db 2
 d db 1
 e dd 1
 x dq 4
 aux resd 1
 auxq resq 1
; our code starts here
segment code use32 class=code ;(a*2+b/2+e)/(c-d)+x/a ; a - word ; b,c,d-byte; e-doubleword; x-qword
    start:
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0
        
        mov bx, 2
        mov ax, [a]
        imul bx ; dx:ax=a*2
        
        mov word[aux+0], ax
        mov word[aux+2], dx ; aux= dx:ax (doubleword)
        
        mov al, [b]
        cbw; ax=b (word)
        mov bl, 2
        idiv bl; ah - rest, al - cat
        cbw 
        cwde ; doubleword b/2
        
        mov ebx, [aux]
        mov ecx, [e]
        
        add eax, ebx;
        add eax, ecx; eax = (a*2+b/2+e) - doubleword
        
        mov ebx, eax; ebx=eax;
        
        mov al, [c]
        sub al, [d]; al= c-d
        cbw ; ax=c-d
        
        mov cx,ax; cx=ax; cx= c-d (word)
        mov eax, ebx; eax= (a*2+b/2+e) - doubleword
        
        ;moving eax to dx:ax
        
        mov [aux], eax        
        mov dx, word[aux+2]
        mov ax, word[aux+0]
        idiv cx; dx:ax / cx -> dx - rest, ax- cat 
       ; ax=(a*2+b/2+e)/(c-d)
        
        mov cx, ax; cx =(a*2+b/2+e)/(c-d)
        
        mov ax, [a]
        cwde
        mov ebx, eax; ebx=a
        
    
        mov eax, dword[x+0]
        mov edx, dword[x+4]
        
        idiv ebx; eax cat edx rest
        ; eax should have the final result
        

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
