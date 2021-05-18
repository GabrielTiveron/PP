SECTION .data
  msg   db 'AB', 0Ah, 'CD', 0Ah, 'NT', 0Ah
  msg2  db 'AB', 0Ah, 'CD', 0Ah, 'NT', 0Ah
  msg_enc db 'Achou!', 0Ah

SECTION .text
  global _start

_start:
    mov ecx, msg
    jmp nextchar

nextchar:
    mov al, [ecx]
    cmp al, 0Ah
    je  print
    cmp al, 0
    je  quit
    inc ecx
    jmp nextchar

print:
    mov edx, 1
    inc ecx
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp nextchar

achou:
    mov edx, 10
    mov ecx, msg_enc
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp quit

quit:
    mov ebx, 0
    mov eax, 1
    int 80h
