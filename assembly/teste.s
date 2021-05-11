SECTION .data
  msg db 'ABCD', 0Ah

SECTION .text
  global _start

_start:
#  mov ch, byte[msg+2]
  mov edx, 13
  mov ecx, msg
  mov ebx, 1
  mov eax, 4
  int 80h

  mov ebx, 0
  mov eax, 1
  int 80h
