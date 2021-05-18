%include    'functions.s'
section .bss
    buffer:   resb 2048   ; A 2 KB byte buffer used for read
    ; last: resb 1

section .data
    buflen: dd 2048   ; Size buffer
    current: times 2048 dw 0
    last: times 2048 dw 0
    index_b: dd 0
    index_c: dd 0
    index_l: dd 0
    DIF: db 'DIFERENTE' ;
    D1: db 'To aqui', 0Ah ;
    C: db 'Comparando', 0Ah ;
    I: db 'Igual', 0Ah ;


section .text
global _start
_start:

    pop ebx       ; argc
    pop ebx       ; argv[0] (executable name)
    pop ebx       ; argv[1] (desired file name)

    mov eax, 0x05 ; syscall number for open
    xor ecx, ecx  ; O_RDONLY = 0
    xor edx, edx  ; Mode is ignored when O_CREAT isn't specified
    int 0x80      ; Call the kernel
    test eax, eax ; Check the output of open()
    jns file_read ; If the sign flag is set (positive) we can begin reading the file

file_read:

    mov ebx, eax        ; Move our file descriptor into ebx
    mov eax, 0x03       ; syscall for read = 3
    mov ecx, buffer     ; Our 2kb byte buffer
    mov edx, buflen     ; The size of our buffer
    int 0x80
    test eax, eax       ; Check for errors / EOF

    ; mov al, [buffer]
    ; mov [current], al
    cmp [eax], byte 0
    jnz quit

get_last:
    mov al, index_b
    movzx ebx, al
    mov al, index_l
    movzx eax, al
    mov al, [buffer+ebx]
    mov [last+eax], al

    test al, 0Ah
    mov al, [index_b]
    inc al
    mov [index_b], al

    je get_current
    mov al, [index_l]
    inc al
    mov [index_l], al

    mov al, index_b
    mov bl, buflen
    cmp al, bl
    je fim

    jmp get_last

get_current:
    mov al, index_b
    movzx ebx, al
    mov al, index_c
    movzx ecx, al
    mov al, [buffer+ebx]
    mov [current+ecx], al

    test al, 0Ah
    mov al, [index_b]
    inc al
    mov [index_b], al
    je prep_compare
    mov al, [index_c]
    inc al
    mov [index_c], al

    mov al, index_b
    mov bl, buflen
    cmp al, bl
    jne fim

    jmp get_current

prep_compare:
    mov ax, [index_c]
    mov cx, [index_l]
    cmp ax, cx
    je diff
    mov eax, 0
    mov ecx, 0
    mov bx, 0

comp_char:
    cmp eax, index_l
    je equal
    mov eax, [last + bx]
    mov ebx, [current + bx]
    cmp eax, ebx
    add bx, 1
    je comp_char
    jne diff

equal:
    mov al, [index_b]
    mov bl, [index_c]
    sub al, bl
    mov [index_b], al
    mov al, 0
    mov [index_c], al
    mov [index_l], al
    jmp get_last

diff:
    ; print last

fim:
    call quit
