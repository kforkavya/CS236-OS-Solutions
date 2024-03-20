// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"

void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
  int refcount_list[PHYSTOP/PGSIZE];
} kmem;


// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
    kfree(p);
}
//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  struct run *r;

  // check for invalid addresses
  // end is the first address after kernel loaded from ELF file
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  if(kmem.use_lock) // can we use the lock?
    acquire(&kmem.lock);
  
  if(kmem.refcount_list[(V2P(v))/PGSIZE] < 0)
  {
    if(kmem.use_lock)
      release(&kmem.lock);
    panic("kfree: WTF");
  }
  if(kmem.refcount_list[(V2P(v))/PGSIZE] > 0)
    kmem.refcount_list[(V2P(v))/PGSIZE]--;
  if(kmem.refcount_list[(V2P(v))/PGSIZE] == 0)
  {
    // Fill with junk to catch dangling refs. - LOL.
    memset(v, 1, PGSIZE);
    // insert v into the free list
    r = (struct run*)v;
    r->next = kmem.freelist;
    kmem.freelist = r;
    // nice work.
  }

  if(kmem.use_lock)
    release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);

  // pop from the front of the free list
  r = kmem.freelist;
  if(r)
  {
    if(kmem.refcount_list[V2P((char*)r)/PGSIZE] != 0)
    {
      if(kmem.use_lock)
        release(&kmem.lock);
      panic("kalloc: refcount of a free page is not 0");
    }
    kmem.refcount_list[V2P((char*)r)/PGSIZE] = 1;
    kmem.freelist = r->next;
  }

  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

int get_count_of_free_pages_right_now(void)
{
  struct run *r;
  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  int count = 0;
  while(r)
  {
    r = r->next;
    count++;
  }
  if(kmem.use_lock)
    release(&kmem.lock);
  // cprintf("count = %d\n", count);
  return count;
}

void increase_refcount(uint pa)
{
  if(kmem.use_lock)
    acquire(&kmem.lock);
  kmem.refcount_list[pa/PGSIZE]++;
  if(kmem.use_lock)
    release(&kmem.lock);
}

int get_refcount(uint pa)
{
  int ret = 0;
  if(kmem.use_lock)
    acquire(&kmem.lock);
  ret = kmem.refcount_list[pa/PGSIZE];
  if(kmem.use_lock)
    release(&kmem.lock);
  return ret;
}

void decrease_refcount(uint pa)
{
  if(kmem.use_lock)
    acquire(&kmem.lock);
  kmem.refcount_list[pa/PGSIZE]--;
  if(kmem.use_lock)
    release(&kmem.lock);
}