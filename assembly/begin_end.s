%include    'functions.s'
section .bss
    buffer:   resb 2048   ; A 2 KB byte buffer used for read
    ; current:  db 1   ; current line
    ; last:     db 1   ; last line

section .data
    buflen: dw 2048   ; Size buffer
    current: times 2048 dw 0
    DIF: db 'DIFERENTE' ;
    D1: db 'To aqui', 0Ah ;
    C: db 'Comparando', 0Ah ;
    I: db 'Igual', 0Ah ;


section .text
global _start
_start:

    pop ebx ; Leitura dos agumentos
    pop ebx
    pop ebx

    mov eax, 0x05 ; syscall para abrir o arquivo de entrada
    xor ecx, ecx
    xor edx, edx
    int 0x80
    test eax, eax
    jns file_read

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h

file_read:

    mov ebx, eax    ; Leitura do arquivo de entrada
    mov eax, 3
    mov ecx, buffer
    mov edx, buflen
    int 80h
    test eax, eax

    mov eax, [buffer]

    jmp iterate_file

iterate_file:
    ; Leitura de arquivo linha por linha
    push eax
    mov eax, D1
    call sprintLF
    pop eax
    test [eax], byte 0
    je quit

    mov ecx, eax
    jmp fill_current

    mov edx, 0

    jmp compString

compString:
    call sprintLF
    push eax
    mov eax, ecx
    call sprintLF
    pop eax

    cmp ecx, eax
    jne diff

    test ecx, 0Ah
    je equal

    inc eax
    inc ecx
    inc edx

    jmp compString

diff:
  mov eax, DIF
  call sprintLF
  jmp quit

equal:
    mov ecx, I
    mov edx, 6
    call sprintLF
    jmp quit

fill_current:
    test [eax],byte 0Ah
    inc eax

    jne fill_current
    ret
