#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/mman.h>
#include<string.h>

int main()
{
    void* ptr;
    sleep(15);
    ptr = mmap(NULL, 10000000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 100, 0);
    sleep(15);
    for(int i=0; i<10000000; i+=4096)
        strcpy((char*)(ptr+i), "Hello");
    sleep(1000);
}