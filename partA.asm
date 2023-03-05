.model small
.stack
.data





msg db 10, 13, 'Type your string and it will appear in encrypted form', 10, 13, '$'
msg2 db 'Enter the Value of Constant K "which is 20" ', 10, 13, '$'


.code
.startup

mov ah, 9
lea dx, msg2
int 21h


mov cl, 0
jmp waitpresskey

waitpresskey: 

mov ah, 8
int 21h
jmp numcheck

numcheck:
cmp al, 30h
jl waitpresskey
cmp al, 39h
jg waitpresskey
cmp cl, 0ah
je second

mov ah, 0eh
int 10h
cmp al, 30h
je zero
cmp al, 31h
je ten
cmp al, 32h
je twenty
jg waitpresskey

sub al, 30h

first:
mov cl, 0ah
jmp waitpresskey

zero:
mov bl, 0d
jmp first

ten:
mov bl, 10d
jmp first

twenty:
mov bl, 20d
jmp first


second:
mov ah, 0eh
int 10h
sub al, 30h
mov cl, al
add bl, cl 

cmp bl, 1h 
jl finish
cmp bl, 26d
mov ah, 09h
mov dl, space
int 21h
jg waitpresskey


sub bl, 1h

jmp enteringz
jmp waitpress

space db 20h, 24h

enteringz: 
mov ah, 09h
mov dl,_enter
int 21h

_enter db 0dh, 0ah, 024h

waitpress:
mov ah, 08h
int 21h

cmp al, 0dh
je enteringz
cmp al, 1bh
je finish
cmp al, 08h
je printing
cmp al, 09h
je transmit
cmp al, 41h 
jl checkingone
cmp al, 7ah 
jg printing
cmp al, 60h 
je printing
mov cl, 7ah
sub cl, bl
cmp al, cl
jg operation
mov cl, 5ah 
sub cl, bl
cmp al, cl
jg testing


coding: 
add al, bl
jmp printing

checkingone: 
cmp al, 1fh
jg printing
jmp waitpress

printing:
mov ah, 0eh
int 10h
jmp waitpress

operation: 
sub al, 1Ah
jmp coding

testing:
cmp al, 5bh 
jl operation 
cmp al, 60h 
jl printing 
jmp coding 


transmit: 
mov ah, 09h
mov dl, _enter
int 21h
jmp waitpresskey

finish: 
.exit
end