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
    ; open(char *path, int flags, mode_t mode);

    ; Get our command line arguments.
    pop ebx ; argc
    pop ebx ; argv[0] (executable name)
    pop ebx ; argv[1] (desired file name)

    ; mov crnt_len, 0
    ; mov last_len, 0

    mov eax, 0x05 ; syscall number for open
    xor ecx, ecx ; O_RDONLY = 0
    xor edx, edx ; Mode is ignored when O_CREAT isn't specified
    int 0x80 ; Call the kernel
    test eax, eax ; Check the output of open()
    jns file_read ; If the sign flag is set (positive) we can begin reading the file

  ; = If the output is negative, then open failed. So we should exit
exit:
    mov eax, 0x01 ; 0x01 = syscall for exit
    xor ebx, ebx ; makes ebx technically set to zero
    int 0x80

  ; = Begin reading the file

file_read:
    ; read(int fd, void *buf, size_t count);
    mov ebx, eax    ; Move our file descriptor into ebx
    mov eax, 0x03   ; syscall for read = 3
    mov ecx, buffer ; Our 2kb byte buffer
    mov edx, buflen ; The size of our buffer
    int 0x80
    test eax, eax   ; Check for errors / EOF

    ; mov index_c, 0
    ; mov index_l, 0
    mov eax, [buffer]

    ;mov byte[current], [buffer]
    ; cmp [eax], byte 0
    jmp iterate_file ; If EOF, then write our buffer out.
    ; call quit         ; If read failed, we exit.

iterate_file:
    ; get oline by line
    push eax
    mov eax, D1
    call sprintLF
    pop eax
    test [eax], byte 0
    je quit

    mov ecx, eax
    jmp fill_current
    ; inc eax

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

file_out:
    ; write(int fd, void *buf, size_t count);
    mov edx, eax ; read returns amount of bytes read
    mov eax, 0x04 ; syscall write = 4
    mov ebx, 0x01 ; STDOUT = 1
    mov ecx, buffer ; Move our buffer into the arguments
    int 0x80
    call quit
