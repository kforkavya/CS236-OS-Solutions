#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/mman.h>
#include "alloc.h"

char* page_start;
int bit_stat[PAGESIZE];

struct mem_info{
    char* start_addr;
    int length;
    int alloc_or_not;
};

struct mem_info table[PAGESIZE/MINALLOC];

int init_alloc()
{
    page_start = (char*)mmap(NULL, PAGESIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 1, 0);
    if((void*)page_start == MAP_FAILED)
        return -1;
    for(int i=0; i<PAGESIZE; ++i)
        bit_stat[i] = 0;
    for(int i=0; i<PAGESIZE/MINALLOC; ++i)
    {
        table[i].start_addr = 0;
        table[i].length = 0;
        table[i].alloc_or_not = 0;
    }
    return 0;
}

int cleanup()
{
    for(int i=0; i<PAGESIZE; ++i)
        bit_stat[i] = 0;
    for(int i=0; i<PAGESIZE/MINALLOC; ++i)
    {
        table[i].start_addr = 0;
        table[i].length = 0;
        table[i].alloc_or_not = 0;
    }
    // printf("During cleanup()\n");
    int ret = munmap(page_start, PAGESIZE);
    // printf("return value of munmap = %d\n", ret);
    return ret;
}

char* alloc(int size)
{
    if(size%MINALLOC!=0)
        return NULL;
    for(int i=0; i<PAGESIZE; ++i)
    {
        if(bit_stat[i] == 0)
        {
            int end = PAGESIZE-1;
            for(int j=i+1; j<PAGESIZE; ++j)
            {
                if(bit_stat[j] == 1)
                {
                    end = j-1;
                    break;
                }
            }
            if(end - i + 1 >= size)
            {
                for(int k=0; k<PAGESIZE/MINALLOC; ++k)
                {
                    if(table[k].alloc_or_not == 0)
                    {
                        table[k].alloc_or_not = 1;
                        table[k].start_addr = (char*)(page_start+i);
                        table[k].length = size;
                        for(int bit = i; bit<i+size; bit++)
                            bit_stat[bit] = 1;
                        return table[k].start_addr;
                    }
                }
            }
            i=end;
        }
    }
    return NULL;
}

void dealloc(char* addr)
{
    for(int i=0; i<PAGESIZE/MINALLOC; ++i)
    {
        if(table[i].start_addr == addr)
        {
            for(int bit = addr-page_start; bit < addr-page_start+table[i].length; bit++)
                bit_stat[bit] = 0;
            table[i].start_addr = 0;
            table[i].length = 0;
            table[i].alloc_or_not = 0;
            break;
        }
    }
}