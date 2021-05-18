%include 'functions.s'
SECTION .data
    _help db "--help"
    help_str db "Achei help"

SECTION .text
global  _start

_start:
    pop ecx             ; first value on the stack is the number of arguments
    pop eax
    dec ecx
    lea esi, [_help]
    jmp nextArg

loop:
  	mov al, [rsi + rdx]
  	mov bl, [rdi + rdx]
  	inc rdx
  	cmp al, bl      ; compare two current characters
  	jne nextArg   ; not equal
  	cmp al, 0       ; at end?
  	je help_encountered        ; end of both strings
  	jmp loop        ; equal so far

nextArg:

    cmp   ecx, 0h         ; check to see if we have any arguments left
    jz    noMoreArgs      ; if zero flag is set jump to noMoreArgs label (jumping over the end of the loop)
    pop   eax             ; pop the next argument off the stack
    mov   rsi, _help
    mov   rdi, eax
    call loop
    call  sprintLF        ; call our print with linefeed function
    dec   ecx             ; decrease ecx (number of arguments left) by 1
    jne   nextArg         ; jump to nextArg label


help_encountered:
    mov eax, help_str
    call sprintLF
    call quit

noMoreArgs:
    call    quit
