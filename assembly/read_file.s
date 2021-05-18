%include    'functions.s'

SECTION .data
; filename db 'readme.txt', 0h    ; the filename to create
contents db 'To aqui', 0h  ; the contents to write

SECTION .bss
fileContents resb 2048,          ; variable to store file contents

SECTION .text
global  _start

_start:
    pop     ecx
    pop     eax
    pop     eax

    mov     ebx, eax
    mov     ecx, 0
    mov     eax, 5
    int     80h

    mov     edx, 2048
    mov     ecx, fileContents
    mov     ebx, eax
    mov     eax, 3
    int     80h

    ; mov     eax, 0
    mov     eax, fileContents
    mov     ecx, 0
    jmp     iterate

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
