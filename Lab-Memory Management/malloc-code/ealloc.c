#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/mman.h>
#include "ealloc.h"

const int INF = 1e9;

struct mem_info{
    char* start_addr;
    int length;
    int alloc_or_not;
};

struct page_info{
    char* page_start;
    int bit_stat[PAGESIZE];
    struct mem_info table[PAGESIZE/MINALLOC];
};

struct page_info page_table[4];

void init_alloc()
{
    for(int i=0; i<4; ++i)
    {
        page_table[i].page_start = NULL;
        for(int j=0; j<PAGESIZE; ++j)
            page_table[i].bit_stat[j] = 0;
        for(int k=0; k<PAGESIZE/MINALLOC; ++k)
        {
            page_table[i].table[k].start_addr = NULL;
            page_table[i].table[k].length = 0;
            page_table[i].table[k].alloc_or_not = 0;
        }
    }
}

void cleanup()
{
    for(int i=0; i<4; ++i)
    {
        if(page_table[i].page_start != NULL)
            munmap(page_table[i].page_start, PAGESIZE);
        for(int j=0; j<PAGESIZE; ++j)
            page_table[i].bit_stat[j] = 0;
        for(int k=0; k<PAGESIZE/MINALLOC; ++k)
        {
            page_table[i].table[k].start_addr = NULL;
            page_table[i].table[k].length = 0;
            page_table[i].table[k].alloc_or_not = 0;
        }
    }
}

char* alloc(int size)
{
    if(size%MINALLOC != 0)
        return NULL;
    int page_allocated_index = -1;
    int best_fit_offset = 0;
    int best_fit_chunk_size = INF;
    int free_chunk_size = 0;
    for(int i=0; i<4; ++i)
    {
        if(page_table[i].page_start == NULL)
        {
            if(page_allocated_index == -1)
            {
                page_table[i].page_start = mmap(0, PAGESIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
                if(page_table[i].page_start == MAP_FAILED)
                    return NULL;
            }
            else
                continue;
        }
        int start = 0, end = 0, flag = 0;
        for(int j=0; j<PAGESIZE; ++j)
        {
            if(page_table[i].bit_stat[j] == 1)
                continue;
            start = j; end = PAGESIZE-1;
            for(int k=j; k<PAGESIZE; ++k)
            {
                if(page_table[i].bit_stat[k] == 1)
                {
                    end = k-1;
                    break;
                }
            }
            free_chunk_size = end-start+1;
            if(free_chunk_size >= size && free_chunk_size < best_fit_chunk_size)
            {
                page_allocated_index = i;
                best_fit_offset = start;
                best_fit_chunk_size = free_chunk_size;
            }
        }
    }
    if(page_allocated_index == -1)
        return NULL;
    for(int bit=best_fit_offset; bit < best_fit_offset+size; ++bit)
    {
        page_table[page_allocated_index].bit_stat[bit] = 1;
    }
    char* start_addr = (char*)(page_table[page_allocated_index].page_start + best_fit_offset);
    for(int i=0; i<PAGESIZE/MINALLOC; ++i)
    {
        if(page_table[page_allocated_index].table[i].alloc_or_not == 0)
        {
            page_table[page_allocated_index].table[i].start_addr = start_addr;
            page_table[page_allocated_index].table[i].length = size;
            page_table[page_allocated_index].table[i].alloc_or_not = 1;
            break;
        }
    }
    return start_addr;
}

void dealloc(char* addr)
{
    for(int i=0; i<4; ++i)
    {
        for(int j=0; j<PAGESIZE/MINALLOC; ++j)
        {
            if(page_table[i].table[j].start_addr == addr)
            {
                int offset = addr - page_table[i].page_start;
                for(int bit=offset; bit<offset+page_table[i].table[j].length; ++bit)
                    page_table[i].bit_stat[bit] = 0;
                page_table[i].table[j].start_addr = NULL;
                page_table[i].table[j].length = 0;
                page_table[i].table[j].alloc_or_not = 0;
                return;
            }
        }
    }
}