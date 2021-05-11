.data
buffer BYTE 21 DUP(0)          ; input buffer
byteCount DWORD ?              ; holds counter
.code
mov   edx,OFFSET buffer         ; point to the buffer
mov   ecx,SIZEOF buffer         ; specify max characters
call  ReadString                ; input the string
mov   byteCount,eax             ; number of characters
