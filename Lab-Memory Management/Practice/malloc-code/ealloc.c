#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include "ealloc.h"
#define NUMPAGES 4
#define NUMALLOC PAGESIZE/MINALLOC

struct mem_alloc{
    char* start;
    int size;
    int alloc_or_not;
};

struct page_info{
    char* page_start;
    int bits[PAGESIZE];
    struct mem_alloc alloc_table[NUMALLOC];
};

struct page_info pages[NUMPAGES];

void init_alloc(void)
{
    for(int i=0; i<NUMPAGES; ++i)
    {
        pages[i].page_start = NULL;
        for(int j=0; j<PAGESIZE; ++j)
            pages[i].bits[j] = 0;
        for(int k=0; k<NUMALLOC; ++k)
        {
            pages[i].alloc_table[k].start = NULL;
            pages[i].alloc_table[k].size = 0;
            pages[i].alloc_table[k].alloc_or_not = 0;
        }
    }
}

char* alloc(int n)
{
    if(n<0 || n%MINALLOC > 0)
        return NULL;
    int page_allocated = -1;
    int best_fit_size = PAGESIZE+1;
    int offset = 0;
    int start = 0, end = 0, curr_size = 0;
    for(int i=0; i<NUMPAGES; ++i)
    {
        if(pages[i].page_start == NULL)
        {
            if(page_allocated == -1)
                pages[i].page_start = (char*)mmap(0, PAGESIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
            else
                continue;
        }
        for(int j=0; j<PAGESIZE; ++j)
        {
            if(pages[i].bits[j] == 1)
                continue;
            start = j; end = PAGESIZE-1;
            for(int k=j; k<PAGESIZE; ++k)
            {
                if(pages[i].bits[k] == 1)
                {
                    end = k-1;
                    break;
                }
            }
            curr_size = end-start+1;
            if(curr_size>=n && curr_size<best_fit_size)
            {
                page_allocated = i;
                offset = start;
                best_fit_size = curr_size;
            }
            j = end;
        }
    }
    if(page_allocated == -1)
        return NULL;
    char* start_addr = (char*)(pages[page_allocated].page_start + offset);
    for(int bit=offset; bit<offset+n; ++bit)
        pages[page_allocated].bits[bit] = 1;
    for(int i=0; i<NUMALLOC; ++i)
    {
        if(pages[page_allocated].alloc_table[i].alloc_or_not == 0)
        {
            pages[page_allocated].alloc_table[i].alloc_or_not = 1;
            pages[page_allocated].alloc_table[i].size = n;
            pages[page_allocated].alloc_table[i].start = start_addr;
            break;
        }
    }
    return start_addr;
}

void dealloc(char* addr)
{
    for(int i=0; i<NUMPAGES; ++i)
    {
        for(int j=0; j<NUMALLOC; ++j)
        {
            if(pages[i].alloc_table[j].start == addr)
            {
                int offset = (int)(addr - pages[i].page_start);
                for(int bit=offset; bit<offset+pages[i].alloc_table[j].size; ++bit)
                    pages[i].bits[bit] = 0;
                pages[i].alloc_table[j].start = NULL;
                pages[i].alloc_table[j].size = 0;
                pages[i].alloc_table[j].alloc_or_not = 0;
                return;
            }
        }
    }
}

void cleanup(void)
{
    for(int i=0; i<NUMPAGES; ++i)
    {
        if(pages[i].page_start != NULL)
        {
            munmap((void*)pages[i].page_start, PAGESIZE);
            pages[i].page_start = NULL;
        }
        for(int j=0; j<PAGESIZE; ++j)
            pages[i].bits[j] = 0;
        for(int k=0; k<NUMALLOC; ++k)
        {
            pages[i].alloc_table[k].start = NULL;
            pages[i].alloc_table[k].size = 0;
            pages[i].alloc_table[k].alloc_or_not = 0;
        }
    }
}