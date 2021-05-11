%include    'functions.s'
 
SECTION .data
filename db 'readme.txt', 0h    ; the filename to create
contents db 'Hello world!', 0h  ; the contents to write
 
SECTION .bss
fileContents resb 255,          ; variable to store file contents
 
SECTION .text
global  _start
 
_start:
 
    pop     ebx
    pop     ebx
    pop     ebx
    mov     ecx, 0              ; Open file from lesson 24
    mov     eax, 5
    int     80h
 
    mov     edx, 1024           ; number of bytes to read - one for each letter of the file contents
    mov     ecx, fileContents   ; move the memory address of our file contents variable into ecx
    mov     ebx, eax            ; move the opened file descriptor into EBX
    mov     eax, 3              ; invoke SYS_READ (kernel opcode 3)
    int     80h                 ; call the kernel
 
    mov     eax, fileContents   ; move the memory address of our file contents variable into eax for printing
    call    sprintLF            ; call our string printing function
 
    call    quit                ; call our quit function