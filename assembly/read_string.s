SECTION .data
    global x
    mystring: db "stackoverflow",0
    mystringl: equ $-mystring
    array: TIMES mystringl dd 0
SECTION .text
global _start
_start:
    enter 0,0
    pusha
    mov ecx, 0                      ; counter

looper:
    cmp byte[mystring+ecx], 0x0     ; check for end of string
    je exit

    mov eax, 0                      ; empty eax
    mov al, byte[mystring+ecx]      ; move string position into al
    mov byte[array+ecx], al         ; write into memory

    push eax
    mov eax, 0
    mov al, byte[array+ecx]
    call print_char
    push ecx
    call print_nl
    pop eax
    pop ecx

    add ecx, 1
    jmp looper

exit:
    mov ebx, 0
    mov eax, 1
    int 80h

print_char:
    ; Print 'A' character
    mov   eax, 4      ; __NR_write from asm/unistd_32.h (32-bit int 0x80 ABI)
    mov   ebx, 1      ; stdout fileno

    mov   edx, 1      ; edx should contain how many characters to print
    int   80h         ; sys_write(1, "A", 1)

    ; return value in EAX = 1 (byte written), or error (-errno)

print_nl:
    ; Print 'A' character
    mov   eax, 4      ; __NR_write from asm/unistd_32.h (32-bit int 0x80 ABI)
    mov   ebx, 1      ; stdout fileno
    mov   ecx, 0Ah
    mov   edx, 1      ; edx should contain how many characters to print
    int   80h         ; sys_write(1, "A", 1)
    ; return value in EAX = 1 (byte written), or error (-errno)
