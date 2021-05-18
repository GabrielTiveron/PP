%include    'functions.s'

SECTION .data
; filename db 'readme.txt', 0h    ; the filename to create
contents db 'To aqui', 0h  ; the contents to write

SECTION .bss
fileContents resb 2048,          ; variable to store file contents

SECTION .text
global  _start

_start:
    ; pop     ecx
    pop     ecx
    pop     eax
    pop     eax
    ; mov     eax, ecx
    ; call    sprintLF

    mov     ebx, eax
    mov     ecx, 0              ; Open file from lesson 24
    mov     eax, 5
    int     80h

    mov     edx, 2048             ; number of bytes to read - one for each letter of the file contents
    mov     ecx, fileContents   ; move the memory address of our file contents variable into ecx
    mov     ebx, eax            ; move the opened file descriptor into EBX
    mov     eax, 3              ; invoke SYS_READ (kernel opcode 3)
    int     80h                 ; call the kernel

    ; mov     eax, 0
    mov     eax, fileContents
    mov     ecx, 0
    jmp     iterate
    ; mov     eax, fileContents   ; move the memory address of our file contents variable into eax for printing
    ; call    sprintLF            ; call our string printing function
    ;
    ; call    quit                ; call our quit function

iterate:
    mov     ecx, eax
    call    proxchar

    mov     edx, eax

    call    compString

compString:
    cmp ecx, edx
    jnz diferente
    inc ecx
    inc edx
    test ecx, 0
    je  fim
    jmp compString

diferente:
    call sprintLF
    call quit

fim:
    call quit

proxchar:
    cmp     byte [eax], 0Ah
    inc     eax
    jnz     proxchar
    ret
