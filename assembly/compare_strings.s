%include 'functions.s'

SECTION .data
  msg1 db 'ABCD', 0Ah
  msg2 db 'ABCD', 0Ah
  msg3 db 'DCBA', 0Ah
  dif  db 'DIFERENTE', 0Ah

SECTION .text
global  _start

_start:
    mov esi, [msg1]
    mov edi, [msg3]
    jmp compString

compString:
    mov ecx, 5
    rep cmpsb
    je  end
    jne diferente

diferente:
    mov edx, 10
    mov ecx, dif
    mov ebx, 1
    mov eax, 4
    int 80h

    jmp end

nextChar:
    inc eax
    inc ebx
    cmp [eax], byte 0
    je end
    cmp [ebx], byte 0
    je end
    jmp compString

end:
    mov ebx, 0
    mov eax, 1
    int 80h
