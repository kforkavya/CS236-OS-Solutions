#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/mman.h>
#include<string.h>

int main()
{
    void* ptr;
    ptr = mmap(NULL, 10000000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 100, 0);
    sleep(1000);
}