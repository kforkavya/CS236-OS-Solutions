
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 e4 14 80       	mov    $0x8014e4d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 a0 33 10 80       	mov    $0x801033a0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache; // notice how this is a linked list implementation via arrays, thus we get performance of linked lists and caching boosts of arrays. Quite nice.

void
binit(void) // initialize the buffer cache
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache"); // initialie bcache lock
80100041:	ba e0 77 10 80       	mov    $0x801077e0,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	83 ec 18             	sub    $0x18,%esp
8010004b:	89 5d fc             	mov    %ebx,-0x4(%ebp)

//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head; // self loops (empty cache)
8010004e:	bb 1c fc 10 80       	mov    $0x8010fc1c,%ebx
  initlock(&bcache.lock, "bcache"); // initialie bcache lock
80100053:	89 54 24 04          	mov    %edx,0x4(%esp)
80100057:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010005e:	e8 ed 46 00 00       	call   80104750 <initlock>
  bcache.head.prev = &bcache.head;
80100063:	b9 1c fc 10 80       	mov    $0x8010fc1c,%ecx
  bcache.head.next = &bcache.head; // self loops (empty cache)
80100068:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
8010006d:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70

  // put all buffers on free list. Notice the dll is circular and implemented in reverse (head.next is most recently used)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100073:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
  bcache.head.prev = &bcache.head;
80100078:	89 0d 6c fc 10 80    	mov    %ecx,0x8010fc6c
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007e:	eb 02                	jmp    80100082 <binit+0x42>
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	b8 e7 77 10 80       	mov    $0x801077e7,%eax
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 70 45 00 00       	call   80104610 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a5:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000ab:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
    bcache.head.next->prev = b;
801000b1:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000b4:	89 d8                	mov    %ebx,%eax
801000b6:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	89 ec                	mov    %ebp,%esp
801000c3:	5d                   	pop    %ebp
801000c4:	c3                   	ret    
801000c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock); // bcache shared
801000df:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801000e6:	e8 55 48 00 00       	call   80104940 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000f1:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000ff:	90                   	nop
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++; // ah, simply implement refcnt. It's the same block in memory, after all.
80100115:	ff 43 4c             	incl   0x4c(%ebx)
      release(&bcache.lock);
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 62                	jmp    80100192 <bread+0xc2>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 57                	je     80100192 <bread+0xc2>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) { // eviction from cache!
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0; // not valid or dirty
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100161:	e8 6a 47 00 00       	call   801048d0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 df 44 00 00       	call   80104650 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno); // b is a locked buffer
  // read from disk into buffer if b was just allocated
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	74 0a                	je     80100180 <bread+0xb0>
    iderw(b); /* note that this only enqueues b to be written; the write to disk may actually be later */
  }
  return b; // still locked - no other process can use it
}
80100176:	83 c4 1c             	add    $0x1c,%esp
80100179:	89 d8                	mov    %ebx,%eax
8010017b:	5b                   	pop    %ebx
8010017c:	5e                   	pop    %esi
8010017d:	5f                   	pop    %edi
8010017e:	5d                   	pop    %ebp
8010017f:	c3                   	ret    
    iderw(b); /* note that this only enqueues b to be written; the write to disk may actually be later */
80100180:	89 1c 24             	mov    %ebx,(%esp)
80100183:	e8 b8 22 00 00       	call   80102440 <iderw>
}
80100188:	83 c4 1c             	add    $0x1c,%esp
8010018b:	89 d8                	mov    %ebx,%eax
8010018d:	5b                   	pop    %ebx
8010018e:	5e                   	pop    %esi
8010018f:	5f                   	pop    %edi
80100190:	5d                   	pop    %ebp
80100191:	c3                   	ret    
  panic("bget: no buffers");
80100192:	c7 04 24 ee 77 10 80 	movl   $0x801077ee,(%esp)
80100199:	e8 b2 01 00 00       	call   80100350 <panic>
8010019e:	66 90                	xchg   %ax,%ax

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	83 ec 18             	sub    $0x18,%esp
801001a6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801001a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ac:	8d 43 0c             	lea    0xc(%ebx),%eax
801001af:	89 04 24             	mov    %eax,(%esp)
801001b2:	e8 39 45 00 00       	call   801046f0 <holdingsleep>
801001b7:	85 c0                	test   %eax,%eax
801001b9:	74 11                	je     801001cc <bwrite+0x2c>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001bb:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001be:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c4:	89 ec                	mov    %ebp,%esp
801001c6:	5d                   	pop    %ebp
  iderw(b);
801001c7:	e9 74 22 00 00       	jmp    80102440 <iderw>
    panic("bwrite");
801001cc:	c7 04 24 ff 77 10 80 	movl   $0x801077ff,(%esp)
801001d3:	e8 78 01 00 00       	call   80100350 <panic>
801001d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001df:	90                   	nop

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 fa 44 00 00       	call   801046f0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 57                	je     80100251 <brelse+0x71>
    panic("brelse");

  // release lock
  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ae 44 00 00       	call   801046b0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100209:	e8 32 47 00 00       	call   80104940 <acquire>
  b->refcnt--;
8010020e:	ff 4b 4c             	decl   0x4c(%ebx)
  if (b->refcnt == 0) {
80100211:	75 2c                	jne    8010023f <brelse+0x5f>
    // no one is waiting for it. Move it to the end of the array (the first to be allocated next time)
    b->next->prev = b->prev;
80100213:	8b 53 54             	mov    0x54(%ebx),%edx
80100216:	8b 43 50             	mov    0x50(%ebx),%eax
80100219:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
8010021c:	8b 53 54             	mov    0x54(%ebx),%edx
8010021f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100222:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100227:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010022e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100231:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100236:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100239:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010023f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100246:	83 c4 10             	add    $0x10,%esp
80100249:	5b                   	pop    %ebx
8010024a:	5e                   	pop    %esi
8010024b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024c:	e9 7f 46 00 00       	jmp    801048d0 <release>
    panic("brelse");
80100251:	c7 04 24 06 78 10 80 	movl   $0x80107806,(%esp)
80100258:	e8 f3 00 00 00       	call   80100350 <panic>
8010025d:	66 90                	xchg   %ax,%ax
8010025f:	90                   	nop

80100260 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 2c             	sub    $0x2c,%esp
80100269:	8b 7d 08             	mov    0x8(%ebp),%edi
8010026c:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010026f:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
80100272:	89 3c 24             	mov    %edi,(%esp)
80100275:	e8 d6 16 00 00       	call   80101950 <iunlock>
  target = n;
8010027a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
8010027d:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80100284:	e8 b7 46 00 00       	call   80104940 <acquire>
  while(n > 0){
80100289:	85 db                	test   %ebx,%ebx
8010028b:	0f 8e 86 00 00 00    	jle    80100317 <consoleread+0xb7>
    while(input.r == input.w){
80100291:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100296:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010029c:	74 24                	je     801002c2 <consoleread+0x62>
8010029e:	eb 50                	jmp    801002f0 <consoleread+0x90>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a0:	c7 04 24 00 ff 10 80 	movl   $0x8010ff00,(%esp)
801002a7:	b8 20 ff 10 80       	mov    $0x8010ff20,%eax
801002ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b0:	e8 cb 40 00 00       	call   80104380 <sleep>
    while(input.r == input.w){
801002b5:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002ba:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002c0:	75 2e                	jne    801002f0 <consoleread+0x90>
      if(myproc()->killed){
801002c2:	e8 f9 39 00 00       	call   80103cc0 <myproc>
801002c7:	8b 50 24             	mov    0x24(%eax),%edx
801002ca:	85 d2                	test   %edx,%edx
801002cc:	74 d2                	je     801002a0 <consoleread+0x40>
        release(&cons.lock);
801002ce:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002d5:	e8 f6 45 00 00       	call   801048d0 <release>
        ilock(ip);
801002da:	89 3c 24             	mov    %edi,(%esp)
801002dd:	e8 8e 15 00 00       	call   80101870 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002e2:	83 c4 2c             	add    $0x2c,%esp
        return -1;
801002e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002ea:	5b                   	pop    %ebx
801002eb:	5e                   	pop    %esi
801002ec:	5f                   	pop    %edi
801002ed:	5d                   	pop    %ebp
801002ee:	c3                   	ret    
801002ef:	90                   	nop
    c = input.buf[input.r++ % INPUT_BUF];
801002f0:	8d 50 01             	lea    0x1(%eax),%edx
801002f3:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
801002f9:	89 c2                	mov    %eax,%edx
801002fb:	83 e2 7f             	and    $0x7f,%edx
801002fe:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
80100305:	80 f9 04             	cmp    $0x4,%cl
80100308:	74 2e                	je     80100338 <consoleread+0xd8>
    *dst++ = c;
8010030a:	88 0e                	mov    %cl,(%esi)
8010030c:	46                   	inc    %esi
    --n;
8010030d:	4b                   	dec    %ebx
    if(c == '\n')
8010030e:	83 f9 0a             	cmp    $0xa,%ecx
80100311:	0f 85 72 ff ff ff    	jne    80100289 <consoleread+0x29>
  release(&cons.lock);
80100317:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010031e:	e8 ad 45 00 00       	call   801048d0 <release>
  ilock(ip);
80100323:	89 3c 24             	mov    %edi,(%esp)
80100326:	e8 45 15 00 00       	call   80101870 <ilock>
  return target - n;
8010032b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010032e:	83 c4 2c             	add    $0x2c,%esp
  return target - n;
80100331:	29 d8                	sub    %ebx,%eax
}
80100333:	5b                   	pop    %ebx
80100334:	5e                   	pop    %esi
80100335:	5f                   	pop    %edi
80100336:	5d                   	pop    %ebp
80100337:	c3                   	ret    
      if(n < target){
80100338:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010033b:	39 cb                	cmp    %ecx,%ebx
8010033d:	73 d8                	jae    80100317 <consoleread+0xb7>
        input.r--;
8010033f:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100344:	eb d1                	jmp    80100317 <consoleread+0xb7>
80100346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010034d:	8d 76 00             	lea    0x0(%esi),%esi

80100350 <panic>:
{
80100350:	55                   	push   %ebp
80100351:	89 e5                	mov    %esp,%ebp
80100353:	56                   	push   %esi
80100354:	53                   	push   %ebx
80100355:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100358:	fa                   	cli    
  getcallerpcs(&s, pcs);
80100359:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cons.locking = 0;
8010035c:	31 d2                	xor    %edx,%edx
8010035e:	89 15 54 ff 10 80    	mov    %edx,0x8010ff54
  cprintf("lapicid %d: panic: ", lapicid());
80100364:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100367:	e8 24 29 00 00       	call   80102c90 <lapicid>
8010036c:	c7 04 24 0d 78 10 80 	movl   $0x8010780d,(%esp)
80100373:	89 44 24 04          	mov    %eax,0x4(%esp)
80100377:	e8 04 03 00 00       	call   80100680 <cprintf>
  cprintf(s);
8010037c:	8b 45 08             	mov    0x8(%ebp),%eax
8010037f:	89 04 24             	mov    %eax,(%esp)
80100382:	e8 f9 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
80100387:	c7 04 24 6b 82 10 80 	movl   $0x8010826b,(%esp)
8010038e:	e8 ed 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
80100393:	8d 45 08             	lea    0x8(%ebp),%eax
80100396:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010039a:	89 04 24             	mov    %eax,(%esp)
8010039d:	e8 ce 43 00 00       	call   80104770 <getcallerpcs>
  for(i=0; i<10; i++)
801003a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b0:	8b 03                	mov    (%ebx),%eax
  for(i=0; i<10; i++)
801003b2:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003b5:	c7 04 24 21 78 10 80 	movl   $0x80107821,(%esp)
801003bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c0:	e8 bb 02 00 00       	call   80100680 <cprintf>
  for(i=0; i<10; i++)
801003c5:	39 f3                	cmp    %esi,%ebx
801003c7:	75 e7                	jne    801003b0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003c9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ce:	a3 58 ff 10 80       	mov    %eax,0x8010ff58
  for(;;)
801003d3:	eb fe                	jmp    801003d3 <panic+0x83>
801003d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801003e0 <consputc.part.0>:
consputc(int c)
801003e0:	55                   	push   %ebp
801003e1:	89 e5                	mov    %esp,%ebp
801003e3:	57                   	push   %edi
801003e4:	56                   	push   %esi
801003e5:	53                   	push   %ebx
801003e6:	83 ec 2c             	sub    $0x2c,%esp
  if(c == BACKSPACE){
801003e9:	3d 00 01 00 00       	cmp    $0x100,%eax
801003ee:	0f 84 bc 00 00 00    	je     801004b0 <consputc.part.0+0xd0>
    uartputc(c);
801003f4:	89 04 24             	mov    %eax,(%esp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003f7:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003fc:	89 c3                	mov    %eax,%ebx
801003fe:	e8 3d 5d 00 00       	call   80106140 <uartputc>
80100403:	b0 0e                	mov    $0xe,%al
80100405:	89 fa                	mov    %edi,%edx
80100407:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100408:	be d5 03 00 00       	mov    $0x3d5,%esi
8010040d:	89 f2                	mov    %esi,%edx
8010040f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100410:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	89 fa                	mov    %edi,%edx
80100415:	c1 e1 08             	shl    $0x8,%ecx
80100418:	b0 0f                	mov    $0xf,%al
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	89 f2                	mov    %esi,%edx
8010041d:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010041e:	0f b6 c0             	movzbl %al,%eax
80100421:	09 c8                	or     %ecx,%eax
  if(c == '\n')
80100423:	83 fb 0a             	cmp    $0xa,%ebx
80100426:	75 68                	jne    80100490 <consputc.part.0+0xb0>
    pos += 80 - pos%80;
80100428:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010042d:	f7 e2                	mul    %edx
8010042f:	c1 ea 06             	shr    $0x6,%edx
80100432:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100435:	c1 e0 04             	shl    $0x4,%eax
80100438:	8d 50 50             	lea    0x50(%eax),%edx
  if(pos < 0 || pos > 25*80)
8010043b:	81 fa d0 07 00 00    	cmp    $0x7d0,%edx
80100441:	0f 8f 29 01 00 00    	jg     80100570 <consputc.part.0+0x190>
  if((pos/80) >= 24){  // Scroll up.
80100447:	81 fa 7f 07 00 00    	cmp    $0x77f,%edx
8010044d:	0f 8f b5 00 00 00    	jg     80100508 <consputc.part.0+0x128>
  outb(CRTPORT+1, pos);
80100453:	88 55 e4             	mov    %dl,-0x1c(%ebp)
  crt[pos] = ' ' | 0x0700;
80100456:	8d bc 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%edi
  outb(CRTPORT+1, pos>>8);
8010045d:	0f b6 ce             	movzbl %dh,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100460:	be d4 03 00 00       	mov    $0x3d4,%esi
80100465:	b0 0e                	mov    $0xe,%al
80100467:	89 f2                	mov    %esi,%edx
80100469:	ee                   	out    %al,(%dx)
8010046a:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010046f:	88 c8                	mov    %cl,%al
80100471:	89 da                	mov    %ebx,%edx
80100473:	ee                   	out    %al,(%dx)
80100474:	b0 0f                	mov    $0xf,%al
80100476:	89 f2                	mov    %esi,%edx
80100478:	ee                   	out    %al,(%dx)
80100479:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
8010047d:	89 da                	mov    %ebx,%edx
8010047f:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100480:	66 c7 07 20 07       	movw   $0x720,(%edi)
}
80100485:	83 c4 2c             	add    $0x2c,%esp
80100488:	5b                   	pop    %ebx
80100489:	5e                   	pop    %esi
8010048a:	5f                   	pop    %edi
8010048b:	5d                   	pop    %ebp
8010048c:	c3                   	ret    
8010048d:	8d 76 00             	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100490:	8d 50 01             	lea    0x1(%eax),%edx
80100493:	0f b6 db             	movzbl %bl,%ebx
80100496:	81 cb 00 07 00 00    	or     $0x700,%ebx
8010049c:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004a3:	80 
801004a4:	eb 95                	jmp    8010043b <consputc.part.0+0x5b>
801004a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004ad:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b7:	be d4 03 00 00       	mov    $0x3d4,%esi
801004bc:	e8 7f 5c 00 00       	call   80106140 <uartputc>
801004c1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c8:	e8 73 5c 00 00       	call   80106140 <uartputc>
801004cd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d4:	e8 67 5c 00 00       	call   80106140 <uartputc>
801004d9:	b0 0e                	mov    $0xe,%al
801004db:	89 f2                	mov    %esi,%edx
801004dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004de:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801004e3:	89 da                	mov    %ebx,%edx
801004e5:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801004e6:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004e9:	89 f2                	mov    %esi,%edx
801004eb:	c1 e1 08             	shl    $0x8,%ecx
801004ee:	b0 0f                	mov    $0xf,%al
801004f0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004f1:	89 da                	mov    %ebx,%edx
801004f3:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801004f4:	0f b6 d0             	movzbl %al,%edx
    if(pos > 0) --pos;
801004f7:	09 ca                	or     %ecx,%edx
801004f9:	74 65                	je     80100560 <consputc.part.0+0x180>
801004fb:	4a                   	dec    %edx
801004fc:	e9 3a ff ff ff       	jmp    8010043b <consputc.part.0+0x5b>
80100501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100508:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010050b:	b8 60 0e 00 00       	mov    $0xe60,%eax
80100510:	ba a0 80 0b 80       	mov    $0x800b80a0,%edx
80100515:	89 54 24 04          	mov    %edx,0x4(%esp)
80100519:	89 44 24 08          	mov    %eax,0x8(%esp)
8010051d:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100524:	e8 87 45 00 00       	call   80104ab0 <memmove>
    pos -= 80;
80100529:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010052c:	b8 80 07 00 00       	mov    $0x780,%eax
80100531:	31 c9                	xor    %ecx,%ecx
80100533:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    pos -= 80;
80100537:	8d 5a b0             	lea    -0x50(%edx),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010053a:	8d bc 12 60 7f 0b 80 	lea    -0x7ff480a0(%edx,%edx,1),%edi
80100541:	29 d8                	sub    %ebx,%eax
80100543:	89 3c 24             	mov    %edi,(%esp)
80100546:	01 c0                	add    %eax,%eax
80100548:	89 44 24 08          	mov    %eax,0x8(%esp)
8010054c:	e8 cf 44 00 00       	call   80104a20 <memset>
  outb(CRTPORT+1, pos);
80100551:	b1 07                	mov    $0x7,%cl
80100553:	88 5d e4             	mov    %bl,-0x1c(%ebp)
80100556:	e9 05 ff ff ff       	jmp    80100460 <consputc.part.0+0x80>
8010055b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010055f:	90                   	nop
80100560:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
80100564:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
80100569:	31 c9                	xor    %ecx,%ecx
8010056b:	e9 f0 fe ff ff       	jmp    80100460 <consputc.part.0+0x80>
    panic("pos under/overflow");
80100570:	c7 04 24 25 78 10 80 	movl   $0x80107825,(%esp)
80100577:	e8 d4 fd ff ff       	call   80100350 <panic>
8010057c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100580 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
80100589:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010058c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
8010058f:	89 04 24             	mov    %eax,(%esp)
80100592:	e8 b9 13 00 00       	call   80101950 <iunlock>
  acquire(&cons.lock);
80100597:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010059e:	e8 9d 43 00 00       	call   80104940 <acquire>
  for(i = 0; i < n; i++)
801005a3:	85 db                	test   %ebx,%ebx
801005a5:	7e 23                	jle    801005ca <consolewrite+0x4a>
801005a7:	8b 75 0c             	mov    0xc(%ebp),%esi
801005aa:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
  if(panicked){
801005ad:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005b3:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
801005b6:	85 d2                	test   %edx,%edx
801005b8:	74 06                	je     801005c0 <consolewrite+0x40>
  asm volatile("cli");
801005ba:	fa                   	cli    
    for(;;)
801005bb:	eb fe                	jmp    801005bb <consolewrite+0x3b>
801005bd:	8d 76 00             	lea    0x0(%esi),%esi
801005c0:	e8 1b fe ff ff       	call   801003e0 <consputc.part.0>
  for(i = 0; i < n; i++)
801005c5:	46                   	inc    %esi
801005c6:	39 f7                	cmp    %esi,%edi
801005c8:	75 e3                	jne    801005ad <consolewrite+0x2d>
  release(&cons.lock);
801005ca:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005d1:	e8 fa 42 00 00       	call   801048d0 <release>
  ilock(ip);
801005d6:	8b 45 08             	mov    0x8(%ebp),%eax
801005d9:	89 04 24             	mov    %eax,(%esp)
801005dc:	e8 8f 12 00 00       	call   80101870 <ilock>

  return n;
}
801005e1:	83 c4 1c             	add    $0x1c,%esp
801005e4:	89 d8                	mov    %ebx,%eax
801005e6:	5b                   	pop    %ebx
801005e7:	5e                   	pop    %esi
801005e8:	5f                   	pop    %edi
801005e9:	5d                   	pop    %ebp
801005ea:	c3                   	ret    
801005eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801005ef:	90                   	nop

801005f0 <printint>:
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	89 c6                	mov    %eax,%esi
801005f7:	53                   	push   %ebx
801005f8:	89 d3                	mov    %edx,%ebx
801005fa:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801005fd:	85 c9                	test   %ecx,%ecx
801005ff:	74 04                	je     80100605 <printint+0x15>
80100601:	85 c0                	test   %eax,%eax
80100603:	78 6b                	js     80100670 <printint+0x80>
    x = xx;
80100605:	89 f1                	mov    %esi,%ecx
80100607:	31 c0                	xor    %eax,%eax
  i = 0;
80100609:	89 45 d0             	mov    %eax,-0x30(%ebp)
8010060c:	31 f6                	xor    %esi,%esi
8010060e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100610:	89 c8                	mov    %ecx,%eax
80100612:	31 d2                	xor    %edx,%edx
80100614:	f7 f3                	div    %ebx
80100616:	89 f7                	mov    %esi,%edi
80100618:	8d 76 01             	lea    0x1(%esi),%esi
8010061b:	0f b6 92 50 78 10 80 	movzbl -0x7fef87b0(%edx),%edx
80100622:	88 55 d7             	mov    %dl,-0x29(%ebp)
80100625:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
80100629:	89 ca                	mov    %ecx,%edx
8010062b:	89 c1                	mov    %eax,%ecx
8010062d:	39 da                	cmp    %ebx,%edx
8010062f:	73 df                	jae    80100610 <printint+0x20>
  if(sign)
80100631:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100634:	85 c0                	test   %eax,%eax
80100636:	74 07                	je     8010063f <printint+0x4f>
    buf[i++] = '-';
80100638:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
8010063d:	89 f7                	mov    %esi,%edi
8010063f:	8d 75 d8             	lea    -0x28(%ebp),%esi
80100642:	8d 5c 3d d8          	lea    -0x28(%ebp,%edi,1),%ebx
  if(panicked){
80100646:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i]);
8010064c:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
8010064f:	85 d2                	test   %edx,%edx
80100651:	74 0d                	je     80100660 <printint+0x70>
80100653:	fa                   	cli    
    for(;;)
80100654:	eb fe                	jmp    80100654 <printint+0x64>
80100656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010065d:	8d 76 00             	lea    0x0(%esi),%esi
80100660:	e8 7b fd ff ff       	call   801003e0 <consputc.part.0>
  while(--i >= 0)
80100665:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100668:	39 f3                	cmp    %esi,%ebx
8010066a:	74 0c                	je     80100678 <printint+0x88>
8010066c:	89 c3                	mov    %eax,%ebx
8010066e:	eb d6                	jmp    80100646 <printint+0x56>
    x = -xx;
80100670:	f7 de                	neg    %esi
80100672:	89 c8                	mov    %ecx,%eax
80100674:	89 f1                	mov    %esi,%ecx
80100676:	eb 91                	jmp    80100609 <printint+0x19>
}
80100678:	83 c4 2c             	add    $0x2c,%esp
8010067b:	5b                   	pop    %ebx
8010067c:	5e                   	pop    %esi
8010067d:	5f                   	pop    %edi
8010067e:	5d                   	pop    %ebp
8010067f:	c3                   	ret    

80100680 <cprintf>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100689:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
8010068f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100692:	85 ff                	test   %edi,%edi
80100694:	0f 85 36 01 00 00    	jne    801007d0 <cprintf+0x150>
  if (fmt == 0)
8010069a:	85 f6                	test   %esi,%esi
8010069c:	0f 84 f3 01 00 00    	je     80100895 <cprintf+0x215>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a2:	0f b6 06             	movzbl (%esi),%eax
801006a5:	85 c0                	test   %eax,%eax
801006a7:	74 6b                	je     80100714 <cprintf+0x94>
801006a9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
801006ac:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006af:	31 db                	xor    %ebx,%ebx
801006b1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006b3:	83 f8 25             	cmp    $0x25,%eax
801006b6:	0f 85 d4 00 00 00    	jne    80100790 <cprintf+0x110>
    c = fmt[++i] & 0xff;
801006bc:	43                   	inc    %ebx
801006bd:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006c1:	85 c9                	test   %ecx,%ecx
801006c3:	74 44                	je     80100709 <cprintf+0x89>
    switch(c){
801006c5:	83 f9 70             	cmp    $0x70,%ecx
801006c8:	0f 84 93 00 00 00    	je     80100761 <cprintf+0xe1>
801006ce:	7f 50                	jg     80100720 <cprintf+0xa0>
801006d0:	83 f9 25             	cmp    $0x25,%ecx
801006d3:	0f 84 c7 00 00 00    	je     801007a0 <cprintf+0x120>
801006d9:	83 f9 64             	cmp    $0x64,%ecx
801006dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006e0:	0f 85 1a 01 00 00    	jne    80100800 <cprintf+0x180>
      printint(*argp++, 10, 1);
801006e6:	8d 47 04             	lea    0x4(%edi),%eax
801006e9:	b9 01 00 00 00       	mov    $0x1,%ecx
801006ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006f1:	8b 07                	mov    (%edi),%eax
801006f3:	ba 0a 00 00 00       	mov    $0xa,%edx
801006f8:	e8 f3 fe ff ff       	call   801005f0 <printint>
801006fd:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100700:	43                   	inc    %ebx
80100701:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100705:	85 c0                	test   %eax,%eax
80100707:	75 aa                	jne    801006b3 <cprintf+0x33>
80100709:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
8010070c:	85 ff                	test   %edi,%edi
8010070e:	0f 85 db 00 00 00    	jne    801007ef <cprintf+0x16f>
}
80100714:	83 c4 2c             	add    $0x2c,%esp
80100717:	5b                   	pop    %ebx
80100718:	5e                   	pop    %esi
80100719:	5f                   	pop    %edi
8010071a:	5d                   	pop    %ebp
8010071b:	c3                   	ret    
8010071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 f9 73             	cmp    $0x73,%ecx
80100723:	75 33                	jne    80100758 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100725:	8b 17                	mov    (%edi),%edx
80100727:	8d 47 04             	lea    0x4(%edi),%eax
8010072a:	85 d2                	test   %edx,%edx
8010072c:	0f 85 16 01 00 00    	jne    80100848 <cprintf+0x1c8>
        s = "(null)";
80100732:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100735:	bf 38 78 10 80       	mov    $0x80107838,%edi
8010073a:	b1 28                	mov    $0x28,%cl
8010073c:	89 fb                	mov    %edi,%ebx
8010073e:	89 f7                	mov    %esi,%edi
80100740:	89 c6                	mov    %eax,%esi
  if(panicked){
80100742:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100747:	85 c0                	test   %eax,%eax
80100749:	0f 84 11 01 00 00    	je     80100860 <cprintf+0x1e0>
8010074f:	fa                   	cli    
    for(;;)
80100750:	eb fe                	jmp    80100750 <cprintf+0xd0>
80100752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100758:	83 f9 78             	cmp    $0x78,%ecx
8010075b:	0f 85 9f 00 00 00    	jne    80100800 <cprintf+0x180>
      printint(*argp++, 16, 0);
80100761:	8d 47 04             	lea    0x4(%edi),%eax
80100764:	31 c9                	xor    %ecx,%ecx
80100766:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100769:	8b 07                	mov    (%edi),%eax
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010076b:	43                   	inc    %ebx
      printint(*argp++, 16, 0);
8010076c:	ba 10 00 00 00       	mov    $0x10,%edx
80100771:	e8 7a fe ff ff       	call   801005f0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100776:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010077a:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010077d:	85 c0                	test   %eax,%eax
8010077f:	0f 85 2e ff ff ff    	jne    801006b3 <cprintf+0x33>
80100785:	eb 82                	jmp    80100709 <cprintf+0x89>
80100787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010078e:	66 90                	xchg   %ax,%ax
  if(panicked){
80100790:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100796:	85 d2                	test   %edx,%edx
80100798:	74 19                	je     801007b3 <cprintf+0x133>
8010079a:	fa                   	cli    
    for(;;)
8010079b:	eb fe                	jmp    8010079b <cprintf+0x11b>
8010079d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a0:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007a6:	85 c9                	test   %ecx,%ecx
801007a8:	0f 85 82 00 00 00    	jne    80100830 <cprintf+0x1b0>
801007ae:	b8 25 00 00 00       	mov    $0x25,%eax
801007b3:	e8 28 fc ff ff       	call   801003e0 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b8:	43                   	inc    %ebx
801007b9:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	0f 85 ee fe ff ff    	jne    801006b3 <cprintf+0x33>
801007c5:	e9 3f ff ff ff       	jmp    80100709 <cprintf+0x89>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&cons.lock);
801007d0:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801007d7:	e8 64 41 00 00       	call   80104940 <acquire>
  if (fmt == 0)
801007dc:	85 f6                	test   %esi,%esi
801007de:	0f 84 b1 00 00 00    	je     80100895 <cprintf+0x215>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e4:	0f b6 06             	movzbl (%esi),%eax
801007e7:	85 c0                	test   %eax,%eax
801007e9:	0f 85 ba fe ff ff    	jne    801006a9 <cprintf+0x29>
    release(&cons.lock);
801007ef:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801007f6:	e8 d5 40 00 00       	call   801048d0 <release>
801007fb:	e9 14 ff ff ff       	jmp    80100714 <cprintf+0x94>
  if(panicked){
80100800:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100806:	85 d2                	test   %edx,%edx
80100808:	75 2e                	jne    80100838 <cprintf+0x1b8>
8010080a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010080d:	b8 25 00 00 00       	mov    $0x25,%eax
80100812:	e8 c9 fb ff ff       	call   801003e0 <consputc.part.0>
80100817:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010081c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010081f:	85 c0                	test   %eax,%eax
80100821:	74 5f                	je     80100882 <cprintf+0x202>
80100823:	fa                   	cli    
    for(;;)
80100824:	eb fe                	jmp    80100824 <cprintf+0x1a4>
80100826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010082d:	8d 76 00             	lea    0x0(%esi),%esi
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x1b1>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
80100838:	fa                   	cli    
80100839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100840:	eb f7                	jmp    80100839 <cprintf+0x1b9>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for(; *s; s++)
80100848:	0f b6 0a             	movzbl (%edx),%ecx
8010084b:	84 c9                	test   %cl,%cl
8010084d:	8d 76 00             	lea    0x0(%esi),%esi
80100850:	74 3c                	je     8010088e <cprintf+0x20e>
80100852:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100855:	89 f7                	mov    %esi,%edi
80100857:	89 d3                	mov    %edx,%ebx
80100859:	89 c6                	mov    %eax,%esi
8010085b:	e9 e2 fe ff ff       	jmp    80100742 <cprintf+0xc2>
        consputc(*s);
80100860:	0f be c1             	movsbl %cl,%eax
      for(; *s; s++)
80100863:	43                   	inc    %ebx
80100864:	e8 77 fb ff ff       	call   801003e0 <consputc.part.0>
80100869:	0f b6 0b             	movzbl (%ebx),%ecx
8010086c:	84 c9                	test   %cl,%cl
8010086e:	0f 85 ce fe ff ff    	jne    80100742 <cprintf+0xc2>
      if((s = (char*)*argp++) == 0)
80100874:	89 f0                	mov    %esi,%eax
80100876:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100879:	89 fe                	mov    %edi,%esi
8010087b:	89 c7                	mov    %eax,%edi
8010087d:	e9 7e fe ff ff       	jmp    80100700 <cprintf+0x80>
80100882:	89 c8                	mov    %ecx,%eax
80100884:	e8 57 fb ff ff       	call   801003e0 <consputc.part.0>
80100889:	e9 72 fe ff ff       	jmp    80100700 <cprintf+0x80>
8010088e:	89 c7                	mov    %eax,%edi
80100890:	e9 6b fe ff ff       	jmp    80100700 <cprintf+0x80>
    panic("null fmt");
80100895:	c7 04 24 3f 78 10 80 	movl   $0x8010783f,(%esp)
8010089c:	e8 af fa ff ff       	call   80100350 <panic>
801008a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008af:	90                   	nop

801008b0 <consoleintr>:
{
801008b0:	55                   	push   %ebp
801008b1:	89 e5                	mov    %esp,%ebp
801008b3:	57                   	push   %edi
801008b4:	56                   	push   %esi
  int c, doprocdump = 0;
801008b5:	31 f6                	xor    %esi,%esi
{
801008b7:	53                   	push   %ebx
801008b8:	83 ec 2c             	sub    $0x2c,%esp
801008bb:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
801008be:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801008c5:	e8 76 40 00 00       	call   80104940 <acquire>
  while((c = getc()) >= 0){
801008ca:	eb 1f                	jmp    801008eb <consoleintr+0x3b>
801008cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801008d0:	83 f8 08             	cmp    $0x8,%eax
801008d3:	0f 84 e7 00 00 00    	je     801009c0 <consoleintr+0x110>
801008d9:	83 f8 10             	cmp    $0x10,%eax
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008e0:	0f 85 35 01 00 00    	jne    80100a1b <consoleintr+0x16b>
801008e6:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008eb:	ff d7                	call   *%edi
801008ed:	85 c0                	test   %eax,%eax
801008ef:	0f 88 f3 00 00 00    	js     801009e8 <consoleintr+0x138>
    switch(c){
801008f5:	83 f8 15             	cmp    $0x15,%eax
801008f8:	0f 84 8c 00 00 00    	je     8010098a <consoleintr+0xda>
801008fe:	66 90                	xchg   %ax,%ax
80100900:	7e ce                	jle    801008d0 <consoleintr+0x20>
80100902:	83 f8 7f             	cmp    $0x7f,%eax
80100905:	0f 84 b5 00 00 00    	je     801009c0 <consoleintr+0x110>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010090b:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
80100911:	8b 0d 00 ff 10 80    	mov    0x8010ff00,%ecx
80100917:	89 da                	mov    %ebx,%edx
80100919:	29 ca                	sub    %ecx,%edx
8010091b:	83 fa 7f             	cmp    $0x7f,%edx
8010091e:	77 cb                	ja     801008eb <consoleintr+0x3b>
  if(panicked){
80100920:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100926:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100929:	83 e3 7f             	and    $0x7f,%ebx
8010092c:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
  if(panicked){
80100932:	85 d2                	test   %edx,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100934:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
  if(panicked){
8010093a:	0f 85 45 01 00 00    	jne    80100a85 <consoleintr+0x1d5>
80100940:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100943:	e8 98 fa ff ff       	call   801003e0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100948:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010094b:	83 f8 0a             	cmp    $0xa,%eax
8010094e:	0f 84 16 01 00 00    	je     80100a6a <consoleintr+0x1ba>
80100954:	83 f8 04             	cmp    $0x4,%eax
80100957:	0f 84 0d 01 00 00    	je     80100a6a <consoleintr+0x1ba>
8010095d:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100962:	83 e8 80             	sub    $0xffffff80,%eax
80100965:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
8010096b:	0f 85 7a ff ff ff    	jne    801008eb <consoleintr+0x3b>
80100971:	e9 f9 00 00 00       	jmp    80100a6f <consoleintr+0x1bf>
80100976:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097d:	8d 76 00             	lea    0x0(%esi),%esi
80100980:	b8 00 01 00 00       	mov    $0x100,%eax
80100985:	e8 56 fa ff ff       	call   801003e0 <consputc.part.0>
      while(input.e != input.w &&
8010098a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010098f:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100995:	0f 84 50 ff ff ff    	je     801008eb <consoleintr+0x3b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010099b:	48                   	dec    %eax
8010099c:	89 c2                	mov    %eax,%edx
8010099e:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801009a1:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
801009a8:	0f 84 3d ff ff ff    	je     801008eb <consoleintr+0x3b>
        input.e--;
801009ae:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801009b3:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801009b8:	85 c0                	test   %eax,%eax
801009ba:	74 c4                	je     80100980 <consoleintr+0xd0>
801009bc:	fa                   	cli    
    for(;;)
801009bd:	eb fe                	jmp    801009bd <consoleintr+0x10d>
801009bf:	90                   	nop
      if(input.e != input.w){
801009c0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009c5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009cb:	0f 84 1a ff ff ff    	je     801008eb <consoleintr+0x3b>
  if(panicked){
801009d1:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
        input.e--;
801009d7:	48                   	dec    %eax
801009d8:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801009dd:	85 db                	test   %ebx,%ebx
801009df:	74 1f                	je     80100a00 <consoleintr+0x150>
801009e1:	fa                   	cli    
    for(;;)
801009e2:	eb fe                	jmp    801009e2 <consoleintr+0x132>
801009e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009e8:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801009ef:	e8 dc 3e 00 00       	call   801048d0 <release>
  if(doprocdump) {
801009f4:	85 f6                	test   %esi,%esi
801009f6:	75 17                	jne    80100a0f <consoleintr+0x15f>
}
801009f8:	83 c4 2c             	add    $0x2c,%esp
801009fb:	5b                   	pop    %ebx
801009fc:	5e                   	pop    %esi
801009fd:	5f                   	pop    %edi
801009fe:	5d                   	pop    %ebp
801009ff:	c3                   	ret    
80100a00:	b8 00 01 00 00       	mov    $0x100,%eax
80100a05:	e8 d6 f9 ff ff       	call   801003e0 <consputc.part.0>
80100a0a:	e9 dc fe ff ff       	jmp    801008eb <consoleintr+0x3b>
80100a0f:	83 c4 2c             	add    $0x2c,%esp
80100a12:	5b                   	pop    %ebx
80100a13:	5e                   	pop    %esi
80100a14:	5f                   	pop    %edi
80100a15:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a16:	e9 15 3b 00 00       	jmp    80104530 <procdump>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a1b:	85 c0                	test   %eax,%eax
80100a1d:	0f 84 c8 fe ff ff    	je     801008eb <consoleintr+0x3b>
80100a23:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
80100a29:	89 da                	mov    %ebx,%edx
80100a2b:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100a31:	83 fa 7f             	cmp    $0x7f,%edx
80100a34:	0f 87 b1 fe ff ff    	ja     801008eb <consoleintr+0x3b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a3a:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100a3d:	83 e3 7f             	and    $0x7f,%ebx
  if(panicked){
80100a40:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        c = (c == '\r') ? '\n' : c;
80100a46:	83 f8 0d             	cmp    $0xd,%eax
80100a49:	0f 85 dd fe ff ff    	jne    8010092c <consoleintr+0x7c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a4f:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
  if(panicked){
80100a55:	85 d2                	test   %edx,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a57:	c6 83 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%ebx)
  if(panicked){
80100a5e:	75 25                	jne    80100a85 <consoleintr+0x1d5>
80100a60:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a65:	e8 76 f9 ff ff       	call   801003e0 <consputc.part.0>
          input.w = input.e;
80100a6a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a6f:	c7 04 24 00 ff 10 80 	movl   $0x8010ff00,(%esp)
          input.w = input.e;
80100a76:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a7b:	e8 d0 39 00 00       	call   80104450 <wakeup>
80100a80:	e9 66 fe ff ff       	jmp    801008eb <consoleintr+0x3b>
80100a85:	fa                   	cli    
    for(;;)
80100a86:	eb fe                	jmp    80100a86 <consoleintr+0x1d6>
80100a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a8f:	90                   	nop

80100a90 <consoleinit>:

void
consoleinit(void)
{
80100a90:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100a91:	b8 48 78 10 80       	mov    $0x80107848,%eax
{
80100a96:	89 e5                	mov    %esp,%ebp
80100a98:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a9b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a9f:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80100aa6:	e8 a5 3c 00 00       	call   80104750 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
80100aab:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
80100ab0:	ba 80 05 10 80       	mov    $0x80100580,%edx
  cons.locking = 1;
80100ab5:	a3 54 ff 10 80       	mov    %eax,0x8010ff54
  devsw[CONSOLE].read = consoleread;
80100aba:	b9 60 02 10 80       	mov    $0x80100260,%ecx

  ioapicenable(IRQ_KBD, 0);
80100abf:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].write = consolewrite;
80100ac1:	89 15 0c 09 11 80    	mov    %edx,0x8011090c
  devsw[CONSOLE].read = consoleread;
80100ac7:	89 0d 08 09 11 80    	mov    %ecx,0x80110908
  ioapicenable(IRQ_KBD, 0);
80100acd:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ad1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100ad8:	e8 03 1b 00 00       	call   801025e0 <ioapicenable>
}
80100add:	89 ec                	mov    %ebp,%esp
80100adf:	5d                   	pop    %ebp
80100ae0:	c3                   	ret    
80100ae1:	66 90                	xchg   %ax,%ax
80100ae3:	66 90                	xchg   %ax,%ax
80100ae5:	66 90                	xchg   %ax,%ax
80100ae7:	66 90                	xchg   %ax,%ax
80100ae9:	66 90                	xchg   %ax,%ax
80100aeb:	66 90                	xchg   %ax,%ax
80100aed:	66 90                	xchg   %ax,%ax
80100aef:	90                   	nop

80100af0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100af0:	55                   	push   %ebp
80100af1:	89 e5                	mov    %esp,%ebp
80100af3:	57                   	push   %edi
80100af4:	56                   	push   %esi
80100af5:	53                   	push   %ebx
80100af6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100afc:	e8 bf 31 00 00       	call   80103cc0 <myproc>
80100b01:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b07:	e8 d4 25 00 00       	call   801030e0 <begin_op>

  if((ip = namei(path)) == 0){
80100b0c:	8b 45 08             	mov    0x8(%ebp),%eax
80100b0f:	89 04 24             	mov    %eax,(%esp)
80100b12:	e8 e9 16 00 00       	call   80102200 <namei>
80100b17:	85 c0                	test   %eax,%eax
80100b19:	0f 84 53 03 00 00    	je     80100e72 <exec+0x382>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b1f:	89 04 24             	mov    %eax,(%esp)
80100b22:	89 c7                	mov    %eax,%edi
80100b24:	e8 47 0d 00 00       	call   80101870 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b29:	b8 34 00 00 00       	mov    $0x34,%eax
80100b2e:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b32:	31 c0                	xor    %eax,%eax
80100b34:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b38:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b3e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b42:	89 3c 24             	mov    %edi,(%esp)
80100b45:	e8 26 10 00 00       	call   80101b70 <readi>
80100b4a:	83 f8 34             	cmp    $0x34,%eax
80100b4d:	0f 85 1a 01 00 00    	jne    80100c6d <exec+0x17d>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b53:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b5a:	45 4c 46 
80100b5d:	0f 85 0a 01 00 00    	jne    80100c6d <exec+0x17d>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b63:	e8 58 67 00 00       	call   801072c0 <setupkvm>
80100b68:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b6e:	85 c0                	test   %eax,%eax
80100b70:	0f 84 f7 00 00 00    	je     80100c6d <exec+0x17d>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b76:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b7d:	00 
80100b7e:	8b 9d 40 ff ff ff    	mov    -0xc0(%ebp),%ebx
80100b84:	0f 84 c0 02 00 00    	je     80100e4a <exec+0x35a>
  sz = 0;
80100b8a:	31 f6                	xor    %esi,%esi
80100b8c:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b92:	31 f6                	xor    %esi,%esi
80100b94:	e9 9e 00 00 00       	jmp    80100c37 <exec+0x147>
80100b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ba0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ba7:	75 7f                	jne    80100c28 <exec+0x138>
      continue;
    if(ph.memsz < ph.filesz)
80100ba9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100baf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bb5:	0f 82 a4 00 00 00    	jb     80100c5f <exec+0x16f>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100bbb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bc1:	0f 82 98 00 00 00    	jb     80100c5f <exec+0x16f>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bc7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100bcb:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bd5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100bdb:	89 04 24             	mov    %eax,(%esp)
80100bde:	e8 1d 65 00 00       	call   80107100 <allocuvm>
80100be3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100be9:	85 c0                	test   %eax,%eax
80100beb:	74 72                	je     80100c5f <exec+0x16f>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bed:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bf3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bf8:	75 65                	jne    80100c5f <exec+0x16f>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bfa:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100c00:	89 54 24 10          	mov    %edx,0x10(%esp)
80100c04:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100c0a:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100c0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c12:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c16:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c1c:	89 04 24             	mov    %eax,(%esp)
80100c1f:	e8 ec 63 00 00       	call   80107010 <loaduvm>
80100c24:	85 c0                	test   %eax,%eax
80100c26:	78 37                	js     80100c5f <exec+0x16f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c28:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c2f:	46                   	inc    %esi
80100c30:	83 c3 20             	add    $0x20,%ebx
80100c33:	39 f0                	cmp    %esi,%eax
80100c35:	7e 59                	jle    80100c90 <exec+0x1a0>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100c3b:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c41:	b9 20 00 00 00       	mov    $0x20,%ecx
80100c46:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c4e:	89 3c 24             	mov    %edi,(%esp)
80100c51:	e8 1a 0f 00 00       	call   80101b70 <readi>
80100c56:	83 f8 20             	cmp    $0x20,%eax
80100c59:	0f 84 41 ff ff ff    	je     80100ba0 <exec+0xb0>
  freevm(oldpgdir);
  return 0; // return to exec() in syscall.c

 bad:
  if(pgdir)
    freevm(pgdir);
80100c5f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c65:	89 04 24             	mov    %eax,(%esp)
80100c68:	e8 d3 65 00 00       	call   80107240 <freevm>
  if(ip){
    iunlockput(ip);
80100c6d:	89 3c 24             	mov    %edi,(%esp)
80100c70:	e8 7b 0e 00 00       	call   80101af0 <iunlockput>
    end_op();
80100c75:	e8 d6 24 00 00       	call   80103150 <end_op>
    return -1;
80100c7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c7f:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100c85:	5b                   	pop    %ebx
80100c86:	5e                   	pop    %esi
80100c87:	5f                   	pop    %edi
80100c88:	5d                   	pop    %ebp
80100c89:	c3                   	ret    
80100c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sz = PGROUNDUP(sz);
80100c90:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c96:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c9c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ca2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100ca8:	89 3c 24             	mov    %edi,(%esp)
80100cab:	e8 40 0e 00 00       	call   80101af0 <iunlockput>
  end_op();
80100cb0:	e8 9b 24 00 00       	call   80103150 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cb5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100cb9:	89 74 24 04          	mov    %esi,0x4(%esp)
80100cbd:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cc3:	89 3c 24             	mov    %edi,(%esp)
80100cc6:	e8 35 64 00 00       	call   80107100 <allocuvm>
80100ccb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100cd1:	85 c0                	test   %eax,%eax
80100cd3:	89 c3                	mov    %eax,%ebx
80100cd5:	0f 84 86 00 00 00    	je     80100d61 <exec+0x271>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cdb:	89 3c 24             	mov    %edi,(%esp)
80100cde:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100ce4:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ce6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cea:	e8 71 66 00 00       	call   80107360 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cef:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf2:	8b 08                	mov    (%eax),%ecx
80100cf4:	85 c9                	test   %ecx,%ecx
80100cf6:	0f 84 5a 01 00 00    	je     80100e56 <exec+0x366>
80100cfc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100cff:	eb 25                	jmp    80100d26 <exec+0x236>
80100d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ustack[3+argc] = sp;
80100d08:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d0f:	8d 46 01             	lea    0x1(%esi),%eax
80100d12:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
    ustack[3+argc] = sp;
80100d15:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d1b:	85 c9                	test   %ecx,%ecx
80100d1d:	74 55                	je     80100d74 <exec+0x284>
    if(argc >= MAXARG)
80100d1f:	83 f8 20             	cmp    $0x20,%eax
80100d22:	74 3d                	je     80100d61 <exec+0x271>
  for(argc = 0; argv[argc]; argc++) {
80100d24:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d26:	89 0c 24             	mov    %ecx,(%esp)
80100d29:	e8 d2 3e 00 00       	call   80104c00 <strlen>
80100d2e:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d30:	8b 04 b7             	mov    (%edi,%esi,4),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d33:	4b                   	dec    %ebx
80100d34:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d37:	89 04 24             	mov    %eax,(%esp)
80100d3a:	e8 c1 3e 00 00       	call   80104c00 <strlen>
80100d3f:	40                   	inc    %eax
80100d40:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100d44:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80100d47:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100d4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d4f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d55:	89 04 24             	mov    %eax,(%esp)
80100d58:	e8 73 69 00 00       	call   801076d0 <copyout>
80100d5d:	85 c0                	test   %eax,%eax
80100d5f:	79 a7                	jns    80100d08 <exec+0x218>
    freevm(pgdir);
80100d61:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d67:	89 04 24             	mov    %eax,(%esp)
80100d6a:	e8 d1 64 00 00       	call   80107240 <freevm>
  if(ip){
80100d6f:	e9 06 ff ff ff       	jmp    80100c7a <exec+0x18a>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d74:	8d 0c b5 08 00 00 00 	lea    0x8(,%esi,4),%ecx
  ustack[3+argc] = 0;
80100d7b:	89 d7                	mov    %edx,%edi
80100d7d:	8d 56 04             	lea    0x4(%esi),%edx
  sp -= (3+argc+1) * 4;
80100d80:	8d 71 0c             	lea    0xc(%ecx),%esi
  ustack[1] = argc;
80100d83:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d89:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d8b:	29 f3                	sub    %esi,%ebx
  ustack[3+argc] = 0;
80100d8d:	c7 84 95 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%edx,4)
80100d94:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d98:	29 c8                	sub    %ecx,%eax
  ustack[0] = 0xffffffff;  // fake return PC from main
80100d9a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d9f:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC from main
80100da5:	89 95 58 ff ff ff    	mov    %edx,-0xa8(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100dab:	89 74 24 0c          	mov    %esi,0xc(%esp)
80100daf:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100db3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100db7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100dbd:	89 04 24             	mov    %eax,(%esp)
80100dc0:	e8 0b 69 00 00       	call   801076d0 <copyout>
80100dc5:	85 c0                	test   %eax,%eax
80100dc7:	78 98                	js     80100d61 <exec+0x271>
  for(last=s=path; *s; s++)
80100dc9:	8b 45 08             	mov    0x8(%ebp),%eax
80100dcc:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100dcf:	0f b6 00             	movzbl (%eax),%eax
80100dd2:	84 c0                	test   %al,%al
80100dd4:	74 17                	je     80100ded <exec+0x2fd>
80100dd6:	89 ca                	mov    %ecx,%edx
80100dd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ddf:	90                   	nop
      last = s+1;
80100de0:	42                   	inc    %edx
80100de1:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100de3:	0f b6 02             	movzbl (%edx),%eax
      last = s+1;
80100de6:	0f 44 ca             	cmove  %edx,%ecx
  for(last=s=path; *s; s++)
80100de9:	84 c0                	test   %al,%al
80100deb:	75 f3                	jne    80100de0 <exec+0x2f0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ded:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100df1:	b8 10 00 00 00       	mov    $0x10,%eax
80100df6:	89 44 24 08          	mov    %eax,0x8(%esp)
80100dfa:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100e00:	89 f8                	mov    %edi,%eax
80100e02:	83 c0 6c             	add    $0x6c,%eax
80100e05:	89 04 24             	mov    %eax,(%esp)
80100e08:	e8 b3 3d 00 00       	call   80104bc0 <safestrcpy>
  curproc->pgdir = pgdir;
80100e0d:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e13:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100e16:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100e19:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100e1c:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100e22:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e24:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e2a:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e2d:	8b 47 18             	mov    0x18(%edi),%eax
80100e30:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e33:	89 3c 24             	mov    %edi,(%esp)
80100e36:	e8 45 60 00 00       	call   80106e80 <switchuvm>
  freevm(oldpgdir);
80100e3b:	89 34 24             	mov    %esi,(%esp)
80100e3e:	e8 fd 63 00 00       	call   80107240 <freevm>
  return 0; // return to exec() in syscall.c
80100e43:	31 c0                	xor    %eax,%eax
80100e45:	e9 35 fe ff ff       	jmp    80100c7f <exec+0x18f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e4a:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e4f:	31 f6                	xor    %esi,%esi
80100e51:	e9 52 fe ff ff       	jmp    80100ca8 <exec+0x1b8>
  for(argc = 0; argv[argc]; argc++) {
80100e56:	be 10 00 00 00       	mov    $0x10,%esi
80100e5b:	b9 04 00 00 00       	mov    $0x4,%ecx
80100e60:	ba 03 00 00 00       	mov    $0x3,%edx
80100e65:	31 c0                	xor    %eax,%eax
80100e67:	8d bd 58 ff ff ff    	lea    -0xa8(%ebp),%edi
80100e6d:	e9 11 ff ff ff       	jmp    80100d83 <exec+0x293>
    end_op();
80100e72:	e8 d9 22 00 00       	call   80103150 <end_op>
    cprintf("exec: fail\n");
80100e77:	c7 04 24 61 78 10 80 	movl   $0x80107861,(%esp)
80100e7e:	e8 fd f7 ff ff       	call   80100680 <cprintf>
    return -1;
80100e83:	e9 f2 fd ff ff       	jmp    80100c7a <exec+0x18a>
80100e88:	66 90                	xchg   %ax,%ax
80100e8a:	66 90                	xchg   %ax,%ax
80100e8c:	66 90                	xchg   %ax,%ax
80100e8e:	66 90                	xchg   %ax,%ax

80100e90 <fileinit>:
} ftable;

// initialize the OFT
void
fileinit(void)
{
80100e90:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100e91:	b8 6d 78 10 80       	mov    $0x8010786d,%eax
{
80100e96:	89 e5                	mov    %esp,%ebp
80100e98:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100e9b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e9f:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100ea6:	e8 a5 38 00 00       	call   80104750 <initlock>
}
80100eab:	89 ec                	mov    %ebp,%esp
80100ead:	5d                   	pop    %ebp
80100eae:	c3                   	ret    
80100eaf:	90                   	nop

80100eb0 <filealloc>:

// Allocate a new file structure.
struct file*
filealloc(void)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	83 ec 18             	sub    $0x18,%esp
80100eb6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100eb9:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
  acquire(&ftable.lock);
80100ebe:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100ec5:	e8 76 3a 00 00       	call   80104940 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100eca:	eb 0f                	jmp    80100edb <filealloc+0x2b>
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100ed0:	83 c3 18             	add    $0x18,%ebx
80100ed3:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100ed9:	74 23                	je     80100efe <filealloc+0x4e>
    if(f->ref == 0){
80100edb:	8b 43 04             	mov    0x4(%ebx),%eax
80100ede:	85 c0                	test   %eax,%eax
80100ee0:	75 ee                	jne    80100ed0 <filealloc+0x20>
      f->ref = 1;
80100ee2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ee9:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100ef0:	e8 db 39 00 00       	call   801048d0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ef5:	89 d8                	mov    %ebx,%eax
80100ef7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100efa:	89 ec                	mov    %ebp,%esp
80100efc:	5d                   	pop    %ebp
80100efd:	c3                   	ret    
  release(&ftable.lock);
80100efe:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
  return 0;
80100f05:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f07:	e8 c4 39 00 00       	call   801048d0 <release>
}
80100f0c:	89 d8                	mov    %ebx,%eax
80100f0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f11:	89 ec                	mov    %ebp,%esp
80100f13:	5d                   	pop    %ebp
80100f14:	c3                   	ret    
80100f15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f20 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 18             	sub    $0x18,%esp
80100f26:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80100f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f2c:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f33:	e8 08 3a 00 00       	call   80104940 <acquire>
  if(f->ref < 1)
80100f38:	8b 43 04             	mov    0x4(%ebx),%eax
80100f3b:	85 c0                	test   %eax,%eax
80100f3d:	7e 19                	jle    80100f58 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f3f:	40                   	inc    %eax
80100f40:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f43:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f4a:	e8 81 39 00 00       	call   801048d0 <release>
  return f;
}
80100f4f:	89 d8                	mov    %ebx,%eax
80100f51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f54:	89 ec                	mov    %ebp,%esp
80100f56:	5d                   	pop    %ebp
80100f57:	c3                   	ret    
    panic("filedup");
80100f58:	c7 04 24 74 78 10 80 	movl   $0x80107874,(%esp)
80100f5f:	e8 ec f3 ff ff       	call   80100350 <panic>
80100f64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f6f:	90                   	nop

80100f70 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	83 ec 38             	sub    $0x38,%esp
80100f76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f7c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f7f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80100f82:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f89:	e8 b2 39 00 00       	call   80104940 <acquire>
  if(f->ref < 1)
80100f8e:	8b 53 04             	mov    0x4(%ebx),%edx
80100f91:	85 d2                	test   %edx,%edx
80100f93:	0f 8e ac 00 00 00    	jle    80101045 <fileclose+0xd5>
    panic("fileclose");
  if(--f->ref > 0){
80100f99:	4a                   	dec    %edx
80100f9a:	89 53 04             	mov    %edx,0x4(%ebx)
80100f9d:	75 41                	jne    80100fe0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f9f:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100fa3:	8b 3b                	mov    (%ebx),%edi
  f->ref = 0;
  f->type = FD_NONE;
80100fa5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100fab:	8b 73 0c             	mov    0xc(%ebx),%esi
80100fae:	88 45 e7             	mov    %al,-0x19(%ebp)
80100fb1:	8b 43 10             	mov    0x10(%ebx),%eax
80100fb4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100fb7:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100fbe:	e8 0d 39 00 00       	call   801048d0 <release>

  if(ff.type == FD_PIPE)
80100fc3:	83 ff 01             	cmp    $0x1,%edi
80100fc6:	74 60                	je     80101028 <fileclose+0xb8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100fc8:	83 ff 02             	cmp    $0x2,%edi
80100fcb:	74 33                	je     80101000 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fcd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fd0:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fd3:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fd6:	89 ec                	mov    %ebp,%esp
80100fd8:	5d                   	pop    %ebp
80100fd9:	c3                   	ret    
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fe0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    release(&ftable.lock);
80100fe3:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100fea:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fed:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ff0:	89 ec                	mov    %ebp,%esp
80100ff2:	5d                   	pop    %ebp
    release(&ftable.lock);
80100ff3:	e9 d8 38 00 00       	jmp    801048d0 <release>
80100ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fff:	90                   	nop
    begin_op();
80101000:	e8 db 20 00 00       	call   801030e0 <begin_op>
    iput(ff.ip);
80101005:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101008:	89 04 24             	mov    %eax,(%esp)
8010100b:	e8 90 09 00 00       	call   801019a0 <iput>
}
80101010:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101013:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101016:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101019:	89 ec                	mov    %ebp,%esp
8010101b:	5d                   	pop    %ebp
    end_op();
8010101c:	e9 2f 21 00 00       	jmp    80103150 <end_op>
80101021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80101028:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010102c:	89 34 24             	mov    %esi,(%esp)
8010102f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101033:	e8 28 28 00 00       	call   80103860 <pipeclose>
}
80101038:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010103b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010103e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101041:	89 ec                	mov    %ebp,%esp
80101043:	5d                   	pop    %ebp
80101044:	c3                   	ret    
    panic("fileclose");
80101045:	c7 04 24 7c 78 10 80 	movl   $0x8010787c,(%esp)
8010104c:	e8 ff f2 ff ff       	call   80100350 <panic>
80101051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010105f:	90                   	nop

80101060 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101060:	55                   	push   %ebp
80101061:	89 e5                	mov    %esp,%ebp
80101063:	83 ec 18             	sub    $0x18,%esp
80101066:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80101069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010106c:	83 3b 02             	cmpl   $0x2,(%ebx)
8010106f:	75 37                	jne    801010a8 <filestat+0x48>
    ilock(f->ip); // lock inode in place
80101071:	8b 43 10             	mov    0x10(%ebx),%eax
80101074:	89 04 24             	mov    %eax,(%esp)
80101077:	e8 f4 07 00 00       	call   80101870 <ilock>
    stati(f->ip, st); // copy stat information from inode.
8010107c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010107f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101083:	8b 43 10             	mov    0x10(%ebx),%eax
80101086:	89 04 24             	mov    %eax,(%esp)
80101089:	e8 b2 0a 00 00       	call   80101b40 <stati>
    iunlock(f->ip);
8010108e:	8b 43 10             	mov    0x10(%ebx),%eax
80101091:	89 04 24             	mov    %eax,(%esp)
80101094:	e8 b7 08 00 00       	call   80101950 <iunlock>
    return 0;
  }
  return -1;
}
80101099:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010109c:	89 ec                	mov    %ebp,%esp
8010109e:	5d                   	pop    %ebp
    return 0;
8010109f:	31 c0                	xor    %eax,%eax
}
801010a1:	c3                   	ret    
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010ab:	89 ec                	mov    %ebp,%esp
  return -1;
801010ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010b2:	5d                   	pop    %ebp
801010b3:	c3                   	ret    
801010b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010bf:	90                   	nop

801010c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	83 ec 28             	sub    $0x28,%esp
801010c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801010c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801010cf:	8b 75 0c             	mov    0xc(%ebp),%esi
801010d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
801010d5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010d8:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010dc:	74 72                	je     80101150 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
801010de:	8b 03                	mov    (%ebx),%eax
801010e0:	83 f8 01             	cmp    $0x1,%eax
801010e3:	74 53                	je     80101138 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010e5:	83 f8 02             	cmp    $0x2,%eax
801010e8:	75 6d                	jne    80101157 <fileread+0x97>
    ilock(f->ip);
801010ea:	8b 43 10             	mov    0x10(%ebx),%eax
801010ed:	89 04 24             	mov    %eax,(%esp)
801010f0:	e8 7b 07 00 00       	call   80101870 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010f5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801010f9:	8b 43 14             	mov    0x14(%ebx),%eax
801010fc:	89 74 24 04          	mov    %esi,0x4(%esp)
80101100:	89 44 24 08          	mov    %eax,0x8(%esp)
80101104:	8b 43 10             	mov    0x10(%ebx),%eax
80101107:	89 04 24             	mov    %eax,(%esp)
8010110a:	e8 61 0a 00 00       	call   80101b70 <readi>
8010110f:	85 c0                	test   %eax,%eax
80101111:	89 c6                	mov    %eax,%esi
80101113:	7e 03                	jle    80101118 <fileread+0x58>
      f->off += r; // offset incremented!
80101115:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101118:	8b 43 10             	mov    0x10(%ebx),%eax
8010111b:	89 04 24             	mov    %eax,(%esp)
8010111e:	e8 2d 08 00 00       	call   80101950 <iunlock>
    return r; // and return the number of bytes read!
  }
  panic("fileread");
}
80101123:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101126:	89 f0                	mov    %esi,%eax
80101128:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010112b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010112e:	89 ec                	mov    %ebp,%esp
80101130:	5d                   	pop    %ebp
80101131:	c3                   	ret    
80101132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return piperead(f->pipe, addr, n);
80101138:	8b 43 0c             	mov    0xc(%ebx),%eax
}
8010113b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010113e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101141:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
80101144:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101147:	89 ec                	mov    %ebp,%esp
80101149:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010114a:	e9 c1 28 00 00       	jmp    80103a10 <piperead>
8010114f:	90                   	nop
    return -1;
80101150:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101155:	eb cc                	jmp    80101123 <fileread+0x63>
  panic("fileread");
80101157:	c7 04 24 86 78 10 80 	movl   $0x80107886,(%esp)
8010115e:	e8 ed f1 ff ff       	call   80100350 <panic>
80101163:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010116a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101170 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 2c             	sub    $0x2c,%esp
80101179:	8b 45 0c             	mov    0xc(%ebp),%eax
8010117c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010117f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101182:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101185:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101189:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010118c:	0f 84 b3 00 00 00    	je     80101245 <filewrite+0xd5>
    return -1;
  if(f->type == FD_PIPE)
80101192:	8b 0b                	mov    (%ebx),%ecx
80101194:	83 f9 01             	cmp    $0x1,%ecx
80101197:	0f 84 b7 00 00 00    	je     80101254 <filewrite+0xe4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010119d:	83 f9 02             	cmp    $0x2,%ecx
801011a0:	0f 85 c0 00 00 00    	jne    80101266 <filewrite+0xf6>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801011a9:	31 ff                	xor    %edi,%edi
    while(i < n){
801011ab:	85 c0                	test   %eax,%eax
801011ad:	7f 2d                	jg     801011dc <filewrite+0x6c>
801011af:	e9 8c 00 00 00       	jmp    80101240 <filewrite+0xd0>
801011b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011b8:	01 43 14             	add    %eax,0x14(%ebx)
801011bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011be:	8b 43 10             	mov    0x10(%ebx),%eax
801011c1:	89 04 24             	mov    %eax,(%esp)
801011c4:	e8 87 07 00 00       	call   80101950 <iunlock>
      end_op();
801011c9:	e8 82 1f 00 00       	call   80103150 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801011ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011d1:	39 c6                	cmp    %eax,%esi
801011d3:	75 5f                	jne    80101234 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801011d5:	01 f7                	add    %esi,%edi
    while(i < n){
801011d7:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011da:	7e 64                	jle    80101240 <filewrite+0xd0>
      int n1 = n - i;
801011dc:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      if(n1 > max)
801011df:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801011e4:	29 fe                	sub    %edi,%esi
      if(n1 > max)
801011e6:	39 c6                	cmp    %eax,%esi
801011e8:	0f 4f f0             	cmovg  %eax,%esi
      begin_op();
801011eb:	e8 f0 1e 00 00       	call   801030e0 <begin_op>
      ilock(f->ip);
801011f0:	8b 43 10             	mov    0x10(%ebx),%eax
801011f3:	89 04 24             	mov    %eax,(%esp)
801011f6:	e8 75 06 00 00       	call   80101870 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011fb:	89 74 24 0c          	mov    %esi,0xc(%esp)
801011ff:	8b 43 14             	mov    0x14(%ebx),%eax
80101202:	89 44 24 08          	mov    %eax,0x8(%esp)
80101206:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101209:	01 f8                	add    %edi,%eax
8010120b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010120f:	8b 43 10             	mov    0x10(%ebx),%eax
80101212:	89 04 24             	mov    %eax,(%esp)
80101215:	e8 86 0a 00 00       	call   80101ca0 <writei>
8010121a:	85 c0                	test   %eax,%eax
8010121c:	7f 9a                	jg     801011b8 <filewrite+0x48>
      iunlock(f->ip);
8010121e:	89 c6                	mov    %eax,%esi
80101220:	8b 43 10             	mov    0x10(%ebx),%eax
80101223:	89 04 24             	mov    %eax,(%esp)
80101226:	e8 25 07 00 00       	call   80101950 <iunlock>
      end_op();
8010122b:	e8 20 1f 00 00       	call   80103150 <end_op>
      if(r < 0)
80101230:	85 f6                	test   %esi,%esi
80101232:	75 0c                	jne    80101240 <filewrite+0xd0>
        panic("short filewrite");
80101234:	c7 04 24 8f 78 10 80 	movl   $0x8010788f,(%esp)
8010123b:	e8 10 f1 ff ff       	call   80100350 <panic>
    }
    return i == n ? n : -1; // why not just return i?
80101240:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101243:	74 05                	je     8010124a <filewrite+0xda>
    return -1;
80101245:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
8010124a:	83 c4 2c             	add    $0x2c,%esp
8010124d:	89 f8                	mov    %edi,%eax
8010124f:	5b                   	pop    %ebx
80101250:	5e                   	pop    %esi
80101251:	5f                   	pop    %edi
80101252:	5d                   	pop    %ebp
80101253:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101254:	8b 43 0c             	mov    0xc(%ebx),%eax
80101257:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010125a:	83 c4 2c             	add    $0x2c,%esp
8010125d:	5b                   	pop    %ebx
8010125e:	5e                   	pop    %esi
8010125f:	5f                   	pop    %edi
80101260:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101261:	e9 9a 26 00 00       	jmp    80103900 <pipewrite>
  panic("filewrite");
80101266:	c7 04 24 95 78 10 80 	movl   $0x80107895,(%esp)
8010126d:	e8 de f0 ff ff       	call   80100350 <panic>
80101272:	66 90                	xchg   %ax,%ax
80101274:	66 90                	xchg   %ax,%ax
80101276:	66 90                	xchg   %ax,%ax
80101278:	66 90                	xchg   %ax,%ax
8010127a:	66 90                	xchg   %ax,%ax
8010127c:	66 90                	xchg   %ax,%ax
8010127e:	66 90                	xchg   %ax,%ax

80101280 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	83 ec 2c             	sub    $0x2c,%esp
80101289:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){ // iterate over bitmap blocks
8010128c:	8b 35 b4 25 11 80    	mov    0x801125b4,%esi
80101292:	85 f6                	test   %esi,%esi
80101294:	0f 84 7f 00 00 00    	je     80101319 <balloc+0x99>
8010129a:	31 ff                	xor    %edi,%edi

    bp = bread(dev, BBLOCK(b, sb)); // read block bitmap block into memory
8010129c:	8b 1d cc 25 11 80    	mov    0x801125cc,%ebx
801012a2:	89 f8                	mov    %edi,%eax
801012a4:	89 fe                	mov    %edi,%esi
801012a6:	c1 f8 0c             	sar    $0xc,%eax
801012a9:	01 d8                	add    %ebx,%eax
801012ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801012af:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012b2:	89 04 24             	mov    %eax,(%esp)
801012b5:	e8 16 ee ff ff       	call   801000d0 <bread>
801012ba:	89 7d d8             	mov    %edi,-0x28(%ebp)
801012bd:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){ // iterate over blocks
801012bf:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801012c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012c7:	31 c0                	xor    %eax,%eax
801012c9:	eb 2e                	jmp    801012f9 <balloc+0x79>
801012cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012cf:	90                   	nop

      m = 1 << (bi % 8); // mask for bit corresponding to bi^th block in bitmap block
801012d0:	89 c1                	mov    %eax,%ecx
801012d2:	ba 01 00 00 00       	mov    $0x1,%edx
801012d7:	83 e1 07             	and    $0x7,%ecx
801012da:	d3 e2                	shl    %cl,%edx
      
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012dc:	89 c1                	mov    %eax,%ecx
      m = 1 << (bi % 8); // mask for bit corresponding to bi^th block in bitmap block
801012de:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012e1:	c1 f9 03             	sar    $0x3,%ecx
801012e4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801012e9:	85 7d e4             	test   %edi,-0x1c(%ebp)
801012ec:	89 fa                	mov    %edi,%edx
801012ee:	74 38                	je     80101328 <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){ // iterate over blocks
801012f0:	40                   	inc    %eax
801012f1:	46                   	inc    %esi
801012f2:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012f7:	74 07                	je     80101300 <balloc+0x80>
801012f9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801012fc:	39 fe                	cmp    %edi,%esi
801012fe:	72 d0                	jb     801012d0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi); // zero the (in-memory) block and return it
        return b + bi; // return the block number
      }
    }
    brelse(bp);
80101300:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101303:	89 1c 24             	mov    %ebx,(%esp)
80101306:	e8 d5 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){ // iterate over bitmap blocks
8010130b:	81 c7 00 10 00 00    	add    $0x1000,%edi
80101311:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
80101317:	72 83                	jb     8010129c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101319:	c7 04 24 9f 78 10 80 	movl   $0x8010789f,(%esp)
80101320:	e8 2b f0 ff ff       	call   80100350 <panic>
80101325:	8d 76 00             	lea    0x0(%esi),%esi
        bp->data[bi/8] |= m;  // Mark block in use. (set that bit to 1 essentially)
80101328:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
8010132c:	08 c2                	or     %al,%dl
8010132e:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp); // write the updated bitmap back to disk
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 46 1f 00 00       	call   80103280 <log_write>
        brelse(bp);
8010133a:	89 1c 24             	mov    %ebx,(%esp)
8010133d:	e8 9e ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
80101342:	89 74 24 04          	mov    %esi,0x4(%esp)
80101346:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101349:	89 04 24             	mov    %eax,(%esp)
8010134c:	e8 7f ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101351:	ba 00 02 00 00       	mov    $0x200,%edx
80101356:	31 c9                	xor    %ecx,%ecx
80101358:	89 54 24 08          	mov    %edx,0x8(%esp)
8010135c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
80101360:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101362:	8d 40 5c             	lea    0x5c(%eax),%eax
80101365:	89 04 24             	mov    %eax,(%esp)
80101368:	e8 b3 36 00 00       	call   80104a20 <memset>
  log_write(bp);
8010136d:	89 1c 24             	mov    %ebx,(%esp)
80101370:	e8 0b 1f 00 00       	call   80103280 <log_write>
  brelse(bp);
80101375:	89 1c 24             	mov    %ebx,(%esp)
80101378:	e8 63 ee ff ff       	call   801001e0 <brelse>
}
8010137d:	83 c4 2c             	add    $0x2c,%esp
80101380:	89 f0                	mov    %esi,%eax
80101382:	5b                   	pop    %ebx
80101383:	5e                   	pop    %esi
80101384:	5f                   	pop    %edi
80101385:	5d                   	pop    %ebp
80101386:	c3                   	ret    
80101387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010138e:	66 90                	xchg   %ax,%ax

80101390 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101394:	31 ff                	xor    %edi,%edi
{
80101396:	56                   	push   %esi
80101397:	89 c6                	mov    %eax,%esi
80101399:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010139a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010139f:	83 ec 2c             	sub    $0x2c,%esp
801013a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013a5:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801013ac:	e8 8f 35 00 00       	call   80104940 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013b4:	eb 1c                	jmp    801013d2 <iget+0x42>
801013b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013c0:	39 33                	cmp    %esi,(%ebx)
801013c2:	74 6c                	je     80101430 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013c4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ca:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013d0:	74 2e                	je     80101400 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013d2:	8b 43 08             	mov    0x8(%ebx),%eax
801013d5:	85 c0                	test   %eax,%eax
801013d7:	7f e7                	jg     801013c0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013d9:	85 ff                	test   %edi,%edi
801013db:	75 e7                	jne    801013c4 <iget+0x34>
801013dd:	85 c0                	test   %eax,%eax
801013df:	90                   	nop
801013e0:	75 6f                	jne    80101451 <iget+0xc1>
801013e2:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ea:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013f0:	75 e0                	jne    801013d2 <iget+0x42>
801013f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101400:	85 ff                	test   %edi,%edi
80101402:	74 6b                	je     8010146f <iget+0xdf>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101404:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101406:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101409:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
80101410:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101417:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010141e:	e8 ad 34 00 00       	call   801048d0 <release>

  return ip;
}
80101423:	83 c4 2c             	add    $0x2c,%esp
80101426:	89 f8                	mov    %edi,%eax
80101428:	5b                   	pop    %ebx
80101429:	5e                   	pop    %esi
8010142a:	5f                   	pop    %edi
8010142b:	5d                   	pop    %ebp
8010142c:	c3                   	ret    
8010142d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101430:	39 53 04             	cmp    %edx,0x4(%ebx)
80101433:	75 8f                	jne    801013c4 <iget+0x34>
      ip->ref++;
80101435:	40                   	inc    %eax
      return ip;
80101436:	89 df                	mov    %ebx,%edi
      ip->ref++;
80101438:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
8010143b:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101442:	e8 89 34 00 00       	call   801048d0 <release>
}
80101447:	83 c4 2c             	add    $0x2c,%esp
8010144a:	89 f8                	mov    %edi,%eax
8010144c:	5b                   	pop    %ebx
8010144d:	5e                   	pop    %esi
8010144e:	5f                   	pop    %edi
8010144f:	5d                   	pop    %ebp
80101450:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101451:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101457:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010145d:	74 10                	je     8010146f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010145f:	8b 43 08             	mov    0x8(%ebx),%eax
80101462:	85 c0                	test   %eax,%eax
80101464:	0f 8f 56 ff ff ff    	jg     801013c0 <iget+0x30>
8010146a:	e9 6e ff ff ff       	jmp    801013dd <iget+0x4d>
    panic("iget: no inodes");
8010146f:	c7 04 24 b5 78 10 80 	movl   $0x801078b5,(%esp)
80101476:	e8 d5 ee ff ff       	call   80100350 <panic>
8010147b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010147f:	90                   	nop

80101480 <bfree>:
{
80101480:	55                   	push   %ebp
80101481:	89 c1                	mov    %eax,%ecx
80101483:	89 e5                	mov    %esp,%ebp
  bp = bread(dev, BBLOCK(b, sb));
80101485:	89 d0                	mov    %edx,%eax
{
80101487:	56                   	push   %esi
80101488:	53                   	push   %ebx
80101489:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
8010148b:	c1 e8 0c             	shr    $0xc,%eax
{
8010148e:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101491:	89 0c 24             	mov    %ecx,(%esp)
80101494:	8b 15 cc 25 11 80    	mov    0x801125cc,%edx
8010149a:	01 d0                	add    %edx,%eax
8010149c:	89 44 24 04          	mov    %eax,0x4(%esp)
801014a0:	e8 2b ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014a5:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014a7:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801014aa:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801014ad:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801014b3:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801014b5:	b8 01 00 00 00       	mov    $0x1,%eax
801014ba:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801014bc:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801014c1:	85 c1                	test   %eax,%ecx
801014c3:	74 1f                	je     801014e4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
801014c5:	f6 d0                	not    %al
801014c7:	20 c8                	and    %cl,%al
801014c9:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801014cd:	89 34 24             	mov    %esi,(%esp)
801014d0:	e8 ab 1d 00 00       	call   80103280 <log_write>
  brelse(bp);
801014d5:	89 34 24             	mov    %esi,(%esp)
801014d8:	e8 03 ed ff ff       	call   801001e0 <brelse>
}
801014dd:	83 c4 10             	add    $0x10,%esp
801014e0:	5b                   	pop    %ebx
801014e1:	5e                   	pop    %esi
801014e2:	5d                   	pop    %ebp
801014e3:	c3                   	ret    
    panic("freeing free block");
801014e4:	c7 04 24 c5 78 10 80 	movl   $0x801078c5,(%esp)
801014eb:	e8 60 ee ff ff       	call   80100350 <panic>

801014f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	83 ec 38             	sub    $0x38,%esp
801014f6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014f9:	83 fa 0b             	cmp    $0xb,%edx
{
801014fc:	89 c6                	mov    %eax,%esi
801014fe:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101501:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
80101504:	76 7a                	jbe    80101580 <bmap+0x90>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101506:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101509:	83 fb 7f             	cmp    $0x7f,%ebx
8010150c:	0f 87 95 00 00 00    	ja     801015a7 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101512:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101518:	85 c0                	test   %eax,%eax
8010151a:	74 54                	je     80101570 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010151c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101520:	8b 06                	mov    (%esi),%eax
80101522:	89 04 24             	mov    %eax,(%esp)
80101525:	e8 a6 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010152a:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010152e:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101530:	8b 3b                	mov    (%ebx),%edi
80101532:	85 ff                	test   %edi,%edi
80101534:	74 1a                	je     80101550 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101536:	89 14 24             	mov    %edx,(%esp)
80101539:	e8 a2 ec ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
8010153e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101541:	89 f8                	mov    %edi,%eax
80101543:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101546:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101549:	89 ec                	mov    %ebp,%esp
8010154b:	5d                   	pop    %ebp
8010154c:	c3                   	ret    
8010154d:	8d 76 00             	lea    0x0(%esi),%esi
80101550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101553:	8b 06                	mov    (%esi),%eax
80101555:	e8 26 fd ff ff       	call   80101280 <balloc>
      log_write(bp);
8010155a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      a[bn] = addr = balloc(ip->dev);
8010155d:	89 03                	mov    %eax,(%ebx)
8010155f:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101561:	89 14 24             	mov    %edx,(%esp)
80101564:	e8 17 1d 00 00       	call   80103280 <log_write>
80101569:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010156c:	eb c8                	jmp    80101536 <bmap+0x46>
8010156e:	66 90                	xchg   %ax,%ax
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101570:	8b 06                	mov    (%esi),%eax
80101572:	e8 09 fd ff ff       	call   80101280 <balloc>
80101577:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010157d:	eb 9d                	jmp    8010151c <bmap+0x2c>
8010157f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101580:	8d 5a 14             	lea    0x14(%edx),%ebx
80101583:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101587:	85 ff                	test   %edi,%edi
80101589:	75 b3                	jne    8010153e <bmap+0x4e>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010158b:	8b 00                	mov    (%eax),%eax
8010158d:	e8 ee fc ff ff       	call   80101280 <balloc>
80101592:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101596:	89 c7                	mov    %eax,%edi
}
80101598:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010159b:	89 f8                	mov    %edi,%eax
8010159d:	8b 75 f8             	mov    -0x8(%ebp),%esi
801015a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801015a3:	89 ec                	mov    %ebp,%esp
801015a5:	5d                   	pop    %ebp
801015a6:	c3                   	ret    
  panic("bmap: out of range");
801015a7:	c7 04 24 d8 78 10 80 	movl   $0x801078d8,(%esp)
801015ae:	e8 9d ed ff ff       	call   80100350 <panic>
801015b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801015c0 <readsb>:
{
801015c0:	55                   	push   %ebp
  bp = bread(dev, 1); // superblock block number is known to be 1
801015c1:	b8 01 00 00 00       	mov    $0x1,%eax
{
801015c6:	89 e5                	mov    %esp,%ebp
801015c8:	83 ec 18             	sub    $0x18,%esp
801015cb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801015ce:	89 75 fc             	mov    %esi,-0x4(%ebp)
801015d1:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1); // superblock block number is known to be 1
801015d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801015d8:	8b 45 08             	mov    0x8(%ebp),%eax
801015db:	89 04 24             	mov    %eax,(%esp)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb)); // copy buf data to superblock
801015e3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801015e8:	89 34 24             	mov    %esi,(%esp)
801015eb:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1); // superblock block number is known to be 1
801015ef:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb)); // copy buf data to superblock
801015f1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801015f8:	e8 b3 34 00 00       	call   80104ab0 <memmove>
}
801015fd:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
80101600:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101603:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101606:	89 ec                	mov    %ebp,%esp
80101608:	5d                   	pop    %ebp
  brelse(bp);
80101609:	e9 d2 eb ff ff       	jmp    801001e0 <brelse>
8010160e:	66 90                	xchg   %ax,%ax

80101610 <iinit>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	83 ec 28             	sub    $0x28,%esp
80101616:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  initlock(&icache.lock, "icache");
80101619:	bb eb 78 10 80       	mov    $0x801078eb,%ebx
8010161e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101622:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101627:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010162e:	e8 1d 31 00 00       	call   80104750 <initlock>
  for(i = 0; i < NINODE; i++) {
80101633:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010163a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101640:	89 1c 24             	mov    %ebx,(%esp)
80101643:	b9 f2 78 10 80       	mov    $0x801078f2,%ecx
  for(i = 0; i < NINODE; i++) {
80101648:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010164e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101652:	e8 b9 2f 00 00       	call   80104610 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101657:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010165d:	75 e1                	jne    80101640 <iinit+0x30>
  bp = bread(dev, 1); // superblock block number is known to be 1
8010165f:	b8 01 00 00 00       	mov    $0x1,%eax
80101664:	89 44 24 04          	mov    %eax,0x4(%esp)
80101668:	8b 45 08             	mov    0x8(%ebp),%eax
8010166b:	89 04 24             	mov    %eax,(%esp)
8010166e:	e8 5d ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb)); // copy buf data to superblock
80101673:	ba 1c 00 00 00       	mov    $0x1c,%edx
80101678:	89 54 24 08          	mov    %edx,0x8(%esp)
8010167c:	c7 04 24 b4 25 11 80 	movl   $0x801125b4,(%esp)
  bp = bread(dev, 1); // superblock block number is known to be 1
80101683:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb)); // copy buf data to superblock
80101685:	8d 40 5c             	lea    0x5c(%eax),%eax
80101688:	89 44 24 04          	mov    %eax,0x4(%esp)
8010168c:	e8 1f 34 00 00       	call   80104ab0 <memmove>
  brelse(bp);
80101691:	89 1c 24             	mov    %ebx,(%esp)
80101694:	e8 47 eb ff ff       	call   801001e0 <brelse>
  cprintf("superblock: \nsize = %d blocks \n#datablocks = %d \n#inodes = %d \n#log-blocks = %d \nstart block index of log = %d \nstart block index of inodes = %d \nstart block of bitmap = %d\n", sb.size, sb.nblocks,
80101699:	a1 cc 25 11 80       	mov    0x801125cc,%eax
8010169e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801016a2:	a1 c8 25 11 80       	mov    0x801125c8,%eax
801016a7:	89 44 24 18          	mov    %eax,0x18(%esp)
801016ab:	a1 c4 25 11 80       	mov    0x801125c4,%eax
801016b0:	89 44 24 14          	mov    %eax,0x14(%esp)
801016b4:	a1 c0 25 11 80       	mov    0x801125c0,%eax
801016b9:	89 44 24 10          	mov    %eax,0x10(%esp)
801016bd:	a1 bc 25 11 80       	mov    0x801125bc,%eax
801016c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
801016c6:	a1 b8 25 11 80       	mov    0x801125b8,%eax
801016cb:	89 44 24 08          	mov    %eax,0x8(%esp)
801016cf:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801016d4:	c7 04 24 58 79 10 80 	movl   $0x80107958,(%esp)
801016db:	89 44 24 04          	mov    %eax,0x4(%esp)
801016df:	e8 9c ef ff ff       	call   80100680 <cprintf>
}
801016e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016e7:	89 ec                	mov    %ebp,%esp
801016e9:	5d                   	pop    %ebp
801016ea:	c3                   	ret    
801016eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801016ef:	90                   	nop

801016f0 <ialloc>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	56                   	push   %esi
801016f5:	53                   	push   %ebx
801016f6:	83 ec 2c             	sub    $0x2c,%esp
801016f9:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801016fd:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101704:	8b 75 08             	mov    0x8(%ebp),%esi
80101707:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010170a:	0f 86 91 00 00 00    	jbe    801017a1 <ialloc+0xb1>
80101710:	bf 01 00 00 00       	mov    $0x1,%edi
80101715:	eb 1a                	jmp    80101731 <ialloc+0x41>
80101717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101720:	89 1c 24             	mov    %ebx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101723:	47                   	inc    %edi
    brelse(bp);
80101724:	e8 b7 ea ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101729:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
8010172f:	73 70                	jae    801017a1 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb)); // get the block where the inode with index inum is stored
80101731:	89 34 24             	mov    %esi,(%esp)
80101734:	8b 0d c8 25 11 80    	mov    0x801125c8,%ecx
8010173a:	89 f8                	mov    %edi,%eax
8010173c:	c1 e8 03             	shr    $0x3,%eax
8010173f:	01 c8                	add    %ecx,%eax
80101741:	89 44 24 04          	mov    %eax,0x4(%esp)
80101745:	e8 86 e9 ff ff       	call   801000d0 <bread>
8010174a:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB; // get the inode we need from the block
8010174c:	89 f8                	mov    %edi,%eax
8010174e:	83 e0 07             	and    $0x7,%eax
80101751:	c1 e0 06             	shl    $0x6,%eax
80101754:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // if it's a free inode, perfect
80101758:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010175c:	75 c2                	jne    80101720 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip)); // zero out the struct
8010175e:	89 0c 24             	mov    %ecx,(%esp)
80101761:	31 d2                	xor    %edx,%edx
80101763:	b8 40 00 00 00       	mov    $0x40,%eax
80101768:	89 54 24 04          	mov    %edx,0x4(%esp)
8010176c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101770:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101773:	e8 a8 32 00 00       	call   80104a20 <memset>
      dip->type = type;
80101778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010177b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010177e:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101781:	89 1c 24             	mov    %ebx,(%esp)
80101784:	e8 f7 1a 00 00       	call   80103280 <log_write>
      brelse(bp);
80101789:	89 1c 24             	mov    %ebx,(%esp)
8010178c:	e8 4f ea ff ff       	call   801001e0 <brelse>
}
80101791:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101794:	89 f0                	mov    %esi,%eax
}
80101796:	5b                   	pop    %ebx
      return iget(dev, inum);
80101797:	89 fa                	mov    %edi,%edx
}
80101799:	5e                   	pop    %esi
8010179a:	5f                   	pop    %edi
8010179b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010179c:	e9 ef fb ff ff       	jmp    80101390 <iget>
  panic("ialloc: no inodes");
801017a1:	c7 04 24 f8 78 10 80 	movl   $0x801078f8,(%esp)
801017a8:	e8 a3 eb ff ff       	call   80100350 <panic>
801017ad:	8d 76 00             	lea    0x0(%esi),%esi

801017b0 <iupdate>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	83 ec 10             	sub    $0x10,%esp
801017b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017bb:	8b 15 c8 25 11 80    	mov    0x801125c8,%edx
801017c1:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017c4:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c7:	c1 e8 03             	shr    $0x3,%eax
801017ca:	01 d0                	add    %edx,%eax
801017cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801017d0:	8b 43 a4             	mov    -0x5c(%ebx),%eax
801017d3:	89 04 24             	mov    %eax,(%esp)
801017d6:	e8 f5 e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801017db:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017df:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017e4:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017e6:	8b 43 a8             	mov    -0x58(%ebx),%eax
801017e9:	83 e0 07             	and    $0x7,%eax
801017ec:	c1 e0 06             	shl    $0x6,%eax
801017ef:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017f3:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017f6:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801017f9:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
801017fd:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101801:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
80101805:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101809:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
8010180d:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101811:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101814:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101817:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010181b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010181f:	89 04 24             	mov    %eax,(%esp)
80101822:	e8 89 32 00 00       	call   80104ab0 <memmove>
  log_write(bp);
80101827:	89 34 24             	mov    %esi,(%esp)
8010182a:	e8 51 1a 00 00       	call   80103280 <log_write>
  brelse(bp);
8010182f:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101832:	83 c4 10             	add    $0x10,%esp
80101835:	5b                   	pop    %ebx
80101836:	5e                   	pop    %esi
80101837:	5d                   	pop    %ebp
  brelse(bp);
80101838:	e9 a3 e9 ff ff       	jmp    801001e0 <brelse>
8010183d:	8d 76 00             	lea    0x0(%esi),%esi

80101840 <idup>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	83 ec 18             	sub    $0x18,%esp
80101846:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80101849:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010184c:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101853:	e8 e8 30 00 00       	call   80104940 <acquire>
  ip->ref++;
80101858:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
8010185b:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101862:	e8 69 30 00 00       	call   801048d0 <release>
}
80101867:	89 d8                	mov    %ebx,%eax
80101869:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010186c:	89 ec                	mov    %ebp,%esp
8010186e:	5d                   	pop    %ebp
8010186f:	c3                   	ret    

80101870 <ilock>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	83 ec 10             	sub    $0x10,%esp
80101878:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010187b:	85 db                	test   %ebx,%ebx
8010187d:	0f 84 be 00 00 00    	je     80101941 <ilock+0xd1>
80101883:	8b 43 08             	mov    0x8(%ebx),%eax
80101886:	85 c0                	test   %eax,%eax
80101888:	0f 8e b3 00 00 00    	jle    80101941 <ilock+0xd1>
  acquiresleep(&ip->lock);
8010188e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101891:	89 04 24             	mov    %eax,(%esp)
80101894:	e8 b7 2d 00 00       	call   80104650 <acquiresleep>
  if(ip->valid == 0){
80101899:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010189c:	85 f6                	test   %esi,%esi
8010189e:	74 10                	je     801018b0 <ilock+0x40>
}
801018a0:	83 c4 10             	add    $0x10,%esp
801018a3:	5b                   	pop    %ebx
801018a4:	5e                   	pop    %esi
801018a5:	5d                   	pop    %ebp
801018a6:	c3                   	ret    
801018a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ae:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018b0:	8b 43 04             	mov    0x4(%ebx),%eax
801018b3:	8b 15 c8 25 11 80    	mov    0x801125c8,%edx
801018b9:	c1 e8 03             	shr    $0x3,%eax
801018bc:	01 d0                	add    %edx,%eax
801018be:	89 44 24 04          	mov    %eax,0x4(%esp)
801018c2:	8b 03                	mov    (%ebx),%eax
801018c4:	89 04 24             	mov    %eax,(%esp)
801018c7:	e8 04 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018cc:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018d1:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018d3:	8b 43 04             	mov    0x4(%ebx),%eax
801018d6:	83 e0 07             	and    $0x7,%eax
801018d9:	c1 e0 06             	shl    $0x6,%eax
801018dc:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018e0:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018e3:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018e6:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018ea:	0f bf 50 f6          	movswl -0xa(%eax),%edx
801018ee:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018f2:	0f bf 50 f8          	movswl -0x8(%eax),%edx
801018f6:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018fa:	0f bf 50 fa          	movswl -0x6(%eax),%edx
801018fe:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101902:	8b 50 fc             	mov    -0x4(%eax),%edx
80101905:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101908:	89 44 24 04          	mov    %eax,0x4(%esp)
8010190c:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010190f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101913:	89 04 24             	mov    %eax,(%esp)
80101916:	e8 95 31 00 00       	call   80104ab0 <memmove>
    brelse(bp);
8010191b:	89 34 24             	mov    %esi,(%esp)
8010191e:	e8 bd e8 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101923:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101928:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
8010192f:	0f 85 6b ff ff ff    	jne    801018a0 <ilock+0x30>
      panic("ilock: no type");
80101935:	c7 04 24 10 79 10 80 	movl   $0x80107910,(%esp)
8010193c:	e8 0f ea ff ff       	call   80100350 <panic>
    panic("ilock");
80101941:	c7 04 24 0a 79 10 80 	movl   $0x8010790a,(%esp)
80101948:	e8 03 ea ff ff       	call   80100350 <panic>
8010194d:	8d 76 00             	lea    0x0(%esi),%esi

80101950 <iunlock>:
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	83 ec 18             	sub    $0x18,%esp
80101956:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101959:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010195c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010195f:	85 db                	test   %ebx,%ebx
80101961:	74 27                	je     8010198a <iunlock+0x3a>
80101963:	8d 73 0c             	lea    0xc(%ebx),%esi
80101966:	89 34 24             	mov    %esi,(%esp)
80101969:	e8 82 2d 00 00       	call   801046f0 <holdingsleep>
8010196e:	85 c0                	test   %eax,%eax
80101970:	74 18                	je     8010198a <iunlock+0x3a>
80101972:	8b 43 08             	mov    0x8(%ebx),%eax
80101975:	85 c0                	test   %eax,%eax
80101977:	7e 11                	jle    8010198a <iunlock+0x3a>
  releasesleep(&ip->lock);
80101979:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010197c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010197f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101982:	89 ec                	mov    %ebp,%esp
80101984:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101985:	e9 26 2d 00 00       	jmp    801046b0 <releasesleep>
    panic("iunlock");
8010198a:	c7 04 24 1f 79 10 80 	movl   $0x8010791f,(%esp)
80101991:	e8 ba e9 ff ff       	call   80100350 <panic>
80101996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010199d:	8d 76 00             	lea    0x0(%esi),%esi

801019a0 <iput>:
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	83 ec 38             	sub    $0x38,%esp
801019a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801019a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801019ac:	89 7d fc             	mov    %edi,-0x4(%ebp)
801019af:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
801019b2:	8d 7b 0c             	lea    0xc(%ebx),%edi
801019b5:	89 3c 24             	mov    %edi,(%esp)
801019b8:	e8 93 2c 00 00       	call   80104650 <acquiresleep>
  if(ip->valid && ip->nlink == 0){ // true iff one of valid and nlink is 0
801019bd:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019c0:	85 d2                	test   %edx,%edx
801019c2:	74 07                	je     801019cb <iput+0x2b>
801019c4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019c9:	74 35                	je     80101a00 <iput+0x60>
  releasesleep(&ip->lock);
801019cb:	89 3c 24             	mov    %edi,(%esp)
801019ce:	e8 dd 2c 00 00       	call   801046b0 <releasesleep>
  acquire(&icache.lock);
801019d3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019da:	e8 61 2f 00 00       	call   80104940 <acquire>
  ip->ref--;
801019df:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
801019e2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801019e9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801019ec:	8b 75 f8             	mov    -0x8(%ebp),%esi
801019ef:	8b 7d fc             	mov    -0x4(%ebp),%edi
801019f2:	89 ec                	mov    %ebp,%esp
801019f4:	5d                   	pop    %ebp
  release(&icache.lock);
801019f5:	e9 d6 2e 00 00       	jmp    801048d0 <release>
801019fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a00:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a07:	e8 34 2f 00 00       	call   80104940 <acquire>
    int r = ip->ref;
80101a0c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a0f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a16:	e8 b5 2e 00 00       	call   801048d0 <release>
    if(r == 1){
80101a1b:	4e                   	dec    %esi
80101a1c:	75 ad                	jne    801019cb <iput+0x2b>
80101a1e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a21:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a27:	89 df                	mov    %ebx,%edi
80101a29:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a2c:	89 cb                	mov    %ecx,%ebx
80101a2e:	eb 07                	jmp    80101a37 <iput+0x97>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a30:	83 c6 04             	add    $0x4,%esi
80101a33:	39 de                	cmp    %ebx,%esi
80101a35:	74 19                	je     80101a50 <iput+0xb0>
    if(ip->addrs[i]){
80101a37:	8b 16                	mov    (%esi),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a3d:	8b 07                	mov    (%edi),%eax
80101a3f:	e8 3c fa ff ff       	call   80101480 <bfree>
      ip->addrs[i] = 0;
80101a44:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a4a:	eb e4                	jmp    80101a30 <iput+0x90>
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a50:	89 fb                	mov    %edi,%ebx
80101a52:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a55:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a5b:	85 c0                	test   %eax,%eax
80101a5d:	75 29                	jne    80101a88 <iput+0xe8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101a5f:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a66:	89 1c 24             	mov    %ebx,(%esp)
80101a69:	e8 42 fd ff ff       	call   801017b0 <iupdate>
      ip->type = 0;
80101a6e:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip); // push latest version of inode to disk
80101a74:	89 1c 24             	mov    %ebx,(%esp)
80101a77:	e8 34 fd ff ff       	call   801017b0 <iupdate>
      ip->valid = 0; // and then set to free
80101a7c:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a83:	e9 43 ff ff ff       	jmp    801019cb <iput+0x2b>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a88:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a8c:	8b 03                	mov    (%ebx),%eax
80101a8e:	89 04 24             	mov    %eax,(%esp)
80101a91:	e8 3a e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a96:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a99:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a9c:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101aa2:	8d 70 5c             	lea    0x5c(%eax),%esi
80101aa5:	89 cf                	mov    %ecx,%edi
80101aa7:	eb 0e                	jmp    80101ab7 <iput+0x117>
80101aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ab0:	83 c6 04             	add    $0x4,%esi
80101ab3:	39 fe                	cmp    %edi,%esi
80101ab5:	74 0f                	je     80101ac6 <iput+0x126>
      if(a[j])
80101ab7:	8b 16                	mov    (%esi),%edx
80101ab9:	85 d2                	test   %edx,%edx
80101abb:	74 f3                	je     80101ab0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101abd:	8b 03                	mov    (%ebx),%eax
80101abf:	e8 bc f9 ff ff       	call   80101480 <bfree>
80101ac4:	eb ea                	jmp    80101ab0 <iput+0x110>
    brelse(bp);
80101ac6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ac9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101acc:	89 04 24             	mov    %eax,(%esp)
80101acf:	e8 0c e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ad4:	8b 03                	mov    (%ebx),%eax
80101ad6:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101adc:	e8 9f f9 ff ff       	call   80101480 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ae1:	31 c0                	xor    %eax,%eax
80101ae3:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101ae9:	e9 71 ff ff ff       	jmp    80101a5f <iput+0xbf>
80101aee:	66 90                	xchg   %ax,%ax

80101af0 <iunlockput>:
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	83 ec 18             	sub    $0x18,%esp
80101af6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101afc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101aff:	85 db                	test   %ebx,%ebx
80101b01:	74 2f                	je     80101b32 <iunlockput+0x42>
80101b03:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b06:	89 34 24             	mov    %esi,(%esp)
80101b09:	e8 e2 2b 00 00       	call   801046f0 <holdingsleep>
80101b0e:	85 c0                	test   %eax,%eax
80101b10:	74 20                	je     80101b32 <iunlockput+0x42>
80101b12:	8b 43 08             	mov    0x8(%ebx),%eax
80101b15:	85 c0                	test   %eax,%eax
80101b17:	7e 19                	jle    80101b32 <iunlockput+0x42>
  releasesleep(&ip->lock);
80101b19:	89 34 24             	mov    %esi,(%esp)
80101b1c:	e8 8f 2b 00 00       	call   801046b0 <releasesleep>
}
80101b21:	8b 75 fc             	mov    -0x4(%ebp),%esi
  iput(ip);
80101b24:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b27:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101b2a:	89 ec                	mov    %ebp,%esp
80101b2c:	5d                   	pop    %ebp
  iput(ip);
80101b2d:	e9 6e fe ff ff       	jmp    801019a0 <iput>
    panic("iunlock");
80101b32:	c7 04 24 1f 79 10 80 	movl   $0x8010791f,(%esp)
80101b39:	e8 12 e8 ff ff       	call   80100350 <panic>
80101b3e:	66 90                	xchg   %ax,%ax

80101b40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	8b 55 08             	mov    0x8(%ebp),%edx
80101b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b49:	8b 0a                	mov    (%edx),%ecx
80101b4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b54:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
80101b58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b5b:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
80101b5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b63:	8b 52 58             	mov    0x58(%edx),%edx
80101b66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b69:	5d                   	pop    %ebp
80101b6a:	c3                   	ret    
80101b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b6f:	90                   	nop

80101b70 <readi>:

// Read data from inode. Arguments: inode to read from, buffer to read into, offset to start reading from, number of bytes to read.
// Caller must hold ip->lock. This function issues read requests to disk if a block is not present in the (LRU) buf cache.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 2c             	sub    $0x2c,%esp
80101b79:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b7c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101b7f:	8b 75 10             	mov    0x10(%ebp),%esi
80101b82:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101b85:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m; // tot is total bytes read so far, m is the number of bytes to read in the current block
  struct buf *bp;

  if(ip->type == T_DEV){
80101b88:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101b8d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b90:	0f 84 ca 00 00 00    	je     80101c60 <readi+0xf0>
      return -1;
    // read from device. Where is the read method initialized? In devsw. Where is devsw initialized? In init.c
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b96:	8b 47 58             	mov    0x58(%edi),%eax
80101b99:	39 f0                	cmp    %esi,%eax
80101b9b:	0f 82 e3 00 00 00    	jb     80101c84 <readi+0x114>
80101ba1:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101ba4:	31 d2                	xor    %edx,%edx
80101ba6:	01 f1                	add    %esi,%ecx
80101ba8:	0f 82 dd 00 00 00    	jb     80101c8b <readi+0x11b>
80101bae:	85 d2                	test   %edx,%edx
80101bb0:	0f 85 ce 00 00 00    	jne    80101c84 <readi+0x114>
    return -1;
  if(off + n > ip->size)
80101bb6:	39 c8                	cmp    %ecx,%eax
80101bb8:	0f 82 92 00 00 00    	jb     80101c50 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bc1:	85 c0                	test   %eax,%eax
80101bc3:	74 79                	je     80101c3e <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE); // bytes which will be read in the current block
80101bc5:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80101bc8:	89 d6                	mov    %edx,%esi
80101bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bd3:	89 f8                	mov    %edi,%eax
80101bd5:	89 da                	mov    %ebx,%edx
80101bd7:	c1 ea 09             	shr    $0x9,%edx
80101bda:	e8 11 f9 ff ff       	call   801014f0 <bmap>
80101bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80101be3:	8b 07                	mov    (%edi),%eax
80101be5:	89 04 24             	mov    %eax,(%esp)
80101be8:	e8 e3 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE); // bytes which will be read in the current block
80101bed:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bf2:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE); // bytes which will be read in the current block
80101bf7:	89 d8                	mov    %ebx,%eax
80101bf9:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bfc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c01:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m); // so read those m bytes, and go to next disk (if tot < n)
80101c03:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE); // bytes which will be read in the current block
80101c07:	29 f3                	sub    %esi,%ebx
80101c09:	39 d9                	cmp    %ebx,%ecx
80101c0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m); // so read those m bytes, and go to next disk (if tot < n)
80101c0e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c12:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m); // so read those m bytes, and go to next disk (if tot < n)
80101c14:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101c17:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c1b:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101c1e:	89 0c 24             	mov    %ecx,(%esp)
80101c21:	e8 8a 2e 00 00       	call   80104ab0 <memmove>
    brelse(bp);
80101c26:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101c29:	89 14 24             	mov    %edx,(%esp)
80101c2c:	e8 af e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c31:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c34:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c37:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c3a:	39 de                	cmp    %ebx,%esi
80101c3c:	72 92                	jb     80101bd0 <readi+0x60>
  }
  return n;
80101c3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c41:	83 c4 2c             	add    $0x2c,%esp
80101c44:	5b                   	pop    %ebx
80101c45:	5e                   	pop    %esi
80101c46:	5f                   	pop    %edi
80101c47:	5d                   	pop    %ebp
80101c48:	c3                   	ret    
80101c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = ip->size - off;
80101c50:	29 f0                	sub    %esi,%eax
80101c52:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c55:	e9 64 ff ff ff       	jmp    80101bbe <readi+0x4e>
80101c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c60:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101c64:	66 83 f8 09          	cmp    $0x9,%ax
80101c68:	77 1a                	ja     80101c84 <readi+0x114>
80101c6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101c71:	85 c0                	test   %eax,%eax
80101c73:	74 0f                	je     80101c84 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101c75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c78:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c7b:	83 c4 2c             	add    $0x2c,%esp
80101c7e:	5b                   	pop    %ebx
80101c7f:	5e                   	pop    %esi
80101c80:	5f                   	pop    %edi
80101c81:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c82:	ff e0                	jmp    *%eax
      return -1;
80101c84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c89:	eb b6                	jmp    80101c41 <readi+0xd1>
80101c8b:	ba 01 00 00 00       	mov    $0x1,%edx
80101c90:	e9 19 ff ff ff       	jmp    80101bae <readi+0x3e>
80101c95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <writei>:

// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	83 ec 2c             	sub    $0x2c,%esp
80101ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cac:	8b 7d 08             	mov    0x8(%ebp),%edi
80101caf:	8b 75 10             	mov    0x10(%ebp),%esi
80101cb2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101cb5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101cb8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101cbd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101cc0:	0f 84 da 00 00 00    	je     80101da0 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cc6:	39 77 58             	cmp    %esi,0x58(%edi)
80101cc9:	0f 82 06 01 00 00    	jb     80101dd5 <writei+0x135>
80101ccf:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101cd2:	31 c0                	xor    %eax,%eax
80101cd4:	01 f2                	add    %esi,%edx
80101cd6:	0f 82 00 01 00 00    	jb     80101ddc <writei+0x13c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cdc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101ce2:	0f 87 ed 00 00 00    	ja     80101dd5 <writei+0x135>
80101ce8:	85 c0                	test   %eax,%eax
80101cea:	0f 85 e5 00 00 00    	jne    80101dd5 <writei+0x135>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cf0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101cf3:	85 c0                	test   %eax,%eax
80101cf5:	0f 84 94 00 00 00    	je     80101d8f <writei+0xef>
80101cfb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE)); // fetch the block where the data is to be written from
    m = min(n - tot, BSIZE - off%BSIZE); // number of bytes to write in the current block
80101d02:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101d05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE)); // fetch the block where the data is to be written from
80101d10:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d13:	89 f8                	mov    %edi,%eax
80101d15:	89 da                	mov    %ebx,%edx
80101d17:	c1 ea 09             	shr    $0x9,%edx
80101d1a:	e8 d1 f7 ff ff       	call   801014f0 <bmap>
80101d1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d23:	8b 07                	mov    (%edi),%eax
80101d25:	89 04 24             	mov    %eax,(%esp)
80101d28:	e8 a3 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE); // number of bytes to write in the current block
80101d2d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d30:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d35:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE)); // fetch the block where the data is to be written from
80101d38:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE); // number of bytes to write in the current block
80101d3a:	89 d8                	mov    %ebx,%eax
80101d3c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101d3f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d44:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m); // write those bytes
80101d46:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE); // number of bytes to write in the current block
80101d4a:	29 d3                	sub    %edx,%ebx
80101d4c:	39 d9                	cmp    %ebx,%ecx
80101d4e:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m); // write those bytes
80101d51:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101d55:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101d58:	89 04 24             	mov    %eax,(%esp)
80101d5b:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d5f:	e8 4c 2d 00 00       	call   80104ab0 <memmove>
    log_write(bp); // add to transaction
80101d64:	89 34 24             	mov    %esi,(%esp)
80101d67:	e8 14 15 00 00       	call   80103280 <log_write>
    brelse(bp);
80101d6c:	89 34 24             	mov    %esi,(%esp)
80101d6f:	e8 6c e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d74:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d77:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d7a:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101d7d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d80:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101d83:	39 d9                	cmp    %ebx,%ecx
80101d85:	72 89                	jb     80101d10 <writei+0x70>
  }

  // update inode size if needed
  if(n > 0 && off > ip->size){
80101d87:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101d8a:	39 77 58             	cmp    %esi,0x58(%edi)
80101d8d:	72 39                	jb     80101dc8 <writei+0x128>
    ip->size = off;
    iupdate(ip); // push change to disk
  }
  return n;
80101d8f:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101d92:	83 c4 2c             	add    $0x2c,%esp
80101d95:	5b                   	pop    %ebx
80101d96:	5e                   	pop    %esi
80101d97:	5f                   	pop    %edi
80101d98:	5d                   	pop    %ebp
80101d99:	c3                   	ret    
80101d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101da0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101da4:	66 83 f8 09          	cmp    $0x9,%ax
80101da8:	77 2b                	ja     80101dd5 <writei+0x135>
80101daa:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101db1:	85 c0                	test   %eax,%eax
80101db3:	74 20                	je     80101dd5 <writei+0x135>
    return devsw[ip->major].write(ip, src, n);
80101db5:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101db8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101dbb:	83 c4 2c             	add    $0x2c,%esp
80101dbe:	5b                   	pop    %ebx
80101dbf:	5e                   	pop    %esi
80101dc0:	5f                   	pop    %edi
80101dc1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101dc2:	ff e0                	jmp    *%eax
80101dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101dc8:	89 77 58             	mov    %esi,0x58(%edi)
    iupdate(ip); // push change to disk
80101dcb:	89 3c 24             	mov    %edi,(%esp)
80101dce:	e8 dd f9 ff ff       	call   801017b0 <iupdate>
80101dd3:	eb ba                	jmp    80101d8f <writei+0xef>
      return -1;
80101dd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dda:	eb b6                	jmp    80101d92 <writei+0xf2>
80101ddc:	b8 01 00 00 00       	mov    $0x1,%eax
80101de1:	e9 f6 fe ff ff       	jmp    80101cdc <writei+0x3c>
80101de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ded:	8d 76 00             	lea    0x0(%esi),%esi

80101df0 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
80101df0:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101df1:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101df6:	89 e5                	mov    %esp,%ebp
80101df8:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101dfb:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e02:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e06:	8b 45 08             	mov    0x8(%ebp),%eax
80101e09:	89 04 24             	mov    %eax,(%esp)
80101e0c:	e8 0f 2d 00 00       	call   80104b20 <strncmp>
}
80101e11:	89 ec                	mov    %ebp,%esp
80101e13:	5d                   	pop    %ebp
80101e14:	c3                   	ret    
80101e15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 2c             	sub    $0x2c,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e31:	0f 85 a4 00 00 00    	jne    80101edb <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e37:	8b 43 58             	mov    0x58(%ebx),%eax
80101e3a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e3d:	31 ff                	xor    %edi,%edi
80101e3f:	85 c0                	test   %eax,%eax
80101e41:	74 59                	je     80101e9c <dirlookup+0x7c>
80101e43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e50:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101e54:	b9 10 00 00 00       	mov    $0x10,%ecx
80101e59:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101e5d:	89 74 24 04          	mov    %esi,0x4(%esp)
80101e61:	89 1c 24             	mov    %ebx,(%esp)
80101e64:	e8 07 fd ff ff       	call   80101b70 <readi>
80101e69:	83 f8 10             	cmp    $0x10,%eax
80101e6c:	75 61                	jne    80101ecf <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101e6e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e73:	74 1f                	je     80101e94 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101e75:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e78:	ba 0e 00 00 00       	mov    $0xe,%edx
80101e7d:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e81:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e85:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e88:	89 04 24             	mov    %eax,(%esp)
80101e8b:	e8 90 2c 00 00       	call   80104b20 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e90:	85 c0                	test   %eax,%eax
80101e92:	74 1c                	je     80101eb0 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e94:	83 c7 10             	add    $0x10,%edi
80101e97:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e9a:	72 b4                	jb     80101e50 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e9c:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101e9f:	31 c0                	xor    %eax,%eax
}
80101ea1:	5b                   	pop    %ebx
80101ea2:	5e                   	pop    %esi
80101ea3:	5f                   	pop    %edi
80101ea4:	5d                   	pop    %ebp
80101ea5:	c3                   	ret    
80101ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ead:	8d 76 00             	lea    0x0(%esi),%esi
      if(poff)
80101eb0:	8b 45 10             	mov    0x10(%ebp),%eax
80101eb3:	85 c0                	test   %eax,%eax
80101eb5:	74 05                	je     80101ebc <dirlookup+0x9c>
        *poff = off;
80101eb7:	8b 45 10             	mov    0x10(%ebp),%eax
80101eba:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ebc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101ec0:	8b 03                	mov    (%ebx),%eax
80101ec2:	e8 c9 f4 ff ff       	call   80101390 <iget>
}
80101ec7:	83 c4 2c             	add    $0x2c,%esp
80101eca:	5b                   	pop    %ebx
80101ecb:	5e                   	pop    %esi
80101ecc:	5f                   	pop    %edi
80101ecd:	5d                   	pop    %ebp
80101ece:	c3                   	ret    
      panic("dirlookup read");
80101ecf:	c7 04 24 39 79 10 80 	movl   $0x80107939,(%esp)
80101ed6:	e8 75 e4 ff ff       	call   80100350 <panic>
    panic("dirlookup not DIR");
80101edb:	c7 04 24 27 79 10 80 	movl   $0x80107927,(%esp)
80101ee2:	e8 69 e4 ff ff       	call   80100350 <panic>
80101ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eee:	66 90                	xchg   %ax,%ax

80101ef0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
80101ef6:	89 c3                	mov    %eax,%ebx
80101ef8:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  // is it absolute or relative path
  if(*path == '/')
80101efb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101efe:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f01:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101f04:	0f 84 68 01 00 00    	je     80102072 <namex+0x182>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f0a:	e8 b1 1d 00 00       	call   80103cc0 <myproc>
80101f0f:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101f12:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101f19:	e8 22 2a 00 00       	call   80104940 <acquire>
  ip->ref++;
80101f1e:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101f21:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101f28:	e8 a3 29 00 00       	call   801048d0 <release>
  return ip;
80101f2d:	eb 02                	jmp    80101f31 <namex+0x41>
80101f2f:	90                   	nop
    path++;
80101f30:	43                   	inc    %ebx
  while(*path == '/')
80101f31:	0f b6 03             	movzbl (%ebx),%eax
80101f34:	3c 2f                	cmp    $0x2f,%al
80101f36:	74 f8                	je     80101f30 <namex+0x40>
  if(*path == 0)
80101f38:	84 c0                	test   %al,%al
80101f3a:	0f 84 18 01 00 00    	je     80102058 <namex+0x168>
  while(*path != '/' && *path != 0)
80101f40:	0f b6 03             	movzbl (%ebx),%eax
80101f43:	84 c0                	test   %al,%al
80101f45:	0f 84 1e 01 00 00    	je     80102069 <namex+0x179>
80101f4b:	3c 2f                	cmp    $0x2f,%al
80101f4d:	89 df                	mov    %ebx,%edi
80101f4f:	0f 84 14 01 00 00    	je     80102069 <namex+0x179>
80101f55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f60:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f64:	47                   	inc    %edi
  while(*path != '/' && *path != 0)
80101f65:	3c 2f                	cmp    $0x2f,%al
80101f67:	74 04                	je     80101f6d <namex+0x7d>
80101f69:	84 c0                	test   %al,%al
80101f6b:	75 f3                	jne    80101f60 <namex+0x70>
  len = path - s;
80101f6d:	89 f8                	mov    %edi,%eax
80101f6f:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f71:	83 f8 0d             	cmp    $0xd,%eax
80101f74:	0f 8e ae 00 00 00    	jle    80102028 <namex+0x138>
    memmove(name, s, DIRSIZ); // truncate name if too long
80101f7a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101f7e:	b8 0e 00 00 00       	mov    $0xe,%eax
    path++;
80101f83:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ); // truncate name if too long
80101f85:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f8c:	89 04 24             	mov    %eax,(%esp)
80101f8f:	e8 1c 2b 00 00       	call   80104ab0 <memmove>
  while(*path == '/')
80101f94:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f97:	75 0d                	jne    80101fa6 <namex+0xb6>
80101f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101fa0:	43                   	inc    %ebx
  while(*path == '/')
80101fa1:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101fa4:	74 fa                	je     80101fa0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){ // go one by one down the directory tree
    ilock(ip);
80101fa6:	89 34 24             	mov    %esi,(%esp)
80101fa9:	e8 c2 f8 ff ff       	call   80101870 <ilock>
    if(ip->type != T_DIR){
80101fae:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101fb3:	0f 85 01 01 00 00    	jne    801020ba <namex+0x1ca>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101fb9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fbc:	85 c0                	test   %eax,%eax
80101fbe:	74 09                	je     80101fc9 <namex+0xd9>
80101fc0:	80 3b 00             	cmpb   $0x0,(%ebx)
80101fc3:	0f 84 1b 01 00 00    	je     801020e4 <namex+0x1f4>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101fc9:	31 ff                	xor    %edi,%edi
80101fcb:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101fcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fd2:	89 34 24             	mov    %esi,(%esp)
80101fd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fd9:	e8 42 fe ff ff       	call   80101e20 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fde:	8d 56 0c             	lea    0xc(%esi),%edx
80101fe1:	89 14 24             	mov    %edx,(%esp)
    if((next = dirlookup(ip, name, 0)) == 0){
80101fe4:	85 c0                	test   %eax,%eax
80101fe6:	89 c7                	mov    %eax,%edi
80101fe8:	0f 84 9a 00 00 00    	je     80102088 <namex+0x198>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fee:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ff1:	e8 fa 26 00 00       	call   801046f0 <holdingsleep>
80101ff6:	85 c0                	test   %eax,%eax
80101ff8:	0f 84 0e 01 00 00    	je     8010210c <namex+0x21c>
80101ffe:	8b 4e 08             	mov    0x8(%esi),%ecx
80102001:	85 c9                	test   %ecx,%ecx
80102003:	0f 8e 03 01 00 00    	jle    8010210c <namex+0x21c>
  releasesleep(&ip->lock);
80102009:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010200c:	89 14 24             	mov    %edx,(%esp)
8010200f:	e8 9c 26 00 00       	call   801046b0 <releasesleep>
  iput(ip);
80102014:	89 34 24             	mov    %esi,(%esp)
80102017:	89 fe                	mov    %edi,%esi
80102019:	e8 82 f9 ff ff       	call   801019a0 <iput>
  while(*path == '/')
8010201e:	e9 0e ff ff ff       	jmp    80101f31 <namex+0x41>
80102023:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102027:	90                   	nop
    name[len] = 0; // nulterminate. Why not just use strncpy?
80102028:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010202b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010202e:	89 55 e0             	mov    %edx,-0x20(%ebp)
    memmove(name, s, len);
80102031:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0; // nulterminate. Why not just use strncpy?
80102035:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102037:	89 44 24 08          	mov    %eax,0x8(%esp)
8010203b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010203e:	89 04 24             	mov    %eax,(%esp)
80102041:	e8 6a 2a 00 00       	call   80104ab0 <memmove>
    name[len] = 0; // nulterminate. Why not just use strncpy?
80102046:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102049:	c6 02 00             	movb   $0x0,(%edx)
8010204c:	e9 43 ff ff ff       	jmp    80101f94 <namex+0xa4>
80102051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip); // free this reference to ip, we move on to another ip.
    ip = next; // update ip to the next inode in the tree
  }
  if(nameiparent){
80102058:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010205b:	85 d2                	test   %edx,%edx
8010205d:	75 47                	jne    801020a6 <namex+0x1b6>
    iput(ip);
    return 0;
  }
  return ip; // note that the returned ip is not locked, but has incremented ref count of inode
}
8010205f:	83 c4 2c             	add    $0x2c,%esp
80102062:	89 f0                	mov    %esi,%eax
80102064:	5b                   	pop    %ebx
80102065:	5e                   	pop    %esi
80102066:	5f                   	pop    %edi
80102067:	5d                   	pop    %ebp
80102068:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102069:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010206c:	89 df                	mov    %ebx,%edi
8010206e:	31 c0                	xor    %eax,%eax
80102070:	eb bc                	jmp    8010202e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80102072:	ba 01 00 00 00       	mov    $0x1,%edx
80102077:	b8 01 00 00 00       	mov    $0x1,%eax
8010207c:	e8 0f f3 ff ff       	call   80101390 <iget>
80102081:	89 c6                	mov    %eax,%esi
80102083:	e9 a9 fe ff ff       	jmp    80101f31 <namex+0x41>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102088:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010208b:	e8 60 26 00 00       	call   801046f0 <holdingsleep>
80102090:	85 c0                	test   %eax,%eax
80102092:	74 78                	je     8010210c <namex+0x21c>
80102094:	8b 5e 08             	mov    0x8(%esi),%ebx
80102097:	85 db                	test   %ebx,%ebx
80102099:	7e 71                	jle    8010210c <namex+0x21c>
  releasesleep(&ip->lock);
8010209b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010209e:	89 14 24             	mov    %edx,(%esp)
801020a1:	e8 0a 26 00 00       	call   801046b0 <releasesleep>
  iput(ip);
801020a6:	89 34 24             	mov    %esi,(%esp)
      return 0;
801020a9:	31 f6                	xor    %esi,%esi
  iput(ip);
801020ab:	e8 f0 f8 ff ff       	call   801019a0 <iput>
}
801020b0:	83 c4 2c             	add    $0x2c,%esp
801020b3:	89 f0                	mov    %esi,%eax
801020b5:	5b                   	pop    %ebx
801020b6:	5e                   	pop    %esi
801020b7:	5f                   	pop    %edi
801020b8:	5d                   	pop    %ebp
801020b9:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020ba:	8d 5e 0c             	lea    0xc(%esi),%ebx
801020bd:	89 1c 24             	mov    %ebx,(%esp)
801020c0:	e8 2b 26 00 00       	call   801046f0 <holdingsleep>
801020c5:	85 c0                	test   %eax,%eax
801020c7:	74 43                	je     8010210c <namex+0x21c>
801020c9:	8b 46 08             	mov    0x8(%esi),%eax
801020cc:	85 c0                	test   %eax,%eax
801020ce:	7e 3c                	jle    8010210c <namex+0x21c>
  releasesleep(&ip->lock);
801020d0:	89 1c 24             	mov    %ebx,(%esp)
801020d3:	e8 d8 25 00 00       	call   801046b0 <releasesleep>
  iput(ip);
801020d8:	89 34 24             	mov    %esi,(%esp)
      return 0;
801020db:	31 f6                	xor    %esi,%esi
  iput(ip);
801020dd:	e8 be f8 ff ff       	call   801019a0 <iput>
      return 0;
801020e2:	eb cc                	jmp    801020b0 <namex+0x1c0>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020e4:	8d 5e 0c             	lea    0xc(%esi),%ebx
801020e7:	89 1c 24             	mov    %ebx,(%esp)
801020ea:	e8 01 26 00 00       	call   801046f0 <holdingsleep>
801020ef:	85 c0                	test   %eax,%eax
801020f1:	74 19                	je     8010210c <namex+0x21c>
801020f3:	8b 46 08             	mov    0x8(%esi),%eax
801020f6:	85 c0                	test   %eax,%eax
801020f8:	7e 12                	jle    8010210c <namex+0x21c>
  releasesleep(&ip->lock);
801020fa:	89 1c 24             	mov    %ebx,(%esp)
801020fd:	e8 ae 25 00 00       	call   801046b0 <releasesleep>
}
80102102:	83 c4 2c             	add    $0x2c,%esp
80102105:	89 f0                	mov    %esi,%eax
80102107:	5b                   	pop    %ebx
80102108:	5e                   	pop    %esi
80102109:	5f                   	pop    %edi
8010210a:	5d                   	pop    %ebp
8010210b:	c3                   	ret    
    panic("iunlock");
8010210c:	c7 04 24 1f 79 10 80 	movl   $0x8010791f,(%esp)
80102113:	e8 38 e2 ff ff       	call   80100350 <panic>
80102118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010211f:	90                   	nop

80102120 <dirlink>:
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	57                   	push   %edi
80102124:	56                   	push   %esi
80102125:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102126:	31 db                	xor    %ebx,%ebx
{
80102128:	83 ec 2c             	sub    $0x2c,%esp
8010212b:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
8010212e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102132:	8b 45 0c             	mov    0xc(%ebp),%eax
80102135:	89 3c 24             	mov    %edi,(%esp)
80102138:	89 44 24 04          	mov    %eax,0x4(%esp)
8010213c:	e8 df fc ff ff       	call   80101e20 <dirlookup>
80102141:	85 c0                	test   %eax,%eax
80102143:	0f 85 8e 00 00 00    	jne    801021d7 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102149:	8b 5f 58             	mov    0x58(%edi),%ebx
8010214c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010214f:	85 db                	test   %ebx,%ebx
80102151:	74 3a                	je     8010218d <dirlink+0x6d>
80102153:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102156:	31 db                	xor    %ebx,%ebx
80102158:	eb 0e                	jmp    80102168 <dirlink+0x48>
8010215a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102160:	83 c3 10             	add    $0x10,%ebx
80102163:	3b 5f 58             	cmp    0x58(%edi),%ebx
80102166:	73 25                	jae    8010218d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102168:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010216c:	b9 10 00 00 00       	mov    $0x10,%ecx
80102171:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80102175:	89 74 24 04          	mov    %esi,0x4(%esp)
80102179:	89 3c 24             	mov    %edi,(%esp)
8010217c:	e8 ef f9 ff ff       	call   80101b70 <readi>
80102181:	83 f8 10             	cmp    $0x10,%eax
80102184:	75 60                	jne    801021e6 <dirlink+0xc6>
    if(de.inum == 0)
80102186:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010218b:	75 d3                	jne    80102160 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
8010218d:	b8 0e 00 00 00       	mov    $0xe,%eax
80102192:	89 44 24 08          	mov    %eax,0x8(%esp)
80102196:	8b 45 0c             	mov    0xc(%ebp),%eax
80102199:	89 44 24 04          	mov    %eax,0x4(%esp)
8010219d:	8d 45 da             	lea    -0x26(%ebp),%eax
801021a0:	89 04 24             	mov    %eax,(%esp)
801021a3:	e8 b8 29 00 00       	call   80104b60 <strncpy>
  de.inum = inum;
801021a8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021ab:	ba 10 00 00 00       	mov    $0x10,%edx
  de.inum = inum;
801021b0:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021b4:	89 54 24 0c          	mov    %edx,0xc(%esp)
801021b8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801021bc:	89 74 24 04          	mov    %esi,0x4(%esp)
801021c0:	89 3c 24             	mov    %edi,(%esp)
801021c3:	e8 d8 fa ff ff       	call   80101ca0 <writei>
801021c8:	83 f8 10             	cmp    $0x10,%eax
801021cb:	75 25                	jne    801021f2 <dirlink+0xd2>
  return 0;
801021cd:	31 c0                	xor    %eax,%eax
}
801021cf:	83 c4 2c             	add    $0x2c,%esp
801021d2:	5b                   	pop    %ebx
801021d3:	5e                   	pop    %esi
801021d4:	5f                   	pop    %edi
801021d5:	5d                   	pop    %ebp
801021d6:	c3                   	ret    
    iput(ip);
801021d7:	89 04 24             	mov    %eax,(%esp)
801021da:	e8 c1 f7 ff ff       	call   801019a0 <iput>
    return -1;
801021df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021e4:	eb e9                	jmp    801021cf <dirlink+0xaf>
      panic("dirlink read");
801021e6:	c7 04 24 48 79 10 80 	movl   $0x80107948,(%esp)
801021ed:	e8 5e e1 ff ff       	call   80100350 <panic>
    panic("dirlink");
801021f2:	c7 04 24 e2 7f 10 80 	movl   $0x80107fe2,(%esp)
801021f9:	e8 52 e1 ff ff       	call   80100350 <panic>
801021fe:	66 90                	xchg   %ax,%ax

80102200 <namei>:

struct inode*
namei(char *path)
{
80102200:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102201:	31 d2                	xor    %edx,%edx
{
80102203:	89 e5                	mov    %esp,%ebp
80102205:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102208:	8b 45 08             	mov    0x8(%ebp),%eax
8010220b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010220e:	e8 dd fc ff ff       	call   80101ef0 <namex>
}
80102213:	89 ec                	mov    %ebp,%esp
80102215:	5d                   	pop    %ebp
80102216:	c3                   	ret    
80102217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010221e:	66 90                	xchg   %ax,%ax

80102220 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102220:	55                   	push   %ebp
  return namex(path, 1, name);
80102221:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102226:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102228:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010222b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010222e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010222f:	e9 bc fc ff ff       	jmp    80101ef0 <namex>
80102234:	66 90                	xchg   %ax,%ax
80102236:	66 90                	xchg   %ax,%ax
80102238:	66 90                	xchg   %ax,%ax
8010223a:	66 90                	xchg   %ax,%ax
8010223c:	66 90                	xchg   %ax,%ax
8010223e:	66 90                	xchg   %ax,%ax

80102240 <idestart>:
}

// Start the request for b. Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	56                   	push   %esi
80102244:	53                   	push   %ebx
80102245:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80102248:	85 c0                	test   %eax,%eax
8010224a:	0f 84 a8 00 00 00    	je     801022f8 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102250:	8b 48 08             	mov    0x8(%eax),%ecx
80102253:	89 c6                	mov    %eax,%esi
80102255:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010225b:	0f 87 8b 00 00 00    	ja     801022ec <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102261:	bb f7 01 00 00       	mov    $0x1f7,%ebx
80102266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010226d:	8d 76 00             	lea    0x0(%esi),%esi
80102270:	89 da                	mov    %ebx,%edx
80102272:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102273:	24 c0                	and    $0xc0,%al
80102275:	3c 40                	cmp    $0x40,%al
80102277:	75 f7                	jne    80102270 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102279:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010227e:	31 c0                	xor    %eax,%eax
80102280:	ee                   	out    %al,(%dx)
80102281:	b0 01                	mov    $0x1,%al
80102283:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102288:	ee                   	out    %al,(%dx)
80102289:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010228e:	88 c8                	mov    %cl,%al
80102290:	ee                   	out    %al,(%dx)

  // interact with disk (PIO so in and out instructions), setting up registers for request b.
  outb(0x3f6, 0);  // enable interrupts
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff); // low byte of LBA = sector number
  outb(0x1f4, (sector >> 8) & 0xff);
80102291:	c1 f9 08             	sar    $0x8,%ecx
80102294:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102299:	89 c8                	mov    %ecx,%eax
8010229b:	ee                   	out    %al,(%dx)
8010229c:	ba f5 01 00 00       	mov    $0x1f5,%edx
801022a1:	31 c0                	xor    %eax,%eax
801022a3:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801022a4:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801022a8:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022ad:	c0 e0 04             	shl    $0x4,%al
801022b0:	24 10                	and    $0x10,%al
801022b2:	0c e0                	or     $0xe0,%al
801022b4:	ee                   	out    %al,(%dx)

  // if this is a write
  if(b->flags & B_DIRTY){
801022b5:	f6 06 04             	testb  $0x4,(%esi)
801022b8:	75 16                	jne    801022d0 <idestart+0x90>
801022ba:	b0 20                	mov    $0x20,%al
801022bc:	89 da                	mov    %ebx,%edx
801022be:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4); // put data to be written in the data port as a string of 4B values - so BSIZE/4 values, which can be found at address b->data in memory
  } else {
    outb(0x1f7, read_cmd); // simply read sector (or sectors). The data will be available at the data port.
  }
}
801022bf:	83 c4 10             	add    $0x10,%esp
801022c2:	5b                   	pop    %ebx
801022c3:	5e                   	pop    %esi
801022c4:	5d                   	pop    %ebp
801022c5:	c3                   	ret    
801022c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022cd:	8d 76 00             	lea    0x0(%esi),%esi
801022d0:	b0 30                	mov    $0x30,%al
801022d2:	89 da                	mov    %ebx,%edx
801022d4:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022d5:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4); // put data to be written in the data port as a string of 4B values - so BSIZE/4 values, which can be found at address b->data in memory
801022da:	83 c6 5c             	add    $0x5c,%esi
801022dd:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022e2:	fc                   	cld    
801022e3:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801022e5:	83 c4 10             	add    $0x10,%esp
801022e8:	5b                   	pop    %ebx
801022e9:	5e                   	pop    %esi
801022ea:	5d                   	pop    %ebp
801022eb:	c3                   	ret    
    panic("incorrect blockno");
801022ec:	c7 04 24 0f 7a 10 80 	movl   $0x80107a0f,(%esp)
801022f3:	e8 58 e0 ff ff       	call   80100350 <panic>
    panic("idestart");
801022f8:	c7 04 24 06 7a 10 80 	movl   $0x80107a06,(%esp)
801022ff:	e8 4c e0 ff ff       	call   80100350 <panic>
80102304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010230b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010230f:	90                   	nop

80102310 <ideinit>:
{
80102310:	55                   	push   %ebp
  initlock(&idelock, "ide"); // set up spinlock for the queue
80102311:	ba 21 7a 10 80       	mov    $0x80107a21,%edx
{
80102316:	89 e5                	mov    %esp,%ebp
80102318:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide"); // set up spinlock for the queue
8010231b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010231f:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
80102326:	e8 25 24 00 00       	call   80104750 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1); // enable interrupts from the disk as interrupt number IRQ_IDE
8010232b:	a1 84 a7 14 80       	mov    0x8014a784,%eax
80102330:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102337:	48                   	dec    %eax
80102338:	89 44 24 04          	mov    %eax,0x4(%esp)
8010233c:	e8 9f 02 00 00       	call   801025e0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102341:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010234d:	8d 76 00             	lea    0x0(%esi),%esi
80102350:	89 ca                	mov    %ecx,%edx
80102352:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102353:	24 c0                	and    $0xc0,%al
80102355:	3c 40                	cmp    $0x40,%al
80102357:	75 f7                	jne    80102350 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102359:	b0 f0                	mov    $0xf0,%al
8010235b:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102360:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102361:	89 ca                	mov    %ecx,%edx
80102363:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){ // if the disk is present, inb(0x1f7) will return a non-zero value
80102364:	84 c0                	test   %al,%al
80102366:	75 20                	jne    80102388 <ideinit+0x78>
80102368:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
8010236d:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102380:	49                   	dec    %ecx
80102381:	74 0f                	je     80102392 <ideinit+0x82>
80102383:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){ // if the disk is present, inb(0x1f7) will return a non-zero value
80102384:	84 c0                	test   %al,%al
80102386:	74 f8                	je     80102380 <ideinit+0x70>
      havedisk1 = 1;
80102388:	b8 01 00 00 00       	mov    $0x1,%eax
8010238d:	a3 e0 25 11 80       	mov    %eax,0x801125e0
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102392:	b0 e0                	mov    $0xe0,%al
80102394:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102399:	ee                   	out    %al,(%dx)
}
8010239a:	89 ec                	mov    %ebp,%esp
8010239c:	5d                   	pop    %ebp
8010239d:	c3                   	ret    
8010239e:	66 90                	xchg   %ax,%ax

801023a0 <ideintr>:

// Interrupt handler. called in trap.c when IRQ_IDE is triggered.
void
ideintr(void)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	57                   	push   %edi
801023a4:	56                   	push   %esi
801023a5:	53                   	push   %ebx
801023a6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801023a9:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
801023b0:	e8 8b 25 00 00       	call   80104940 <acquire>

  // nothing to do, say ok and return
  if((b = idequeue) == 0){
801023b5:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
801023bb:	85 db                	test   %ebx,%ebx
801023bd:	74 60                	je     8010241f <ideintr+0x7f>
    release(&idelock);
    return;
  }
  // update the queue, the current request is done (current request is still at b btw)
  idequeue = b->qnext;
801023bf:	8b 43 58             	mov    0x58(%ebx),%eax
801023c2:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0) // if the request is a read, and there are no errors
801023c7:	8b 33                	mov    (%ebx),%esi
801023c9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801023cf:	75 30                	jne    80102401 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023d1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023dd:	8d 76 00             	lea    0x0(%esi),%esi
801023e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023e1:	88 c1                	mov    %al,%cl
801023e3:	80 e1 c0             	and    $0xc0,%cl
801023e6:	80 f9 40             	cmp    $0x40,%cl
801023e9:	75 f5                	jne    801023e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801023eb:	a8 21                	test   $0x21,%al
801023ed:	75 12                	jne    80102401 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4); // read from data port into b->data
801023ef:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023f2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023f7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023fc:	fc                   	cld    
801023fd:	f3 6d                	rep insl (%dx),%es:(%edi)

  b->flags |= B_VALID; // set the valid flag
801023ff:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY; // not dirty yet
80102401:	83 e6 fb             	and    $0xfffffffb,%esi
80102404:	83 ce 02             	or     $0x2,%esi
80102407:	89 33                	mov    %esi,(%ebx)

  // Wake process waiting for this buf.
  wakeup(b);
80102409:	89 1c 24             	mov    %ebx,(%esp)
8010240c:	e8 3f 20 00 00       	call   80104450 <wakeup>

  // Start disk on next buf in queue if job exists. Cool.
  if(idequeue != 0)
80102411:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102416:	85 c0                	test   %eax,%eax
80102418:	74 05                	je     8010241f <ideintr+0x7f>
    idestart(idequeue);
8010241a:	e8 21 fe ff ff       	call   80102240 <idestart>
    release(&idelock);
8010241f:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
80102426:	e8 a5 24 00 00       	call   801048d0 <release>

  release(&idelock);
}
8010242b:	83 c4 1c             	add    $0x1c,%esp
8010242e:	5b                   	pop    %ebx
8010242f:	5e                   	pop    %esi
80102430:	5f                   	pop    %edi
80102431:	5d                   	pop    %ebp
80102432:	c3                   	ret    
80102433:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102440 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	83 ec 18             	sub    $0x18,%esp
80102446:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80102449:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010244c:	8d 43 0c             	lea    0xc(%ebx),%eax
8010244f:	89 04 24             	mov    %eax,(%esp)
80102452:	e8 99 22 00 00       	call   801046f0 <holdingsleep>
80102457:	85 c0                	test   %eax,%eax
80102459:	0f 84 c0 00 00 00    	je     8010251f <iderw+0xdf>
    panic("iderw: buf not locked");
  // if valid and not dirty, we have nothing to sync at all
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010245f:	8b 03                	mov    (%ebx),%eax
80102461:	83 e0 06             	and    $0x6,%eax
80102464:	83 f8 02             	cmp    $0x2,%eax
80102467:	0f 84 a6 00 00 00    	je     80102513 <iderw+0xd3>
    panic("iderw: nothing to do");
  // can't sync with nonexistent disk
  if(b->dev != 0 && !havedisk1)
8010246d:	8b 4b 04             	mov    0x4(%ebx),%ecx
80102470:	85 c9                	test   %ecx,%ecx
80102472:	74 0e                	je     80102482 <iderw+0x42>
80102474:	8b 15 e0 25 11 80    	mov    0x801125e0,%edx
8010247a:	85 d2                	test   %edx,%edx
8010247c:	0f 84 85 00 00 00    	je     80102507 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102482:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
80102489:	e8 b2 24 00 00       	call   80104940 <acquire>

  // Append b to idequeue at the end
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010248e:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102493:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010249a:	85 c0                	test   %eax,%eax
8010249c:	74 62                	je     80102500 <iderw+0xc0>
8010249e:	66 90                	xchg   %ax,%ax
801024a0:	89 c2                	mov    %eax,%edx
801024a2:	8b 40 58             	mov    0x58(%eax),%eax
801024a5:	85 c0                	test   %eax,%eax
801024a7:	75 f7                	jne    801024a0 <iderw+0x60>
801024a9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801024ac:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary (queue was empty, we had nothing to do, now we do).
  if(idequeue == b)
801024ae:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
801024b4:	75 1b                	jne    801024d1 <iderw+0x91>
801024b6:	eb 38                	jmp    801024f0 <iderw+0xb0>
801024b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024bf:	90                   	nop
    idestart(b);

  // Wait for request to finish (not spin but sleep).
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
801024c0:	89 1c 24             	mov    %ebx,(%esp)
801024c3:	b8 00 26 11 80       	mov    $0x80112600,%eax
801024c8:	89 44 24 04          	mov    %eax,0x4(%esp)
801024cc:	e8 af 1e 00 00       	call   80104380 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024d1:	8b 03                	mov    (%ebx),%eax
801024d3:	83 e0 06             	and    $0x6,%eax
801024d6:	83 f8 02             	cmp    $0x2,%eax
801024d9:	75 e5                	jne    801024c0 <iderw+0x80>
  }

  release(&idelock);
801024db:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
801024e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e5:	89 ec                	mov    %ebp,%esp
801024e7:	5d                   	pop    %ebp
  release(&idelock);
801024e8:	e9 e3 23 00 00       	jmp    801048d0 <release>
801024ed:	8d 76 00             	lea    0x0(%esi),%esi
    idestart(b);
801024f0:	89 d8                	mov    %ebx,%eax
801024f2:	e8 49 fd ff ff       	call   80102240 <idestart>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024f7:	eb d8                	jmp    801024d1 <iderw+0x91>
801024f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102500:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102505:	eb a5                	jmp    801024ac <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102507:	c7 04 24 50 7a 10 80 	movl   $0x80107a50,(%esp)
8010250e:	e8 3d de ff ff       	call   80100350 <panic>
    panic("iderw: nothing to do");
80102513:	c7 04 24 3b 7a 10 80 	movl   $0x80107a3b,(%esp)
8010251a:	e8 31 de ff ff       	call   80100350 <panic>
    panic("iderw: buf not locked");
8010251f:	c7 04 24 25 7a 10 80 	movl   $0x80107a25,(%esp)
80102526:	e8 25 de ff ff       	call   80100350 <panic>
8010252b:	66 90                	xchg   %ax,%ax
8010252d:	66 90                	xchg   %ax,%ax
8010252f:	90                   	nop

80102530 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102530:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102531:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
80102536:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102538:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010253d:	56                   	push   %esi
8010253e:	53                   	push   %ebx
8010253f:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
80102542:	a3 34 26 11 80       	mov    %eax,0x80112634
  ioapic->reg = reg;
80102547:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010254d:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102553:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
80102556:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010255c:	0f b6 15 80 a7 14 80 	movzbl 0x8014a780,%edx
  return ioapic->data;
80102563:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102569:	c1 e8 10             	shr    $0x10,%eax
8010256c:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010256f:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102572:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102575:	39 c2                	cmp    %eax,%edx
80102577:	74 12                	je     8010258b <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102579:	c7 04 24 70 7a 10 80 	movl   $0x80107a70,(%esp)
80102580:	e8 fb e0 ff ff       	call   80100680 <cprintf>
  ioapic->reg = reg;
80102585:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
{
8010258b:	ba 10 00 00 00       	mov    $0x10,%edx
80102590:	31 c0                	xor    %eax,%eax
80102592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801025a0:	89 13                	mov    %edx,(%ebx)
801025a2:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801025a5:	40                   	inc    %eax
  ioapic->data = data;
801025a6:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
801025ac:	81 c9 00 00 01 00    	or     $0x10000,%ecx
801025b2:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801025b5:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801025b8:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801025bb:	89 0b                	mov    %ecx,(%ebx)
  for(i = 0; i <= maxintr; i++){
801025bd:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
801025bf:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
801025c5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801025cc:	7d d2                	jge    801025a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025ce:	83 c4 10             	add    $0x10,%esp
801025d1:	5b                   	pop    %ebx
801025d2:	5e                   	pop    %esi
801025d3:	5d                   	pop    %ebp
801025d4:	c3                   	ret    
801025d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025e0:	55                   	push   %ebp
  ioapic->reg = reg;
801025e1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801025e7:	89 e5                	mov    %esp,%ebp
801025e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025ec:	8d 50 20             	lea    0x20(%eax),%edx
801025ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801025f3:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025f5:	40                   	inc    %eax
  ioapic->data = data;
801025f6:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801025fc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102602:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102604:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102609:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010260c:	89 50 10             	mov    %edx,0x10(%eax)
}
8010260f:	5d                   	pop    %ebp
80102610:	c3                   	ret    
80102611:	66 90                	xchg   %ax,%ax
80102613:	66 90                	xchg   %ax,%ax
80102615:	66 90                	xchg   %ax,%ax
80102617:	66 90                	xchg   %ax,%ax
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <getNumFreePages>:
int refs_count[PHYSTOP/PGSIZE];

int getNumFreePages(void)
{
  return kmem.numFreePages;
}
80102620:	a1 7c a6 14 80       	mov    0x8014a67c,%eax
80102625:	c3                   	ret    
80102626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010262d:	8d 76 00             	lea    0x0(%esi),%esi

80102630 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx
80102635:	83 ec 10             	sub    $0x10,%esp
80102638:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010263b:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102641:	0f 85 c2 00 00 00    	jne    80102709 <kfree+0xd9>
80102647:	81 fb d0 e4 14 80    	cmp    $0x8014e4d0,%ebx
8010264d:	0f 82 b6 00 00 00    	jb     80102709 <kfree+0xd9>
80102653:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102659:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010265e:	0f 87 a5 00 00 00    	ja     80102709 <kfree+0xd9>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  // we will have to andle the edge when 2 or more threrads call kfree at the same time, nothing equality exact with threads
  
  if(kmem.use_lock)
80102664:	a1 74 a6 14 80       	mov    0x8014a674,%eax
80102669:	85 c0                	test   %eax,%eax
8010266b:	0f 85 87 00 00 00    	jne    801026f8 <kfree+0xc8>
    acquire(&kmem.lock);

  if (refs_count[(uint)v/PGSIZE]<=1)
80102671:	89 de                	mov    %ebx,%esi
80102673:	c1 ee 0c             	shr    $0xc,%esi
80102676:	8b 04 b5 40 26 11 80 	mov    -0x7feed9c0(,%esi,4),%eax
8010267d:	83 f8 01             	cmp    $0x1,%eax
80102680:	7e 1e                	jle    801026a0 <kfree+0x70>
    kmem.freelist = r;
    kmem.numFreePages++;
  }
  else
  {
    refs_count[(uint)v/PGSIZE]-=1;
80102682:	48                   	dec    %eax
80102683:	89 04 b5 40 26 11 80 	mov    %eax,-0x7feed9c0(,%esi,4)
  }
  if(kmem.use_lock)
8010268a:	a1 74 a6 14 80       	mov    0x8014a674,%eax
8010268f:	85 c0                	test   %eax,%eax
80102691:	75 50                	jne    801026e3 <kfree+0xb3>
    release(&kmem.lock);
}
80102693:	83 c4 10             	add    $0x10,%esp
80102696:	5b                   	pop    %ebx
80102697:	5e                   	pop    %esi
80102698:	5d                   	pop    %ebp
80102699:	c3                   	ret    
8010269a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (refs_count[(uint)v/PGSIZE]==0) panic("kfree2");
801026a0:	85 c0                	test   %eax,%eax
801026a2:	74 71                	je     80102715 <kfree+0xe5>
    memset(v, 1, PGSIZE);
801026a4:	89 1c 24             	mov    %ebx,(%esp)
801026a7:	ba 00 10 00 00       	mov    $0x1000,%edx
801026ac:	b9 01 00 00 00       	mov    $0x1,%ecx
801026b1:	89 54 24 08          	mov    %edx,0x8(%esp)
801026b5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801026b9:	e8 62 23 00 00       	call   80104a20 <memset>
    refs_count[(uint)v/PGSIZE]=0;
801026be:	31 c0                	xor    %eax,%eax
801026c0:	89 04 b5 40 26 11 80 	mov    %eax,-0x7feed9c0(,%esi,4)
    r->next = kmem.freelist;
801026c7:	a1 78 a6 14 80       	mov    0x8014a678,%eax
801026cc:	89 03                	mov    %eax,(%ebx)
    kmem.freelist = r;
801026ce:	89 1d 78 a6 14 80    	mov    %ebx,0x8014a678
  if(kmem.use_lock)
801026d4:	a1 74 a6 14 80       	mov    0x8014a674,%eax
    kmem.numFreePages++;
801026d9:	ff 05 7c a6 14 80    	incl   0x8014a67c
  if(kmem.use_lock)
801026df:	85 c0                	test   %eax,%eax
801026e1:	74 b0                	je     80102693 <kfree+0x63>
    release(&kmem.lock);
801026e3:	c7 45 08 40 a6 14 80 	movl   $0x8014a640,0x8(%ebp)
}
801026ea:	83 c4 10             	add    $0x10,%esp
801026ed:	5b                   	pop    %ebx
801026ee:	5e                   	pop    %esi
801026ef:	5d                   	pop    %ebp
    release(&kmem.lock);
801026f0:	e9 db 21 00 00       	jmp    801048d0 <release>
801026f5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801026f8:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
801026ff:	e8 3c 22 00 00       	call   80104940 <acquire>
80102704:	e9 68 ff ff ff       	jmp    80102671 <kfree+0x41>
    panic("kfree");
80102709:	c7 04 24 a2 7a 10 80 	movl   $0x80107aa2,(%esp)
80102710:	e8 3b dc ff ff       	call   80100350 <panic>
    if (refs_count[(uint)v/PGSIZE]==0) panic("kfree2");
80102715:	c7 04 24 a8 7a 10 80 	movl   $0x80107aa8,(%esp)
8010271c:	e8 2f dc ff ff       	call   80100350 <panic>
80102721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272f:	90                   	nop

80102730 <freerange>:
{
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	57                   	push   %edi
80102734:	56                   	push   %esi
80102735:	53                   	push   %ebx
80102736:	83 ec 1c             	sub    $0x1c,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102739:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010273c:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010273f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102745:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010274b:	8d bb 00 10 00 00    	lea    0x1000(%ebx),%edi
80102751:	39 fe                	cmp    %edi,%esi
80102753:	73 11                	jae    80102766 <freerange+0x36>
80102755:	eb 35                	jmp    8010278c <freerange+0x5c>
80102757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010275e:	66 90                	xchg   %ax,%ax
80102760:	81 c7 00 10 00 00    	add    $0x1000,%edi
    kfree(p);
80102766:	89 1c 24             	mov    %ebx,(%esp)
    refs_count[(uint)p/PGSIZE]=1; 
80102769:	89 d8                	mov    %ebx,%eax
8010276b:	ba 01 00 00 00       	mov    $0x1,%edx
80102770:	c1 e8 0c             	shr    $0xc,%eax
80102773:	89 14 85 40 26 11 80 	mov    %edx,-0x7feed9c0(,%eax,4)
    kfree(p);
8010277a:	e8 b1 fe ff ff       	call   80102630 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010277f:	89 d8                	mov    %ebx,%eax
80102781:	89 fb                	mov    %edi,%ebx
80102783:	05 00 20 00 00       	add    $0x2000,%eax
80102788:	39 c6                	cmp    %eax,%esi
8010278a:	73 d4                	jae    80102760 <freerange+0x30>
}
8010278c:	83 c4 1c             	add    $0x1c,%esp
8010278f:	5b                   	pop    %ebx
80102790:	5e                   	pop    %esi
80102791:	5f                   	pop    %edi
80102792:	5d                   	pop    %ebp
80102793:	c3                   	ret    
80102794:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010279b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010279f:	90                   	nop

801027a0 <kinit2>:
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
801027a3:	57                   	push   %edi
801027a4:	56                   	push   %esi
801027a5:	53                   	push   %ebx
801027a6:	83 ec 1c             	sub    $0x1c,%esp
  p = (char*)PGROUNDUP((uint)vstart);
801027a9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027af:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027b5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027bb:	8d bb 00 10 00 00    	lea    0x1000(%ebx),%edi
801027c1:	39 fe                	cmp    %edi,%esi
801027c3:	73 11                	jae    801027d6 <kinit2+0x36>
801027c5:	eb 35                	jmp    801027fc <kinit2+0x5c>
801027c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ce:	66 90                	xchg   %ax,%ax
801027d0:	81 c7 00 10 00 00    	add    $0x1000,%edi
    kfree(p);
801027d6:	89 1c 24             	mov    %ebx,(%esp)
    refs_count[(uint)p/PGSIZE]=1; 
801027d9:	89 d8                	mov    %ebx,%eax
801027db:	ba 01 00 00 00       	mov    $0x1,%edx
801027e0:	c1 e8 0c             	shr    $0xc,%eax
801027e3:	89 14 85 40 26 11 80 	mov    %edx,-0x7feed9c0(,%eax,4)
    kfree(p);
801027ea:	e8 41 fe ff ff       	call   80102630 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ef:	89 d8                	mov    %ebx,%eax
801027f1:	89 fb                	mov    %edi,%ebx
801027f3:	05 00 20 00 00       	add    $0x2000,%eax
801027f8:	39 c6                	cmp    %eax,%esi
801027fa:	73 d4                	jae    801027d0 <kinit2+0x30>
  kmem.use_lock = 1;
801027fc:	b8 01 00 00 00       	mov    $0x1,%eax
80102801:	a3 74 a6 14 80       	mov    %eax,0x8014a674
}
80102806:	83 c4 1c             	add    $0x1c,%esp
80102809:	5b                   	pop    %ebx
8010280a:	5e                   	pop    %esi
8010280b:	5f                   	pop    %edi
8010280c:	5d                   	pop    %ebp
8010280d:	c3                   	ret    
8010280e:	66 90                	xchg   %ax,%ax

80102810 <kinit1>:
{
80102810:	55                   	push   %ebp
  kmem.numFreePages=0;
80102811:	31 c9                	xor    %ecx,%ecx
{
80102813:	89 e5                	mov    %esp,%ebp
80102815:	57                   	push   %edi
  kmem.use_lock = 0;
80102816:	31 ff                	xor    %edi,%edi
{
80102818:	56                   	push   %esi
80102819:	53                   	push   %ebx
  initlock(&kmem.lock, "kmem");
8010281a:	bb af 7a 10 80       	mov    $0x80107aaf,%ebx
{
8010281f:	83 ec 1c             	sub    $0x1c,%esp
  kmem.numFreePages=0;
80102822:	89 0d 7c a6 14 80    	mov    %ecx,0x8014a67c
{
80102828:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010282b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010282f:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
80102836:	e8 15 1f 00 00       	call   80104750 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010283b:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
8010283e:	89 3d 74 a6 14 80    	mov    %edi,0x8014a674
  p = (char*)PGROUNDUP((uint)vstart);
80102844:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010284a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102850:	8d bb 00 10 00 00    	lea    0x1000(%ebx),%edi
80102856:	39 fe                	cmp    %edi,%esi
80102858:	73 0c                	jae    80102866 <kinit1+0x56>
8010285a:	eb 30                	jmp    8010288c <kinit1+0x7c>
8010285c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102860:	81 c7 00 10 00 00    	add    $0x1000,%edi
    kfree(p);
80102866:	89 1c 24             	mov    %ebx,(%esp)
    refs_count[(uint)p/PGSIZE]=1; 
80102869:	89 d8                	mov    %ebx,%eax
8010286b:	ba 01 00 00 00       	mov    $0x1,%edx
80102870:	c1 e8 0c             	shr    $0xc,%eax
80102873:	89 14 85 40 26 11 80 	mov    %edx,-0x7feed9c0(,%eax,4)
    kfree(p);
8010287a:	e8 b1 fd ff ff       	call   80102630 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010287f:	89 d8                	mov    %ebx,%eax
80102881:	89 fb                	mov    %edi,%ebx
80102883:	05 00 20 00 00       	add    $0x2000,%eax
80102888:	39 c6                	cmp    %eax,%esi
8010288a:	73 d4                	jae    80102860 <kinit1+0x50>
}
8010288c:	83 c4 1c             	add    $0x1c,%esp
8010288f:	5b                   	pop    %ebx
80102890:	5e                   	pop    %esi
80102891:	5f                   	pop    %edi
80102892:	5d                   	pop    %ebp
80102893:	c3                   	ret    
80102894:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010289b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010289f:	90                   	nop

801028a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
801028a6:	a1 74 a6 14 80       	mov    0x8014a674,%eax
801028ab:	85 c0                	test   %eax,%eax
801028ad:	75 61                	jne    80102910 <kalloc+0x70>
    acquire(&kmem.lock);
  r = kmem.freelist;
801028af:	a1 78 a6 14 80       	mov    0x8014a678,%eax
  if(r)
801028b4:	85 c0                	test   %eax,%eax
801028b6:	74 34                	je     801028ec <kalloc+0x4c>
  {
    kmem.freelist = r->next;
801028b8:	8b 10                	mov    (%eax),%edx
    kmem.numFreePages--;
801028ba:	ff 0d 7c a6 14 80    	decl   0x8014a67c
    kmem.freelist = r->next;
801028c0:	89 15 78 a6 14 80    	mov    %edx,0x8014a678
    
    if (refs_count[(uint)r/PGSIZE]==0) refs_count[(uint)r/PGSIZE]=1;
801028c6:	89 c2                	mov    %eax,%edx
801028c8:	c1 ea 0c             	shr    $0xc,%edx
801028cb:	8b 0c 95 40 26 11 80 	mov    -0x7feed9c0(,%edx,4),%ecx
801028d2:	85 c9                	test   %ecx,%ecx
801028d4:	75 51                	jne    80102927 <kalloc+0x87>
801028d6:	b9 01 00 00 00       	mov    $0x1,%ecx
801028db:	89 0c 95 40 26 11 80 	mov    %ecx,-0x7feed9c0(,%edx,4)
    else panic("kalloc");
  }
  if(kmem.use_lock)
801028e2:	8b 15 74 a6 14 80    	mov    0x8014a674,%edx
801028e8:	85 d2                	test   %edx,%edx
801028ea:	75 04                	jne    801028f0 <kalloc+0x50>
    release(&kmem.lock);
  return (char*)r;
}
801028ec:	89 ec                	mov    %ebp,%esp
801028ee:	5d                   	pop    %ebp
801028ef:	c3                   	ret    
801028f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&kmem.lock);
801028f3:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
801028fa:	e8 d1 1f 00 00       	call   801048d0 <release>
801028ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102902:	89 ec                	mov    %ebp,%esp
80102904:	5d                   	pop    %ebp
80102905:	c3                   	ret    
80102906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102910:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
80102917:	e8 24 20 00 00       	call   80104940 <acquire>
  r = kmem.freelist;
8010291c:	a1 78 a6 14 80       	mov    0x8014a678,%eax
  if(r)
80102921:	85 c0                	test   %eax,%eax
80102923:	75 93                	jne    801028b8 <kalloc+0x18>
80102925:	eb bb                	jmp    801028e2 <kalloc+0x42>
    else panic("kalloc");
80102927:	c7 04 24 b4 7a 10 80 	movl   $0x80107ab4,(%esp)
8010292e:	e8 1d da ff ff       	call   80100350 <panic>
80102933:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102940 <increase_ref>:

void increase_ref(uint pa)
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	83 ec 18             	sub    $0x18,%esp
80102946:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80102949:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(kmem.use_lock)
8010294c:	8b 15 74 a6 14 80    	mov    0x8014a674,%edx
80102952:	85 d2                	test   %edx,%edx
80102954:	75 42                	jne    80102998 <increase_ref+0x58>
    acquire(&kmem.lock);
  if (pa>PHYSTOP)
80102956:	81 fb 00 00 00 0e    	cmp    $0xe000000,%ebx
8010295c:	77 70                	ja     801029ce <increase_ref+0x8e>
  {
    panic("increase_ref1");
  }
  if (refs_count[pa/PGSIZE]<0) panic("gajab baat hai: increase_ref2");
8010295e:	c1 eb 0c             	shr    $0xc,%ebx
80102961:	8b 14 9d 40 26 11 80 	mov    -0x7feed9c0(,%ebx,4),%edx
80102968:	85 d2                	test   %edx,%edx
8010296a:	78 56                	js     801029c2 <increase_ref+0x82>
  if (refs_count[pa/PGSIZE]==0)
8010296c:	b8 02 00 00 00       	mov    $0x2,%eax
80102971:	75 1d                	jne    80102990 <increase_ref+0x50>
  {
    refs_count[pa/PGSIZE]=1;// give it a new entry for now
    // panic("increase_ref2");
  }
  refs_count[pa/PGSIZE]+=1;
80102973:	89 04 9d 40 26 11 80 	mov    %eax,-0x7feed9c0(,%ebx,4)
  if(kmem.use_lock)
8010297a:	a1 74 a6 14 80       	mov    0x8014a674,%eax
8010297f:	85 c0                	test   %eax,%eax
80102981:	75 2d                	jne    801029b0 <increase_ref+0x70>
    release(&kmem.lock);
}
80102983:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102986:	89 ec                	mov    %ebp,%esp
80102988:	5d                   	pop    %ebp
80102989:	c3                   	ret    
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  refs_count[pa/PGSIZE]+=1;
80102990:	8d 42 01             	lea    0x1(%edx),%eax
80102993:	eb de                	jmp    80102973 <increase_ref+0x33>
80102995:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102998:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
8010299f:	e8 9c 1f 00 00       	call   80104940 <acquire>
801029a4:	eb b0                	jmp    80102956 <increase_ref+0x16>
801029a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029ad:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029b0:	c7 45 08 40 a6 14 80 	movl   $0x8014a640,0x8(%ebp)
}
801029b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ba:	89 ec                	mov    %ebp,%esp
801029bc:	5d                   	pop    %ebp
    release(&kmem.lock);
801029bd:	e9 0e 1f 00 00       	jmp    801048d0 <release>
  if (refs_count[pa/PGSIZE]<0) panic("gajab baat hai: increase_ref2");
801029c2:	c7 04 24 c9 7a 10 80 	movl   $0x80107ac9,(%esp)
801029c9:	e8 82 d9 ff ff       	call   80100350 <panic>
    panic("increase_ref1");
801029ce:	c7 04 24 bb 7a 10 80 	movl   $0x80107abb,(%esp)
801029d5:	e8 76 d9 ff ff       	call   80100350 <panic>
801029da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029e0 <decrease_ref>:

void decrease_ref(uint pa)
{
801029e0:	55                   	push   %ebp
801029e1:	89 e5                	mov    %esp,%ebp
801029e3:	83 ec 18             	sub    $0x18,%esp
801029e6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801029e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(kmem.use_lock)
801029ec:	8b 15 74 a6 14 80    	mov    0x8014a674,%edx
801029f2:	85 d2                	test   %edx,%edx
801029f4:	75 3a                	jne    80102a30 <decrease_ref+0x50>
    acquire(&kmem.lock);
  if (pa>PHYSTOP)
801029f6:	81 fb 00 00 00 0e    	cmp    $0xe000000,%ebx
801029fc:	77 6c                	ja     80102a6a <decrease_ref+0x8a>
  {
    panic("decrease_ref1");
  }
  if (refs_count[pa/PGSIZE]<0) panic("gajab baat hai: decrease_ref2");
801029fe:	c1 eb 0c             	shr    $0xc,%ebx
80102a01:	8b 04 9d 40 26 11 80 	mov    -0x7feed9c0(,%ebx,4),%eax
80102a08:	85 c0                	test   %eax,%eax
80102a0a:	78 52                	js     80102a5e <decrease_ref+0x7e>
  if (refs_count[pa/PGSIZE]==0)
80102a0c:	74 44                	je     80102a52 <decrease_ref+0x72>
  {
    // refs_count[pa/PGSIZE]=1;// give it a new entry for now
    panic("decrease_ref2");
  }
  refs_count[pa/PGSIZE]-=1;
80102a0e:	48                   	dec    %eax
80102a0f:	89 04 9d 40 26 11 80 	mov    %eax,-0x7feed9c0(,%ebx,4)
  if(kmem.use_lock)
80102a16:	a1 74 a6 14 80       	mov    0x8014a674,%eax
80102a1b:	85 c0                	test   %eax,%eax
80102a1d:	75 21                	jne    80102a40 <decrease_ref+0x60>
    release(&kmem.lock);
}
80102a1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a22:	89 ec                	mov    %ebp,%esp
80102a24:	5d                   	pop    %ebp
80102a25:	c3                   	ret    
80102a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a2d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102a30:	c7 04 24 40 a6 14 80 	movl   $0x8014a640,(%esp)
80102a37:	e8 04 1f 00 00       	call   80104940 <acquire>
80102a3c:	eb b8                	jmp    801029f6 <decrease_ref+0x16>
80102a3e:	66 90                	xchg   %ax,%ax
    release(&kmem.lock);
80102a40:	c7 45 08 40 a6 14 80 	movl   $0x8014a640,0x8(%ebp)
}
80102a47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a4a:	89 ec                	mov    %ebp,%esp
80102a4c:	5d                   	pop    %ebp
    release(&kmem.lock);
80102a4d:	e9 7e 1e 00 00       	jmp    801048d0 <release>
    panic("decrease_ref2");
80102a52:	c7 04 24 05 7b 10 80 	movl   $0x80107b05,(%esp)
80102a59:	e8 f2 d8 ff ff       	call   80100350 <panic>
  if (refs_count[pa/PGSIZE]<0) panic("gajab baat hai: decrease_ref2");
80102a5e:	c7 04 24 f5 7a 10 80 	movl   $0x80107af5,(%esp)
80102a65:	e8 e6 d8 ff ff       	call   80100350 <panic>
    panic("decrease_ref1");
80102a6a:	c7 04 24 e7 7a 10 80 	movl   $0x80107ae7,(%esp)
80102a71:	e8 da d8 ff ff       	call   80100350 <panic>
80102a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a7d:	8d 76 00             	lea    0x0(%esi),%esi

80102a80 <get_ref>:

int get_ref(uint pa)
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
  return refs_count[pa/PGSIZE];
80102a83:	8b 45 08             	mov    0x8(%ebp),%eax
80102a86:	5d                   	pop    %ebp
  return refs_count[pa/PGSIZE];
80102a87:	c1 e8 0c             	shr    $0xc,%eax
80102a8a:	8b 04 85 40 26 11 80 	mov    -0x7feed9c0(,%eax,4),%eax
80102a91:	c3                   	ret    
80102a92:	66 90                	xchg   %ax,%ax
80102a94:	66 90                	xchg   %ax,%ax
80102a96:	66 90                	xchg   %ax,%ax
80102a98:	66 90                	xchg   %ax,%ax
80102a9a:	66 90                	xchg   %ax,%ax
80102a9c:	66 90                	xchg   %ax,%ax
80102a9e:	66 90                	xchg   %ax,%ax

80102aa0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aa0:	ba 64 00 00 00       	mov    $0x64,%edx
80102aa5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102aa6:	24 01                	and    $0x1,%al
80102aa8:	0f 84 b2 00 00 00    	je     80102b60 <kbdgetc+0xc0>
{
80102aae:	55                   	push   %ebp
80102aaf:	ba 60 00 00 00       	mov    $0x60,%edx
80102ab4:	89 e5                	mov    %esp,%ebp
80102ab6:	53                   	push   %ebx
80102ab7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
80102ab8:	3c e0                	cmp    $0xe0,%al
    shift |= E0ESC;
80102aba:	8b 1d 80 a6 14 80    	mov    0x8014a680,%ebx
  data = inb(KBDATAP);
80102ac0:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102ac3:	74 5b                	je     80102b20 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102ac5:	89 da                	mov    %ebx,%edx
80102ac7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102aca:	84 c0                	test   %al,%al
80102acc:	78 62                	js     80102b30 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102ace:	85 d2                	test   %edx,%edx
80102ad0:	74 08                	je     80102ada <kbdgetc+0x3a>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102ad2:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
80102ad4:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102ad7:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102ada:	0f b6 91 40 7c 10 80 	movzbl -0x7fef83c0(%ecx),%edx
  shift ^= togglecode[data];
80102ae1:	0f b6 81 40 7b 10 80 	movzbl -0x7fef84c0(%ecx),%eax
  shift |= shiftcode[data];
80102ae8:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102aea:	31 c2                	xor    %eax,%edx
80102aec:	89 15 80 a6 14 80    	mov    %edx,0x8014a680
  c = charcode[shift & (CTL | SHIFT)][data];
80102af2:	89 d0                	mov    %edx,%eax
80102af4:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102af7:	f6 c2 08             	test   $0x8,%dl
  c = charcode[shift & (CTL | SHIFT)][data];
80102afa:	8b 04 85 20 7b 10 80 	mov    -0x7fef84e0(,%eax,4),%eax
80102b01:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102b05:	74 13                	je     80102b1a <kbdgetc+0x7a>
    if('a' <= c && c <= 'z')
80102b07:	8d 50 9f             	lea    -0x61(%eax),%edx
80102b0a:	83 fa 19             	cmp    $0x19,%edx
80102b0d:	76 41                	jbe    80102b50 <kbdgetc+0xb0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102b0f:	8d 50 bf             	lea    -0x41(%eax),%edx
80102b12:	83 fa 19             	cmp    $0x19,%edx
80102b15:	77 03                	ja     80102b1a <kbdgetc+0x7a>
      c += 'a' - 'A';
80102b17:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
80102b1a:	5b                   	pop    %ebx
80102b1b:	5d                   	pop    %ebp
80102b1c:	c3                   	ret    
80102b1d:	8d 76 00             	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102b20:	89 d8                	mov    %ebx,%eax
80102b22:	83 c8 40             	or     $0x40,%eax
}
80102b25:	5b                   	pop    %ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102b26:	a3 80 a6 14 80       	mov    %eax,0x8014a680
    return 0;
80102b2b:	31 c0                	xor    %eax,%eax
}
80102b2d:	5d                   	pop    %ebp
80102b2e:	c3                   	ret    
80102b2f:	90                   	nop
    data = (shift & E0ESC ? data : data & 0x7F);
80102b30:	85 d2                	test   %edx,%edx
80102b32:	75 05                	jne    80102b39 <kbdgetc+0x99>
80102b34:	24 7f                	and    $0x7f,%al
80102b36:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102b39:	0f b6 81 40 7c 10 80 	movzbl -0x7fef83c0(%ecx),%eax
80102b40:	0c 40                	or     $0x40,%al
80102b42:	0f b6 c0             	movzbl %al,%eax
80102b45:	f7 d0                	not    %eax
80102b47:	21 d8                	and    %ebx,%eax
    return 0;
80102b49:	eb da                	jmp    80102b25 <kbdgetc+0x85>
80102b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b4f:	90                   	nop
}
80102b50:	5b                   	pop    %ebx
      c += 'A' - 'a';
80102b51:	83 e8 20             	sub    $0x20,%eax
}
80102b54:	5d                   	pop    %ebp
80102b55:	c3                   	ret    
80102b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b5d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80102b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102b65:	c3                   	ret    
80102b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b6d:	8d 76 00             	lea    0x0(%esi),%esi

80102b70 <kbdintr>:

void
kbdintr(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102b76:	c7 04 24 a0 2a 10 80 	movl   $0x80102aa0,(%esp)
80102b7d:	e8 2e dd ff ff       	call   801008b0 <consoleintr>
}
80102b82:	89 ec                	mov    %ebp,%esp
80102b84:	5d                   	pop    %ebp
80102b85:	c3                   	ret    
80102b86:	66 90                	xchg   %ax,%ax
80102b88:	66 90                	xchg   %ax,%ax
80102b8a:	66 90                	xchg   %ax,%ax
80102b8c:	66 90                	xchg   %ax,%ax
80102b8e:	66 90                	xchg   %ax,%ax

80102b90 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102b90:	a1 84 a6 14 80       	mov    0x8014a684,%eax
80102b95:	85 c0                	test   %eax,%eax
80102b97:	0f 84 c9 00 00 00    	je     80102c66 <lapicinit+0xd6>
  lapic[index] = value;
80102b9d:	ba 3f 01 00 00       	mov    $0x13f,%edx
80102ba2:	b9 0b 00 00 00       	mov    $0xb,%ecx
80102ba7:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bb0:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
80102bb6:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102bbb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bbe:	ba 20 00 02 00       	mov    $0x20020,%edx
80102bc3:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bc9:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bcc:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102bd2:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102bd7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bda:	ba 00 00 01 00       	mov    $0x10000,%edx
80102bdf:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102be5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102be8:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bee:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102bf1:	8b 50 30             	mov    0x30(%eax),%edx
80102bf4:	c1 ea 10             	shr    $0x10,%edx
80102bf7:	f6 c2 fc             	test   $0xfc,%dl
80102bfa:	75 74                	jne    80102c70 <lapicinit+0xe0>
  lapic[index] = value;
80102bfc:	b9 33 00 00 00       	mov    $0x33,%ecx
80102c01:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
80102c07:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102c09:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c0c:	31 d2                	xor    %edx,%edx
80102c0e:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c14:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c17:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
80102c1d:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102c1f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c22:	31 d2                	xor    %edx,%edx
80102c24:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c2a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c2d:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c33:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c36:	ba 00 85 08 00       	mov    $0x88500,%edx
80102c3b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c41:	8b 50 20             	mov    0x20(%eax),%edx
80102c44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c4f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102c50:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102c56:	f6 c6 10             	test   $0x10,%dh
80102c59:	75 f5                	jne    80102c50 <lapicinit+0xc0>
  lapic[index] = value;
80102c5b:	31 d2                	xor    %edx,%edx
80102c5d:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c63:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102c66:	c3                   	ret    
80102c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6e:	66 90                	xchg   %ax,%ax
  lapic[index] = value;
80102c70:	b9 00 00 01 00       	mov    $0x10000,%ecx
80102c75:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c7b:	8b 50 20             	mov    0x20(%eax),%edx
}
80102c7e:	e9 79 ff ff ff       	jmp    80102bfc <lapicinit+0x6c>
80102c83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c90 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102c90:	a1 84 a6 14 80       	mov    0x8014a684,%eax
80102c95:	85 c0                	test   %eax,%eax
80102c97:	74 07                	je     80102ca0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102c99:	8b 40 20             	mov    0x20(%eax),%eax
80102c9c:	c1 e8 18             	shr    $0x18,%eax
80102c9f:	c3                   	ret    
    return 0;
80102ca0:	31 c0                	xor    %eax,%eax
}
80102ca2:	c3                   	ret    
80102ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102cb0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102cb0:	a1 84 a6 14 80       	mov    0x8014a684,%eax
80102cb5:	85 c0                	test   %eax,%eax
80102cb7:	74 0b                	je     80102cc4 <lapiceoi+0x14>
  lapic[index] = value;
80102cb9:	31 d2                	xor    %edx,%edx
80102cbb:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102cc1:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102cc4:	c3                   	ret    
80102cc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cd0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102cd0:	c3                   	ret    
80102cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cdf:	90                   	nop

80102ce0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ce0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce1:	b0 0f                	mov    $0xf,%al
80102ce3:	89 e5                	mov    %esp,%ebp
80102ce5:	ba 70 00 00 00       	mov    $0x70,%edx
80102cea:	53                   	push   %ebx
80102ceb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102cee:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
80102cf2:	ee                   	out    %al,(%dx)
80102cf3:	b0 0a                	mov    $0xa,%al
80102cf5:	ba 71 00 00 00       	mov    $0x71,%edx
80102cfa:	ee                   	out    %al,(%dx)
  lapic[index] = value;
80102cfb:	c1 e1 18             	shl    $0x18,%ecx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102cfe:	31 c0                	xor    %eax,%eax
80102d00:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102d06:	89 d8                	mov    %ebx,%eax
80102d08:	c1 e8 04             	shr    $0x4,%eax
80102d0b:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d11:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
80102d14:	a1 84 a6 14 80       	mov    0x8014a684,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d19:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
80102d1f:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d25:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d28:	ba 00 c5 00 00       	mov    $0xc500,%edx
80102d2d:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d33:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d36:	ba 00 85 00 00       	mov    $0x8500,%edx
80102d3b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d41:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d44:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d4a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d4d:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d53:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d56:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d5c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d5f:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
80102d65:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102d66:	8b 40 20             	mov    0x20(%eax),%eax
}
80102d69:	5d                   	pop    %ebp
80102d6a:	c3                   	ret    
80102d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d6f:	90                   	nop

80102d70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102d70:	55                   	push   %ebp
80102d71:	b0 0b                	mov    $0xb,%al
80102d73:	89 e5                	mov    %esp,%ebp
80102d75:	ba 70 00 00 00       	mov    $0x70,%edx
80102d7a:	57                   	push   %edi
80102d7b:	56                   	push   %esi
80102d7c:	53                   	push   %ebx
80102d7d:	83 ec 5c             	sub    $0x5c,%esp
80102d80:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d81:	ba 71 00 00 00       	mov    $0x71,%edx
80102d86:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102d87:	24 04                	and    $0x4,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d89:	be 70 00 00 00       	mov    $0x70,%esi
80102d8e:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102d91:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102d94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d9f:	90                   	nop
80102da0:	31 c0                	xor    %eax,%eax
80102da2:	89 f2                	mov    %esi,%edx
80102da4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102da5:	bb 71 00 00 00       	mov    $0x71,%ebx
80102daa:	89 da                	mov    %ebx,%edx
80102dac:	ec                   	in     (%dx),%al
80102dad:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102db0:	89 f2                	mov    %esi,%edx
80102db2:	b0 02                	mov    $0x2,%al
80102db4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102db5:	89 da                	mov    %ebx,%edx
80102db7:	ec                   	in     (%dx),%al
80102db8:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dbb:	89 f2                	mov    %esi,%edx
80102dbd:	b0 04                	mov    $0x4,%al
80102dbf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dc0:	89 da                	mov    %ebx,%edx
80102dc2:	ec                   	in     (%dx),%al
80102dc3:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dc6:	89 f2                	mov    %esi,%edx
80102dc8:	b0 07                	mov    $0x7,%al
80102dca:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dcb:	89 da                	mov    %ebx,%edx
80102dcd:	ec                   	in     (%dx),%al
80102dce:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd1:	89 f2                	mov    %esi,%edx
80102dd3:	b0 08                	mov    $0x8,%al
80102dd5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dd6:	89 da                	mov    %ebx,%edx
80102dd8:	ec                   	in     (%dx),%al
80102dd9:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ddc:	89 f2                	mov    %esi,%edx
80102dde:	b0 09                	mov    $0x9,%al
80102de0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de1:	89 da                	mov    %ebx,%edx
80102de3:	ec                   	in     (%dx),%al
80102de4:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102de7:	89 f2                	mov    %esi,%edx
80102de9:	b0 0a                	mov    $0xa,%al
80102deb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dec:	89 da                	mov    %ebx,%edx
80102dee:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102def:	84 c0                	test   %al,%al
80102df1:	78 ad                	js     80102da0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102df3:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80102df6:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dfa:	89 f2                	mov    %esi,%edx
80102dfc:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102dff:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102e03:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102e06:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102e0a:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102e0d:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102e11:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102e14:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
80102e18:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102e1b:	31 c0                	xor    %eax,%eax
80102e1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e1e:	89 da                	mov    %ebx,%edx
80102e20:	ec                   	in     (%dx),%al
80102e21:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e24:	89 f2                	mov    %esi,%edx
80102e26:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102e29:	b0 02                	mov    $0x2,%al
80102e2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e2c:	89 da                	mov    %ebx,%edx
80102e2e:	ec                   	in     (%dx),%al
80102e2f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e32:	89 f2                	mov    %esi,%edx
80102e34:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102e37:	b0 04                	mov    $0x4,%al
80102e39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e3a:	89 da                	mov    %ebx,%edx
80102e3c:	ec                   	in     (%dx),%al
80102e3d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e40:	89 f2                	mov    %esi,%edx
80102e42:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102e45:	b0 07                	mov    $0x7,%al
80102e47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e48:	89 da                	mov    %ebx,%edx
80102e4a:	ec                   	in     (%dx),%al
80102e4b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e4e:	89 f2                	mov    %esi,%edx
80102e50:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e53:	b0 08                	mov    $0x8,%al
80102e55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e56:	89 da                	mov    %ebx,%edx
80102e58:	ec                   	in     (%dx),%al
80102e59:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e5c:	89 f2                	mov    %esi,%edx
80102e5e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102e61:	b0 09                	mov    $0x9,%al
80102e63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e64:	89 da                	mov    %ebx,%edx
80102e66:	ec                   	in     (%dx),%al
80102e67:	0f b6 c0             	movzbl %al,%eax
80102e6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102e6d:	b8 18 00 00 00       	mov    $0x18,%eax
80102e72:	89 44 24 08          	mov    %eax,0x8(%esp)
80102e76:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102e79:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102e7d:	89 04 24             	mov    %eax,(%esp)
80102e80:	e8 db 1b 00 00       	call   80104a60 <memcmp>
80102e85:	85 c0                	test   %eax,%eax
80102e87:	0f 85 13 ff ff ff    	jne    80102da0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102e8d:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102e91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e94:	75 78                	jne    80102f0e <cmostime+0x19e>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102e96:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e99:	89 c2                	mov    %eax,%edx
80102e9b:	83 e0 0f             	and    $0xf,%eax
80102e9e:	c1 ea 04             	shr    $0x4,%edx
80102ea1:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ea4:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ea7:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102eaa:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ead:	89 c2                	mov    %eax,%edx
80102eaf:	83 e0 0f             	and    $0xf,%eax
80102eb2:	c1 ea 04             	shr    $0x4,%edx
80102eb5:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eb8:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ebb:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ebe:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ec1:	89 c2                	mov    %eax,%edx
80102ec3:	83 e0 0f             	and    $0xf,%eax
80102ec6:	c1 ea 04             	shr    $0x4,%edx
80102ec9:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ecc:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ecf:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ed2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ed5:	89 c2                	mov    %eax,%edx
80102ed7:	83 e0 0f             	and    $0xf,%eax
80102eda:	c1 ea 04             	shr    $0x4,%edx
80102edd:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ee0:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ee3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102ee6:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ee9:	89 c2                	mov    %eax,%edx
80102eeb:	83 e0 0f             	and    $0xf,%eax
80102eee:	c1 ea 04             	shr    $0x4,%edx
80102ef1:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ef4:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ef7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102efa:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102efd:	89 c2                	mov    %eax,%edx
80102eff:	83 e0 0f             	and    $0xf,%eax
80102f02:	c1 ea 04             	shr    $0x4,%edx
80102f05:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f08:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f0b:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102f0e:	31 c0                	xor    %eax,%eax
80102f10:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102f14:	89 14 03             	mov    %edx,(%ebx,%eax,1)
80102f17:	83 c0 04             	add    $0x4,%eax
80102f1a:	83 f8 18             	cmp    $0x18,%eax
80102f1d:	72 f1                	jb     80102f10 <cmostime+0x1a0>
  r->year += 2000;
80102f1f:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102f26:	83 c4 5c             	add    $0x5c,%esp
80102f29:	5b                   	pop    %ebx
80102f2a:	5e                   	pop    %esi
80102f2b:	5f                   	pop    %edi
80102f2c:	5d                   	pop    %ebp
80102f2d:	c3                   	ret    
80102f2e:	66 90                	xchg   %ax,%ax

80102f30 <install_trans>:
static void
install_trans(void) // install transaction
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f30:	8b 15 e8 a6 14 80    	mov    0x8014a6e8,%edx
80102f36:	85 d2                	test   %edx,%edx
80102f38:	0f 8e 92 00 00 00    	jle    80102fd0 <install_trans+0xa0>
{
80102f3e:	55                   	push   %ebp
80102f3f:	89 e5                	mov    %esp,%ebp
80102f41:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102f42:	31 ff                	xor    %edi,%edi
{
80102f44:	56                   	push   %esi
80102f45:	53                   	push   %ebx
80102f46:	83 ec 1c             	sub    $0x1c,%esp
80102f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block into memory
80102f50:	a1 d4 a6 14 80       	mov    0x8014a6d4,%eax
80102f55:	01 f8                	add    %edi,%eax
80102f57:	40                   	inc    %eax
80102f58:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f5c:	a1 e4 a6 14 80       	mov    0x8014a6e4,%eax
80102f61:	89 04 24             	mov    %eax,(%esp)
80102f64:	e8 67 d1 ff ff       	call   801000d0 <bread>
80102f69:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst block (or create buf for it)
80102f6b:	8b 04 bd ec a6 14 80 	mov    -0x7feb5914(,%edi,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102f72:	47                   	inc    %edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst block (or create buf for it)
80102f73:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f77:	a1 e4 a6 14 80       	mov    0x8014a6e4,%eax
80102f7c:	89 04 24             	mov    %eax,(%esp)
80102f7f:	e8 4c d1 ff ff       	call   801000d0 <bread>
80102f84:	89 c3                	mov    %eax,%ebx
    
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst - possibly overwriting its content
80102f86:	b8 00 02 00 00       	mov    $0x200,%eax
80102f8b:	89 44 24 08          	mov    %eax,0x8(%esp)
80102f8f:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f92:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f96:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102f99:	89 04 24             	mov    %eax,(%esp)
80102f9c:	e8 0f 1b 00 00       	call   80104ab0 <memmove>
    
    bwrite(dbuf);  // write dst to disk (which calls iderw which enqueues the write to disk)
80102fa1:	89 1c 24             	mov    %ebx,(%esp)
80102fa4:	e8 f7 d1 ff ff       	call   801001a0 <bwrite>

    // done using buffers
    brelse(lbuf);
80102fa9:	89 34 24             	mov    %esi,(%esp)
80102fac:	e8 2f d2 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102fb1:	89 1c 24             	mov    %ebx,(%esp)
80102fb4:	e8 27 d2 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102fb9:	39 3d e8 a6 14 80    	cmp    %edi,0x8014a6e8
80102fbf:	7f 8f                	jg     80102f50 <install_trans+0x20>
  }
}
80102fc1:	83 c4 1c             	add    $0x1c,%esp
80102fc4:	5b                   	pop    %ebx
80102fc5:	5e                   	pop    %esi
80102fc6:	5f                   	pop    %edi
80102fc7:	5d                   	pop    %ebp
80102fc8:	c3                   	ret    
80102fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fd0:	c3                   	ret    
80102fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fdf:	90                   	nop

80102fe0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	83 ec 18             	sub    $0x18,%esp
80102fe6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct buf *buf = bread(log.dev, log.start);
80102fe9:	a1 d4 a6 14 80       	mov    0x8014a6d4,%eax
80102fee:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff2:	a1 e4 a6 14 80       	mov    0x8014a6e4,%eax
80102ff7:	89 04 24             	mov    %eax,(%esp)
80102ffa:	e8 d1 d0 ff ff       	call   801000d0 <bread>
80102fff:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  // reverse copy
  hb->n = log.lh.n;
80103001:	a1 e8 a6 14 80       	mov    0x8014a6e8,%eax
80103006:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103009:	85 c0                	test   %eax,%eax
8010300b:	7e 13                	jle    80103020 <write_head+0x40>
8010300d:	31 d2                	xor    %edx,%edx
8010300f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103010:	8b 0c 95 ec a6 14 80 	mov    -0x7feb5914(,%edx,4),%ecx
80103017:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010301b:	42                   	inc    %edx
8010301c:	39 d0                	cmp    %edx,%eax
8010301e:	75 f0                	jne    80103010 <write_head+0x30>
  }
  bwrite(buf); // push logheader to disk
80103020:	89 1c 24             	mov    %ebx,(%esp)
80103023:	e8 78 d1 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80103028:	89 1c 24             	mov    %ebx,(%esp)
8010302b:	e8 b0 d1 ff ff       	call   801001e0 <brelse>
}
80103030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103033:	89 ec                	mov    %ebp,%esp
80103035:	5d                   	pop    %ebp
80103036:	c3                   	ret    
80103037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010303e:	66 90                	xchg   %ax,%ax

80103040 <initlog>:
{
80103040:	55                   	push   %ebp
  initlock(&log.lock, "log"); // initialize log lock
80103041:	ba 40 7d 10 80       	mov    $0x80107d40,%edx
{
80103046:	89 e5                	mov    %esp,%ebp
80103048:	83 ec 38             	sub    $0x38,%esp
8010304b:	89 5d fc             	mov    %ebx,-0x4(%ebp)
8010304e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log"); // initialize log lock
80103051:	89 54 24 04          	mov    %edx,0x4(%esp)
80103055:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
8010305c:	e8 ef 16 00 00       	call   80104750 <initlock>
  readsb(dev, &sb); // read superblock from disk
80103061:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103064:	89 44 24 04          	mov    %eax,0x4(%esp)
80103068:	89 1c 24             	mov    %ebx,(%esp)
8010306b:	e8 50 e5 ff ff       	call   801015c0 <readsb>
  log.start = sb.logstart;
80103070:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.dev = dev;
80103073:	89 1d e4 a6 14 80    	mov    %ebx,0x8014a6e4
  log.size = sb.nlog; // number of blocks in the log
80103079:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
8010307c:	a3 d4 a6 14 80       	mov    %eax,0x8014a6d4
  log.size = sb.nlog; // number of blocks in the log
80103081:	89 15 d8 a6 14 80    	mov    %edx,0x8014a6d8
  struct buf *buf = bread(log.dev, log.start);
80103087:	89 1c 24             	mov    %ebx,(%esp)
8010308a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010308e:	e8 3d d0 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103093:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103096:	89 1d e8 a6 14 80    	mov    %ebx,0x8014a6e8
  for (i = 0; i < log.lh.n; i++) {
8010309c:	85 db                	test   %ebx,%ebx
8010309e:	7e 20                	jle    801030c0 <initlog+0x80>
801030a0:	31 d2                	xor    %edx,%edx
801030a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
801030b0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801030b4:	89 0c 95 ec a6 14 80 	mov    %ecx,-0x7feb5914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801030bb:	42                   	inc    %edx
801030bc:	39 d3                	cmp    %edx,%ebx
801030be:	75 f0                	jne    801030b0 <initlog+0x70>
  brelse(buf);
801030c0:	89 04 24             	mov    %eax,(%esp)
801030c3:	e8 18 d1 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head(); // get logheader
  install_trans(); // if committed, copy from log to disk
801030c8:	e8 63 fe ff ff       	call   80102f30 <install_trans>
  log.lh.n = 0; // clear log in memory
801030cd:	31 c0                	xor    %eax,%eax
801030cf:	a3 e8 a6 14 80       	mov    %eax,0x8014a6e8
  write_head(); // clear the log on disk
801030d4:	e8 07 ff ff ff       	call   80102fe0 <write_head>
}
801030d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030dc:	89 ec                	mov    %ebp,%esp
801030de:	5d                   	pop    %ebp
801030df:	c3                   	ret    

801030e0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock); // acquire lock on log
801030e6:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801030ed:	e8 4e 18 00 00       	call   80104940 <acquire>
801030f2:	eb 19                	jmp    8010310d <begin_op+0x2d>
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(1){ // many threads can be in this loop

    // wait for commit to finish before starting new transaction
    if(log.committing){
      sleep(&log, &log.lock);
801030f8:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801030ff:	b8 a0 a6 14 80       	mov    $0x8014a6a0,%eax
80103104:	89 44 24 04          	mov    %eax,0x4(%esp)
80103108:	e8 73 12 00 00       	call   80104380 <sleep>
    if(log.committing){
8010310d:	8b 15 e0 a6 14 80    	mov    0x8014a6e0,%edx
80103113:	85 d2                	test   %edx,%edx
80103115:	75 e1                	jne    801030f8 <begin_op+0x18>
    } 
    // can we start a new transaction for this new syscall?
    else 
      // no
      if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103117:	a1 dc a6 14 80       	mov    0x8014a6dc,%eax
8010311c:	8d 54 80 05          	lea    0x5(%eax,%eax,4),%edx
80103120:	8d 48 01             	lea    0x1(%eax),%ecx
80103123:	a1 e8 a6 14 80       	mov    0x8014a6e8,%eax
80103128:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010312b:	83 f8 1e             	cmp    $0x1e,%eax
8010312e:	7f c8                	jg     801030f8 <begin_op+0x18>
        // this op might exhaust log space; wait for commit.
        sleep(&log, &log.lock);
      } 
      // yes
      else {
        log.outstanding += 1; // one more syscall
80103130:	89 0d dc a6 14 80    	mov    %ecx,0x8014a6dc
        release(&log.lock); // updated log, release lock
80103136:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
8010313d:	e8 8e 17 00 00       	call   801048d0 <release>
        break;
    }
  }
}
80103142:	89 ec                	mov    %ebp,%esp
80103144:	5d                   	pop    %ebp
80103145:	c3                   	ret    
80103146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010314d:	8d 76 00             	lea    0x0(%esi),%esi

80103150 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103150:	55                   	push   %ebp
80103151:	89 e5                	mov    %esp,%ebp
80103153:	57                   	push   %edi
80103154:	56                   	push   %esi
80103155:	53                   	push   %ebx
80103156:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0; // should we commit?

  acquire(&log.lock);
80103159:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
80103160:	e8 db 17 00 00       	call   80104940 <acquire>
  log.outstanding -= 1; // first up, one syscall less
80103165:	a1 dc a6 14 80       	mov    0x8014a6dc,%eax
8010316a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
8010316d:	a1 e0 a6 14 80       	mov    0x8014a6e0,%eax
  log.outstanding -= 1; // first up, one syscall less
80103172:	89 1d dc a6 14 80    	mov    %ebx,0x8014a6dc
  if(log.committing)
80103178:	85 c0                	test   %eax,%eax
8010317a:	0f 85 ed 00 00 00    	jne    8010326d <end_op+0x11d>
    panic("log.committing");
  
  // if no more outstanding syscalls still running, commit
  if(log.outstanding == 0){
80103180:	85 db                	test   %ebx,%ebx
80103182:	75 34                	jne    801031b8 <end_op+0x68>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log); // wakeup all processes waiting on log
  }
  release(&log.lock);
80103184:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
    log.committing = 1; // decided to commit, variable part of the log to let the rest of the log know that we are committing now, and to wait for us to finish commiting the whole log
8010318b:	be 01 00 00 00       	mov    $0x1,%esi
80103190:	89 35 e0 a6 14 80    	mov    %esi,0x8014a6e0
  release(&log.lock);
80103196:	e8 35 17 00 00       	call   801048d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
8010319b:	8b 3d e8 a6 14 80    	mov    0x8014a6e8,%edi
801031a1:	85 ff                	test   %edi,%edi
801031a3:	7f 3b                	jg     801031e0 <end_op+0x90>
    acquire(&log.lock);
801031a5:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801031ac:	e8 8f 17 00 00       	call   80104940 <acquire>
    log.committing = 0;
801031b1:	31 c0                	xor    %eax,%eax
801031b3:	a3 e0 a6 14 80       	mov    %eax,0x8014a6e0
    wakeup(&log); // wake up all processes waiting on log (which we did not previously do, they are all sleeping waiting for the commit to conclude)
801031b8:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801031bf:	e8 8c 12 00 00       	call   80104450 <wakeup>
    release(&log.lock);
801031c4:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801031cb:	e8 00 17 00 00       	call   801048d0 <release>
}
801031d0:	83 c4 1c             	add    $0x1c,%esp
801031d3:	5b                   	pop    %ebx
801031d4:	5e                   	pop    %esi
801031d5:	5f                   	pop    %edi
801031d6:	5d                   	pop    %ebp
801031d7:	c3                   	ret    
801031d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031df:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801031e0:	a1 d4 a6 14 80       	mov    0x8014a6d4,%eax
801031e5:	01 d8                	add    %ebx,%eax
801031e7:	40                   	inc    %eax
801031e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801031ec:	a1 e4 a6 14 80       	mov    0x8014a6e4,%eax
801031f1:	89 04 24             	mov    %eax,(%esp)
801031f4:	e8 d7 ce ff ff       	call   801000d0 <bread>
801031f9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801031fb:	8b 04 9d ec a6 14 80 	mov    -0x7feb5914(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80103202:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103203:	89 44 24 04          	mov    %eax,0x4(%esp)
80103207:	a1 e4 a6 14 80       	mov    0x8014a6e4,%eax
8010320c:	89 04 24             	mov    %eax,(%esp)
8010320f:	e8 bc ce ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103214:	b9 00 02 00 00       	mov    $0x200,%ecx
80103219:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010321d:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
8010321f:	8d 40 5c             	lea    0x5c(%eax),%eax
80103222:	89 44 24 04          	mov    %eax,0x4(%esp)
80103226:	8d 46 5c             	lea    0x5c(%esi),%eax
80103229:	89 04 24             	mov    %eax,(%esp)
8010322c:	e8 7f 18 00 00       	call   80104ab0 <memmove>
    bwrite(to);  // write the log
80103231:	89 34 24             	mov    %esi,(%esp)
80103234:	e8 67 cf ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103239:	89 3c 24             	mov    %edi,(%esp)
8010323c:	e8 9f cf ff ff       	call   801001e0 <brelse>
    brelse(to);
80103241:	89 34 24             	mov    %esi,(%esp)
80103244:	e8 97 cf ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103249:	3b 1d e8 a6 14 80    	cmp    0x8014a6e8,%ebx
8010324f:	7c 8f                	jl     801031e0 <end_op+0x90>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103251:	e8 8a fd ff ff       	call   80102fe0 <write_head>
    /* if the system crashes before completing the above - nothing is in the logheader @log.start. Which means that none of these changes to the blocks will be reflected on disk (whichever ones happened will be on log, but none on disk - that is why we need a log; as a sort of safety against incomplete changes to disk blocks). There is twice the copying yes, but in the interest of safety this is probably worth the extra cost. */
    install_trans(); // Now install writes to home locations on disk - notice that this can crash and the next time the system starts up the log which was saved on disk will be used to recover the changes to the blocks! And then install_trans will run again trying to push these back to disk. see recover_from_log() for the recovery process.
80103256:	e8 d5 fc ff ff       	call   80102f30 <install_trans>
    log.lh.n = 0;
8010325b:	31 d2                	xor    %edx,%edx
8010325d:	89 15 e8 a6 14 80    	mov    %edx,0x8014a6e8
    write_head();    // Erase the transaction from the log
80103263:	e8 78 fd ff ff       	call   80102fe0 <write_head>
80103268:	e9 38 ff ff ff       	jmp    801031a5 <end_op+0x55>
    panic("log.committing");
8010326d:	c7 04 24 44 7d 10 80 	movl   $0x80107d44,(%esp)
80103274:	e8 d7 d0 ff ff       	call   80100350 <panic>
80103279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103280 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103280:	55                   	push   %ebp
80103281:	89 e5                	mov    %esp,%ebp
80103283:	83 ec 18             	sub    $0x18,%esp
80103286:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80103289:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  // can't do such a big transaction
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010328c:	8b 15 e8 a6 14 80    	mov    0x8014a6e8,%edx
80103292:	83 fa 1d             	cmp    $0x1d,%edx
80103295:	7f 79                	jg     80103310 <log_write+0x90>
80103297:	a1 d8 a6 14 80       	mov    0x8014a6d8,%eax
8010329c:	48                   	dec    %eax
8010329d:	39 c2                	cmp    %eax,%edx
8010329f:	7d 6f                	jge    80103310 <log_write+0x90>
    panic("too big a transaction");
  
  // no outstanding transaction (begin_op was not called), panic.
  if (log.outstanding < 1)
801032a1:	a1 dc a6 14 80       	mov    0x8014a6dc,%eax
801032a6:	85 c0                	test   %eax,%eax
801032a8:	7e 72                	jle    8010331c <log_write+0x9c>
    panic("log_write outside of trans");

  acquire(&log.lock);
801032aa:	c7 04 24 a0 a6 14 80 	movl   $0x8014a6a0,(%esp)
801032b1:	e8 8a 16 00 00       	call   80104940 <acquire>

  // if this block is already part of the current transaction (0 to log.lh.n - 1), do nothing
  for (i = 0; i < log.lh.n; i++) {
801032b6:	8b 15 e8 a6 14 80    	mov    0x8014a6e8,%edx
801032bc:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion, update the block all you want
801032be:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801032c1:	85 d2                	test   %edx,%edx
801032c3:	7f 10                	jg     801032d5 <log_write+0x55>
801032c5:	eb 17                	jmp    801032de <log_write+0x5e>
801032c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032ce:	66 90                	xchg   %ax,%ax
801032d0:	40                   	inc    %eax
801032d1:	39 c2                	cmp    %eax,%edx
801032d3:	74 2b                	je     80103300 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion, update the block all you want
801032d5:	39 0c 85 ec a6 14 80 	cmp    %ecx,-0x7feb5914(,%eax,4)
801032dc:	75 f2                	jne    801032d0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno; // lol, even if we pass the if () above we reassign
801032de:	89 0c 85 ec a6 14 80 	mov    %ecx,-0x7feb5914(,%eax,4)
  
  // if a new block was added to the log, update log.lh.n
  if (i == log.lh.n)
801032e5:	39 c2                	cmp    %eax,%edx
801032e7:	74 1e                	je     80103307 <log_write+0x87>
    log.lh.n++; // < log.size

  b->flags |= B_DIRTY; // needs to be written to disk
801032e9:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock); // done with log
801032ec:	c7 45 08 a0 a6 14 80 	movl   $0x8014a6a0,0x8(%ebp)
}
801032f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032f6:	89 ec                	mov    %ebp,%esp
801032f8:	5d                   	pop    %ebp
  release(&log.lock); // done with log
801032f9:	e9 d2 15 00 00       	jmp    801048d0 <release>
801032fe:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno; // lol, even if we pass the if () above we reassign
80103300:	89 0c 95 ec a6 14 80 	mov    %ecx,-0x7feb5914(,%edx,4)
    log.lh.n++; // < log.size
80103307:	42                   	inc    %edx
80103308:	89 15 e8 a6 14 80    	mov    %edx,0x8014a6e8
8010330e:	eb d9                	jmp    801032e9 <log_write+0x69>
    panic("too big a transaction");
80103310:	c7 04 24 53 7d 10 80 	movl   $0x80107d53,(%esp)
80103317:	e8 34 d0 ff ff       	call   80100350 <panic>
    panic("log_write outside of trans");
8010331c:	c7 04 24 69 7d 10 80 	movl   $0x80107d69,(%esp)
80103323:	e8 28 d0 ff ff       	call   80100350 <panic>
80103328:	66 90                	xchg   %ax,%ax
8010332a:	66 90                	xchg   %ax,%ax
8010332c:	66 90                	xchg   %ax,%ax
8010332e:	66 90                	xchg   %ax,%ax

80103330 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	53                   	push   %ebx
80103334:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid()); // this prints each time a cpu is started
80103337:	e8 64 09 00 00       	call   80103ca0 <cpuid>
8010333c:	89 c3                	mov    %eax,%ebx
8010333e:	e8 5d 09 00 00       	call   80103ca0 <cpuid>
80103343:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103347:	c7 04 24 84 7d 10 80 	movl   $0x80107d84,(%esp)
8010334e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103352:	e8 29 d3 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register - this is the interrupt descriptor table
80103357:	e8 44 29 00 00       	call   80105ca0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up.
8010335c:	e8 cf 08 00 00       	call   80103c30 <mycpu>
80103361:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103363:	b8 01 00 00 00       	mov    $0x1,%eax
80103368:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes via the scheduler - this is the "main loop", if you will. The kernel has begun its work.
8010336f:	e8 1c 0c 00 00       	call   80103f90 <scheduler>
80103374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010337b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010337f:	90                   	nop

80103380 <mpenter>:
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103386:	e8 e5 3a 00 00       	call   80106e70 <switchkvm>
  seginit();
8010338b:	e8 50 3a 00 00       	call   80106de0 <seginit>
  lapicinit();
80103390:	e8 fb f7 ff ff       	call   80102b90 <lapicinit>
  mpmain();
80103395:	e8 96 ff ff ff       	call   80103330 <mpmain>
8010339a:	66 90                	xchg   %ax,%ax
8010339c:	66 90                	xchg   %ax,%ax
8010339e:	66 90                	xchg   %ax,%ax

801033a0 <main>:
{
801033a0:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801033a1:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
801033a6:	89 e5                	mov    %esp,%ebp
801033a8:	53                   	push   %ebx
801033a9:	83 e4 f0             	and    $0xfffffff0,%esp
801033ac:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801033af:	89 44 24 04          	mov    %eax,0x4(%esp)
801033b3:	c7 04 24 d0 e4 14 80 	movl   $0x8014e4d0,(%esp)
801033ba:	e8 51 f4 ff ff       	call   80102810 <kinit1>
  kvmalloc();      // kernel page table
801033bf:	e8 7c 3f 00 00       	call   80107340 <kvmalloc>
  mpinit();        // detect other processors
801033c4:	e8 97 01 00 00       	call   80103560 <mpinit>
  lapicinit();     // interrupt controller
801033c9:	e8 c2 f7 ff ff       	call   80102b90 <lapicinit>
  seginit();       // segment descriptors
801033ce:	66 90                	xchg   %ax,%ax
801033d0:	e8 0b 3a 00 00       	call   80106de0 <seginit>
  picinit();       // disable pic
801033d5:	e8 86 03 00 00       	call   80103760 <picinit>
  ioapicinit();    // another interrupt controller
801033da:	e8 51 f1 ff ff       	call   80102530 <ioapicinit>
  consoleinit();   // console hardware
801033df:	90                   	nop
801033e0:	e8 ab d6 ff ff       	call   80100a90 <consoleinit>
  uartinit();      // serial port
801033e5:	e8 66 2c 00 00       	call   80106050 <uartinit>
  pinit();         // process table
801033ea:	e8 21 08 00 00       	call   80103c10 <pinit>
  tvinit();        // trap vectors
801033ef:	90                   	nop
801033f0:	e8 2b 28 00 00       	call   80105c20 <tvinit>
  binit();         // buffer cache
801033f5:	e8 46 cc ff ff       	call   80100040 <binit>
  fileinit();      // file table
801033fa:	e8 91 da ff ff       	call   80100e90 <fileinit>
  ideinit();       // disk 
801033ff:	90                   	nop
80103400:	e8 0b ef ff ff       	call   80102310 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103405:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010340a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010340e:	b8 8c b4 10 80       	mov    $0x8010b48c,%eax
80103413:	89 44 24 04          	mov    %eax,0x4(%esp)
80103417:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
8010341e:	e8 8d 16 00 00       	call   80104ab0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103423:	a1 84 a7 14 80       	mov    0x8014a784,%eax
80103428:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010342b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010342e:	c1 e0 04             	shl    $0x4,%eax
80103431:	05 a0 a7 14 80       	add    $0x8014a7a0,%eax
80103436:	3d a0 a7 14 80       	cmp    $0x8014a7a0,%eax
8010343b:	0f 86 7f 00 00 00    	jbe    801034c0 <main+0x120>
80103441:	bb a0 a7 14 80       	mov    $0x8014a7a0,%ebx
80103446:	eb 25                	jmp    8010346d <main+0xcd>
80103448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010344f:	90                   	nop
80103450:	a1 84 a7 14 80       	mov    0x8014a784,%eax
80103455:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010345b:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010345e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103461:	c1 e0 04             	shl    $0x4,%eax
80103464:	05 a0 a7 14 80       	add    $0x8014a7a0,%eax
80103469:	39 c3                	cmp    %eax,%ebx
8010346b:	73 53                	jae    801034c0 <main+0x120>
    if(c == mycpu())  // We've started already.
8010346d:	e8 be 07 00 00       	call   80103c30 <mycpu>
80103472:	39 c3                	cmp    %eax,%ebx
80103474:	74 da                	je     80103450 <main+0xb0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103476:	e8 25 f4 ff ff       	call   801028a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
8010347b:	ba 80 33 10 80       	mov    $0x80103380,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103480:	b9 00 a0 10 00       	mov    $0x10a000,%ecx
    *(void(**)(void))(code-8) = mpenter;
80103485:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010348b:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
80103491:	05 00 10 00 00       	add    $0x1000,%eax
80103496:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010349b:	b8 00 70 00 00       	mov    $0x7000,%eax
801034a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801034a4:	0f b6 03             	movzbl (%ebx),%eax
801034a7:	89 04 24             	mov    %eax,(%esp)
801034aa:	e8 31 f8 ff ff       	call   80102ce0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801034af:	90                   	nop
801034b0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801034b6:	85 c0                	test   %eax,%eax
801034b8:	74 f6                	je     801034b0 <main+0x110>
801034ba:	eb 94                	jmp    80103450 <main+0xb0>
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801034c0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801034c7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801034cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801034d0:	e8 cb f2 ff ff       	call   801027a0 <kinit2>
  userinit();      // set up first user process
801034d5:	e8 16 08 00 00       	call   80103cf0 <userinit>
  mpmain();        // finish this processor's setup
801034da:	e8 51 fe ff ff       	call   80103330 <mpmain>
801034df:	90                   	nop

801034e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	57                   	push   %edi
801034e4:	56                   	push   %esi
801034e5:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
801034e6:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801034ec:	83 ec 1c             	sub    $0x1c,%esp
  e = addr+len;
801034ef:	8d 9c 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
801034f6:	39 de                	cmp    %ebx,%esi
801034f8:	72 0c                	jb     80103506 <mpsearch1+0x26>
801034fa:	eb 54                	jmp    80103550 <mpsearch1+0x70>
801034fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103500:	39 d9                	cmp    %ebx,%ecx
80103502:	89 ce                	mov    %ecx,%esi
80103504:	73 4a                	jae    80103550 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103506:	89 34 24             	mov    %esi,(%esp)
80103509:	b8 04 00 00 00       	mov    $0x4,%eax
8010350e:	ba 98 7d 10 80       	mov    $0x80107d98,%edx
80103513:	89 44 24 08          	mov    %eax,0x8(%esp)
80103517:	89 54 24 04          	mov    %edx,0x4(%esp)
8010351b:	e8 40 15 00 00       	call   80104a60 <memcmp>
80103520:	8d 4e 10             	lea    0x10(%esi),%ecx
80103523:	85 c0                	test   %eax,%eax
80103525:	75 d9                	jne    80103500 <mpsearch1+0x20>
80103527:	89 f2                	mov    %esi,%edx
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103530:	0f b6 3a             	movzbl (%edx),%edi
  for(i=0; i<len; i++)
80103533:	42                   	inc    %edx
    sum += addr[i];
80103534:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
80103536:	39 ca                	cmp    %ecx,%edx
80103538:	75 f6                	jne    80103530 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010353a:	84 c0                	test   %al,%al
8010353c:	75 c2                	jne    80103500 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
8010353e:	83 c4 1c             	add    $0x1c,%esp
80103541:	89 f0                	mov    %esi,%eax
80103543:	5b                   	pop    %ebx
80103544:	5e                   	pop    %esi
80103545:	5f                   	pop    %edi
80103546:	5d                   	pop    %ebp
80103547:	c3                   	ret    
80103548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010354f:	90                   	nop
80103550:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80103553:	31 f6                	xor    %esi,%esi
}
80103555:	5b                   	pop    %ebx
80103556:	89 f0                	mov    %esi,%eax
80103558:	5e                   	pop    %esi
80103559:	5f                   	pop    %edi
8010355a:	5d                   	pop    %ebp
8010355b:	c3                   	ret    
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103560 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103569:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103570:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103577:	c1 e0 08             	shl    $0x8,%eax
8010357a:	09 d0                	or     %edx,%eax
8010357c:	c1 e0 04             	shl    $0x4,%eax
8010357f:	75 1b                	jne    8010359c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103581:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103588:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010358f:	c1 e0 08             	shl    $0x8,%eax
80103592:	09 d0                	or     %edx,%eax
80103594:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103597:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010359c:	ba 00 04 00 00       	mov    $0x400,%edx
801035a1:	e8 3a ff ff ff       	call   801034e0 <mpsearch1>
801035a6:	85 c0                	test   %eax,%eax
801035a8:	89 c3                	mov    %eax,%ebx
801035aa:	0f 84 50 01 00 00    	je     80103700 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035b0:	8b 73 04             	mov    0x4(%ebx),%esi
801035b3:	85 f6                	test   %esi,%esi
801035b5:	0f 84 35 01 00 00    	je     801036f0 <mpinit+0x190>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801035bb:	8d 8e 00 00 00 80    	lea    -0x80000000(%esi),%ecx
  if(memcmp(conf, "PCMP", 4) != 0)
801035c1:	b8 04 00 00 00       	mov    $0x4,%eax
801035c6:	89 44 24 08          	mov    %eax,0x8(%esp)
801035ca:	ba 9d 7d 10 80       	mov    $0x80107d9d,%edx
801035cf:	89 54 24 04          	mov    %edx,0x4(%esp)
801035d3:	89 0c 24             	mov    %ecx,(%esp)
801035d6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035d9:	e8 82 14 00 00       	call   80104a60 <memcmp>
801035de:	85 c0                	test   %eax,%eax
801035e0:	0f 85 0a 01 00 00    	jne    801036f0 <mpinit+0x190>
  if(conf->version != 1 && conf->version != 4)
801035e6:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801035ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801035f0:	3c 01                	cmp    $0x1,%al
801035f2:	74 08                	je     801035fc <mpinit+0x9c>
801035f4:	3c 04                	cmp    $0x4,%al
801035f6:	0f 85 f4 00 00 00    	jne    801036f0 <mpinit+0x190>
  if(sum((uchar*)conf, conf->length) != 0)
801035fc:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
  for(i=0; i<len; i++)
80103603:	85 ff                	test   %edi,%edi
80103605:	74 22                	je     80103629 <mpinit+0xc9>
80103607:	89 f0                	mov    %esi,%eax
80103609:	01 f7                	add    %esi,%edi
  sum = 0;
8010360b:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010360e:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80103610:	0f b6 b0 00 00 00 80 	movzbl -0x80000000(%eax),%esi
  for(i=0; i<len; i++)
80103617:	40                   	inc    %eax
    sum += addr[i];
80103618:	01 f2                	add    %esi,%edx
  for(i=0; i<len; i++)
8010361a:	39 c7                	cmp    %eax,%edi
8010361c:	75 f2                	jne    80103610 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
8010361e:	84 d2                	test   %dl,%dl
80103620:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103623:	0f 85 c7 00 00 00    	jne    801036f0 <mpinit+0x190>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103629:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010362c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103632:	8d 96 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edx
  lapic = (uint*)conf->lapicaddr;
80103638:	a3 84 a6 14 80       	mov    %eax,0x8014a684
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010363d:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
  ismp = 1;
80103644:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103649:	01 c1                	add    %eax,%ecx
8010364b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010364f:	90                   	nop
80103650:	39 ca                	cmp    %ecx,%edx
80103652:	73 15                	jae    80103669 <mpinit+0x109>
    switch(*p){
80103654:	0f b6 02             	movzbl (%edx),%eax
80103657:	3c 02                	cmp    $0x2,%al
80103659:	74 4d                	je     801036a8 <mpinit+0x148>
8010365b:	77 3b                	ja     80103698 <mpinit+0x138>
8010365d:	84 c0                	test   %al,%al
8010365f:	90                   	nop
80103660:	74 5e                	je     801036c0 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103662:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103665:	39 ca                	cmp    %ecx,%edx
80103667:	72 eb                	jb     80103654 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103669:	85 f6                	test   %esi,%esi
8010366b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010366e:	0f 84 df 00 00 00    	je     80103753 <mpinit+0x1f3>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103674:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103678:	74 11                	je     8010368b <mpinit+0x12b>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010367a:	b0 70                	mov    $0x70,%al
8010367c:	ba 22 00 00 00       	mov    $0x22,%edx
80103681:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103682:	ba 23 00 00 00       	mov    $0x23,%edx
80103687:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103688:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010368a:	ee                   	out    %al,(%dx)
  }
}
8010368b:	83 c4 2c             	add    $0x2c,%esp
8010368e:	5b                   	pop    %ebx
8010368f:	5e                   	pop    %esi
80103690:	5f                   	pop    %edi
80103691:	5d                   	pop    %ebp
80103692:	c3                   	ret    
80103693:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103697:	90                   	nop
    switch(*p){
80103698:	2c 03                	sub    $0x3,%al
8010369a:	3c 01                	cmp    $0x1,%al
8010369c:	76 c4                	jbe    80103662 <mpinit+0x102>
8010369e:	31 f6                	xor    %esi,%esi
801036a0:	eb ae                	jmp    80103650 <mpinit+0xf0>
801036a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
801036a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
801036ac:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
801036af:	a2 80 a7 14 80       	mov    %al,0x8014a780
      continue;
801036b4:	eb 9a                	jmp    80103650 <mpinit+0xf0>
801036b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036bd:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801036c0:	a1 84 a7 14 80       	mov    0x8014a784,%eax
801036c5:	83 f8 07             	cmp    $0x7,%eax
801036c8:	7f 19                	jg     801036e3 <mpinit+0x183>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801036ca:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
801036ce:	8d 3c 80             	lea    (%eax,%eax,4),%edi
801036d1:	8d 3c 78             	lea    (%eax,%edi,2),%edi
        ncpu++;
801036d4:	40                   	inc    %eax
801036d5:	a3 84 a7 14 80       	mov    %eax,0x8014a784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801036da:	c1 e7 04             	shl    $0x4,%edi
801036dd:	88 9f a0 a7 14 80    	mov    %bl,-0x7feb5860(%edi)
      p += sizeof(struct mpproc);
801036e3:	83 c2 14             	add    $0x14,%edx
      continue;
801036e6:	e9 65 ff ff ff       	jmp    80103650 <mpinit+0xf0>
801036eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036ef:	90                   	nop
    panic("Expect to run on an SMP");
801036f0:	c7 04 24 a2 7d 10 80 	movl   $0x80107da2,(%esp)
801036f7:	e8 54 cc ff ff       	call   80100350 <panic>
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
80103700:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103705:	eb 13                	jmp    8010371a <mpinit+0x1ba>
80103707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103710:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103716:	89 f3                	mov    %esi,%ebx
80103718:	74 d6                	je     801036f0 <mpinit+0x190>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010371a:	89 1c 24             	mov    %ebx,(%esp)
8010371d:	b9 04 00 00 00       	mov    $0x4,%ecx
80103722:	be 98 7d 10 80       	mov    $0x80107d98,%esi
80103727:	89 74 24 04          	mov    %esi,0x4(%esp)
8010372b:	8d 73 10             	lea    0x10(%ebx),%esi
8010372e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103732:	e8 29 13 00 00       	call   80104a60 <memcmp>
80103737:	85 c0                	test   %eax,%eax
80103739:	75 d5                	jne    80103710 <mpinit+0x1b0>
8010373b:	89 da                	mov    %ebx,%edx
8010373d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103740:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103743:	42                   	inc    %edx
    sum += addr[i];
80103744:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103746:	39 f2                	cmp    %esi,%edx
80103748:	75 f6                	jne    80103740 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010374a:	84 c0                	test   %al,%al
8010374c:	75 c2                	jne    80103710 <mpinit+0x1b0>
8010374e:	e9 5d fe ff ff       	jmp    801035b0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103753:	c7 04 24 bc 7d 10 80 	movl   $0x80107dbc,(%esp)
8010375a:	e8 f1 cb ff ff       	call   80100350 <panic>
8010375f:	90                   	nop

80103760 <picinit>:
80103760:	b0 ff                	mov    $0xff,%al
80103762:	ba 21 00 00 00       	mov    $0x21,%edx
80103767:	ee                   	out    %al,(%dx)
80103768:	ba a1 00 00 00       	mov    $0xa1,%edx
8010376d:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
8010376e:	c3                   	ret    
8010376f:	90                   	nop

80103770 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	57                   	push   %edi
80103774:	56                   	push   %esi
80103775:	53                   	push   %ebx
80103776:	83 ec 1c             	sub    $0x1c,%esp
80103779:	8b 75 08             	mov    0x8(%ebp),%esi
8010377c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010377f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103785:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010378b:	e8 20 d7 ff ff       	call   80100eb0 <filealloc>
80103790:	89 06                	mov    %eax,(%esi)
80103792:	85 c0                	test   %eax,%eax
80103794:	0f 84 9f 00 00 00    	je     80103839 <pipealloc+0xc9>
8010379a:	e8 11 d7 ff ff       	call   80100eb0 <filealloc>
8010379f:	89 07                	mov    %eax,(%edi)
801037a1:	85 c0                	test   %eax,%eax
801037a3:	0f 84 82 00 00 00    	je     8010382b <pipealloc+0xbb>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801037a9:	e8 f2 f0 ff ff       	call   801028a0 <kalloc>
801037ae:	85 c0                	test   %eax,%eax
801037b0:	89 c3                	mov    %eax,%ebx
801037b2:	0f 84 96 00 00 00    	je     8010384e <pipealloc+0xde>
    goto bad;
  p->readopen = 1;
801037b8:	b8 01 00 00 00       	mov    $0x1,%eax
  p->writeopen = 1;
801037bd:	ba 01 00 00 00       	mov    $0x1,%edx
  p->readopen = 1;
801037c2:	89 83 3c 02 00 00    	mov    %eax,0x23c(%ebx)
  p->nwrite = 0;
  p->nread = 0;
801037c8:	31 c0                	xor    %eax,%eax
  p->nwrite = 0;
801037ca:	31 c9                	xor    %ecx,%ecx
  p->nread = 0;
801037cc:	89 83 34 02 00 00    	mov    %eax,0x234(%ebx)
  initlock(&p->lock, "pipe");
801037d2:	b8 db 7d 10 80       	mov    $0x80107ddb,%eax
  p->writeopen = 1;
801037d7:	89 93 40 02 00 00    	mov    %edx,0x240(%ebx)
  p->nwrite = 0;
801037dd:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
  initlock(&p->lock, "pipe");
801037e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801037e7:	89 1c 24             	mov    %ebx,(%esp)
801037ea:	e8 61 0f 00 00       	call   80104750 <initlock>
  (*f0)->type = FD_PIPE;
801037ef:	8b 06                	mov    (%esi),%eax
801037f1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801037f7:	8b 06                	mov    (%esi),%eax
801037f9:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801037fd:	8b 06                	mov    (%esi),%eax
801037ff:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103803:	8b 06                	mov    (%esi),%eax
80103805:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103808:	8b 07                	mov    (%edi),%eax
8010380a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103810:	8b 07                	mov    (%edi),%eax
80103812:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103816:	8b 07                	mov    (%edi),%eax
80103818:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010381c:	8b 07                	mov    (%edi),%eax
8010381e:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103821:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103823:	83 c4 1c             	add    $0x1c,%esp
80103826:	5b                   	pop    %ebx
80103827:	5e                   	pop    %esi
80103828:	5f                   	pop    %edi
80103829:	5d                   	pop    %ebp
8010382a:	c3                   	ret    
  if(*f0)
8010382b:	8b 06                	mov    (%esi),%eax
8010382d:	85 c0                	test   %eax,%eax
8010382f:	74 16                	je     80103847 <pipealloc+0xd7>
    fileclose(*f0);
80103831:	89 04 24             	mov    %eax,(%esp)
80103834:	e8 37 d7 ff ff       	call   80100f70 <fileclose>
  if(*f1)
80103839:	8b 07                	mov    (%edi),%eax
8010383b:	85 c0                	test   %eax,%eax
8010383d:	74 08                	je     80103847 <pipealloc+0xd7>
    fileclose(*f1);
8010383f:	89 04 24             	mov    %eax,(%esp)
80103842:	e8 29 d7 ff ff       	call   80100f70 <fileclose>
  return -1;
80103847:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010384c:	eb d5                	jmp    80103823 <pipealloc+0xb3>
  if(*f0)
8010384e:	8b 06                	mov    (%esi),%eax
80103850:	85 c0                	test   %eax,%eax
80103852:	75 dd                	jne    80103831 <pipealloc+0xc1>
80103854:	eb e3                	jmp    80103839 <pipealloc+0xc9>
80103856:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385d:	8d 76 00             	lea    0x0(%esi),%esi

80103860 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 18             	sub    $0x18,%esp
80103866:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103869:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010386c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010386f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103872:	89 1c 24             	mov    %ebx,(%esp)
80103875:	e8 c6 10 00 00       	call   80104940 <acquire>
  if(writable){
8010387a:	85 f6                	test   %esi,%esi
8010387c:	74 62                	je     801038e0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010387e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103884:	31 f6                	xor    %esi,%esi
80103886:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
8010388c:	89 04 24             	mov    %eax,(%esp)
8010388f:	e8 bc 0b 00 00       	call   80104450 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103894:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010389a:	85 d2                	test   %edx,%edx
8010389c:	75 0a                	jne    801038a8 <pipeclose+0x48>
8010389e:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801038a4:	85 c0                	test   %eax,%eax
801038a6:	74 18                	je     801038c0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801038a8:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801038ab:	8b 75 fc             	mov    -0x4(%ebp),%esi
801038ae:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801038b1:	89 ec                	mov    %ebp,%esp
801038b3:	5d                   	pop    %ebp
    release(&p->lock);
801038b4:	e9 17 10 00 00       	jmp    801048d0 <release>
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801038c0:	89 1c 24             	mov    %ebx,(%esp)
801038c3:	e8 08 10 00 00       	call   801048d0 <release>
}
801038c8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
801038cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801038ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801038d1:	89 ec                	mov    %ebp,%esp
801038d3:	5d                   	pop    %ebp
    kfree((char*)p);
801038d4:	e9 57 ed ff ff       	jmp    80102630 <kfree>
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801038e0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801038e6:	31 c9                	xor    %ecx,%ecx
801038e8:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
801038ee:	89 04 24             	mov    %eax,(%esp)
801038f1:	e8 5a 0b 00 00       	call   80104450 <wakeup>
801038f6:	eb 9c                	jmp    80103894 <pipeclose+0x34>
801038f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ff:	90                   	nop

80103900 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	57                   	push   %edi
80103904:	56                   	push   %esi
80103905:	53                   	push   %ebx
80103906:	83 ec 2c             	sub    $0x2c,%esp
80103909:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010390f:	89 1c 24             	mov    %ebx,(%esp)
80103912:	e8 29 10 00 00       	call   80104940 <acquire>
  for(i = 0; i < n; i++){
80103917:	85 ff                	test   %edi,%edi
80103919:	0f 8e c5 00 00 00    	jle    801039e4 <pipewrite+0xe4>
8010391f:	89 7d 10             	mov    %edi,0x10(%ebp)
80103922:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103925:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010392b:	8d 34 39             	lea    (%ecx,%edi,1),%esi
8010392e:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103931:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
80103937:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010393a:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103940:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103946:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010394c:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
8010394f:	0f 85 a9 00 00 00    	jne    801039fe <pipewrite+0xfe>
80103955:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103958:	eb 3b                	jmp    80103995 <pipewrite+0x95>
8010395a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103960:	e8 5b 03 00 00       	call   80103cc0 <myproc>
80103965:	8b 40 24             	mov    0x24(%eax),%eax
80103968:	85 c0                	test   %eax,%eax
8010396a:	75 33                	jne    8010399f <pipewrite+0x9f>
      wakeup(&p->nread);
8010396c:	89 34 24             	mov    %esi,(%esp)
8010396f:	e8 dc 0a 00 00       	call   80104450 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103974:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103978:	89 3c 24             	mov    %edi,(%esp)
8010397b:	e8 00 0a 00 00       	call   80104380 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103980:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103986:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010398c:	05 00 02 00 00       	add    $0x200,%eax
80103991:	39 c2                	cmp    %eax,%edx
80103993:	75 23                	jne    801039b8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103995:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010399b:	85 d2                	test   %edx,%edx
8010399d:	75 c1                	jne    80103960 <pipewrite+0x60>
        release(&p->lock);
8010399f:	89 1c 24             	mov    %ebx,(%esp)
801039a2:	e8 29 0f 00 00       	call   801048d0 <release>
        return -1;
801039a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801039ac:	83 c4 2c             	add    $0x2c,%esp
801039af:	5b                   	pop    %ebx
801039b0:	5e                   	pop    %esi
801039b1:	5f                   	pop    %edi
801039b2:	5d                   	pop    %ebp
801039b3:	c3                   	ret    
801039b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801039bb:	8d 42 01             	lea    0x1(%edx),%eax
801039be:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801039c4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
  for(i = 0; i < n; i++){
801039ca:	41                   	inc    %ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801039cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039ce:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801039d2:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801039d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801039d9:	39 c1                	cmp    %eax,%ecx
801039db:	0f 85 59 ff ff ff    	jne    8010393a <pipewrite+0x3a>
801039e1:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801039e4:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801039ea:	89 04 24             	mov    %eax,(%esp)
801039ed:	e8 5e 0a 00 00       	call   80104450 <wakeup>
  release(&p->lock);
801039f2:	89 1c 24             	mov    %ebx,(%esp)
801039f5:	e8 d6 0e 00 00       	call   801048d0 <release>
  return n;
801039fa:	89 f8                	mov    %edi,%eax
801039fc:	eb ae                	jmp    801039ac <pipewrite+0xac>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a01:	eb b8                	jmp    801039bb <pipewrite+0xbb>
80103a03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a10 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	57                   	push   %edi
80103a14:	56                   	push   %esi
80103a15:	53                   	push   %ebx
80103a16:	83 ec 1c             	sub    $0x1c,%esp
80103a19:	8b 75 08             	mov    0x8(%ebp),%esi
80103a1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103a1f:	89 34 24             	mov    %esi,(%esp)
80103a22:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103a28:	e8 13 0f 00 00       	call   80104940 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a2d:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a33:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103a39:	74 2f                	je     80103a6a <piperead+0x5a>
80103a3b:	eb 37                	jmp    80103a74 <piperead+0x64>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103a40:	e8 7b 02 00 00       	call   80103cc0 <myproc>
80103a45:	8b 48 24             	mov    0x24(%eax),%ecx
80103a48:	85 c9                	test   %ecx,%ecx
80103a4a:	0f 85 80 00 00 00    	jne    80103ad0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103a50:	89 74 24 04          	mov    %esi,0x4(%esp)
80103a54:	89 1c 24             	mov    %ebx,(%esp)
80103a57:	e8 24 09 00 00       	call   80104380 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a5c:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103a62:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103a68:	75 0a                	jne    80103a74 <piperead+0x64>
80103a6a:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103a70:	85 c0                	test   %eax,%eax
80103a72:	75 cc                	jne    80103a40 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a74:	8b 55 10             	mov    0x10(%ebp),%edx
80103a77:	31 db                	xor    %ebx,%ebx
80103a79:	85 d2                	test   %edx,%edx
80103a7b:	7f 1f                	jg     80103a9c <piperead+0x8c>
80103a7d:	eb 2b                	jmp    80103aaa <piperead+0x9a>
80103a7f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103a80:	8d 48 01             	lea    0x1(%eax),%ecx
80103a83:	25 ff 01 00 00       	and    $0x1ff,%eax
80103a88:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103a8e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103a93:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103a96:	43                   	inc    %ebx
80103a97:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103a9a:	74 0e                	je     80103aaa <piperead+0x9a>
    if(p->nread == p->nwrite)
80103a9c:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103aa2:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103aa8:	75 d6                	jne    80103a80 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103aaa:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103ab0:	89 04 24             	mov    %eax,(%esp)
80103ab3:	e8 98 09 00 00       	call   80104450 <wakeup>
  release(&p->lock);
80103ab8:	89 34 24             	mov    %esi,(%esp)
80103abb:	e8 10 0e 00 00       	call   801048d0 <release>
  return i;
}
80103ac0:	83 c4 1c             	add    $0x1c,%esp
80103ac3:	89 d8                	mov    %ebx,%eax
80103ac5:	5b                   	pop    %ebx
80103ac6:	5e                   	pop    %esi
80103ac7:	5f                   	pop    %edi
80103ac8:	5d                   	pop    %ebp
80103ac9:	c3                   	ret    
80103aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
80103ad0:	89 34 24             	mov    %esi,(%esp)
      return -1;
80103ad3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103ad8:	e8 f3 0d 00 00       	call   801048d0 <release>
}
80103add:	83 c4 1c             	add    $0x1c,%esp
80103ae0:	89 d8                	mov    %ebx,%eax
80103ae2:	5b                   	pop    %ebx
80103ae3:	5e                   	pop    %esi
80103ae4:	5f                   	pop    %edi
80103ae5:	5d                   	pop    %ebp
80103ae6:	c3                   	ret    
80103ae7:	66 90                	xchg   %ax,%ax
80103ae9:	66 90                	xchg   %ax,%ax
80103aeb:	66 90                	xchg   %ax,%ax
80103aed:	66 90                	xchg   %ax,%ax
80103aef:	90                   	nop

80103af0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	83 ec 18             	sub    $0x18,%esp
80103af6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103af9:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
  acquire(&ptable.lock);
80103afe:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103b05:	e8 36 0e 00 00       	call   80104940 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b0a:	eb 0f                	jmp    80103b1b <allocproc+0x2b>
80103b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b10:	83 c3 7c             	add    $0x7c,%ebx
80103b13:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80103b19:	74 7d                	je     80103b98 <allocproc+0xa8>
    if(p->state == UNUSED)
80103b1b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103b1e:	85 c9                	test   %ecx,%ecx
80103b20:	75 ee                	jne    80103b10 <allocproc+0x20>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103b22:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103b29:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103b2e:	89 43 10             	mov    %eax,0x10(%ebx)
80103b31:	8d 50 01             	lea    0x1(%eax),%edx
80103b34:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80103b3a:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103b41:	e8 8a 0d 00 00       	call   801048d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103b46:	e8 55 ed ff ff       	call   801028a0 <kalloc>
80103b4b:	89 43 08             	mov    %eax,0x8(%ebx)
80103b4e:	85 c0                	test   %eax,%eax
80103b50:	74 5d                	je     80103baf <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103b52:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103b58:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
80103b5d:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103b60:	ba 0d 5c 10 80       	mov    $0x80105c0d,%edx
  sp -= sizeof *p->context;
80103b65:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
80103b6a:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
80103b6d:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
80103b6f:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103b72:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103b76:	89 54 24 04          	mov    %edx,0x4(%esp)
80103b7a:	89 04 24             	mov    %eax,(%esp)
80103b7d:	e8 9e 0e 00 00       	call   80104a20 <memset>
  p->context->eip = (uint)forkret;
80103b82:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103b85:	c7 40 10 c0 3b 10 80 	movl   $0x80103bc0,0x10(%eax)

  return p;
}
80103b8c:	89 d8                	mov    %ebx,%eax
80103b8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b91:	89 ec                	mov    %ebp,%esp
80103b93:	5d                   	pop    %ebp
80103b94:	c3                   	ret    
80103b95:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103b98:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
  return 0;
80103b9f:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103ba1:	e8 2a 0d 00 00       	call   801048d0 <release>
}
80103ba6:	89 d8                	mov    %ebx,%eax
80103ba8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bab:	89 ec                	mov    %ebp,%esp
80103bad:	5d                   	pop    %ebp
80103bae:	c3                   	ret    
    p->state = UNUSED;
80103baf:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103bb6:	31 db                	xor    %ebx,%ebx
80103bb8:	eb ec                	jmp    80103ba6 <allocproc+0xb6>
80103bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103bc0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103bc6:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103bcd:	e8 fe 0c 00 00       	call   801048d0 <release>

  if (first) {
80103bd2:	8b 15 00 b0 10 80    	mov    0x8010b000,%edx
80103bd8:	85 d2                	test   %edx,%edx
80103bda:	75 04                	jne    80103be0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103bdc:	89 ec                	mov    %ebp,%esp
80103bde:	5d                   	pop    %ebp
80103bdf:	c3                   	ret    
    first = 0;
80103be0:	31 c0                	xor    %eax,%eax
80103be2:	a3 00 b0 10 80       	mov    %eax,0x8010b000
    iinit(ROOTDEV);
80103be7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103bee:	e8 1d da ff ff       	call   80101610 <iinit>
    initlog(ROOTDEV);
80103bf3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103bfa:	e8 41 f4 ff ff       	call   80103040 <initlog>
}
80103bff:	89 ec                	mov    %ebp,%esp
80103c01:	5d                   	pop    %ebp
80103c02:	c3                   	ret    
80103c03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103c10 <pinit>:
{
80103c10:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
80103c11:	b8 e0 7d 10 80       	mov    $0x80107de0,%eax
{
80103c16:	89 e5                	mov    %esp,%ebp
80103c18:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c1f:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103c26:	e8 25 0b 00 00       	call   80104750 <initlock>
}
80103c2b:	89 ec                	mov    %ebp,%esp
80103c2d:	5d                   	pop    %ebp
80103c2e:	c3                   	ret    
80103c2f:	90                   	nop

80103c30 <mycpu>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	56                   	push   %esi
80103c34:	53                   	push   %ebx
80103c35:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c38:	9c                   	pushf  
80103c39:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c3a:	f6 c4 02             	test   $0x2,%ah
80103c3d:	75 4a                	jne    80103c89 <mycpu+0x59>
  apicid = lapicid();
80103c3f:	e8 4c f0 ff ff       	call   80102c90 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103c44:	8b 35 84 a7 14 80    	mov    0x8014a784,%esi
80103c4a:	85 f6                	test   %esi,%esi
  apicid = lapicid();
80103c4c:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103c4e:	7e 2d                	jle    80103c7d <mycpu+0x4d>
80103c50:	31 d2                	xor    %edx,%edx
80103c52:	eb 09                	jmp    80103c5d <mycpu+0x2d>
80103c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c58:	42                   	inc    %edx
80103c59:	39 f2                	cmp    %esi,%edx
80103c5b:	74 20                	je     80103c7d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103c5d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103c60:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103c63:	c1 e0 04             	shl    $0x4,%eax
80103c66:	0f b6 88 a0 a7 14 80 	movzbl -0x7feb5860(%eax),%ecx
80103c6d:	39 d9                	cmp    %ebx,%ecx
80103c6f:	75 e7                	jne    80103c58 <mycpu+0x28>
}
80103c71:	83 c4 10             	add    $0x10,%esp
      return &cpus[i];
80103c74:	05 a0 a7 14 80       	add    $0x8014a7a0,%eax
}
80103c79:	5b                   	pop    %ebx
80103c7a:	5e                   	pop    %esi
80103c7b:	5d                   	pop    %ebp
80103c7c:	c3                   	ret    
  panic("unknown apicid\n");
80103c7d:	c7 04 24 e7 7d 10 80 	movl   $0x80107de7,(%esp)
80103c84:	e8 c7 c6 ff ff       	call   80100350 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c89:	c7 04 24 c4 7e 10 80 	movl   $0x80107ec4,(%esp)
80103c90:	e8 bb c6 ff ff       	call   80100350 <panic>
80103c95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ca0 <cpuid>:
cpuid() {
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103ca6:	e8 85 ff ff ff       	call   80103c30 <mycpu>
}
80103cab:	89 ec                	mov    %ebp,%esp
80103cad:	5d                   	pop    %ebp
  return mycpu()-cpus;
80103cae:	2d a0 a7 14 80       	sub    $0x8014a7a0,%eax
80103cb3:	c1 f8 04             	sar    $0x4,%eax
80103cb6:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103cbc:	c3                   	ret    
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi

80103cc0 <myproc>:
myproc(void) {
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	83 ec 08             	sub    $0x8,%esp
80103cc6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  pushcli();
80103cc9:	e8 02 0b 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103cce:	e8 5d ff ff ff       	call   80103c30 <mycpu>
  p = c->proc;
80103cd3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd9:	e8 42 0b 00 00       	call   80104820 <popcli>
}
80103cde:	89 d8                	mov    %ebx,%eax
80103ce0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ce3:	89 ec                	mov    %ebp,%esp
80103ce5:	5d                   	pop    %ebp
80103ce6:	c3                   	ret    
80103ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cee:	66 90                	xchg   %ax,%ax

80103cf0 <userinit>:
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	83 ec 18             	sub    $0x18,%esp
80103cf6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  p = allocproc();
80103cf9:	e8 f2 fd ff ff       	call   80103af0 <allocproc>
  initproc = p;
80103cfe:	a3 54 cc 14 80       	mov    %eax,0x8014cc54
  p = allocproc();
80103d03:	89 c3                	mov    %eax,%ebx
  if((p->pgdir = setupkvm()) == 0)
80103d05:	e8 b6 35 00 00       	call   801072c0 <setupkvm>
80103d0a:	89 43 04             	mov    %eax,0x4(%ebx)
80103d0d:	85 c0                	test   %eax,%eax
80103d0f:	0f 84 d0 00 00 00    	je     80103de5 <userinit+0xf5>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103d15:	89 04 24             	mov    %eax,(%esp)
80103d18:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103d1d:	b9 60 b4 10 80       	mov    $0x8010b460,%ecx
80103d22:	89 54 24 08          	mov    %edx,0x8(%esp)
80103d26:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103d2a:	e8 51 32 00 00       	call   80106f80 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103d2f:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103d34:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103d3a:	89 44 24 08          	mov    %eax,0x8(%esp)
80103d3e:	31 c0                	xor    %eax,%eax
80103d40:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d44:	8b 43 18             	mov    0x18(%ebx),%eax
80103d47:	89 04 24             	mov    %eax,(%esp)
80103d4a:	e8 d1 0c 00 00       	call   80104a20 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d52:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d58:	8b 43 18             	mov    0x18(%ebx),%eax
80103d5b:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103d61:	8b 43 18             	mov    0x18(%ebx),%eax
80103d64:	8b 50 2c             	mov    0x2c(%eax),%edx
80103d67:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103d6b:	8b 43 18             	mov    0x18(%ebx),%eax
80103d6e:	8b 48 2c             	mov    0x2c(%eax),%ecx
80103d71:	66 89 48 48          	mov    %cx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103d75:	8b 43 18             	mov    0x18(%ebx),%eax
80103d78:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d7f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d82:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d89:	8b 43 18             	mov    0x18(%ebx),%eax
80103d8c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d93:	b8 10 00 00 00       	mov    $0x10,%eax
80103d98:	89 44 24 08          	mov    %eax,0x8(%esp)
80103d9c:	b8 10 7e 10 80       	mov    $0x80107e10,%eax
80103da1:	89 44 24 04          	mov    %eax,0x4(%esp)
80103da5:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103da8:	89 04 24             	mov    %eax,(%esp)
80103dab:	e8 10 0e 00 00       	call   80104bc0 <safestrcpy>
  p->cwd = namei("/");
80103db0:	c7 04 24 19 7e 10 80 	movl   $0x80107e19,(%esp)
80103db7:	e8 44 e4 ff ff       	call   80102200 <namei>
80103dbc:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103dbf:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103dc6:	e8 75 0b 00 00       	call   80104940 <acquire>
  p->state = RUNNABLE;
80103dcb:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103dd2:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103dd9:	e8 f2 0a 00 00       	call   801048d0 <release>
}
80103dde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103de1:	89 ec                	mov    %ebp,%esp
80103de3:	5d                   	pop    %ebp
80103de4:	c3                   	ret    
    panic("userinit: out of memory?");
80103de5:	c7 04 24 f7 7d 10 80 	movl   $0x80107df7,(%esp)
80103dec:	e8 5f c5 ff ff       	call   80100350 <panic>
80103df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103df8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dff:	90                   	nop

80103e00 <growproc>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	53                   	push   %ebx
80103e05:	83 ec 10             	sub    $0x10,%esp
80103e08:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103e0b:	e8 c0 09 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103e10:	e8 1b fe ff ff       	call   80103c30 <mycpu>
  p = c->proc;
80103e15:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e1b:	e8 00 0a 00 00       	call   80104820 <popcli>
  if(n > 0){
80103e20:	85 f6                	test   %esi,%esi
  sz = curproc->sz;
80103e22:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103e24:	7f 1a                	jg     80103e40 <growproc+0x40>
  } else if(n < 0){
80103e26:	75 38                	jne    80103e60 <growproc+0x60>
  curproc->sz = sz;
80103e28:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103e2a:	89 1c 24             	mov    %ebx,(%esp)
80103e2d:	e8 4e 30 00 00       	call   80106e80 <switchuvm>
  return 0;
80103e32:	31 c0                	xor    %eax,%eax
}
80103e34:	83 c4 10             	add    $0x10,%esp
80103e37:	5b                   	pop    %ebx
80103e38:	5e                   	pop    %esi
80103e39:	5d                   	pop    %ebp
80103e3a:	c3                   	ret    
80103e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e3f:	90                   	nop
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e40:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e44:	01 c6                	add    %eax,%esi
80103e46:	89 74 24 08          	mov    %esi,0x8(%esp)
80103e4a:	8b 43 04             	mov    0x4(%ebx),%eax
80103e4d:	89 04 24             	mov    %eax,(%esp)
80103e50:	e8 ab 32 00 00       	call   80107100 <allocuvm>
80103e55:	85 c0                	test   %eax,%eax
80103e57:	75 cf                	jne    80103e28 <growproc+0x28>
      return -1;
80103e59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e5e:	eb d4                	jmp    80103e34 <growproc+0x34>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e60:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e64:	01 c6                	add    %eax,%esi
80103e66:	89 74 24 08          	mov    %esi,0x8(%esp)
80103e6a:	8b 43 04             	mov    0x4(%ebx),%eax
80103e6d:	89 04 24             	mov    %eax,(%esp)
80103e70:	e8 9b 33 00 00       	call   80107210 <deallocuvm>
80103e75:	85 c0                	test   %eax,%eax
80103e77:	75 af                	jne    80103e28 <growproc+0x28>
80103e79:	eb de                	jmp    80103e59 <growproc+0x59>
80103e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e7f:	90                   	nop

80103e80 <fork>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e89:	e8 42 09 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80103e8e:	e8 9d fd ff ff       	call   80103c30 <mycpu>
  p = c->proc;
80103e93:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103e99:	e8 82 09 00 00       	call   80104820 <popcli>
  if((np = allocproc()) == 0){
80103e9e:	e8 4d fc ff ff       	call   80103af0 <allocproc>
80103ea3:	85 c0                	test   %eax,%eax
80103ea5:	0f 84 dd 00 00 00    	je     80103f88 <fork+0x108>
80103eab:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103ead:	8b 07                	mov    (%edi),%eax
80103eaf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103eb3:	8b 47 04             	mov    0x4(%edi),%eax
80103eb6:	89 04 24             	mov    %eax,(%esp)
80103eb9:	e8 72 35 00 00       	call   80107430 <copyuvm>
80103ebe:	89 46 04             	mov    %eax,0x4(%esi)
80103ec1:	85 c0                	test   %eax,%eax
80103ec3:	0f 84 a6 00 00 00    	je     80103f6f <fork+0xef>
  np->sz = curproc->sz;
80103ec9:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103ecb:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103ece:	8b 4e 18             	mov    0x18(%esi),%ecx
  np->sz = curproc->sz;
80103ed1:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103ed3:	31 c0                	xor    %eax,%eax
80103ed5:	8b 5f 18             	mov    0x18(%edi),%ebx
80103ed8:	8b 14 03             	mov    (%ebx,%eax,1),%edx
80103edb:	89 14 01             	mov    %edx,(%ecx,%eax,1)
80103ede:	83 c0 04             	add    $0x4,%eax
80103ee1:	83 f8 4c             	cmp    $0x4c,%eax
80103ee4:	72 f2                	jb     80103ed8 <fork+0x58>
  np->tf->eax = 0;
80103ee6:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103ee9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103eeb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103f00:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103f04:	85 c0                	test   %eax,%eax
80103f06:	74 0c                	je     80103f14 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103f08:	89 04 24             	mov    %eax,(%esp)
80103f0b:	e8 10 d0 ff ff       	call   80100f20 <filedup>
80103f10:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103f14:	43                   	inc    %ebx
80103f15:	83 fb 10             	cmp    $0x10,%ebx
80103f18:	75 e6                	jne    80103f00 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103f1a:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f1d:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103f20:	89 04 24             	mov    %eax,(%esp)
80103f23:	e8 18 d9 ff ff       	call   80101840 <idup>
80103f28:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103f2b:	b8 10 00 00 00       	mov    $0x10,%eax
80103f30:	89 44 24 08          	mov    %eax,0x8(%esp)
80103f34:	8d 46 6c             	lea    0x6c(%esi),%eax
80103f37:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103f3b:	89 04 24             	mov    %eax,(%esp)
80103f3e:	e8 7d 0c 00 00       	call   80104bc0 <safestrcpy>
  pid = np->pid;
80103f43:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103f46:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103f4d:	e8 ee 09 00 00       	call   80104940 <acquire>
  np->state = RUNNABLE;
80103f52:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103f59:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80103f60:	e8 6b 09 00 00       	call   801048d0 <release>
}
80103f65:	83 c4 1c             	add    $0x1c,%esp
80103f68:	89 d8                	mov    %ebx,%eax
80103f6a:	5b                   	pop    %ebx
80103f6b:	5e                   	pop    %esi
80103f6c:	5f                   	pop    %edi
80103f6d:	5d                   	pop    %ebp
80103f6e:	c3                   	ret    
    kfree(np->kstack);
80103f6f:	8b 46 08             	mov    0x8(%esi),%eax
80103f72:	89 04 24             	mov    %eax,(%esp)
80103f75:	e8 b6 e6 ff ff       	call   80102630 <kfree>
    np->kstack = 0;
80103f7a:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103f81:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103f88:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f8d:	eb d6                	jmp    80103f65 <fork+0xe5>
80103f8f:	90                   	nop

80103f90 <scheduler>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	57                   	push   %edi
80103f94:	56                   	push   %esi
80103f95:	53                   	push   %ebx
80103f96:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103f99:	e8 92 fc ff ff       	call   80103c30 <mycpu>
  c->proc = 0;
80103f9e:	31 d2                	xor    %edx,%edx
80103fa0:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80103fa6:	8d 78 04             	lea    0x4(%eax),%edi
  struct cpu *c = mycpu();
80103fa9:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103faf:	90                   	nop
  asm volatile("sti");
80103fb0:	fb                   	sti    
    acquire(&ptable.lock);
80103fb1:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb8:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
    acquire(&ptable.lock);
80103fbd:	e8 7e 09 00 00       	call   80104940 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->state != RUNNABLE)
80103fd0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103fd4:	75 31                	jne    80104007 <scheduler+0x77>
      c->proc = p;
80103fd6:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103fdc:	89 1c 24             	mov    %ebx,(%esp)
80103fdf:	e8 9c 2e 00 00       	call   80106e80 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103fe4:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103fe7:	89 3c 24             	mov    %edi,(%esp)
      p->state = RUNNING;
80103fea:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ff1:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ff5:	e8 1f 0c 00 00       	call   80104c19 <swtch>
      switchkvm();
80103ffa:	e8 71 2e 00 00       	call   80106e70 <switchkvm>
      c->proc = 0;
80103fff:	31 c0                	xor    %eax,%eax
80104001:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104007:	83 c3 7c             	add    $0x7c,%ebx
8010400a:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80104010:	75 be                	jne    80103fd0 <scheduler+0x40>
    release(&ptable.lock);
80104012:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104019:	e8 b2 08 00 00       	call   801048d0 <release>
    sti();
8010401e:	eb 90                	jmp    80103fb0 <scheduler+0x20>

80104020 <sched>:
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	56                   	push   %esi
80104024:	53                   	push   %ebx
80104025:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104028:	e8 a3 07 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010402d:	e8 fe fb ff ff       	call   80103c30 <mycpu>
  p = c->proc;
80104032:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104038:	e8 e3 07 00 00       	call   80104820 <popcli>
  if(!holding(&ptable.lock))
8010403d:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104044:	e8 37 08 00 00       	call   80104880 <holding>
80104049:	85 c0                	test   %eax,%eax
8010404b:	74 4f                	je     8010409c <sched+0x7c>
  if(mycpu()->ncli != 1)
8010404d:	e8 de fb ff ff       	call   80103c30 <mycpu>
80104052:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104059:	75 65                	jne    801040c0 <sched+0xa0>
  if(p->state == RUNNING)
8010405b:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
8010405f:	74 53                	je     801040b4 <sched+0x94>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104061:	9c                   	pushf  
80104062:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104063:	f6 c4 02             	test   $0x2,%ah
80104066:	75 40                	jne    801040a8 <sched+0x88>
  intena = mycpu()->intena;
80104068:	e8 c3 fb ff ff       	call   80103c30 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010406d:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104070:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104076:	e8 b5 fb ff ff       	call   80103c30 <mycpu>
8010407b:	8b 40 04             	mov    0x4(%eax),%eax
8010407e:	89 1c 24             	mov    %ebx,(%esp)
80104081:	89 44 24 04          	mov    %eax,0x4(%esp)
80104085:	e8 8f 0b 00 00       	call   80104c19 <swtch>
  mycpu()->intena = intena;
8010408a:	e8 a1 fb ff ff       	call   80103c30 <mycpu>
8010408f:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104095:	83 c4 10             	add    $0x10,%esp
80104098:	5b                   	pop    %ebx
80104099:	5e                   	pop    %esi
8010409a:	5d                   	pop    %ebp
8010409b:	c3                   	ret    
    panic("sched ptable.lock");
8010409c:	c7 04 24 1b 7e 10 80 	movl   $0x80107e1b,(%esp)
801040a3:	e8 a8 c2 ff ff       	call   80100350 <panic>
    panic("sched interruptible");
801040a8:	c7 04 24 47 7e 10 80 	movl   $0x80107e47,(%esp)
801040af:	e8 9c c2 ff ff       	call   80100350 <panic>
    panic("sched running");
801040b4:	c7 04 24 39 7e 10 80 	movl   $0x80107e39,(%esp)
801040bb:	e8 90 c2 ff ff       	call   80100350 <panic>
    panic("sched locks");
801040c0:	c7 04 24 2d 7e 10 80 	movl   $0x80107e2d,(%esp)
801040c7:	e8 84 c2 ff ff       	call   80100350 <panic>
801040cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801040d0 <exit>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
801040d9:	e8 e2 fb ff ff       	call   80103cc0 <myproc>
  if(curproc == initproc)
801040de:	39 05 54 cc 14 80    	cmp    %eax,0x8014cc54
801040e4:	0f 84 fc 00 00 00    	je     801041e6 <exit+0x116>
801040ea:	8d 70 28             	lea    0x28(%eax),%esi
801040ed:	89 c3                	mov    %eax,%ebx
801040ef:	8d 78 68             	lea    0x68(%eax),%edi
801040f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104100:	8b 06                	mov    (%esi),%eax
80104102:	85 c0                	test   %eax,%eax
80104104:	74 0e                	je     80104114 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80104106:	89 04 24             	mov    %eax,(%esp)
80104109:	e8 62 ce ff ff       	call   80100f70 <fileclose>
      curproc->ofile[fd] = 0;
8010410e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(fd = 0; fd < NOFILE; fd++){
80104114:	83 c6 04             	add    $0x4,%esi
80104117:	39 f7                	cmp    %esi,%edi
80104119:	75 e5                	jne    80104100 <exit+0x30>
  begin_op();
8010411b:	e8 c0 ef ff ff       	call   801030e0 <begin_op>
  iput(curproc->cwd);
80104120:	8b 43 68             	mov    0x68(%ebx),%eax
80104123:	89 04 24             	mov    %eax,(%esp)
80104126:	e8 75 d8 ff ff       	call   801019a0 <iput>
  end_op();
8010412b:	e8 20 f0 ff ff       	call   80103150 <end_op>
  curproc->cwd = 0;
80104130:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104137:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
8010413e:	e8 fd 07 00 00       	call   80104940 <acquire>
  wakeup1(curproc->parent);
80104143:	8b 53 14             	mov    0x14(%ebx),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104146:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
8010414b:	eb 0d                	jmp    8010415a <exit+0x8a>
8010414d:	8d 76 00             	lea    0x0(%esi),%esi
80104150:	83 c0 7c             	add    $0x7c,%eax
80104153:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104158:	74 1c                	je     80104176 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010415a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010415e:	75 f0                	jne    80104150 <exit+0x80>
80104160:	3b 50 20             	cmp    0x20(%eax),%edx
80104163:	75 eb                	jne    80104150 <exit+0x80>
      p->state = RUNNABLE;
80104165:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010416c:	83 c0 7c             	add    $0x7c,%eax
8010416f:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104174:	75 e4                	jne    8010415a <exit+0x8a>
      p->parent = initproc;
80104176:	8b 0d 54 cc 14 80    	mov    0x8014cc54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010417c:	ba 54 ad 14 80       	mov    $0x8014ad54,%edx
80104181:	eb 10                	jmp    80104193 <exit+0xc3>
80104183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104187:	90                   	nop
80104188:	83 c2 7c             	add    $0x7c,%edx
8010418b:	81 fa 54 cc 14 80    	cmp    $0x8014cc54,%edx
80104191:	74 3b                	je     801041ce <exit+0xfe>
    if(p->parent == curproc){
80104193:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104196:	75 f0                	jne    80104188 <exit+0xb8>
      if(p->state == ZOMBIE)
80104198:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010419c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010419f:	75 e7                	jne    80104188 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041a1:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
801041a6:	eb 12                	jmp    801041ba <exit+0xea>
801041a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041af:	90                   	nop
801041b0:	83 c0 7c             	add    $0x7c,%eax
801041b3:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
801041b8:	74 ce                	je     80104188 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
801041ba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041be:	75 f0                	jne    801041b0 <exit+0xe0>
801041c0:	3b 48 20             	cmp    0x20(%eax),%ecx
801041c3:	75 eb                	jne    801041b0 <exit+0xe0>
      p->state = RUNNABLE;
801041c5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041cc:	eb e2                	jmp    801041b0 <exit+0xe0>
  curproc->state = ZOMBIE;
801041ce:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801041d5:	e8 46 fe ff ff       	call   80104020 <sched>
  panic("zombie exit");
801041da:	c7 04 24 68 7e 10 80 	movl   $0x80107e68,(%esp)
801041e1:	e8 6a c1 ff ff       	call   80100350 <panic>
    panic("init exiting");
801041e6:	c7 04 24 5b 7e 10 80 	movl   $0x80107e5b,(%esp)
801041ed:	e8 5e c1 ff ff       	call   80100350 <panic>
801041f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104200 <wait>:
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104208:	e8 c3 05 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010420d:	e8 1e fa ff ff       	call   80103c30 <mycpu>
  p = c->proc;
80104212:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104218:	e8 03 06 00 00       	call   80104820 <popcli>
  acquire(&ptable.lock);
8010421d:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104224:	e8 17 07 00 00       	call   80104940 <acquire>
    havekids = 0;
80104229:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010422b:	bb 54 ad 14 80       	mov    $0x8014ad54,%ebx
80104230:	eb 11                	jmp    80104243 <wait+0x43>
80104232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104238:	83 c3 7c             	add    $0x7c,%ebx
8010423b:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
80104241:	74 1b                	je     8010425e <wait+0x5e>
      if(p->parent != curproc)
80104243:	39 73 14             	cmp    %esi,0x14(%ebx)
80104246:	75 f0                	jne    80104238 <wait+0x38>
      if(p->state == ZOMBIE){
80104248:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010424c:	74 62                	je     801042b0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010424e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104251:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104256:	81 fb 54 cc 14 80    	cmp    $0x8014cc54,%ebx
8010425c:	75 e5                	jne    80104243 <wait+0x43>
    if(!havekids || curproc->killed){
8010425e:	85 c0                	test   %eax,%eax
80104260:	0f 84 9f 00 00 00    	je     80104305 <wait+0x105>
80104266:	8b 46 24             	mov    0x24(%esi),%eax
80104269:	85 c0                	test   %eax,%eax
8010426b:	0f 85 94 00 00 00    	jne    80104305 <wait+0x105>
  pushcli();
80104271:	e8 5a 05 00 00       	call   801047d0 <pushcli>
  c = mycpu();
80104276:	e8 b5 f9 ff ff       	call   80103c30 <mycpu>
  p = c->proc;
8010427b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104281:	e8 9a 05 00 00       	call   80104820 <popcli>
  if(p == 0)
80104286:	85 db                	test   %ebx,%ebx
80104288:	0f 84 8a 00 00 00    	je     80104318 <wait+0x118>
  p->chan = chan;
8010428e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104291:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104298:	e8 83 fd ff ff       	call   80104020 <sched>
  p->chan = 0;
8010429d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801042a4:	eb 83                	jmp    80104229 <wait+0x29>
801042a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042ad:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
801042b0:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
801042b3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801042b6:	89 04 24             	mov    %eax,(%esp)
801042b9:	e8 72 e3 ff ff       	call   80102630 <kfree>
        freevm(p->pgdir);
801042be:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
801042c1:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801042c8:	89 04 24             	mov    %eax,(%esp)
801042cb:	e8 70 2f 00 00       	call   80107240 <freevm>
        p->pid = 0;
801042d0:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042d7:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042de:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042e2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042e9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042f0:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801042f7:	e8 d4 05 00 00       	call   801048d0 <release>
}
801042fc:	83 c4 10             	add    $0x10,%esp
801042ff:	89 f0                	mov    %esi,%eax
80104301:	5b                   	pop    %ebx
80104302:	5e                   	pop    %esi
80104303:	5d                   	pop    %ebp
80104304:	c3                   	ret    
      release(&ptable.lock);
80104305:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
      return -1;
8010430c:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104311:	e8 ba 05 00 00       	call   801048d0 <release>
      return -1;
80104316:	eb e4                	jmp    801042fc <wait+0xfc>
    panic("sleep");
80104318:	c7 04 24 74 7e 10 80 	movl   $0x80107e74,(%esp)
8010431f:	e8 2c c0 ff ff       	call   80100350 <panic>
80104324:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010432b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010432f:	90                   	nop

80104330 <yield>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	83 ec 18             	sub    $0x18,%esp
80104336:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  acquire(&ptable.lock);  //DOC: yieldlock
80104339:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104340:	e8 fb 05 00 00       	call   80104940 <acquire>
  pushcli();
80104345:	e8 86 04 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010434a:	e8 e1 f8 ff ff       	call   80103c30 <mycpu>
  p = c->proc;
8010434f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104355:	e8 c6 04 00 00       	call   80104820 <popcli>
  myproc()->state = RUNNABLE;
8010435a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104361:	e8 ba fc ff ff       	call   80104020 <sched>
  release(&ptable.lock);
80104366:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
8010436d:	e8 5e 05 00 00       	call   801048d0 <release>
}
80104372:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104375:	89 ec                	mov    %ebp,%esp
80104377:	5d                   	pop    %ebp
80104378:	c3                   	ret    
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104380 <sleep>:
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	83 ec 28             	sub    $0x28,%esp
80104386:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104389:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010438c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010438f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104392:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80104395:	e8 36 04 00 00       	call   801047d0 <pushcli>
  c = mycpu();
8010439a:	e8 91 f8 ff ff       	call   80103c30 <mycpu>
  p = c->proc;
8010439f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043a5:	e8 76 04 00 00       	call   80104820 <popcli>
  if(p == 0)
801043aa:	85 db                	test   %ebx,%ebx
801043ac:	0f 84 8d 00 00 00    	je     8010443f <sleep+0xbf>
  if(lk == 0)
801043b2:	85 f6                	test   %esi,%esi
801043b4:	74 7d                	je     80104433 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801043b6:	81 fe 20 ad 14 80    	cmp    $0x8014ad20,%esi
801043bc:	74 52                	je     80104410 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
801043be:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801043c5:	e8 76 05 00 00       	call   80104940 <acquire>
    release(lk);
801043ca:	89 34 24             	mov    %esi,(%esp)
801043cd:	e8 fe 04 00 00       	call   801048d0 <release>
  p->chan = chan;
801043d2:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043d5:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043dc:	e8 3f fc ff ff       	call   80104020 <sched>
  p->chan = 0;
801043e1:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801043e8:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801043ef:	e8 dc 04 00 00       	call   801048d0 <release>
}
801043f4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
801043f7:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043fa:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043fd:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104400:	89 ec                	mov    %ebp,%esp
80104402:	5d                   	pop    %ebp
    acquire(lk);
80104403:	e9 38 05 00 00       	jmp    80104940 <acquire>
80104408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010440f:	90                   	nop
  p->chan = chan;
80104410:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104413:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010441a:	e8 01 fc ff ff       	call   80104020 <sched>
  p->chan = 0;
8010441f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104426:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104429:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010442c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010442f:	89 ec                	mov    %ebp,%esp
80104431:	5d                   	pop    %ebp
80104432:	c3                   	ret    
    panic("sleep without lk");
80104433:	c7 04 24 7a 7e 10 80 	movl   $0x80107e7a,(%esp)
8010443a:	e8 11 bf ff ff       	call   80100350 <panic>
    panic("sleep");
8010443f:	c7 04 24 74 7e 10 80 	movl   $0x80107e74,(%esp)
80104446:	e8 05 bf ff ff       	call   80100350 <panic>
8010444b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010444f:	90                   	nop

80104450 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	83 ec 18             	sub    $0x18,%esp
80104456:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104459:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010445c:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104463:	e8 d8 04 00 00       	call   80104940 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104468:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
8010446d:	eb 0b                	jmp    8010447a <wakeup+0x2a>
8010446f:	90                   	nop
80104470:	83 c0 7c             	add    $0x7c,%eax
80104473:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104478:	74 1c                	je     80104496 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010447a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010447e:	75 f0                	jne    80104470 <wakeup+0x20>
80104480:	3b 58 20             	cmp    0x20(%eax),%ebx
80104483:	75 eb                	jne    80104470 <wakeup+0x20>
      p->state = RUNNABLE;
80104485:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010448c:	83 c0 7c             	add    $0x7c,%eax
8010448f:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
80104494:	75 e4                	jne    8010447a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104496:	c7 45 08 20 ad 14 80 	movl   $0x8014ad20,0x8(%ebp)
}
8010449d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044a0:	89 ec                	mov    %ebp,%esp
801044a2:	5d                   	pop    %ebp
  release(&ptable.lock);
801044a3:	e9 28 04 00 00       	jmp    801048d0 <release>
801044a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044af:	90                   	nop

801044b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	83 ec 18             	sub    $0x18,%esp
801044b6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801044b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801044bc:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801044c3:	e8 78 04 00 00       	call   80104940 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044c8:	b8 54 ad 14 80       	mov    $0x8014ad54,%eax
801044cd:	eb 0b                	jmp    801044da <kill+0x2a>
801044cf:	90                   	nop
801044d0:	83 c0 7c             	add    $0x7c,%eax
801044d3:	3d 54 cc 14 80       	cmp    $0x8014cc54,%eax
801044d8:	74 36                	je     80104510 <kill+0x60>
    if(p->pid == pid){
801044da:	39 58 10             	cmp    %ebx,0x10(%eax)
801044dd:	75 f1                	jne    801044d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801044df:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801044e3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801044ea:	75 07                	jne    801044f3 <kill+0x43>
        p->state = RUNNABLE;
801044ec:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801044f3:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
801044fa:	e8 d1 03 00 00       	call   801048d0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104502:	89 ec                	mov    %ebp,%esp
80104504:	5d                   	pop    %ebp
      return 0;
80104505:	31 c0                	xor    %eax,%eax
}
80104507:	c3                   	ret    
80104508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450f:	90                   	nop
  release(&ptable.lock);
80104510:	c7 04 24 20 ad 14 80 	movl   $0x8014ad20,(%esp)
80104517:	e8 b4 03 00 00       	call   801048d0 <release>
}
8010451c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010451f:	89 ec                	mov    %ebp,%esp
80104521:	5d                   	pop    %ebp
  return -1;
80104522:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104527:	c3                   	ret    
80104528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010452f:	90                   	nop

80104530 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	bb c0 ad 14 80       	mov    $0x8014adc0,%ebx
8010453b:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010453e:	83 ec 4c             	sub    $0x4c,%esp
80104541:	eb 20                	jmp    80104563 <procdump+0x33>
80104543:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104547:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104548:	c7 04 24 6b 82 10 80 	movl   $0x8010826b,(%esp)
8010454f:	e8 2c c1 ff ff       	call   80100680 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104554:	83 c3 7c             	add    $0x7c,%ebx
80104557:	81 fb c0 cc 14 80    	cmp    $0x8014ccc0,%ebx
8010455d:	0f 84 9d 00 00 00    	je     80104600 <procdump+0xd0>
    if(p->state == UNUSED)
80104563:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104566:	85 c0                	test   %eax,%eax
80104568:	74 ea                	je     80104554 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010456a:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
8010456d:	ba 8b 7e 10 80       	mov    $0x80107e8b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104572:	77 11                	ja     80104585 <procdump+0x55>
80104574:	8b 14 85 ec 7e 10 80 	mov    -0x7fef8114(,%eax,4),%edx
      state = "???";
8010457b:	b8 8b 7e 10 80       	mov    $0x80107e8b,%eax
80104580:	85 d2                	test   %edx,%edx
80104582:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104585:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80104589:	89 54 24 08          	mov    %edx,0x8(%esp)
8010458d:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80104590:	c7 04 24 8f 7e 10 80 	movl   $0x80107e8f,(%esp)
80104597:	89 44 24 04          	mov    %eax,0x4(%esp)
8010459b:	e8 e0 c0 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
801045a0:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801045a4:	75 a2                	jne    80104548 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801045a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
801045a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801045ad:	8d 7d c0             	lea    -0x40(%ebp),%edi
801045b0:	8b 43 b0             	mov    -0x50(%ebx),%eax
801045b3:	8b 40 0c             	mov    0xc(%eax),%eax
801045b6:	83 c0 08             	add    $0x8,%eax
801045b9:	89 04 24             	mov    %eax,(%esp)
801045bc:	e8 af 01 00 00       	call   80104770 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801045c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045cf:	90                   	nop
801045d0:	8b 17                	mov    (%edi),%edx
801045d2:	85 d2                	test   %edx,%edx
801045d4:	0f 84 6e ff ff ff    	je     80104548 <procdump+0x18>
        cprintf(" %p", pc[i]);
801045da:	89 54 24 04          	mov    %edx,0x4(%esp)
      for(i=0; i<10 && pc[i] != 0; i++)
801045de:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801045e1:	c7 04 24 21 78 10 80 	movl   $0x80107821,(%esp)
801045e8:	e8 93 c0 ff ff       	call   80100680 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801045ed:	39 f7                	cmp    %esi,%edi
801045ef:	75 df                	jne    801045d0 <procdump+0xa0>
801045f1:	e9 52 ff ff ff       	jmp    80104548 <procdump+0x18>
801045f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045fd:	8d 76 00             	lea    0x0(%esi),%esi
  }
}
80104600:	83 c4 4c             	add    $0x4c,%esp
80104603:	5b                   	pop    %ebx
80104604:	5e                   	pop    %esi
80104605:	5f                   	pop    %edi
80104606:	5d                   	pop    %ebp
80104607:	c3                   	ret    
80104608:	66 90                	xchg   %ax,%ax
8010460a:	66 90                	xchg   %ax,%ax
8010460c:	66 90                	xchg   %ax,%ax
8010460e:	66 90                	xchg   %ax,%ax

80104610 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104610:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80104611:	b8 04 7f 10 80       	mov    $0x80107f04,%eax
{
80104616:	89 e5                	mov    %esp,%ebp
80104618:	83 ec 18             	sub    $0x18,%esp
8010461b:	89 5d fc             	mov    %ebx,-0x4(%ebp)
8010461e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104621:	89 44 24 04          	mov    %eax,0x4(%esp)
80104625:	8d 43 04             	lea    0x4(%ebx),%eax
80104628:	89 04 24             	mov    %eax,(%esp)
8010462b:	e8 20 01 00 00       	call   80104750 <initlock>
  lk->name = name;
80104630:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104633:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104639:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104640:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104643:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104646:	89 ec                	mov    %ebp,%esp
80104648:	5d                   	pop    %ebp
80104649:	c3                   	ret    
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104650 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	83 ec 10             	sub    $0x10,%esp
80104658:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010465b:	8d 73 04             	lea    0x4(%ebx),%esi
8010465e:	89 34 24             	mov    %esi,(%esp)
80104661:	e8 da 02 00 00       	call   80104940 <acquire>
  while (lk->locked) {
80104666:	8b 13                	mov    (%ebx),%edx
80104668:	85 d2                	test   %edx,%edx
8010466a:	74 16                	je     80104682 <acquiresleep+0x32>
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104670:	89 74 24 04          	mov    %esi,0x4(%esp)
80104674:	89 1c 24             	mov    %ebx,(%esp)
80104677:	e8 04 fd ff ff       	call   80104380 <sleep>
  while (lk->locked) {
8010467c:	8b 03                	mov    (%ebx),%eax
8010467e:	85 c0                	test   %eax,%eax
80104680:	75 ee                	jne    80104670 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104682:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104688:	e8 33 f6 ff ff       	call   80103cc0 <myproc>
8010468d:	8b 40 10             	mov    0x10(%eax),%eax
80104690:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104693:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104696:	83 c4 10             	add    $0x10,%esp
80104699:	5b                   	pop    %ebx
8010469a:	5e                   	pop    %esi
8010469b:	5d                   	pop    %ebp
  release(&lk->lk);
8010469c:	e9 2f 02 00 00       	jmp    801048d0 <release>
801046a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046af:	90                   	nop

801046b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	83 ec 18             	sub    $0x18,%esp
801046b6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801046b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
801046bf:	8d 73 04             	lea    0x4(%ebx),%esi
801046c2:	89 34 24             	mov    %esi,(%esp)
801046c5:	e8 76 02 00 00       	call   80104940 <acquire>
  lk->locked = 0;
801046ca:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801046d0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801046d7:	89 1c 24             	mov    %ebx,(%esp)
801046da:	e8 71 fd ff ff       	call   80104450 <wakeup>
  release(&lk->lk);
}
801046df:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
801046e2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801046e5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801046e8:	89 ec                	mov    %ebp,%esp
801046ea:	5d                   	pop    %ebp
  release(&lk->lk);
801046eb:	e9 e0 01 00 00       	jmp    801048d0 <release>

801046f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	83 ec 28             	sub    $0x28,%esp
801046f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801046f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046fc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801046ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104702:	31 ff                	xor    %edi,%edi
  int r;
  
  acquire(&lk->lk);
80104704:	8d 73 04             	lea    0x4(%ebx),%esi
80104707:	89 34 24             	mov    %esi,(%esp)
8010470a:	e8 31 02 00 00       	call   80104940 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010470f:	8b 03                	mov    (%ebx),%eax
80104711:	85 c0                	test   %eax,%eax
80104713:	75 1b                	jne    80104730 <holdingsleep+0x40>
  release(&lk->lk);
80104715:	89 34 24             	mov    %esi,(%esp)
80104718:	e8 b3 01 00 00       	call   801048d0 <release>
  return r;
}
8010471d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104720:	89 f8                	mov    %edi,%eax
80104722:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104725:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104728:	89 ec                	mov    %ebp,%esp
8010472a:	5d                   	pop    %ebp
8010472b:	c3                   	ret    
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104730:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104733:	e8 88 f5 ff ff       	call   80103cc0 <myproc>
80104738:	39 58 10             	cmp    %ebx,0x10(%eax)
8010473b:	0f 94 c0             	sete   %al
8010473e:	0f b6 f8             	movzbl %al,%edi
80104741:	eb d2                	jmp    80104715 <holdingsleep+0x25>
80104743:	66 90                	xchg   %ax,%ax
80104745:	66 90                	xchg   %ax,%ax
80104747:	66 90                	xchg   %ax,%ax
80104749:	66 90                	xchg   %ax,%ax
8010474b:	66 90                	xchg   %ax,%ax
8010474d:	66 90                	xchg   %ax,%ax
8010474f:	90                   	nop

80104750 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104756:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104759:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010475f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104762:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010476f:	90                   	nop

80104770 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	8b 45 08             	mov    0x8(%ebp),%eax
80104777:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010477a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010477d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104782:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104787:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010478c:	76 10                	jbe    8010479e <getcallerpcs+0x2e>
8010478e:	eb 20                	jmp    801047b0 <getcallerpcs+0x40>
80104790:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104796:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010479c:	77 12                	ja     801047b0 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010479e:	8b 5a 04             	mov    0x4(%edx),%ebx
801047a1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801047a4:	40                   	inc    %eax
801047a5:	83 f8 0a             	cmp    $0xa,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801047a8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801047aa:	75 e4                	jne    80104790 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801047ac:	5b                   	pop    %ebx
801047ad:	5d                   	pop    %ebp
801047ae:	c3                   	ret    
801047af:	90                   	nop
801047b0:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801047b3:	8d 51 28             	lea    0x28(%ecx),%edx
801047b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047bd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801047c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801047c6:	83 c0 04             	add    $0x4,%eax
801047c9:	39 d0                	cmp    %edx,%eax
801047cb:	75 f3                	jne    801047c0 <getcallerpcs+0x50>
}
801047cd:	5b                   	pop    %ebx
801047ce:	5d                   	pop    %ebp
801047cf:	c3                   	ret    

801047d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	83 ec 08             	sub    $0x8,%esp
801047d6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801047d9:	9c                   	pushf  
801047da:	5b                   	pop    %ebx
  asm volatile("cli");
801047db:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801047dc:	e8 4f f4 ff ff       	call   80103c30 <mycpu>
801047e1:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801047e7:	85 c0                	test   %eax,%eax
801047e9:	74 15                	je     80104800 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801047eb:	e8 40 f4 ff ff       	call   80103c30 <mycpu>
801047f0:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801047f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047f9:	89 ec                	mov    %ebp,%esp
801047fb:	5d                   	pop    %ebp
801047fc:	c3                   	ret    
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104800:	e8 2b f4 ff ff       	call   80103c30 <mycpu>
80104805:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010480b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104811:	eb d8                	jmp    801047eb <pushcli+0x1b>
80104813:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104820 <popcli>:

void
popcli(void)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104826:	9c                   	pushf  
80104827:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104828:	f6 c4 02             	test   $0x2,%ah
8010482b:	75 37                	jne    80104864 <popcli+0x44>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010482d:	e8 fe f3 ff ff       	call   80103c30 <mycpu>
80104832:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80104838:	78 36                	js     80104870 <popcli+0x50>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010483a:	e8 f1 f3 ff ff       	call   80103c30 <mycpu>
8010483f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104845:	85 d2                	test   %edx,%edx
80104847:	74 07                	je     80104850 <popcli+0x30>
    sti();
}
80104849:	89 ec                	mov    %ebp,%esp
8010484b:	5d                   	pop    %ebp
8010484c:	c3                   	ret    
8010484d:	8d 76 00             	lea    0x0(%esi),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104850:	e8 db f3 ff ff       	call   80103c30 <mycpu>
80104855:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010485b:	85 c0                	test   %eax,%eax
8010485d:	74 ea                	je     80104849 <popcli+0x29>
  asm volatile("sti");
8010485f:	fb                   	sti    
}
80104860:	89 ec                	mov    %ebp,%esp
80104862:	5d                   	pop    %ebp
80104863:	c3                   	ret    
    panic("popcli - interruptible");
80104864:	c7 04 24 0f 7f 10 80 	movl   $0x80107f0f,(%esp)
8010486b:	e8 e0 ba ff ff       	call   80100350 <panic>
    panic("popcli");
80104870:	c7 04 24 26 7f 10 80 	movl   $0x80107f26,(%esp)
80104877:	e8 d4 ba ff ff       	call   80100350 <panic>
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <holding>:
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	83 ec 08             	sub    $0x8,%esp
80104886:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104889:	8b 75 08             	mov    0x8(%ebp),%esi
8010488c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010488f:	31 db                	xor    %ebx,%ebx
  pushcli();
80104891:	e8 3a ff ff ff       	call   801047d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104896:	8b 06                	mov    (%esi),%eax
80104898:	85 c0                	test   %eax,%eax
8010489a:	75 14                	jne    801048b0 <holding+0x30>
  popcli();
8010489c:	e8 7f ff ff ff       	call   80104820 <popcli>
}
801048a1:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048a4:	89 d8                	mov    %ebx,%eax
801048a6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801048a9:	89 ec                	mov    %ebp,%esp
801048ab:	5d                   	pop    %ebp
801048ac:	c3                   	ret    
801048ad:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048b0:	8b 5e 08             	mov    0x8(%esi),%ebx
801048b3:	e8 78 f3 ff ff       	call   80103c30 <mycpu>
801048b8:	39 c3                	cmp    %eax,%ebx
801048ba:	0f 94 c3             	sete   %bl
801048bd:	0f b6 db             	movzbl %bl,%ebx
801048c0:	eb da                	jmp    8010489c <holding+0x1c>
801048c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048d0 <release>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	83 ec 18             	sub    $0x18,%esp
801048d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801048d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
801048df:	e8 ec fe ff ff       	call   801047d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048e4:	8b 03                	mov    (%ebx),%eax
801048e6:	85 c0                	test   %eax,%eax
801048e8:	75 16                	jne    80104900 <release+0x30>
  popcli();
801048ea:	e8 31 ff ff ff       	call   80104820 <popcli>
    panic("release");
801048ef:	c7 04 24 2d 7f 10 80 	movl   $0x80107f2d,(%esp)
801048f6:	e8 55 ba ff ff       	call   80100350 <panic>
801048fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048ff:	90                   	nop
  r = lock->locked && lock->cpu == mycpu();
80104900:	8b 73 08             	mov    0x8(%ebx),%esi
80104903:	e8 28 f3 ff ff       	call   80103c30 <mycpu>
80104908:	39 c6                	cmp    %eax,%esi
8010490a:	75 de                	jne    801048ea <release+0x1a>
  popcli();
8010490c:	e8 0f ff ff ff       	call   80104820 <popcli>
  lk->pcs[0] = 0;
80104911:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104918:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
8010491f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104924:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010492a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010492d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104930:	89 ec                	mov    %ebp,%esp
80104932:	5d                   	pop    %ebp
  popcli();
80104933:	e9 e8 fe ff ff       	jmp    80104820 <popcli>
80104938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493f:	90                   	nop

80104940 <acquire>:
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	83 ec 18             	sub    $0x18,%esp
80104946:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  pushcli(); // disable interrupts to avoid deadlock. Example of deadlock if interrupts are not disabled: 
80104949:	e8 82 fe ff ff       	call   801047d0 <pushcli>
  if(holding(lk))
8010494e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104951:	e8 7a fe ff ff       	call   801047d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104956:	8b 03                	mov    (%ebx),%eax
80104958:	85 c0                	test   %eax,%eax
8010495a:	0f 85 98 00 00 00    	jne    801049f8 <acquire+0xb8>
  popcli();
80104960:	e8 bb fe ff ff       	call   80104820 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104965:	b9 01 00 00 00       	mov    $0x1,%ecx
8010496a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(xchg(&lk->locked, 1) != 0)
80104970:	8b 55 08             	mov    0x8(%ebp),%edx
80104973:	89 c8                	mov    %ecx,%eax
80104975:	f0 87 02             	lock xchg %eax,(%edx)
80104978:	85 c0                	test   %eax,%eax
8010497a:	75 f4                	jne    80104970 <acquire+0x30>
  __sync_synchronize();
8010497c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104981:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104984:	e8 a7 f2 ff ff       	call   80103c30 <mycpu>
  for(i = 0; i < 10; i++){
80104989:	31 d2                	xor    %edx,%edx
  getcallerpcs(&lk, lk->pcs);
8010498b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  lk->cpu = mycpu();
8010498e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104991:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104997:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010499c:	77 32                	ja     801049d0 <acquire+0x90>
  ebp = (uint*)v - 2;
8010499e:	89 e8                	mov    %ebp,%eax
801049a0:	eb 14                	jmp    801049b6 <acquire+0x76>
801049a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049a8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801049ae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801049b4:	77 1a                	ja     801049d0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801049b6:	8b 58 04             	mov    0x4(%eax),%ebx
801049b9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801049bd:	42                   	inc    %edx
801049be:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801049c1:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801049c3:	75 e3                	jne    801049a8 <acquire+0x68>
}
801049c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c8:	89 ec                	mov    %ebp,%esp
801049ca:	5d                   	pop    %ebp
801049cb:	c3                   	ret    
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049d0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801049d4:	8d 51 34             	lea    0x34(%ecx),%edx
801049d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049de:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801049e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049e6:	83 c0 04             	add    $0x4,%eax
801049e9:	39 c2                	cmp    %eax,%edx
801049eb:	75 f3                	jne    801049e0 <acquire+0xa0>
}
801049ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f0:	89 ec                	mov    %ebp,%esp
801049f2:	5d                   	pop    %ebp
801049f3:	c3                   	ret    
801049f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
801049f8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801049fb:	e8 30 f2 ff ff       	call   80103c30 <mycpu>
80104a00:	39 c3                	cmp    %eax,%ebx
80104a02:	0f 85 58 ff ff ff    	jne    80104960 <acquire+0x20>
  popcli();
80104a08:	e8 13 fe ff ff       	call   80104820 <popcli>
    panic("acquire");
80104a0d:	c7 04 24 35 7f 10 80 	movl   $0x80107f35,(%esp)
80104a14:	e8 37 b9 ff ff       	call   80100350 <panic>
80104a19:	66 90                	xchg   %ax,%ax
80104a1b:	66 90                	xchg   %ax,%ax
80104a1d:	66 90                	xchg   %ax,%ax
80104a1f:	90                   	nop

80104a20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	57                   	push   %edi
80104a24:	8b 55 08             	mov    0x8(%ebp),%edx
80104a27:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a2a:	89 d0                	mov    %edx,%eax
80104a2c:	09 c8                	or     %ecx,%eax
80104a2e:	a8 03                	test   $0x3,%al
80104a30:	75 1e                	jne    80104a50 <memset+0x30>
    c &= 0xFF;
80104a32:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a36:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104a39:	89 d7                	mov    %edx,%edi
80104a3b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104a41:	fc                   	cld    
80104a42:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104a44:	5f                   	pop    %edi
80104a45:	89 d0                	mov    %edx,%eax
80104a47:	5d                   	pop    %ebp
80104a48:	c3                   	ret    
80104a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104a50:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a53:	89 d7                	mov    %edx,%edi
80104a55:	fc                   	cld    
80104a56:	f3 aa                	rep stos %al,%es:(%edi)
80104a58:	5f                   	pop    %edi
80104a59:	89 d0                	mov    %edx,%eax
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret    
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
80104a65:	8b 75 10             	mov    0x10(%ebp),%esi
80104a68:	8b 55 08             	mov    0x8(%ebp),%edx
80104a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a6e:	85 f6                	test   %esi,%esi
80104a70:	74 2e                	je     80104aa0 <memcmp+0x40>
80104a72:	01 c6                	add    %eax,%esi
80104a74:	eb 10                	jmp    80104a86 <memcmp+0x26>
80104a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104a80:	40                   	inc    %eax
80104a81:	42                   	inc    %edx
  while(n-- > 0){
80104a82:	39 f0                	cmp    %esi,%eax
80104a84:	74 1a                	je     80104aa0 <memcmp+0x40>
    if(*s1 != *s2)
80104a86:	0f b6 0a             	movzbl (%edx),%ecx
80104a89:	0f b6 18             	movzbl (%eax),%ebx
80104a8c:	38 d9                	cmp    %bl,%cl
80104a8e:	74 f0                	je     80104a80 <memcmp+0x20>
      return *s1 - *s2;
80104a90:	0f b6 c1             	movzbl %cl,%eax
80104a93:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104a95:	5b                   	pop    %ebx
80104a96:	5e                   	pop    %esi
80104a97:	5d                   	pop    %ebp
80104a98:	c3                   	ret    
80104a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aa0:	5b                   	pop    %ebx
  return 0;
80104aa1:	31 c0                	xor    %eax,%eax
}
80104aa3:	5e                   	pop    %esi
80104aa4:	5d                   	pop    %ebp
80104aa5:	c3                   	ret    
80104aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aad:	8d 76 00             	lea    0x0(%esi),%esi

80104ab0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	57                   	push   %edi
80104ab4:	56                   	push   %esi
80104ab5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ab8:	8b 75 0c             	mov    0xc(%ebp),%esi
80104abb:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104abe:	39 d6                	cmp    %edx,%esi
80104ac0:	73 26                	jae    80104ae8 <memmove+0x38>
80104ac2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104ac5:	39 ca                	cmp    %ecx,%edx
80104ac7:	73 1f                	jae    80104ae8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ac9:	85 c0                	test   %eax,%eax
80104acb:	74 0f                	je     80104adc <memmove+0x2c>
80104acd:	48                   	dec    %eax
80104ace:	66 90                	xchg   %ax,%ax
      *--d = *--s;
80104ad0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ad4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ad7:	83 e8 01             	sub    $0x1,%eax
80104ada:	73 f4                	jae    80104ad0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104adc:	5e                   	pop    %esi
80104add:	89 d0                	mov    %edx,%eax
80104adf:	5f                   	pop    %edi
80104ae0:	5d                   	pop    %ebp
80104ae1:	c3                   	ret    
80104ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104ae8:	85 c0                	test   %eax,%eax
80104aea:	89 d7                	mov    %edx,%edi
80104aec:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104aef:	74 eb                	je     80104adc <memmove+0x2c>
80104af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aff:	90                   	nop
      *d++ = *s++;
80104b00:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104b01:	39 ce                	cmp    %ecx,%esi
80104b03:	75 fb                	jne    80104b00 <memmove+0x50>
}
80104b05:	5e                   	pop    %esi
80104b06:	89 d0                	mov    %edx,%eax
80104b08:	5f                   	pop    %edi
80104b09:	5d                   	pop    %ebp
80104b0a:	c3                   	ret    
80104b0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b0f:	90                   	nop

80104b10 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104b10:	eb 9e                	jmp    80104ab0 <memmove>
80104b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b20 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	53                   	push   %ebx
80104b24:	8b 55 10             	mov    0x10(%ebp),%edx
80104b27:	8b 45 08             	mov    0x8(%ebp),%eax
80104b2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104b2d:	85 d2                	test   %edx,%edx
80104b2f:	75 11                	jne    80104b42 <strncmp+0x22>
80104b31:	eb 25                	jmp    80104b58 <strncmp+0x38>
80104b33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b37:	90                   	nop
80104b38:	3a 19                	cmp    (%ecx),%bl
80104b3a:	75 0d                	jne    80104b49 <strncmp+0x29>
    n--, p++, q++;
80104b3c:	40                   	inc    %eax
80104b3d:	41                   	inc    %ecx
  while(n > 0 && *p && *p == *q)
80104b3e:	4a                   	dec    %edx
80104b3f:	90                   	nop
80104b40:	74 16                	je     80104b58 <strncmp+0x38>
80104b42:	0f b6 18             	movzbl (%eax),%ebx
80104b45:	84 db                	test   %bl,%bl
80104b47:	75 ef                	jne    80104b38 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104b49:	0f b6 00             	movzbl (%eax),%eax
80104b4c:	0f b6 11             	movzbl (%ecx),%edx
}
80104b4f:	5b                   	pop    %ebx
80104b50:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
80104b51:	29 d0                	sub    %edx,%eax
}
80104b53:	c3                   	ret    
80104b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b58:	5b                   	pop    %ebx
    return 0;
80104b59:	31 c0                	xor    %eax,%eax
}
80104b5b:	5d                   	pop    %ebp
80104b5c:	c3                   	ret    
80104b5d:	8d 76 00             	lea    0x0(%esi),%esi

80104b60 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	57                   	push   %edi
80104b64:	56                   	push   %esi
80104b65:	53                   	push   %ebx
80104b66:	8b 75 08             	mov    0x8(%ebp),%esi
80104b69:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104b6c:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b6f:	89 f0                	mov    %esi,%eax
80104b71:	eb 11                	jmp    80104b84 <strncpy+0x24>
80104b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b77:	90                   	nop
80104b78:	0f b6 0f             	movzbl (%edi),%ecx
80104b7b:	47                   	inc    %edi
80104b7c:	40                   	inc    %eax
80104b7d:	88 48 ff             	mov    %cl,-0x1(%eax)
80104b80:	84 c9                	test   %cl,%cl
80104b82:	74 14                	je     80104b98 <strncpy+0x38>
80104b84:	89 d3                	mov    %edx,%ebx
80104b86:	4a                   	dec    %edx
80104b87:	85 db                	test   %ebx,%ebx
80104b89:	7f ed                	jg     80104b78 <strncpy+0x18>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104b8b:	5b                   	pop    %ebx
80104b8c:	89 f0                	mov    %esi,%eax
80104b8e:	5e                   	pop    %esi
80104b8f:	5f                   	pop    %edi
80104b90:	5d                   	pop    %ebp
80104b91:	c3                   	ret    
80104b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(n-- > 0)
80104b98:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104b9b:	49                   	dec    %ecx
80104b9c:	85 d2                	test   %edx,%edx
80104b9e:	74 eb                	je     80104b8b <strncpy+0x2b>
    *s++ = 0;
80104ba0:	c6 00 00             	movb   $0x0,(%eax)
80104ba3:	40                   	inc    %eax
  while(n-- > 0)
80104ba4:	89 ca                	mov    %ecx,%edx
80104ba6:	29 c2                	sub    %eax,%edx
80104ba8:	85 d2                	test   %edx,%edx
80104baa:	7f f4                	jg     80104ba0 <strncpy+0x40>
}
80104bac:	5b                   	pop    %ebx
80104bad:	89 f0                	mov    %esi,%eax
80104baf:	5e                   	pop    %esi
80104bb0:	5f                   	pop    %edi
80104bb1:	5d                   	pop    %ebp
80104bb2:	c3                   	ret    
80104bb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bc0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	56                   	push   %esi
80104bc4:	53                   	push   %ebx
80104bc5:	8b 55 10             	mov    0x10(%ebp),%edx
80104bc8:	8b 75 08             	mov    0x8(%ebp),%esi
80104bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104bce:	85 d2                	test   %edx,%edx
80104bd0:	7e 21                	jle    80104bf3 <safestrcpy+0x33>
80104bd2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104bd6:	89 f2                	mov    %esi,%edx
80104bd8:	eb 12                	jmp    80104bec <safestrcpy+0x2c>
80104bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104be0:	0f b6 08             	movzbl (%eax),%ecx
80104be3:	40                   	inc    %eax
80104be4:	42                   	inc    %edx
80104be5:	88 4a ff             	mov    %cl,-0x1(%edx)
80104be8:	84 c9                	test   %cl,%cl
80104bea:	74 04                	je     80104bf0 <safestrcpy+0x30>
80104bec:	39 d8                	cmp    %ebx,%eax
80104bee:	75 f0                	jne    80104be0 <safestrcpy+0x20>
    ;
  *s = 0;
80104bf0:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104bf3:	5b                   	pop    %ebx
80104bf4:	89 f0                	mov    %esi,%eax
80104bf6:	5e                   	pop    %esi
80104bf7:	5d                   	pop    %ebp
80104bf8:	c3                   	ret    
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c00 <strlen>:

int
strlen(const char *s)
{
80104c00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c01:	31 c0                	xor    %eax,%eax
{
80104c03:	89 e5                	mov    %esp,%ebp
80104c05:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c08:	80 3a 00             	cmpb   $0x0,(%edx)
80104c0b:	74 0a                	je     80104c17 <strlen+0x17>
80104c0d:	8d 76 00             	lea    0x0(%esi),%esi
80104c10:	40                   	inc    %eax
80104c11:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c15:	75 f9                	jne    80104c10 <strlen+0x10>
    ;
  return n;
}
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret    

80104c19 <swtch>:
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  # store arguments in registers
  movl 4(%esp), %eax # eax = (esp+4) -> esp+4 is the first argument (**old)
80104c19:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx # edx = (esp+8) -> esp+8 the second argument
80104c1d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save context of old process
  pushl %ebp # push ebp ==: sub esp, 4; mov ebp, (esp). esp points to the top (lowest address) of the stack
80104c21:	55                   	push   %ebp
  pushl %ebx
80104c22:	53                   	push   %ebx
  pushl %esi
80104c23:	56                   	push   %esi
  pushl %edi
80104c24:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax) # update context of old process (update proc->context (address in eax) basically)
80104c25:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp # the ingenious thing. We actually set esp = edx = new_process->context. esp satisfies the invariant that it always points to the context of the currently executing process, so yup this is the "context" switch
80104c27:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers into edi etc. Notice the ingenuity - pop pops off of esp and modifies esp. And esp is the new context. The push and pop are actually at different locations, though it may sound symmetric.
  popl %edi
80104c29:	5f                   	pop    %edi
  popl %esi
80104c2a:	5e                   	pop    %esi
  popl %ebx
80104c2b:	5b                   	pop    %ebx
  popl %ebp # 
80104c2c:	5d                   	pop    %ebp
  ret
80104c2d:	c3                   	ret    
80104c2e:	66 90                	xchg   %ax,%ax

80104c30 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	83 ec 08             	sub    $0x8,%esp
80104c36:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104c39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c3c:	e8 7f f0 ff ff       	call   80103cc0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz) // invalid stack address, ignore
80104c41:	8b 00                	mov    (%eax),%eax
80104c43:	39 c3                	cmp    %eax,%ebx
80104c45:	73 19                	jae    80104c60 <fetchint+0x30>
80104c47:	8d 53 04             	lea    0x4(%ebx),%edx
80104c4a:	39 d0                	cmp    %edx,%eax
80104c4c:	72 12                	jb     80104c60 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr); // simple 4-byte dereference at addr
80104c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c51:	8b 13                	mov    (%ebx),%edx
80104c53:	89 10                	mov    %edx,(%eax)
  return 0;
80104c55:	31 c0                	xor    %eax,%eax
}
80104c57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c5a:	89 ec                	mov    %ebp,%esp
80104c5c:	5d                   	pop    %ebp
80104c5d:	c3                   	ret    
80104c5e:	66 90                	xchg   %ax,%ax
    return -1;
80104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c65:	eb f0                	jmp    80104c57 <fetchint+0x27>
80104c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6e:	66 90                	xchg   %ax,%ax

80104c70 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets the pointer at address pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	83 ec 08             	sub    $0x8,%esp
80104c76:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c7c:	e8 3f f0 ff ff       	call   80103cc0 <myproc>

  if(addr >= curproc->sz)
80104c81:	3b 18                	cmp    (%eax),%ebx
80104c83:	73 2b                	jae    80104cb0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr; // point to the address of the string
80104c85:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c88:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c8a:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){ // find the end of the string
80104c8c:	39 d3                	cmp    %edx,%ebx
80104c8e:	73 20                	jae    80104cb0 <fetchstr+0x40>
80104c90:	89 d8                	mov    %ebx,%eax
80104c92:	eb 09                	jmp    80104c9d <fetchstr+0x2d>
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c98:	40                   	inc    %eax
80104c99:	39 d0                	cmp    %edx,%eax
80104c9b:	73 13                	jae    80104cb0 <fetchstr+0x40>
    if(*s == 0)
80104c9d:	80 38 00             	cmpb   $0x0,(%eax)
80104ca0:	75 f6                	jne    80104c98 <fetchstr+0x28>
      return s - *pp; // return length of string read
80104ca2:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104ca4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ca7:	89 ec                	mov    %ebp,%esp
80104ca9:	5d                   	pop    %ebp
80104caa:	c3                   	ret    
80104cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104caf:	90                   	nop
80104cb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cb3:	89 ec                	mov    %ebp,%esp
    return -1;
80104cb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cba:	5d                   	pop    %ebp
80104cbb:	c3                   	ret    
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	56                   	push   %esi
80104cc4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104cc5:	e8 f6 ef ff ff       	call   80103cc0 <myproc>
80104cca:	8b 55 08             	mov    0x8(%ebp),%edx
80104ccd:	8b 40 18             	mov    0x18(%eax),%eax
80104cd0:	8b 40 44             	mov    0x44(%eax),%eax
80104cd3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104cd6:	e8 e5 ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104cdb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz) // invalid stack address, ignore
80104cde:	8b 00                	mov    (%eax),%eax
80104ce0:	39 c6                	cmp    %eax,%esi
80104ce2:	73 1c                	jae    80104d00 <argint+0x40>
80104ce4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ce7:	39 d0                	cmp    %edx,%eax
80104ce9:	72 15                	jb     80104d00 <argint+0x40>
  *ip = *(int*)(addr); // simple 4-byte dereference at addr
80104ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cee:	8b 53 04             	mov    0x4(%ebx),%edx
80104cf1:	89 10                	mov    %edx,(%eax)
  return 0;
80104cf3:	31 c0                	xor    %eax,%eax
}
80104cf5:	5b                   	pop    %ebx
80104cf6:	5e                   	pop    %esi
80104cf7:	5d                   	pop    %ebp
80104cf8:	c3                   	ret    
80104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104d05:	eb ee                	jmp    80104cf5 <argint+0x35>
80104d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0e:	66 90                	xchg   %ax,%ax

80104d10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	83 ec 18             	sub    $0x18,%esp
80104d16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104d19:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104d1c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  int i;
  struct proc *curproc = myproc();
80104d1f:	e8 9c ef ff ff       	call   80103cc0 <myproc>
80104d24:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104d26:	e8 95 ef ff ff       	call   80103cc0 <myproc>
80104d2b:	8b 55 08             	mov    0x8(%ebp),%edx
80104d2e:	8b 40 18             	mov    0x18(%eax),%eax
80104d31:	8b 40 44             	mov    0x44(%eax),%eax
80104d34:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d37:	e8 84 ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104d3c:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz) // invalid stack address, ignore
80104d3f:	8b 00                	mov    (%eax),%eax
80104d41:	39 c7                	cmp    %eax,%edi
80104d43:	73 3b                	jae    80104d80 <argptr+0x70>
80104d45:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104d48:	39 c8                	cmp    %ecx,%eax
80104d4a:	72 34                	jb     80104d80 <argptr+0x70>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d4c:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr); // simple 4-byte dereference at addr
80104d4f:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d52:	85 d2                	test   %edx,%edx
80104d54:	78 2a                	js     80104d80 <argptr+0x70>
80104d56:	8b 16                	mov    (%esi),%edx
80104d58:	39 d0                	cmp    %edx,%eax
80104d5a:	73 24                	jae    80104d80 <argptr+0x70>
80104d5c:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d5f:	01 c3                	add    %eax,%ebx
80104d61:	39 da                	cmp    %ebx,%edx
80104d63:	72 1b                	jb     80104d80 <argptr+0x70>
    return -1;
  *pp = (char*)i;
80104d65:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d68:	89 02                	mov    %eax,(%edx)
  return 0;
80104d6a:	31 c0                	xor    %eax,%eax
}
80104d6c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104d6f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104d72:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104d75:	89 ec                	mov    %ebp,%esp
80104d77:	5d                   	pop    %ebp
80104d78:	c3                   	ret    
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d85:	eb e5                	jmp    80104d6c <argptr+0x5c>
80104d87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8e:	66 90                	xchg   %ax,%ax

80104d90 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104d95:	e8 26 ef ff ff       	call   80103cc0 <myproc>
80104d9a:	8b 55 08             	mov    0x8(%ebp),%edx
80104d9d:	8b 40 18             	mov    0x18(%eax),%eax
80104da0:	8b 40 44             	mov    0x44(%eax),%eax
80104da3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104da6:	e8 15 ef ff ff       	call   80103cc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip); // the +4 because eip pushed after the arguments
80104dab:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz) // invalid stack address, ignore
80104dae:	8b 00                	mov    (%eax),%eax
80104db0:	39 c6                	cmp    %eax,%esi
80104db2:	73 3c                	jae    80104df0 <argstr+0x60>
80104db4:	8d 53 08             	lea    0x8(%ebx),%edx
80104db7:	39 d0                	cmp    %edx,%eax
80104db9:	72 35                	jb     80104df0 <argstr+0x60>
  *ip = *(int*)(addr); // simple 4-byte dereference at addr
80104dbb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104dbe:	e8 fd ee ff ff       	call   80103cc0 <myproc>
  if(addr >= curproc->sz)
80104dc3:	3b 18                	cmp    (%eax),%ebx
80104dc5:	73 29                	jae    80104df0 <argstr+0x60>
  *pp = (char*)addr; // point to the address of the string
80104dc7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104dca:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104dcc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){ // find the end of the string
80104dce:	39 d3                	cmp    %edx,%ebx
80104dd0:	73 1e                	jae    80104df0 <argstr+0x60>
80104dd2:	89 d8                	mov    %ebx,%eax
80104dd4:	eb 0f                	jmp    80104de5 <argstr+0x55>
80104dd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ddd:	8d 76 00             	lea    0x0(%esi),%esi
80104de0:	40                   	inc    %eax
80104de1:	39 d0                	cmp    %edx,%eax
80104de3:	73 0b                	jae    80104df0 <argstr+0x60>
    if(*s == 0)
80104de5:	80 38 00             	cmpb   $0x0,(%eax)
80104de8:	75 f6                	jne    80104de0 <argstr+0x50>
      return s - *pp; // return length of string read
80104dea:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  // addr is the nth argument, which is the address of a string too. (the argument was char *)
  return fetchstr(addr, pp);
}
80104dec:	5b                   	pop    %ebx
80104ded:	5e                   	pop    %esi
80104dee:	5d                   	pop    %ebp
80104def:	c3                   	ret    
80104df0:	5b                   	pop    %ebx
    return -1;
80104df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df6:	5e                   	pop    %esi
80104df7:	5d                   	pop    %ebp
80104df8:	c3                   	ret    
80104df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e00 <syscall>:
[SYS_getNumFreePages] sys_getNumFreePages,
};

void
syscall(void)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 18             	sub    $0x18,%esp
80104e06:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc(); // so we are 
80104e09:	e8 b2 ee ff ff       	call   80103cc0 <myproc>
80104e0e:	89 c3                	mov    %eax,%ebx

  // find the trap number, that libc puts in eax before calling trap (that's how it worked in asm syscalls too) and since after the trap call the trapframe copies the eax, we can just read it from there
  num = curproc->tf->eax;
80104e10:	8b 40 18             	mov    0x18(%eax),%eax
80104e13:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e16:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e19:	83 fa 15             	cmp    $0x15,%edx
80104e1c:	77 22                	ja     80104e40 <syscall+0x40>
80104e1e:	8b 14 85 60 7f 10 80 	mov    -0x7fef80a0(,%eax,4),%edx
80104e25:	85 d2                	test   %edx,%edx
80104e27:	74 17                	je     80104e40 <syscall+0x40>
    // call the handler. The return value is stored in eax, again
    curproc->tf->eax = syscalls[num](); // indexing into the trap table/syscall table and calling the function
80104e29:	ff d2                	call   *%edx
80104e2b:	89 c2                	mov    %eax,%edx
80104e2d:	8b 43 18             	mov    0x18(%ebx),%eax
80104e30:	89 50 1c             	mov    %edx,0x1c(%eax)
    // invalid syscall number
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1; // invalid return value
  }
}
80104e33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e36:	89 ec                	mov    %ebp,%esp
80104e38:	5d                   	pop    %ebp
80104e39:	c3                   	ret    
80104e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104e40:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80104e44:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104e47:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104e4b:	8b 43 10             	mov    0x10(%ebx),%eax
80104e4e:	c7 04 24 3d 7f 10 80 	movl   $0x80107f3d,(%esp)
80104e55:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e59:	e8 22 b8 ff ff       	call   80100680 <cprintf>
    curproc->tf->eax = -1; // invalid return value
80104e5e:	8b 43 18             	mov    0x18(%ebx),%eax
80104e61:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e6b:	89 ec                	mov    %ebp,%esp
80104e6d:	5d                   	pop    %ebp
80104e6e:	c3                   	ret    
80104e6f:	90                   	nop

80104e70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e70:	55                   	push   %ebp
80104e71:	0f bf d2             	movswl %dx,%edx
80104e74:	89 e5                	mov    %esp,%ebp
80104e76:	83 ec 48             	sub    $0x48,%esp
80104e79:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104e7c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80104e80:	0f bf c9             	movswl %cx,%ecx
80104e83:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104e86:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104e89:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104e8c:	89 7d cc             	mov    %edi,-0x34(%ebp)
  struct inode *ip, *dp; // ip is the inode of the file to be created, dp is the inode of the directory in which the file is to be created
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e8f:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e92:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e95:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104e99:	89 04 24             	mov    %eax,(%esp)
80104e9c:	e8 7f d3 ff ff       	call   80102220 <nameiparent>
80104ea1:	85 c0                	test   %eax,%eax
80104ea3:	74 5b                	je     80104f00 <create+0x90>
    return 0;
  ilock(dp);
80104ea5:	89 04 24             	mov    %eax,(%esp)
80104ea8:	89 c3                	mov    %eax,%ebx
80104eaa:	e8 c1 c9 ff ff       	call   80101870 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104eaf:	31 c9                	xor    %ecx,%ecx
80104eb1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80104eb5:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104eb9:	89 1c 24             	mov    %ebx,(%esp)
80104ebc:	e8 5f cf ff ff       	call   80101e20 <dirlookup>
80104ec1:	85 c0                	test   %eax,%eax
80104ec3:	89 c6                	mov    %eax,%esi
80104ec5:	74 51                	je     80104f18 <create+0xa8>
    iunlockput(dp);
80104ec7:	89 1c 24             	mov    %ebx,(%esp)
80104eca:	e8 21 cc ff ff       	call   80101af0 <iunlockput>
    ilock(ip);
80104ecf:	89 34 24             	mov    %esi,(%esp)
80104ed2:	e8 99 c9 ff ff       	call   80101870 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ed7:	83 7d d4 02          	cmpl   $0x2,-0x2c(%ebp)
80104edb:	75 1b                	jne    80104ef8 <create+0x88>
80104edd:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104ee2:	75 14                	jne    80104ef8 <create+0x88>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ee4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104ee7:	89 f0                	mov    %esi,%eax
80104ee9:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104eec:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104eef:	89 ec                	mov    %ebp,%esp
80104ef1:	5d                   	pop    %ebp
80104ef2:	c3                   	ret    
80104ef3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ef7:	90                   	nop
    iunlockput(ip);
80104ef8:	89 34 24             	mov    %esi,(%esp)
80104efb:	e8 f0 cb ff ff       	call   80101af0 <iunlockput>
    return 0;
80104f00:	31 f6                	xor    %esi,%esi
}
80104f02:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104f05:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104f08:	89 f0                	mov    %esi,%eax
80104f0a:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104f0d:	89 ec                	mov    %ebp,%esp
80104f0f:	5d                   	pop    %ebp
80104f10:	c3                   	ret    
80104f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0) // allocate an inode for the file
80104f18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104f1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f1f:	8b 03                	mov    (%ebx),%eax
80104f21:	89 04 24             	mov    %eax,(%esp)
80104f24:	e8 c7 c7 ff ff       	call   801016f0 <ialloc>
80104f29:	85 c0                	test   %eax,%eax
80104f2b:	89 c6                	mov    %eax,%esi
80104f2d:	0f 84 b9 00 00 00    	je     80104fec <create+0x17c>
  ilock(ip);
80104f33:	89 04 24             	mov    %eax,(%esp)
80104f36:	e8 35 c9 ff ff       	call   80101870 <ilock>
  ip->major = major;
80104f3b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  ip->nlink = 1;
80104f3e:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
80104f44:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104f48:	8b 45 cc             	mov    -0x34(%ebp),%eax
80104f4b:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80104f4f:	89 34 24             	mov    %esi,(%esp)
80104f52:	e8 59 c8 ff ff       	call   801017b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f57:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
80104f5b:	74 33                	je     80104f90 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f5d:	8b 46 04             	mov    0x4(%esi),%eax
80104f60:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104f64:	89 1c 24             	mov    %ebx,(%esp)
80104f67:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f6b:	e8 b0 d1 ff ff       	call   80102120 <dirlink>
80104f70:	85 c0                	test   %eax,%eax
80104f72:	78 6c                	js     80104fe0 <create+0x170>
  iunlockput(dp);
80104f74:	89 1c 24             	mov    %ebx,(%esp)
80104f77:	e8 74 cb ff ff       	call   80101af0 <iunlockput>
}
80104f7c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104f7f:	89 f0                	mov    %esi,%eax
80104f81:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104f84:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104f87:	89 ec                	mov    %ebp,%esp
80104f89:	5d                   	pop    %ebp
80104f8a:	c3                   	ret    
80104f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f8f:	90                   	nop
    dp->nlink++;  // for ".."
80104f90:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80104f94:	89 1c 24             	mov    %ebx,(%esp)
80104f97:	e8 14 c8 ff ff       	call   801017b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f9c:	8b 46 04             	mov    0x4(%esi),%eax
80104f9f:	ba d8 7f 10 80       	mov    $0x80107fd8,%edx
80104fa4:	89 54 24 04          	mov    %edx,0x4(%esp)
80104fa8:	89 34 24             	mov    %esi,(%esp)
80104fab:	89 44 24 08          	mov    %eax,0x8(%esp)
80104faf:	e8 6c d1 ff ff       	call   80102120 <dirlink>
80104fb4:	85 c0                	test   %eax,%eax
80104fb6:	78 1c                	js     80104fd4 <create+0x164>
80104fb8:	8b 43 04             	mov    0x4(%ebx),%eax
80104fbb:	89 34 24             	mov    %esi,(%esp)
80104fbe:	89 44 24 08          	mov    %eax,0x8(%esp)
80104fc2:	b8 d7 7f 10 80       	mov    $0x80107fd7,%eax
80104fc7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fcb:	e8 50 d1 ff ff       	call   80102120 <dirlink>
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	79 89                	jns    80104f5d <create+0xed>
      panic("create dots");
80104fd4:	c7 04 24 cb 7f 10 80 	movl   $0x80107fcb,(%esp)
80104fdb:	e8 70 b3 ff ff       	call   80100350 <panic>
    panic("create: dirlink");
80104fe0:	c7 04 24 da 7f 10 80 	movl   $0x80107fda,(%esp)
80104fe7:	e8 64 b3 ff ff       	call   80100350 <panic>
    panic("create: ialloc");
80104fec:	c7 04 24 bc 7f 10 80 	movl   $0x80107fbc,(%esp)
80104ff3:	e8 58 b3 ff ff       	call   80100350 <panic>
80104ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fff:	90                   	nop

80105000 <sys_dup>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105005:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105008:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010500b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010500f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105016:	e8 a5 fc ff ff       	call   80104cc0 <argint>
8010501b:	85 c0                	test   %eax,%eax
8010501d:	78 2f                	js     8010504e <sys_dup+0x4e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105023:	77 29                	ja     8010504e <sys_dup+0x4e>
80105025:	e8 96 ec ff ff       	call   80103cc0 <myproc>
8010502a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010502d:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105031:	85 f6                	test   %esi,%esi
80105033:	74 19                	je     8010504e <sys_dup+0x4e>
  struct proc *curproc = myproc();
80105035:	e8 86 ec ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010503a:	31 db                	xor    %ebx,%ebx
8010503c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105040:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105044:	85 d2                	test   %edx,%edx
80105046:	74 18                	je     80105060 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105048:	43                   	inc    %ebx
80105049:	83 fb 10             	cmp    $0x10,%ebx
8010504c:	75 f2                	jne    80105040 <sys_dup+0x40>
}
8010504e:	83 c4 20             	add    $0x20,%esp
    return -1;
80105051:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105056:	89 d8                	mov    %ebx,%eax
80105058:	5b                   	pop    %ebx
80105059:	5e                   	pop    %esi
8010505a:	5d                   	pop    %ebp
8010505b:	c3                   	ret    
8010505c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105060:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105064:	89 34 24             	mov    %esi,(%esp)
80105067:	e8 b4 be ff ff       	call   80100f20 <filedup>
}
8010506c:	83 c4 20             	add    $0x20,%esp
8010506f:	89 d8                	mov    %ebx,%eax
80105071:	5b                   	pop    %ebx
80105072:	5e                   	pop    %esi
80105073:	5d                   	pop    %ebp
80105074:	c3                   	ret    
80105075:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010507c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105080 <sys_read>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105085:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105088:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010508b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010508f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105096:	e8 25 fc ff ff       	call   80104cc0 <argint>
8010509b:	85 c0                	test   %eax,%eax
8010509d:	78 69                	js     80105108 <sys_read+0x88>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050a3:	77 63                	ja     80105108 <sys_read+0x88>
801050a5:	e8 16 ec ff ff       	call   80103cc0 <myproc>
801050aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050ad:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801050b1:	85 f6                	test   %esi,%esi
801050b3:	74 53                	je     80105108 <sys_read+0x88>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050b5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801050bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050bf:	89 44 24 04          	mov    %eax,0x4(%esp)
801050c3:	e8 f8 fb ff ff       	call   80104cc0 <argint>
801050c8:	85 c0                	test   %eax,%eax
801050ca:	78 3c                	js     80105108 <sys_read+0x88>
801050cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050cf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801050d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050da:	89 44 24 08          	mov    %eax,0x8(%esp)
801050de:	e8 2d fc ff ff       	call   80104d10 <argptr>
801050e3:	85 c0                	test   %eax,%eax
801050e5:	78 21                	js     80105108 <sys_read+0x88>
  return fileread(f, p, n);
801050e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ea:	89 44 24 08          	mov    %eax,0x8(%esp)
801050ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f1:	89 34 24             	mov    %esi,(%esp)
801050f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801050f8:	e8 c3 bf ff ff       	call   801010c0 <fileread>
}
801050fd:	83 c4 20             	add    $0x20,%esp
80105100:	5b                   	pop    %ebx
80105101:	5e                   	pop    %esi
80105102:	5d                   	pop    %ebp
80105103:	c3                   	ret    
80105104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105108:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510d:	eb ee                	jmp    801050fd <sys_read+0x7d>
8010510f:	90                   	nop

80105110 <sys_write>:
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105115:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105118:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010511b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010511f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105126:	e8 95 fb ff ff       	call   80104cc0 <argint>
8010512b:	85 c0                	test   %eax,%eax
8010512d:	78 69                	js     80105198 <sys_write+0x88>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010512f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105133:	77 63                	ja     80105198 <sys_write+0x88>
80105135:	e8 86 eb ff ff       	call   80103cc0 <myproc>
8010513a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010513d:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105141:	85 f6                	test   %esi,%esi
80105143:	74 53                	je     80105198 <sys_write+0x88>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105145:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010514c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010514f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105153:	e8 68 fb ff ff       	call   80104cc0 <argint>
80105158:	85 c0                	test   %eax,%eax
8010515a:	78 3c                	js     80105198 <sys_write+0x88>
8010515c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010515f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105163:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010516a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010516e:	e8 9d fb ff ff       	call   80104d10 <argptr>
80105173:	85 c0                	test   %eax,%eax
80105175:	78 21                	js     80105198 <sys_write+0x88>
  return filewrite(f, p, n);
80105177:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010517a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010517e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105181:	89 34 24             	mov    %esi,(%esp)
80105184:	89 44 24 04          	mov    %eax,0x4(%esp)
80105188:	e8 e3 bf ff ff       	call   80101170 <filewrite>
}
8010518d:	83 c4 20             	add    $0x20,%esp
80105190:	5b                   	pop    %ebx
80105191:	5e                   	pop    %esi
80105192:	5d                   	pop    %ebp
80105193:	c3                   	ret    
80105194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519d:	eb ee                	jmp    8010518d <sys_write+0x7d>
8010519f:	90                   	nop

801051a0 <sys_close>:
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	56                   	push   %esi
801051a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801051a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801051a8:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801051ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801051af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b6:	e8 05 fb ff ff       	call   80104cc0 <argint>
801051bb:	85 c0                	test   %eax,%eax
801051bd:	78 39                	js     801051f8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051bf:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051c3:	77 33                	ja     801051f8 <sys_close+0x58>
801051c5:	e8 f6 ea ff ff       	call   80103cc0 <myproc>
801051ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051cd:	8d 5a 08             	lea    0x8(%edx),%ebx
801051d0:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801051d4:	85 f6                	test   %esi,%esi
801051d6:	74 20                	je     801051f8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801051d8:	e8 e3 ea ff ff       	call   80103cc0 <myproc>
801051dd:	31 d2                	xor    %edx,%edx
801051df:	89 54 98 08          	mov    %edx,0x8(%eax,%ebx,4)
  fileclose(f);
801051e3:	89 34 24             	mov    %esi,(%esp)
801051e6:	e8 85 bd ff ff       	call   80100f70 <fileclose>
  return 0;
801051eb:	31 c0                	xor    %eax,%eax
}
801051ed:	83 c4 20             	add    $0x20,%esp
801051f0:	5b                   	pop    %ebx
801051f1:	5e                   	pop    %esi
801051f2:	5d                   	pop    %ebp
801051f3:	c3                   	ret    
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801051f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051fd:	eb ee                	jmp    801051ed <sys_close+0x4d>
801051ff:	90                   	nop

80105200 <sys_fstat>:
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105205:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105208:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010520b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010520f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105216:	e8 a5 fa ff ff       	call   80104cc0 <argint>
8010521b:	85 c0                	test   %eax,%eax
8010521d:	78 51                	js     80105270 <sys_fstat+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010521f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105223:	77 4b                	ja     80105270 <sys_fstat+0x70>
80105225:	e8 96 ea ff ff       	call   80103cc0 <myproc>
8010522a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010522d:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105231:	85 f6                	test   %esi,%esi
80105233:	74 3b                	je     80105270 <sys_fstat+0x70>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105235:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105239:	b8 14 00 00 00       	mov    $0x14,%eax
8010523e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105242:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105249:	e8 c2 fa ff ff       	call   80104d10 <argptr>
8010524e:	85 c0                	test   %eax,%eax
80105250:	78 1e                	js     80105270 <sys_fstat+0x70>
  return filestat(f, st);
80105252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105255:	89 34 24             	mov    %esi,(%esp)
80105258:	89 44 24 04          	mov    %eax,0x4(%esp)
8010525c:	e8 ff bd ff ff       	call   80101060 <filestat>
}
80105261:	83 c4 20             	add    $0x20,%esp
80105264:	5b                   	pop    %ebx
80105265:	5e                   	pop    %esi
80105266:	5d                   	pop    %ebp
80105267:	c3                   	ret    
80105268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526f:	90                   	nop
    return -1;
80105270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105275:	eb ea                	jmp    80105261 <sys_fstat+0x61>
80105277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010527e:	66 90                	xchg   %ax,%ax

80105280 <sys_link>:
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	57                   	push   %edi
80105284:	56                   	push   %esi
80105285:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105286:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105289:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010528c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105290:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105297:	e8 f4 fa ff ff       	call   80104d90 <argstr>
8010529c:	85 c0                	test   %eax,%eax
8010529e:	0f 88 e5 00 00 00    	js     80105389 <sys_link+0x109>
801052a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801052ab:	8d 45 d0             	lea    -0x30(%ebp),%eax
801052ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801052b2:	e8 d9 fa ff ff       	call   80104d90 <argstr>
801052b7:	85 c0                	test   %eax,%eax
801052b9:	0f 88 ca 00 00 00    	js     80105389 <sys_link+0x109>
  begin_op();
801052bf:	e8 1c de ff ff       	call   801030e0 <begin_op>
  if((ip = namei(old)) == 0){
801052c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801052c7:	89 04 24             	mov    %eax,(%esp)
801052ca:	e8 31 cf ff ff       	call   80102200 <namei>
801052cf:	85 c0                	test   %eax,%eax
801052d1:	89 c3                	mov    %eax,%ebx
801052d3:	0f 84 b7 00 00 00    	je     80105390 <sys_link+0x110>
  ilock(ip);
801052d9:	89 04 24             	mov    %eax,(%esp)
801052dc:	e8 8f c5 ff ff       	call   80101870 <ilock>
  if(ip->type == T_DIR){
801052e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052e6:	0f 84 90 00 00 00    	je     8010537c <sys_link+0xfc>
  ip->nlink++;
801052ec:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801052f0:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052f3:	89 1c 24             	mov    %ebx,(%esp)
801052f6:	e8 b5 c4 ff ff       	call   801017b0 <iupdate>
  iunlock(ip);
801052fb:	89 1c 24             	mov    %ebx,(%esp)
801052fe:	e8 4d c6 ff ff       	call   80101950 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105303:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105307:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010530a:	89 04 24             	mov    %eax,(%esp)
8010530d:	e8 0e cf ff ff       	call   80102220 <nameiparent>
80105312:	85 c0                	test   %eax,%eax
80105314:	89 c6                	mov    %eax,%esi
80105316:	74 50                	je     80105368 <sys_link+0xe8>
  ilock(dp);
80105318:	89 04 24             	mov    %eax,(%esp)
8010531b:	e8 50 c5 ff ff       	call   80101870 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105320:	8b 03                	mov    (%ebx),%eax
80105322:	39 06                	cmp    %eax,(%esi)
80105324:	75 3a                	jne    80105360 <sys_link+0xe0>
80105326:	8b 43 04             	mov    0x4(%ebx),%eax
80105329:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010532d:	89 34 24             	mov    %esi,(%esp)
80105330:	89 44 24 08          	mov    %eax,0x8(%esp)
80105334:	e8 e7 cd ff ff       	call   80102120 <dirlink>
80105339:	85 c0                	test   %eax,%eax
8010533b:	78 23                	js     80105360 <sys_link+0xe0>
  iunlockput(dp);
8010533d:	89 34 24             	mov    %esi,(%esp)
80105340:	e8 ab c7 ff ff       	call   80101af0 <iunlockput>
  iput(ip);
80105345:	89 1c 24             	mov    %ebx,(%esp)
80105348:	e8 53 c6 ff ff       	call   801019a0 <iput>
  end_op();
8010534d:	e8 fe dd ff ff       	call   80103150 <end_op>
  return 0;
80105352:	31 c0                	xor    %eax,%eax
}
80105354:	83 c4 3c             	add    $0x3c,%esp
80105357:	5b                   	pop    %ebx
80105358:	5e                   	pop    %esi
80105359:	5f                   	pop    %edi
8010535a:	5d                   	pop    %ebp
8010535b:	c3                   	ret    
8010535c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80105360:	89 34 24             	mov    %esi,(%esp)
80105363:	e8 88 c7 ff ff       	call   80101af0 <iunlockput>
  ilock(ip);
80105368:	89 1c 24             	mov    %ebx,(%esp)
8010536b:	e8 00 c5 ff ff       	call   80101870 <ilock>
  ip->nlink--;
80105370:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105374:	89 1c 24             	mov    %ebx,(%esp)
80105377:	e8 34 c4 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
8010537c:	89 1c 24             	mov    %ebx,(%esp)
8010537f:	e8 6c c7 ff ff       	call   80101af0 <iunlockput>
  end_op();
80105384:	e8 c7 dd ff ff       	call   80103150 <end_op>
    return -1;
80105389:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538e:	eb c4                	jmp    80105354 <sys_link+0xd4>
    end_op();
80105390:	e8 bb dd ff ff       	call   80103150 <end_op>
    return -1;
80105395:	eb f2                	jmp    80105389 <sys_link+0x109>
80105397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010539e:	66 90                	xchg   %ax,%ax

801053a0 <sys_unlink>:
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	56                   	push   %esi
801053a5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801053a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801053a9:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801053ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801053b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053b7:	e8 d4 f9 ff ff       	call   80104d90 <argstr>
801053bc:	85 c0                	test   %eax,%eax
801053be:	0f 88 7c 01 00 00    	js     80105540 <sys_unlink+0x1a0>
  begin_op();
801053c4:	e8 17 dd ff ff       	call   801030e0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801053c9:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801053cc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801053d0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801053d3:	89 04 24             	mov    %eax,(%esp)
801053d6:	e8 45 ce ff ff       	call   80102220 <nameiparent>
801053db:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801053de:	85 c0                	test   %eax,%eax
801053e0:	0f 84 7e 01 00 00    	je     80105564 <sys_unlink+0x1c4>
  ilock(dp);
801053e6:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801053e9:	89 3c 24             	mov    %edi,(%esp)
801053ec:	e8 7f c4 ff ff       	call   80101870 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801053f1:	b8 d8 7f 10 80       	mov    $0x80107fd8,%eax
801053f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801053fa:	89 1c 24             	mov    %ebx,(%esp)
801053fd:	e8 ee c9 ff ff       	call   80101df0 <namecmp>
80105402:	85 c0                	test   %eax,%eax
80105404:	0f 84 26 01 00 00    	je     80105530 <sys_unlink+0x190>
8010540a:	89 1c 24             	mov    %ebx,(%esp)
8010540d:	b8 d7 7f 10 80       	mov    $0x80107fd7,%eax
80105412:	89 44 24 04          	mov    %eax,0x4(%esp)
80105416:	e8 d5 c9 ff ff       	call   80101df0 <namecmp>
8010541b:	85 c0                	test   %eax,%eax
8010541d:	0f 84 0d 01 00 00    	je     80105530 <sys_unlink+0x190>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105423:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105427:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010542a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010542e:	89 3c 24             	mov    %edi,(%esp)
80105431:	e8 ea c9 ff ff       	call   80101e20 <dirlookup>
80105436:	85 c0                	test   %eax,%eax
80105438:	89 c3                	mov    %eax,%ebx
8010543a:	0f 84 f0 00 00 00    	je     80105530 <sys_unlink+0x190>
  ilock(ip);
80105440:	89 04 24             	mov    %eax,(%esp)
80105443:	e8 28 c4 ff ff       	call   80101870 <ilock>
  if(ip->nlink < 1)
80105448:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010544d:	0f 8e 37 01 00 00    	jle    8010558a <sys_unlink+0x1ea>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105453:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105458:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010545b:	74 7b                	je     801054d8 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
8010545d:	89 3c 24             	mov    %edi,(%esp)
80105460:	31 d2                	xor    %edx,%edx
80105462:	b8 10 00 00 00       	mov    $0x10,%eax
80105467:	89 54 24 04          	mov    %edx,0x4(%esp)
8010546b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010546f:	e8 ac f5 ff ff       	call   80104a20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105474:	b9 10 00 00 00       	mov    $0x10,%ecx
80105479:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010547d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105480:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105484:	89 44 24 08          	mov    %eax,0x8(%esp)
80105488:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010548b:	89 04 24             	mov    %eax,(%esp)
8010548e:	e8 0d c8 ff ff       	call   80101ca0 <writei>
80105493:	83 f8 10             	cmp    $0x10,%eax
80105496:	0f 85 e2 00 00 00    	jne    8010557e <sys_unlink+0x1de>
  if(ip->type == T_DIR){
8010549c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054a1:	0f 84 a9 00 00 00    	je     80105550 <sys_unlink+0x1b0>
  iunlockput(dp);
801054a7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801054aa:	89 04 24             	mov    %eax,(%esp)
801054ad:	e8 3e c6 ff ff       	call   80101af0 <iunlockput>
  ip->nlink--;
801054b2:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801054b6:	89 1c 24             	mov    %ebx,(%esp)
801054b9:	e8 f2 c2 ff ff       	call   801017b0 <iupdate>
  iunlockput(ip);
801054be:	89 1c 24             	mov    %ebx,(%esp)
801054c1:	e8 2a c6 ff ff       	call   80101af0 <iunlockput>
  end_op();
801054c6:	e8 85 dc ff ff       	call   80103150 <end_op>
  return 0;
801054cb:	31 c0                	xor    %eax,%eax
}
801054cd:	83 c4 5c             	add    $0x5c,%esp
801054d0:	5b                   	pop    %ebx
801054d1:	5e                   	pop    %esi
801054d2:	5f                   	pop    %edi
801054d3:	5d                   	pop    %ebp
801054d4:	c3                   	ret    
801054d5:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801054d8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801054dc:	0f 86 7b ff ff ff    	jbe    8010545d <sys_unlink+0xbd>
801054e2:	be 20 00 00 00       	mov    $0x20,%esi
801054e7:	eb 13                	jmp    801054fc <sys_unlink+0x15c>
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054f0:	83 c6 10             	add    $0x10,%esi
801054f3:	3b 73 58             	cmp    0x58(%ebx),%esi
801054f6:	0f 83 61 ff ff ff    	jae    8010545d <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054fc:	89 74 24 08          	mov    %esi,0x8(%esp)
80105500:	b8 10 00 00 00       	mov    $0x10,%eax
80105505:	89 44 24 0c          	mov    %eax,0xc(%esp)
80105509:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010550d:	89 1c 24             	mov    %ebx,(%esp)
80105510:	e8 5b c6 ff ff       	call   80101b70 <readi>
80105515:	83 f8 10             	cmp    $0x10,%eax
80105518:	75 58                	jne    80105572 <sys_unlink+0x1d2>
    if(de.inum != 0)
8010551a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010551f:	74 cf                	je     801054f0 <sys_unlink+0x150>
    iunlockput(ip);
80105521:	89 1c 24             	mov    %ebx,(%esp)
80105524:	e8 c7 c5 ff ff       	call   80101af0 <iunlockput>
    goto bad;
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105530:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105533:	89 04 24             	mov    %eax,(%esp)
80105536:	e8 b5 c5 ff ff       	call   80101af0 <iunlockput>
  end_op();
8010553b:	e8 10 dc ff ff       	call   80103150 <end_op>
    return -1;
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105545:	eb 86                	jmp    801054cd <sys_unlink+0x12d>
80105547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010554e:	66 90                	xchg   %ax,%ax
    dp->nlink--;
80105550:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105553:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80105557:	89 04 24             	mov    %eax,(%esp)
8010555a:	e8 51 c2 ff ff       	call   801017b0 <iupdate>
8010555f:	e9 43 ff ff ff       	jmp    801054a7 <sys_unlink+0x107>
    end_op();
80105564:	e8 e7 db ff ff       	call   80103150 <end_op>
    return -1;
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105570:	eb ce                	jmp    80105540 <sys_unlink+0x1a0>
      panic("isdirempty: readi");
80105572:	c7 04 24 fc 7f 10 80 	movl   $0x80107ffc,(%esp)
80105579:	e8 d2 ad ff ff       	call   80100350 <panic>
    panic("unlink: writei");
8010557e:	c7 04 24 0e 80 10 80 	movl   $0x8010800e,(%esp)
80105585:	e8 c6 ad ff ff       	call   80100350 <panic>
    panic("unlink: nlink < 1");
8010558a:	c7 04 24 ea 7f 10 80 	movl   $0x80107fea,(%esp)
80105591:	e8 ba ad ff ff       	call   80100350 <panic>
80105596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010559d:	8d 76 00             	lea    0x0(%esi),%esi

801055a0 <sys_open>:

int
sys_open(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055a6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801055a9:	83 ec 2c             	sub    $0x2c,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801055b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801055b7:	e8 d4 f7 ff ff       	call   80104d90 <argstr>
801055bc:	85 c0                	test   %eax,%eax
801055be:	0f 88 7f 00 00 00    	js     80105643 <sys_open+0xa3>
801055c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055cb:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801055d2:	e8 e9 f6 ff ff       	call   80104cc0 <argint>
801055d7:	85 c0                	test   %eax,%eax
801055d9:	78 68                	js     80105643 <sys_open+0xa3>
    return -1;

  begin_op();
801055db:	e8 00 db ff ff       	call   801030e0 <begin_op>

  if(omode & O_CREATE){
801055e0:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055e4:	75 72                	jne    80105658 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055e9:	89 04 24             	mov    %eax,(%esp)
801055ec:	e8 0f cc ff ff       	call   80102200 <namei>
801055f1:	85 c0                	test   %eax,%eax
801055f3:	89 c6                	mov    %eax,%esi
801055f5:	74 7d                	je     80105674 <sys_open+0xd4>
      end_op();
      return -1;
    }
    ilock(ip);
801055f7:	89 04 24             	mov    %eax,(%esp)
801055fa:	e8 71 c2 ff ff       	call   80101870 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801055ff:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105604:	0f 84 b6 00 00 00    	je     801056c0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010560a:	e8 a1 b8 ff ff       	call   80100eb0 <filealloc>
8010560f:	85 c0                	test   %eax,%eax
80105611:	89 c7                	mov    %eax,%edi
80105613:	74 21                	je     80105636 <sys_open+0x96>
  struct proc *curproc = myproc();
80105615:	e8 a6 e6 ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010561a:	31 db                	xor    %ebx,%ebx
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105620:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105624:	85 d2                	test   %edx,%edx
80105626:	74 58                	je     80105680 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105628:	43                   	inc    %ebx
80105629:	83 fb 10             	cmp    $0x10,%ebx
8010562c:	75 f2                	jne    80105620 <sys_open+0x80>
    if(f)
      fileclose(f);
8010562e:	89 3c 24             	mov    %edi,(%esp)
80105631:	e8 3a b9 ff ff       	call   80100f70 <fileclose>
    iunlockput(ip);
80105636:	89 34 24             	mov    %esi,(%esp)
80105639:	e8 b2 c4 ff ff       	call   80101af0 <iunlockput>
    end_op();
8010563e:	e8 0d db ff ff       	call   80103150 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105643:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80105646:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010564b:	89 d8                	mov    %ebx,%eax
8010564d:	5b                   	pop    %ebx
8010564e:	5e                   	pop    %esi
8010564f:	5f                   	pop    %edi
80105650:	5d                   	pop    %ebp
80105651:	c3                   	ret    
80105652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
80105658:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010565f:	31 c9                	xor    %ecx,%ecx
80105661:	ba 02 00 00 00       	mov    $0x2,%edx
80105666:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105669:	e8 02 f8 ff ff       	call   80104e70 <create>
    if(ip == 0){
8010566e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105670:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105672:	75 96                	jne    8010560a <sys_open+0x6a>
      end_op();
80105674:	e8 d7 da ff ff       	call   80103150 <end_op>
      return -1;
80105679:	eb c8                	jmp    80105643 <sys_open+0xa3>
8010567b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010567f:	90                   	nop
      curproc->ofile[fd] = f;
80105680:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105684:	89 34 24             	mov    %esi,(%esp)
80105687:	e8 c4 c2 ff ff       	call   80101950 <iunlock>
  end_op();
8010568c:	e8 bf da ff ff       	call   80103150 <end_op>
  f->type = FD_INODE;
80105691:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
80105697:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
8010569a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->off = 0;
8010569d:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801056a4:	89 d0                	mov    %edx,%eax
801056a6:	f7 d0                	not    %eax
801056a8:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056ab:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
801056ae:	88 47 08             	mov    %al,0x8(%edi)
}
801056b1:	89 d8                	mov    %ebx,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056b3:	0f 95 47 09          	setne  0x9(%edi)
}
801056b7:	83 c4 2c             	add    $0x2c,%esp
801056ba:	5b                   	pop    %ebx
801056bb:	5e                   	pop    %esi
801056bc:	5f                   	pop    %edi
801056bd:	5d                   	pop    %ebp
801056be:	c3                   	ret    
801056bf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801056c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801056c3:	85 c9                	test   %ecx,%ecx
801056c5:	0f 84 3f ff ff ff    	je     8010560a <sys_open+0x6a>
801056cb:	e9 66 ff ff ff       	jmp    80105636 <sys_open+0x96>

801056d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801056d6:	e8 05 da ff ff       	call   801030e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801056db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056de:	89 44 24 04          	mov    %eax,0x4(%esp)
801056e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056e9:	e8 a2 f6 ff ff       	call   80104d90 <argstr>
801056ee:	85 c0                	test   %eax,%eax
801056f0:	78 2e                	js     80105720 <sys_mkdir+0x50>
801056f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056f9:	31 c9                	xor    %ecx,%ecx
801056fb:	ba 01 00 00 00       	mov    $0x1,%edx
80105700:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105703:	e8 68 f7 ff ff       	call   80104e70 <create>
80105708:	85 c0                	test   %eax,%eax
8010570a:	74 14                	je     80105720 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010570c:	89 04 24             	mov    %eax,(%esp)
8010570f:	e8 dc c3 ff ff       	call   80101af0 <iunlockput>
  end_op();
80105714:	e8 37 da ff ff       	call   80103150 <end_op>
  return 0;
80105719:	31 c0                	xor    %eax,%eax
}
8010571b:	89 ec                	mov    %ebp,%esp
8010571d:	5d                   	pop    %ebp
8010571e:	c3                   	ret    
8010571f:	90                   	nop
    end_op();
80105720:	e8 2b da ff ff       	call   80103150 <end_op>
    return -1;
80105725:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010572a:	eb ef                	jmp    8010571b <sys_mkdir+0x4b>
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_mknod>:

int
sys_mknod(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105736:	e8 a5 d9 ff ff       	call   801030e0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010573b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010573e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105742:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105749:	e8 42 f6 ff ff       	call   80104d90 <argstr>
8010574e:	85 c0                	test   %eax,%eax
80105750:	78 5e                	js     801057b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105752:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105759:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010575c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105760:	e8 5b f5 ff ff       	call   80104cc0 <argint>
  if((argstr(0, &path)) < 0 ||
80105765:	85 c0                	test   %eax,%eax
80105767:	78 47                	js     801057b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105769:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105770:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105773:	89 44 24 04          	mov    %eax,0x4(%esp)
80105777:	e8 44 f5 ff ff       	call   80104cc0 <argint>
     argint(1, &major) < 0 ||
8010577c:	85 c0                	test   %eax,%eax
8010577e:	78 30                	js     801057b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105780:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105784:	ba 03 00 00 00       	mov    $0x3,%edx
80105789:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010578d:	89 04 24             	mov    %eax,(%esp)
80105790:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105793:	e8 d8 f6 ff ff       	call   80104e70 <create>
     argint(2, &minor) < 0 ||
80105798:	85 c0                	test   %eax,%eax
8010579a:	74 14                	je     801057b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010579c:	89 04 24             	mov    %eax,(%esp)
8010579f:	e8 4c c3 ff ff       	call   80101af0 <iunlockput>
  end_op();
801057a4:	e8 a7 d9 ff ff       	call   80103150 <end_op>
  return 0;
801057a9:	31 c0                	xor    %eax,%eax
}
801057ab:	89 ec                	mov    %ebp,%esp
801057ad:	5d                   	pop    %ebp
801057ae:	c3                   	ret    
801057af:	90                   	nop
    end_op();
801057b0:	e8 9b d9 ff ff       	call   80103150 <end_op>
    return -1;
801057b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ba:	eb ef                	jmp    801057ab <sys_mknod+0x7b>
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_chdir>:

int
sys_chdir(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	56                   	push   %esi
801057c4:	53                   	push   %ebx
801057c5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801057c8:	e8 f3 e4 ff ff       	call   80103cc0 <myproc>
801057cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801057cf:	e8 0c d9 ff ff       	call   801030e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801057d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801057db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057e2:	e8 a9 f5 ff ff       	call   80104d90 <argstr>
801057e7:	85 c0                	test   %eax,%eax
801057e9:	78 4a                	js     80105835 <sys_chdir+0x75>
801057eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057ee:	89 04 24             	mov    %eax,(%esp)
801057f1:	e8 0a ca ff ff       	call   80102200 <namei>
801057f6:	85 c0                	test   %eax,%eax
801057f8:	89 c3                	mov    %eax,%ebx
801057fa:	74 39                	je     80105835 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801057fc:	89 04 24             	mov    %eax,(%esp)
801057ff:	e8 6c c0 ff ff       	call   80101870 <ilock>
  if(ip->type != T_DIR){
80105804:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105809:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010580c:	75 22                	jne    80105830 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010580e:	e8 3d c1 ff ff       	call   80101950 <iunlock>
  iput(curproc->cwd);
80105813:	8b 46 68             	mov    0x68(%esi),%eax
80105816:	89 04 24             	mov    %eax,(%esp)
80105819:	e8 82 c1 ff ff       	call   801019a0 <iput>
  end_op();
8010581e:	e8 2d d9 ff ff       	call   80103150 <end_op>
  curproc->cwd = ip;
  return 0;
80105823:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80105825:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80105828:	83 c4 20             	add    $0x20,%esp
8010582b:	5b                   	pop    %ebx
8010582c:	5e                   	pop    %esi
8010582d:	5d                   	pop    %ebp
8010582e:	c3                   	ret    
8010582f:	90                   	nop
    iunlockput(ip);
80105830:	e8 bb c2 ff ff       	call   80101af0 <iunlockput>
    end_op();
80105835:	e8 16 d9 ff ff       	call   80103150 <end_op>
    return -1;
8010583a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010583f:	eb e7                	jmp    80105828 <sys_chdir+0x68>
80105841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop

80105850 <sys_exec>:

int
sys_exec(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	57                   	push   %edi
80105854:	56                   	push   %esi
80105855:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105856:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010585c:	81 ec ac 00 00 00    	sub    $0xac,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105862:	89 44 24 04          	mov    %eax,0x4(%esp)
80105866:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010586d:	e8 1e f5 ff ff       	call   80104d90 <argstr>
80105872:	85 c0                	test   %eax,%eax
80105874:	0f 88 8e 00 00 00    	js     80105908 <sys_exec+0xb8>
8010587a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105881:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105887:	89 44 24 04          	mov    %eax,0x4(%esp)
8010588b:	e8 30 f4 ff ff       	call   80104cc0 <argint>
80105890:	85 c0                	test   %eax,%eax
80105892:	78 74                	js     80105908 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105894:	ba 80 00 00 00       	mov    $0x80,%edx
80105899:	31 c9                	xor    %ecx,%ecx
8010589b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010589f:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801058a5:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058a7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801058ab:	89 34 24             	mov    %esi,(%esp)
801058ae:	e8 6d f1 ff ff       	call   80104a20 <memset>
    if(i >= NELEM(argv))
801058b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801058c0:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801058c6:	89 44 24 04          	mov    %eax,0x4(%esp)
801058ca:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801058d1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801058d7:	01 f8                	add    %edi,%eax
801058d9:	89 04 24             	mov    %eax,(%esp)
801058dc:	e8 4f f3 ff ff       	call   80104c30 <fetchint>
801058e1:	85 c0                	test   %eax,%eax
801058e3:	78 23                	js     80105908 <sys_exec+0xb8>
      return -1;
    if(uarg == 0){
801058e5:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801058eb:	85 c0                	test   %eax,%eax
801058ed:	74 31                	je     80105920 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801058ef:	89 04 24             	mov    %eax,(%esp)
801058f2:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801058f5:	89 54 24 04          	mov    %edx,0x4(%esp)
801058f9:	e8 72 f3 ff ff       	call   80104c70 <fetchstr>
801058fe:	85 c0                	test   %eax,%eax
80105900:	78 06                	js     80105908 <sys_exec+0xb8>
  for(i=0;; i++){
80105902:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80105903:	83 fb 20             	cmp    $0x20,%ebx
80105906:	75 b8                	jne    801058c0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80105908:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
8010590e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105913:	5b                   	pop    %ebx
80105914:	5e                   	pop    %esi
80105915:	5f                   	pop    %edi
80105916:	5d                   	pop    %ebp
80105917:	c3                   	ret    
80105918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop
      argv[i] = 0;
80105920:	31 c0                	xor    %eax,%eax
80105922:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80105929:	89 74 24 04          	mov    %esi,0x4(%esp)
8010592d:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80105933:	89 04 24             	mov    %eax,(%esp)
80105936:	e8 b5 b1 ff ff       	call   80100af0 <exec>
}
8010593b:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105941:	5b                   	pop    %ebx
80105942:	5e                   	pop    %esi
80105943:	5f                   	pop    %edi
80105944:	5d                   	pop    %ebp
80105945:	c3                   	ret    
80105946:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594d:	8d 76 00             	lea    0x0(%esi),%esi

80105950 <sys_pipe>:

int
sys_pipe(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105954:	bf 08 00 00 00       	mov    $0x8,%edi
{
80105959:	56                   	push   %esi
8010595a:	53                   	push   %ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010595b:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010595e:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105961:	89 7c 24 08          	mov    %edi,0x8(%esp)
80105965:	89 44 24 04          	mov    %eax,0x4(%esp)
80105969:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105970:	e8 9b f3 ff ff       	call   80104d10 <argptr>
80105975:	85 c0                	test   %eax,%eax
80105977:	0f 88 82 00 00 00    	js     801059ff <sys_pipe+0xaf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010597d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105980:	89 44 24 04          	mov    %eax,0x4(%esp)
80105984:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105987:	89 04 24             	mov    %eax,(%esp)
8010598a:	e8 e1 dd ff ff       	call   80103770 <pipealloc>
8010598f:	85 c0                	test   %eax,%eax
80105991:	78 6c                	js     801059ff <sys_pipe+0xaf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105993:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105996:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105998:	e8 23 e3 ff ff       	call   80103cc0 <myproc>
    if(curproc->ofile[fd] == 0){
8010599d:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801059a1:	85 f6                	test   %esi,%esi
801059a3:	74 19                	je     801059be <sys_pipe+0x6e>
801059a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801059b0:	43                   	inc    %ebx
801059b1:	83 fb 10             	cmp    $0x10,%ebx
801059b4:	74 33                	je     801059e9 <sys_pipe+0x99>
    if(curproc->ofile[fd] == 0){
801059b6:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801059ba:	85 f6                	test   %esi,%esi
801059bc:	75 f2                	jne    801059b0 <sys_pipe+0x60>
      curproc->ofile[fd] = f;
801059be:	8d 73 08             	lea    0x8(%ebx),%esi
801059c1:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059c5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801059c8:	e8 f3 e2 ff ff       	call   80103cc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059cd:	31 d2                	xor    %edx,%edx
801059cf:	90                   	nop
    if(curproc->ofile[fd] == 0){
801059d0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801059d4:	85 c9                	test   %ecx,%ecx
801059d6:	74 38                	je     80105a10 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
801059d8:	42                   	inc    %edx
801059d9:	83 fa 10             	cmp    $0x10,%edx
801059dc:	75 f2                	jne    801059d0 <sys_pipe+0x80>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801059de:	e8 dd e2 ff ff       	call   80103cc0 <myproc>
801059e3:	31 d2                	xor    %edx,%edx
801059e5:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
    fileclose(rf);
801059e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059ec:	89 04 24             	mov    %eax,(%esp)
801059ef:	e8 7c b5 ff ff       	call   80100f70 <fileclose>
    fileclose(wf);
801059f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059f7:	89 04 24             	mov    %eax,(%esp)
801059fa:	e8 71 b5 ff ff       	call   80100f70 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801059ff:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80105a02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a07:	5b                   	pop    %ebx
80105a08:	5e                   	pop    %esi
80105a09:	5f                   	pop    %edi
80105a0a:	5d                   	pop    %ebp
80105a0b:	c3                   	ret    
80105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105a10:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  fd[0] = fd0;
80105a14:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a17:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105a19:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a1c:	89 50 04             	mov    %edx,0x4(%eax)
}
80105a1f:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80105a22:	31 c0                	xor    %eax,%eax
}
80105a24:	5b                   	pop    %ebx
80105a25:	5e                   	pop    %esi
80105a26:	5f                   	pop    %edi
80105a27:	5d                   	pop    %ebp
80105a28:	c3                   	ret    
80105a29:	66 90                	xchg   %ax,%ax
80105a2b:	66 90                	xchg   %ax,%ax
80105a2d:	66 90                	xchg   %ax,%ax
80105a2f:	90                   	nop

80105a30 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105a30:	e9 4b e4 ff ff       	jmp    80103e80 <fork>
80105a35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a40 <sys_exit>:
}

int
sys_exit(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a46:	e8 85 e6 ff ff       	call   801040d0 <exit>
  return 0;  // not reached
}
80105a4b:	89 ec                	mov    %ebp,%esp
80105a4d:	31 c0                	xor    %eax,%eax
80105a4f:	5d                   	pop    %ebp
80105a50:	c3                   	ret    
80105a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5f:	90                   	nop

80105a60 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105a60:	e9 9b e7 ff ff       	jmp    80104200 <wait>
80105a65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a70 <sys_kill>:
}

int
sys_kill(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105a76:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105a7d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a80:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a84:	e8 37 f2 ff ff       	call   80104cc0 <argint>
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	78 13                	js     80105aa0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a90:	89 04 24             	mov    %eax,(%esp)
80105a93:	e8 18 ea ff ff       	call   801044b0 <kill>
}
80105a98:	89 ec                	mov    %ebp,%esp
80105a9a:	5d                   	pop    %ebp
80105a9b:	c3                   	ret    
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105aa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aa5:	eb f1                	jmp    80105a98 <sys_kill+0x28>
80105aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aae:	66 90                	xchg   %ax,%ax

80105ab0 <sys_getpid>:

int
sys_getpid(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105ab6:	e8 05 e2 ff ff       	call   80103cc0 <myproc>
80105abb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105abe:	89 ec                	mov    %ebp,%esp
80105ac0:	5d                   	pop    %ebp
80105ac1:	c3                   	ret    
80105ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	83 ec 28             	sub    $0x28,%esp
80105ad6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105ad9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105adc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ae0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105ae7:	e8 d4 f1 ff ff       	call   80104cc0 <argint>
80105aec:	85 c0                	test   %eax,%eax
80105aee:	78 20                	js     80105b10 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105af0:	e8 cb e1 ff ff       	call   80103cc0 <myproc>
80105af5:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105afa:	89 04 24             	mov    %eax,(%esp)
80105afd:	e8 fe e2 ff ff       	call   80103e00 <growproc>
80105b02:	85 c0                	test   %eax,%eax
80105b04:	78 0a                	js     80105b10 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b06:	89 d8                	mov    %ebx,%eax
80105b08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b0b:	89 ec                	mov    %ebp,%esp
80105b0d:	5d                   	pop    %ebp
80105b0e:	c3                   	ret    
80105b0f:	90                   	nop
    return -1;
80105b10:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b15:	eb ef                	jmp    80105b06 <sys_sbrk+0x36>
80105b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <sys_sleep>:

int
sys_sleep(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 28             	sub    $0x28,%esp
80105b26:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b2c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105b37:	e8 84 f1 ff ff       	call   80104cc0 <argint>
80105b3c:	85 c0                	test   %eax,%eax
80105b3e:	78 59                	js     80105b99 <sys_sleep+0x79>
    return -1;
  acquire(&tickslock);
80105b40:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105b47:	e8 f4 ed ff ff       	call   80104940 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105b4c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80105b4f:	8b 1d 60 cc 14 80    	mov    0x8014cc60,%ebx
  while(ticks - ticks0 < n){
80105b55:	85 c9                	test   %ecx,%ecx
80105b57:	75 28                	jne    80105b81 <sys_sleep+0x61>
80105b59:	eb 4d                	jmp    80105ba8 <sys_sleep+0x88>
80105b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b5f:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b60:	c7 04 24 60 cc 14 80 	movl   $0x8014cc60,(%esp)
80105b67:	b8 80 cc 14 80       	mov    $0x8014cc80,%eax
80105b6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b70:	e8 0b e8 ff ff       	call   80104380 <sleep>
  while(ticks - ticks0 < n){
80105b75:	a1 60 cc 14 80       	mov    0x8014cc60,%eax
80105b7a:	29 d8                	sub    %ebx,%eax
80105b7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b7f:	73 27                	jae    80105ba8 <sys_sleep+0x88>
    if(myproc()->killed){
80105b81:	e8 3a e1 ff ff       	call   80103cc0 <myproc>
80105b86:	8b 50 24             	mov    0x24(%eax),%edx
80105b89:	85 d2                	test   %edx,%edx
80105b8b:	74 d3                	je     80105b60 <sys_sleep+0x40>
      release(&tickslock);
80105b8d:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105b94:	e8 37 ed ff ff       	call   801048d0 <release>
  }
  release(&tickslock);
  return 0;
}
80105b99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b9c:	89 ec                	mov    %ebp,%esp
    return -1;
80105b9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ba3:	5d                   	pop    %ebp
80105ba4:	c3                   	ret    
80105ba5:	8d 76 00             	lea    0x0(%esi),%esi
  release(&tickslock);
80105ba8:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105baf:	e8 1c ed ff ff       	call   801048d0 <release>
}
80105bb4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bb7:	89 ec                	mov    %ebp,%esp
80105bb9:	5d                   	pop    %ebp
  return 0;
80105bba:	31 c0                	xor    %eax,%eax
}
80105bbc:	c3                   	ret    
80105bbd:	8d 76 00             	lea    0x0(%esi),%esi

80105bc0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 18             	sub    $0x18,%esp
80105bc6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  uint xticks;

  acquire(&tickslock);
80105bc9:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105bd0:	e8 6b ed ff ff       	call   80104940 <acquire>
  xticks = ticks;
80105bd5:	8b 1d 60 cc 14 80    	mov    0x8014cc60,%ebx
  release(&tickslock);
80105bdb:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105be2:	e8 e9 ec ff ff       	call   801048d0 <release>
  return xticks;
}
80105be7:	89 d8                	mov    %ebx,%eax
80105be9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bec:	89 ec                	mov    %ebp,%esp
80105bee:	5d                   	pop    %ebp
80105bef:	c3                   	ret    

80105bf0 <sys_getNumFreePages>:

int sys_getNumFreePages(void)
{
  return getNumFreePages();
80105bf0:	e9 2b ca ff ff       	jmp    80102620 <getNumFreePages>

80105bf5 <alltraps>:
.globl alltraps # the asm version of extern

alltraps:
  # Build trap frame
  
  pushl %ds # push the global data segment
80105bf5:	1e                   	push   %ds
  pushl %es # push the extra data segment
80105bf6:	06                   	push   %es
  pushl %fs # push the file system data segment
80105bf7:	0f a0                	push   %fs
  pushl %gs # push the general data segment
80105bf9:	0f a8                	push   %gs
  pushal # push all the registers! lol wow! The registers are pushed in order - eax, ecx, edx, ebx, eip, ebp, esi, edi.
80105bfb:	60                   	pusha  

  # Set up data segments.̦
  movw $(SEG_KDATA<<3), %ax # load the kernel data segment
80105bfc:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds # set the data segment to the kernel data segment
80105c00:	8e d8                	mov    %eax,%ds
  movw %ax, %es # set the extra data segment to the kernel data segment
80105c02:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp

  pushl %esp # push the stack pointer as the argument to the trap call - it is the virtual address of the trap frame
80105c04:	54                   	push   %esp

  # call the trap function. This is a function call, not a hardware trap. The hardware trap is the int instruction. The trap in bash is a trap command to catch signals.
  call trap 
80105c05:	e8 c6 00 00 00       	call   80105cd0 <trap>
  
  addl $4, %esp # pop the argument (tf*) to the trap call off the stack
80105c0a:	83 c4 04             	add    $0x4,%esp

80105c0d <trapret>:
# lol nice - the return from the trap call falls through to trapret...
.globl trapret

trapret:
  # popus registerus
  popal
80105c0d:	61                   	popa   
  popl %gs
80105c0e:	0f a9                	pop    %gs
  popl %fs
80105c10:	0f a1                	pop    %fs
  popl %es
80105c12:	07                   	pop    %es
  popl %ds
80105c13:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode. Why are we popping them off? Because it is of no need to the caller - action has already been taken based off these values 
80105c14:	83 c4 08             	add    $0x8,%esp

  # the reverse of the int instruction (return from interrupt)
  iret # what's iret? it's the return from interrupt instruction. it's like ret, but it pops the flags and cs as well which the int instruction pushed onto the stack
80105c17:	cf                   	iret   
80105c18:	66 90                	xchg   %ax,%ax
80105c1a:	66 90                	xchg   %ax,%ax
80105c1c:	66 90                	xchg   %ax,%ax
80105c1e:	66 90                	xchg   %ax,%ax

80105c20 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c20:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105c21:	31 c0                	xor    %eax,%eax
{
80105c23:	89 e5                	mov    %esp,%ebp
80105c25:	83 ec 18             	sub    $0x18,%esp
80105c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c30:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105c37:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80105c3c:	89 0c c5 c2 cc 14 80 	mov    %ecx,-0x7feb333e(,%eax,8)
80105c43:	66 89 14 c5 c0 cc 14 	mov    %dx,-0x7feb3340(,%eax,8)
80105c4a:	80 
80105c4b:	c1 ea 10             	shr    $0x10,%edx
80105c4e:	66 89 14 c5 c6 cc 14 	mov    %dx,-0x7feb333a(,%eax,8)
80105c55:	80 
  for(i = 0; i < 256; i++)
80105c56:	40                   	inc    %eax
80105c57:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c5c:	75 d2                	jne    80105c30 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c5e:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105c63:	ba 08 00 00 ef       	mov    $0xef000008,%edx

  initlock(&tickslock, "time");
80105c68:	b9 1d 80 10 80       	mov    $0x8010801d,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c6d:	89 15 c2 ce 14 80    	mov    %edx,0x8014cec2
80105c73:	66 a3 c0 ce 14 80    	mov    %ax,0x8014cec0
80105c79:	c1 e8 10             	shr    $0x10,%eax
80105c7c:	66 a3 c6 ce 14 80    	mov    %ax,0x8014cec6
  initlock(&tickslock, "time");
80105c82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105c86:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105c8d:	e8 be ea ff ff       	call   80104750 <initlock>
}
80105c92:	89 ec                	mov    %ebp,%esp
80105c94:	5d                   	pop    %ebp
80105c95:	c3                   	ret    
80105c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c9d:	8d 76 00             	lea    0x0(%esi),%esi

80105ca0 <idtinit>:

void
idtinit(void)
{
80105ca0:	55                   	push   %ebp
  pd[1] = (uint)p;
80105ca1:	b8 c0 cc 14 80       	mov    $0x8014ccc0,%eax
80105ca6:	89 e5                	mov    %esp,%ebp
80105ca8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80105cab:	c1 e8 10             	shr    $0x10,%eax
80105cae:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80105cb1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105cb7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105cbb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105cbf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105cc2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105cc5:	89 ec                	mov    %ebp,%esp
80105cc7:	5d                   	pop    %ebp
80105cc8:	c3                   	ret    
80105cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cd0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 48             	sub    $0x48,%esp
80105cd6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105cd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105cdc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105cdf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80105ce2:	8b 43 30             	mov    0x30(%ebx),%eax
80105ce5:	83 f8 40             	cmp    $0x40,%eax
80105ce8:	0f 84 62 01 00 00    	je     80105e50 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105cee:	83 e8 0e             	sub    $0xe,%eax
80105cf1:	83 f8 31             	cmp    $0x31,%eax
80105cf4:	0f 87 96 00 00 00    	ja     80105d90 <trap+0xc0>
80105cfa:	ff 24 85 ec 80 10 80 	jmp    *-0x7fef7f14(,%eax,4)
80105d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105d08:	e8 93 df ff ff       	call   80103ca0 <cpuid>
80105d0d:	85 c0                	test   %eax,%eax
80105d0f:	90                   	nop
80105d10:	0f 84 9a 02 00 00    	je     80105fb0 <trap+0x2e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105d16:	e8 95 cf ff ff       	call   80102cb0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d1f:	90                   	nop
80105d20:	e8 9b df ff ff       	call   80103cc0 <myproc>
80105d25:	85 c0                	test   %eax,%eax
80105d27:	74 1b                	je     80105d44 <trap+0x74>
80105d29:	e8 92 df ff ff       	call   80103cc0 <myproc>
80105d2e:	8b 50 24             	mov    0x24(%eax),%edx
80105d31:	85 d2                	test   %edx,%edx
80105d33:	74 0f                	je     80105d44 <trap+0x74>
80105d35:	8b 43 3c             	mov    0x3c(%ebx),%eax
80105d38:	83 e0 03             	and    $0x3,%eax
80105d3b:	83 f8 03             	cmp    $0x3,%eax
80105d3e:	0f 84 4c 02 00 00    	je     80105f90 <trap+0x2c0>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105d44:	e8 77 df ff ff       	call   80103cc0 <myproc>
80105d49:	85 c0                	test   %eax,%eax
80105d4b:	74 12                	je     80105d5f <trap+0x8f>
80105d4d:	8d 76 00             	lea    0x0(%esi),%esi
80105d50:	e8 6b df ff ff       	call   80103cc0 <myproc>
80105d55:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105d59:	0f 84 d1 00 00 00    	je     80105e30 <trap+0x160>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d5f:	e8 5c df ff ff       	call   80103cc0 <myproc>
80105d64:	85 c0                	test   %eax,%eax
80105d66:	74 1b                	je     80105d83 <trap+0xb3>
80105d68:	e8 53 df ff ff       	call   80103cc0 <myproc>
80105d6d:	8b 40 24             	mov    0x24(%eax),%eax
80105d70:	85 c0                	test   %eax,%eax
80105d72:	74 0f                	je     80105d83 <trap+0xb3>
80105d74:	8b 43 3c             	mov    0x3c(%ebx),%eax
80105d77:	83 e0 03             	and    $0x3,%eax
80105d7a:	83 f8 03             	cmp    $0x3,%eax
80105d7d:	0f 84 fa 00 00 00    	je     80105e7d <trap+0x1ad>
    exit();
}
80105d83:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105d86:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105d89:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105d8c:	89 ec                	mov    %ebp,%esp
80105d8e:	5d                   	pop    %ebp
80105d8f:	c3                   	ret    
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d90:	e8 2b df ff ff       	call   80103cc0 <myproc>
80105d95:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d98:	85 c0                	test   %eax,%eax
80105d9a:	0f 84 3f 02 00 00    	je     80105fdf <trap+0x30f>
80105da0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105da4:	0f 84 35 02 00 00    	je     80105fdf <trap+0x30f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105daa:	0f 20 d1             	mov    %cr2,%ecx
80105dad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105db0:	e8 eb de ff ff       	call   80103ca0 <cpuid>
80105db5:	8b 73 30             	mov    0x30(%ebx),%esi
80105db8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105dbb:	8b 43 34             	mov    0x34(%ebx),%eax
80105dbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105dc1:	e8 fa de ff ff       	call   80103cc0 <myproc>
80105dc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105dc9:	e8 f2 de ff ff       	call   80103cc0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105dce:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105dd1:	89 7c 24 18          	mov    %edi,0x18(%esp)
80105dd5:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
80105dd9:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ddc:	89 54 24 14          	mov    %edx,0x14(%esp)
80105de0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105de3:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105de7:	89 4c 24 10          	mov    %ecx,0x10(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105deb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105dee:	83 c6 6c             	add    $0x6c,%esi
80105df1:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105df5:	8b 40 10             	mov    0x10(%eax),%eax
80105df8:	c7 04 24 a8 80 10 80 	movl   $0x801080a8,(%esp)
80105dff:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e03:	e8 78 a8 ff ff       	call   80100680 <cprintf>
    myproc()->killed = 1;
80105e08:	e8 b3 de ff ff       	call   80103cc0 <myproc>
80105e0d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e14:	e8 a7 de ff ff       	call   80103cc0 <myproc>
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	0f 85 08 ff ff ff    	jne    80105d29 <trap+0x59>
80105e21:	e9 1e ff ff ff       	jmp    80105d44 <trap+0x74>
80105e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105e30:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105e34:	0f 85 25 ff ff ff    	jne    80105d5f <trap+0x8f>
    yield();
80105e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e40:	e8 eb e4 ff ff       	call   80104330 <yield>
80105e45:	e9 15 ff ff ff       	jmp    80105d5f <trap+0x8f>
80105e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105e50:	e8 6b de ff ff       	call   80103cc0 <myproc>
80105e55:	8b 70 24             	mov    0x24(%eax),%esi
80105e58:	85 f6                	test   %esi,%esi
80105e5a:	0f 85 40 01 00 00    	jne    80105fa0 <trap+0x2d0>
    myproc()->tf = tf;
80105e60:	e8 5b de ff ff       	call   80103cc0 <myproc>
80105e65:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105e68:	e8 93 ef ff ff       	call   80104e00 <syscall>
    if(myproc()->killed)
80105e6d:	e8 4e de ff ff       	call   80103cc0 <myproc>
80105e72:	8b 48 24             	mov    0x24(%eax),%ecx
80105e75:	85 c9                	test   %ecx,%ecx
80105e77:	0f 84 06 ff ff ff    	je     80105d83 <trap+0xb3>
}
80105e7d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105e80:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105e83:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105e86:	89 ec                	mov    %ebp,%esp
80105e88:	5d                   	pop    %ebp
      exit();
80105e89:	e9 42 e2 ff ff       	jmp    801040d0 <exit>
80105e8e:	66 90                	xchg   %ax,%ax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105e90:	8b 7b 38             	mov    0x38(%ebx),%edi
80105e93:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105e97:	e8 04 de ff ff       	call   80103ca0 <cpuid>
80105e9c:	c7 04 24 50 80 10 80 	movl   $0x80108050,(%esp)
80105ea3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105ea7:	89 74 24 08          	mov    %esi,0x8(%esp)
80105eab:	89 44 24 04          	mov    %eax,0x4(%esp)
80105eaf:	e8 cc a7 ff ff       	call   80100680 <cprintf>
    lapiceoi();
80105eb4:	e8 f7 cd ff ff       	call   80102cb0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eb9:	e8 02 de ff ff       	call   80103cc0 <myproc>
80105ebe:	85 c0                	test   %eax,%eax
80105ec0:	0f 85 63 fe ff ff    	jne    80105d29 <trap+0x59>
80105ec6:	e9 79 fe ff ff       	jmp    80105d44 <trap+0x74>
80105ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ecf:	90                   	nop
    kbdintr();
80105ed0:	e8 9b cc ff ff       	call   80102b70 <kbdintr>
    lapiceoi();
80105ed5:	e8 d6 cd ff ff       	call   80102cb0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eda:	e8 e1 dd ff ff       	call   80103cc0 <myproc>
80105edf:	85 c0                	test   %eax,%eax
80105ee1:	0f 85 42 fe ff ff    	jne    80105d29 <trap+0x59>
80105ee7:	e9 58 fe ff ff       	jmp    80105d44 <trap+0x74>
80105eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105ef0:	e8 bb 02 00 00       	call   801061b0 <uartintr>
    lapiceoi();
80105ef5:	e8 b6 cd ff ff       	call   80102cb0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105efa:	e8 c1 dd ff ff       	call   80103cc0 <myproc>
80105eff:	85 c0                	test   %eax,%eax
80105f01:	0f 85 22 fe ff ff    	jne    80105d29 <trap+0x59>
80105f07:	e9 38 fe ff ff       	jmp    80105d44 <trap+0x74>
80105f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105f10:	e8 8b c4 ff ff       	call   801023a0 <ideintr>
80105f15:	e9 fc fd ff ff       	jmp    80105d16 <trap+0x46>
80105f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("newpgflt\n");
80105f20:	c7 04 24 22 80 10 80 	movl   $0x80108022,(%esp)
80105f27:	e8 54 a7 ff ff       	call   80100680 <cprintf>
    struct proc* curproc=myproc();
80105f2c:	e8 8f dd ff ff       	call   80103cc0 <myproc>
80105f31:	89 c6                	mov    %eax,%esi
80105f33:	0f 20 d7             	mov    %cr2,%edi
    uint vaddr=PGROUNDDOWN(rcr2());// this is the virtual address
80105f36:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    int read_flt=if_read_T_PGFLT(curproc->pgdir, (void*)vaddr);
80105f3c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f40:	8b 40 04             	mov    0x4(%eax),%eax
80105f43:	89 04 24             	mov    %eax,(%esp)
80105f46:	e8 a5 14 00 00       	call   801073f0 <if_read_T_PGFLT>
80105f4b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int present_flt=if_present_T_PGFLT(curproc->pgdir, (void*)vaddr);
80105f4e:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f52:	8b 46 04             	mov    0x4(%esi),%eax
80105f55:	89 04 24             	mov    %eax,(%esp)
80105f58:	e8 53 14 00 00       	call   801073b0 <if_present_T_PGFLT>
    if (!read_flt) panic("present but not cow T_PGFLT");
80105f5d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105f60:	85 d2                	test   %edx,%edx
80105f62:	0f 84 aa 00 00 00    	je     80106012 <trap+0x342>
    if (read_flt) _handle_T_PGFLT_COW(curproc->pgdir, vaddr);
80105f68:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f6c:	8b 46 04             	mov    0x4(%esi),%eax
80105f6f:	89 04 24             	mov    %eax,(%esp)
80105f72:	e8 29 16 00 00       	call   801075a0 <_handle_T_PGFLT_COW>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f77:	e8 44 dd ff ff       	call   80103cc0 <myproc>
80105f7c:	85 c0                	test   %eax,%eax
80105f7e:	0f 85 a5 fd ff ff    	jne    80105d29 <trap+0x59>
80105f84:	e9 bb fd ff ff       	jmp    80105d44 <trap+0x74>
80105f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105f90:	e8 3b e1 ff ff       	call   801040d0 <exit>
80105f95:	e9 aa fd ff ff       	jmp    80105d44 <trap+0x74>
80105f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105fa0:	e8 2b e1 ff ff       	call   801040d0 <exit>
80105fa5:	e9 b6 fe ff ff       	jmp    80105e60 <trap+0x190>
80105faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105fb0:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105fb7:	e8 84 e9 ff ff       	call   80104940 <acquire>
      ticks++;
80105fbc:	ff 05 60 cc 14 80    	incl   0x8014cc60
      wakeup(&ticks);
80105fc2:	c7 04 24 60 cc 14 80 	movl   $0x8014cc60,(%esp)
80105fc9:	e8 82 e4 ff ff       	call   80104450 <wakeup>
      release(&tickslock);
80105fce:	c7 04 24 80 cc 14 80 	movl   $0x8014cc80,(%esp)
80105fd5:	e8 f6 e8 ff ff       	call   801048d0 <release>
    lapiceoi();
80105fda:	e9 37 fd ff ff       	jmp    80105d16 <trap+0x46>
80105fdf:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105fe2:	e8 b9 dc ff ff       	call   80103ca0 <cpuid>
80105fe7:	89 74 24 10          	mov    %esi,0x10(%esp)
80105feb:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105fef:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ff3:	8b 43 30             	mov    0x30(%ebx),%eax
80105ff6:	c7 04 24 74 80 10 80 	movl   $0x80108074,(%esp)
80105ffd:	89 44 24 04          	mov    %eax,0x4(%esp)
80106001:	e8 7a a6 ff ff       	call   80100680 <cprintf>
      panic("trap");
80106006:	c7 04 24 48 80 10 80 	movl   $0x80108048,(%esp)
8010600d:	e8 3e a3 ff ff       	call   80100350 <panic>
    if (!read_flt) panic("present but not cow T_PGFLT");
80106012:	c7 04 24 2c 80 10 80 	movl   $0x8010802c,(%esp)
80106019:	e8 32 a3 ff ff       	call   80100350 <panic>
8010601e:	66 90                	xchg   %ax,%ax

80106020 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106020:	a1 c0 d4 14 80       	mov    0x8014d4c0,%eax
80106025:	85 c0                	test   %eax,%eax
80106027:	74 17                	je     80106040 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106029:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010602e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010602f:	24 01                	and    $0x1,%al
80106031:	74 0d                	je     80106040 <uartgetc+0x20>
80106033:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106038:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106039:	0f b6 c0             	movzbl %al,%eax
8010603c:	c3                   	ret    
8010603d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106045:	c3                   	ret    
80106046:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010604d:	8d 76 00             	lea    0x0(%esi),%esi

80106050 <uartinit>:
{
80106050:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106051:	31 c9                	xor    %ecx,%ecx
80106053:	89 e5                	mov    %esp,%ebp
80106055:	88 c8                	mov    %cl,%al
80106057:	57                   	push   %edi
80106058:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010605d:	56                   	push   %esi
8010605e:	89 fa                	mov    %edi,%edx
80106060:	53                   	push   %ebx
80106061:	83 ec 2c             	sub    $0x2c,%esp
80106064:	ee                   	out    %al,(%dx)
80106065:	be fb 03 00 00       	mov    $0x3fb,%esi
8010606a:	b0 80                	mov    $0x80,%al
8010606c:	89 f2                	mov    %esi,%edx
8010606e:	ee                   	out    %al,(%dx)
8010606f:	b0 0c                	mov    $0xc,%al
80106071:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106076:	ee                   	out    %al,(%dx)
80106077:	bb f9 03 00 00       	mov    $0x3f9,%ebx
8010607c:	88 c8                	mov    %cl,%al
8010607e:	89 da                	mov    %ebx,%edx
80106080:	ee                   	out    %al,(%dx)
80106081:	b0 03                	mov    $0x3,%al
80106083:	89 f2                	mov    %esi,%edx
80106085:	ee                   	out    %al,(%dx)
80106086:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010608b:	88 c8                	mov    %cl,%al
8010608d:	ee                   	out    %al,(%dx)
8010608e:	b0 01                	mov    $0x1,%al
80106090:	89 da                	mov    %ebx,%edx
80106092:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106093:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106098:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106099:	fe c0                	inc    %al
8010609b:	0f 84 8b 00 00 00    	je     8010612c <uartinit+0xdc>
  uart = 1;
801060a1:	ba 01 00 00 00       	mov    $0x1,%edx
801060a6:	89 15 c0 d4 14 80    	mov    %edx,0x8014d4c0
801060ac:	89 fa                	mov    %edi,%edx
801060ae:	ec                   	in     (%dx),%al
801060af:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060b4:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801060b5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801060bc:	31 c9                	xor    %ecx,%ecx
  for(p="xv6...\n"; *p; p++)
801060be:	bf b4 81 10 80       	mov    $0x801081b4,%edi
  ioapicenable(IRQ_COM1, 0);
801060c3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801060c7:	be fd 03 00 00       	mov    $0x3fd,%esi
801060cc:	e8 0f c5 ff ff       	call   801025e0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801060d1:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801060d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
801060e0:	a1 c0 d4 14 80       	mov    0x8014d4c0,%eax
801060e5:	85 c0                	test   %eax,%eax
801060e7:	74 37                	je     80106120 <uartinit+0xd0>
801060e9:	89 f2                	mov    %esi,%edx
801060eb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801060ec:	24 20                	and    $0x20,%al
801060ee:	75 26                	jne    80106116 <uartinit+0xc6>
801060f0:	bb 80 00 00 00       	mov    $0x80,%ebx
801060f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    microdelay(10);
80106100:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106107:	e8 c4 cb ff ff       	call   80102cd0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010610c:	4b                   	dec    %ebx
8010610d:	74 07                	je     80106116 <uartinit+0xc6>
8010610f:	89 f2                	mov    %esi,%edx
80106111:	ec                   	in     (%dx),%al
80106112:	24 20                	and    $0x20,%al
80106114:	74 ea                	je     80106100 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106116:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010611b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010611f:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106120:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106124:	47                   	inc    %edi
80106125:	88 45 e7             	mov    %al,-0x19(%ebp)
80106128:	84 c0                	test   %al,%al
8010612a:	75 b4                	jne    801060e0 <uartinit+0x90>
}
8010612c:	83 c4 2c             	add    $0x2c,%esp
8010612f:	5b                   	pop    %ebx
80106130:	5e                   	pop    %esi
80106131:	5f                   	pop    %edi
80106132:	5d                   	pop    %ebp
80106133:	c3                   	ret    
80106134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010613b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop

80106140 <uartputc>:
  if(!uart)
80106140:	a1 c0 d4 14 80       	mov    0x8014d4c0,%eax
80106145:	85 c0                	test   %eax,%eax
80106147:	74 57                	je     801061a0 <uartputc+0x60>
{
80106149:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010614a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010614f:	89 e5                	mov    %esp,%ebp
80106151:	56                   	push   %esi
80106152:	53                   	push   %ebx
80106153:	83 ec 10             	sub    $0x10,%esp
80106156:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106157:	24 20                	and    $0x20,%al
80106159:	75 2b                	jne    80106186 <uartputc+0x46>
8010615b:	bb 80 00 00 00       	mov    $0x80,%ebx
80106160:	be fd 03 00 00       	mov    $0x3fd,%esi
80106165:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010616c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    microdelay(10);
80106170:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106177:	e8 54 cb ff ff       	call   80102cd0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010617c:	4b                   	dec    %ebx
8010617d:	74 07                	je     80106186 <uartputc+0x46>
8010617f:	89 f2                	mov    %esi,%edx
80106181:	ec                   	in     (%dx),%al
80106182:	24 20                	and    $0x20,%al
80106184:	74 ea                	je     80106170 <uartputc+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106186:	8b 45 08             	mov    0x8(%ebp),%eax
80106189:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010618e:	ee                   	out    %al,(%dx)
}
8010618f:	83 c4 10             	add    $0x10,%esp
80106192:	5b                   	pop    %ebx
80106193:	5e                   	pop    %esi
80106194:	5d                   	pop    %ebp
80106195:	c3                   	ret    
80106196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010619d:	8d 76 00             	lea    0x0(%esi),%esi
801061a0:	c3                   	ret    
801061a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061af:	90                   	nop

801061b0 <uartintr>:

void
uartintr(void)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801061b6:	c7 04 24 20 60 10 80 	movl   $0x80106020,(%esp)
801061bd:	e8 ee a6 ff ff       	call   801008b0 <consoleintr>
}
801061c2:	89 ec                	mov    %ebp,%esp
801061c4:	5d                   	pop    %ebp
801061c5:	c3                   	ret    

801061c6 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0 # padding
801061c6:	6a 00                	push   $0x0
  pushl $0 # trapno
801061c8:	6a 00                	push   $0x0
  jmp alltraps
801061ca:	e9 26 fa ff ff       	jmp    80105bf5 <alltraps>

801061cf <vector1>:
.globl vector1
vector1:
  pushl $0 # padding
801061cf:	6a 00                	push   $0x0
  pushl $1 # trapno
801061d1:	6a 01                	push   $0x1
  jmp alltraps
801061d3:	e9 1d fa ff ff       	jmp    80105bf5 <alltraps>

801061d8 <vector2>:
.globl vector2
vector2:
  pushl $0 # padding
801061d8:	6a 00                	push   $0x0
  pushl $2 # trapno
801061da:	6a 02                	push   $0x2
  jmp alltraps
801061dc:	e9 14 fa ff ff       	jmp    80105bf5 <alltraps>

801061e1 <vector3>:
.globl vector3
vector3:
  pushl $0 # padding
801061e1:	6a 00                	push   $0x0
  pushl $3 # trapno
801061e3:	6a 03                	push   $0x3
  jmp alltraps
801061e5:	e9 0b fa ff ff       	jmp    80105bf5 <alltraps>

801061ea <vector4>:
.globl vector4
vector4:
  pushl $0 # padding
801061ea:	6a 00                	push   $0x0
  pushl $4 # trapno
801061ec:	6a 04                	push   $0x4
  jmp alltraps
801061ee:	e9 02 fa ff ff       	jmp    80105bf5 <alltraps>

801061f3 <vector5>:
.globl vector5
vector5:
  pushl $0 # padding
801061f3:	6a 00                	push   $0x0
  pushl $5 # trapno
801061f5:	6a 05                	push   $0x5
  jmp alltraps
801061f7:	e9 f9 f9 ff ff       	jmp    80105bf5 <alltraps>

801061fc <vector6>:
.globl vector6
vector6:
  pushl $0 # padding
801061fc:	6a 00                	push   $0x0
  pushl $6 # trapno
801061fe:	6a 06                	push   $0x6
  jmp alltraps
80106200:	e9 f0 f9 ff ff       	jmp    80105bf5 <alltraps>

80106205 <vector7>:
.globl vector7
vector7:
  pushl $0 # padding
80106205:	6a 00                	push   $0x0
  pushl $7 # trapno
80106207:	6a 07                	push   $0x7
  jmp alltraps
80106209:	e9 e7 f9 ff ff       	jmp    80105bf5 <alltraps>

8010620e <vector8>:
.globl vector8
vector8:
  pushl $8 # trapno
8010620e:	6a 08                	push   $0x8
  jmp alltraps
80106210:	e9 e0 f9 ff ff       	jmp    80105bf5 <alltraps>

80106215 <vector9>:
.globl vector9
vector9:
  pushl $0 # padding
80106215:	6a 00                	push   $0x0
  pushl $9 # trapno
80106217:	6a 09                	push   $0x9
  jmp alltraps
80106219:	e9 d7 f9 ff ff       	jmp    80105bf5 <alltraps>

8010621e <vector10>:
.globl vector10
vector10:
  pushl $10 # trapno
8010621e:	6a 0a                	push   $0xa
  jmp alltraps
80106220:	e9 d0 f9 ff ff       	jmp    80105bf5 <alltraps>

80106225 <vector11>:
.globl vector11
vector11:
  pushl $11 # trapno
80106225:	6a 0b                	push   $0xb
  jmp alltraps
80106227:	e9 c9 f9 ff ff       	jmp    80105bf5 <alltraps>

8010622c <vector12>:
.globl vector12
vector12:
  pushl $12 # trapno
8010622c:	6a 0c                	push   $0xc
  jmp alltraps
8010622e:	e9 c2 f9 ff ff       	jmp    80105bf5 <alltraps>

80106233 <vector13>:
.globl vector13
vector13:
  pushl $13 # trapno
80106233:	6a 0d                	push   $0xd
  jmp alltraps
80106235:	e9 bb f9 ff ff       	jmp    80105bf5 <alltraps>

8010623a <vector14>:
.globl vector14
vector14:
  pushl $14 # trapno
8010623a:	6a 0e                	push   $0xe
  jmp alltraps
8010623c:	e9 b4 f9 ff ff       	jmp    80105bf5 <alltraps>

80106241 <vector15>:
.globl vector15
vector15:
  pushl $0 # padding
80106241:	6a 00                	push   $0x0
  pushl $15 # trapno
80106243:	6a 0f                	push   $0xf
  jmp alltraps
80106245:	e9 ab f9 ff ff       	jmp    80105bf5 <alltraps>

8010624a <vector16>:
.globl vector16
vector16:
  pushl $0 # padding
8010624a:	6a 00                	push   $0x0
  pushl $16 # trapno
8010624c:	6a 10                	push   $0x10
  jmp alltraps
8010624e:	e9 a2 f9 ff ff       	jmp    80105bf5 <alltraps>

80106253 <vector17>:
.globl vector17
vector17:
  pushl $17 # trapno
80106253:	6a 11                	push   $0x11
  jmp alltraps
80106255:	e9 9b f9 ff ff       	jmp    80105bf5 <alltraps>

8010625a <vector18>:
.globl vector18
vector18:
  pushl $0 # padding
8010625a:	6a 00                	push   $0x0
  pushl $18 # trapno
8010625c:	6a 12                	push   $0x12
  jmp alltraps
8010625e:	e9 92 f9 ff ff       	jmp    80105bf5 <alltraps>

80106263 <vector19>:
.globl vector19
vector19:
  pushl $0 # padding
80106263:	6a 00                	push   $0x0
  pushl $19 # trapno
80106265:	6a 13                	push   $0x13
  jmp alltraps
80106267:	e9 89 f9 ff ff       	jmp    80105bf5 <alltraps>

8010626c <vector20>:
.globl vector20
vector20:
  pushl $0 # padding
8010626c:	6a 00                	push   $0x0
  pushl $20 # trapno
8010626e:	6a 14                	push   $0x14
  jmp alltraps
80106270:	e9 80 f9 ff ff       	jmp    80105bf5 <alltraps>

80106275 <vector21>:
.globl vector21
vector21:
  pushl $0 # padding
80106275:	6a 00                	push   $0x0
  pushl $21 # trapno
80106277:	6a 15                	push   $0x15
  jmp alltraps
80106279:	e9 77 f9 ff ff       	jmp    80105bf5 <alltraps>

8010627e <vector22>:
.globl vector22
vector22:
  pushl $0 # padding
8010627e:	6a 00                	push   $0x0
  pushl $22 # trapno
80106280:	6a 16                	push   $0x16
  jmp alltraps
80106282:	e9 6e f9 ff ff       	jmp    80105bf5 <alltraps>

80106287 <vector23>:
.globl vector23
vector23:
  pushl $0 # padding
80106287:	6a 00                	push   $0x0
  pushl $23 # trapno
80106289:	6a 17                	push   $0x17
  jmp alltraps
8010628b:	e9 65 f9 ff ff       	jmp    80105bf5 <alltraps>

80106290 <vector24>:
.globl vector24
vector24:
  pushl $0 # padding
80106290:	6a 00                	push   $0x0
  pushl $24 # trapno
80106292:	6a 18                	push   $0x18
  jmp alltraps
80106294:	e9 5c f9 ff ff       	jmp    80105bf5 <alltraps>

80106299 <vector25>:
.globl vector25
vector25:
  pushl $0 # padding
80106299:	6a 00                	push   $0x0
  pushl $25 # trapno
8010629b:	6a 19                	push   $0x19
  jmp alltraps
8010629d:	e9 53 f9 ff ff       	jmp    80105bf5 <alltraps>

801062a2 <vector26>:
.globl vector26
vector26:
  pushl $0 # padding
801062a2:	6a 00                	push   $0x0
  pushl $26 # trapno
801062a4:	6a 1a                	push   $0x1a
  jmp alltraps
801062a6:	e9 4a f9 ff ff       	jmp    80105bf5 <alltraps>

801062ab <vector27>:
.globl vector27
vector27:
  pushl $0 # padding
801062ab:	6a 00                	push   $0x0
  pushl $27 # trapno
801062ad:	6a 1b                	push   $0x1b
  jmp alltraps
801062af:	e9 41 f9 ff ff       	jmp    80105bf5 <alltraps>

801062b4 <vector28>:
.globl vector28
vector28:
  pushl $0 # padding
801062b4:	6a 00                	push   $0x0
  pushl $28 # trapno
801062b6:	6a 1c                	push   $0x1c
  jmp alltraps
801062b8:	e9 38 f9 ff ff       	jmp    80105bf5 <alltraps>

801062bd <vector29>:
.globl vector29
vector29:
  pushl $0 # padding
801062bd:	6a 00                	push   $0x0
  pushl $29 # trapno
801062bf:	6a 1d                	push   $0x1d
  jmp alltraps
801062c1:	e9 2f f9 ff ff       	jmp    80105bf5 <alltraps>

801062c6 <vector30>:
.globl vector30
vector30:
  pushl $0 # padding
801062c6:	6a 00                	push   $0x0
  pushl $30 # trapno
801062c8:	6a 1e                	push   $0x1e
  jmp alltraps
801062ca:	e9 26 f9 ff ff       	jmp    80105bf5 <alltraps>

801062cf <vector31>:
.globl vector31
vector31:
  pushl $0 # padding
801062cf:	6a 00                	push   $0x0
  pushl $31 # trapno
801062d1:	6a 1f                	push   $0x1f
  jmp alltraps
801062d3:	e9 1d f9 ff ff       	jmp    80105bf5 <alltraps>

801062d8 <vector32>:
.globl vector32
vector32:
  pushl $0 # padding
801062d8:	6a 00                	push   $0x0
  pushl $32 # trapno
801062da:	6a 20                	push   $0x20
  jmp alltraps
801062dc:	e9 14 f9 ff ff       	jmp    80105bf5 <alltraps>

801062e1 <vector33>:
.globl vector33
vector33:
  pushl $0 # padding
801062e1:	6a 00                	push   $0x0
  pushl $33 # trapno
801062e3:	6a 21                	push   $0x21
  jmp alltraps
801062e5:	e9 0b f9 ff ff       	jmp    80105bf5 <alltraps>

801062ea <vector34>:
.globl vector34
vector34:
  pushl $0 # padding
801062ea:	6a 00                	push   $0x0
  pushl $34 # trapno
801062ec:	6a 22                	push   $0x22
  jmp alltraps
801062ee:	e9 02 f9 ff ff       	jmp    80105bf5 <alltraps>

801062f3 <vector35>:
.globl vector35
vector35:
  pushl $0 # padding
801062f3:	6a 00                	push   $0x0
  pushl $35 # trapno
801062f5:	6a 23                	push   $0x23
  jmp alltraps
801062f7:	e9 f9 f8 ff ff       	jmp    80105bf5 <alltraps>

801062fc <vector36>:
.globl vector36
vector36:
  pushl $0 # padding
801062fc:	6a 00                	push   $0x0
  pushl $36 # trapno
801062fe:	6a 24                	push   $0x24
  jmp alltraps
80106300:	e9 f0 f8 ff ff       	jmp    80105bf5 <alltraps>

80106305 <vector37>:
.globl vector37
vector37:
  pushl $0 # padding
80106305:	6a 00                	push   $0x0
  pushl $37 # trapno
80106307:	6a 25                	push   $0x25
  jmp alltraps
80106309:	e9 e7 f8 ff ff       	jmp    80105bf5 <alltraps>

8010630e <vector38>:
.globl vector38
vector38:
  pushl $0 # padding
8010630e:	6a 00                	push   $0x0
  pushl $38 # trapno
80106310:	6a 26                	push   $0x26
  jmp alltraps
80106312:	e9 de f8 ff ff       	jmp    80105bf5 <alltraps>

80106317 <vector39>:
.globl vector39
vector39:
  pushl $0 # padding
80106317:	6a 00                	push   $0x0
  pushl $39 # trapno
80106319:	6a 27                	push   $0x27
  jmp alltraps
8010631b:	e9 d5 f8 ff ff       	jmp    80105bf5 <alltraps>

80106320 <vector40>:
.globl vector40
vector40:
  pushl $0 # padding
80106320:	6a 00                	push   $0x0
  pushl $40 # trapno
80106322:	6a 28                	push   $0x28
  jmp alltraps
80106324:	e9 cc f8 ff ff       	jmp    80105bf5 <alltraps>

80106329 <vector41>:
.globl vector41
vector41:
  pushl $0 # padding
80106329:	6a 00                	push   $0x0
  pushl $41 # trapno
8010632b:	6a 29                	push   $0x29
  jmp alltraps
8010632d:	e9 c3 f8 ff ff       	jmp    80105bf5 <alltraps>

80106332 <vector42>:
.globl vector42
vector42:
  pushl $0 # padding
80106332:	6a 00                	push   $0x0
  pushl $42 # trapno
80106334:	6a 2a                	push   $0x2a
  jmp alltraps
80106336:	e9 ba f8 ff ff       	jmp    80105bf5 <alltraps>

8010633b <vector43>:
.globl vector43
vector43:
  pushl $0 # padding
8010633b:	6a 00                	push   $0x0
  pushl $43 # trapno
8010633d:	6a 2b                	push   $0x2b
  jmp alltraps
8010633f:	e9 b1 f8 ff ff       	jmp    80105bf5 <alltraps>

80106344 <vector44>:
.globl vector44
vector44:
  pushl $0 # padding
80106344:	6a 00                	push   $0x0
  pushl $44 # trapno
80106346:	6a 2c                	push   $0x2c
  jmp alltraps
80106348:	e9 a8 f8 ff ff       	jmp    80105bf5 <alltraps>

8010634d <vector45>:
.globl vector45
vector45:
  pushl $0 # padding
8010634d:	6a 00                	push   $0x0
  pushl $45 # trapno
8010634f:	6a 2d                	push   $0x2d
  jmp alltraps
80106351:	e9 9f f8 ff ff       	jmp    80105bf5 <alltraps>

80106356 <vector46>:
.globl vector46
vector46:
  pushl $0 # padding
80106356:	6a 00                	push   $0x0
  pushl $46 # trapno
80106358:	6a 2e                	push   $0x2e
  jmp alltraps
8010635a:	e9 96 f8 ff ff       	jmp    80105bf5 <alltraps>

8010635f <vector47>:
.globl vector47
vector47:
  pushl $0 # padding
8010635f:	6a 00                	push   $0x0
  pushl $47 # trapno
80106361:	6a 2f                	push   $0x2f
  jmp alltraps
80106363:	e9 8d f8 ff ff       	jmp    80105bf5 <alltraps>

80106368 <vector48>:
.globl vector48
vector48:
  pushl $0 # padding
80106368:	6a 00                	push   $0x0
  pushl $48 # trapno
8010636a:	6a 30                	push   $0x30
  jmp alltraps
8010636c:	e9 84 f8 ff ff       	jmp    80105bf5 <alltraps>

80106371 <vector49>:
.globl vector49
vector49:
  pushl $0 # padding
80106371:	6a 00                	push   $0x0
  pushl $49 # trapno
80106373:	6a 31                	push   $0x31
  jmp alltraps
80106375:	e9 7b f8 ff ff       	jmp    80105bf5 <alltraps>

8010637a <vector50>:
.globl vector50
vector50:
  pushl $0 # padding
8010637a:	6a 00                	push   $0x0
  pushl $50 # trapno
8010637c:	6a 32                	push   $0x32
  jmp alltraps
8010637e:	e9 72 f8 ff ff       	jmp    80105bf5 <alltraps>

80106383 <vector51>:
.globl vector51
vector51:
  pushl $0 # padding
80106383:	6a 00                	push   $0x0
  pushl $51 # trapno
80106385:	6a 33                	push   $0x33
  jmp alltraps
80106387:	e9 69 f8 ff ff       	jmp    80105bf5 <alltraps>

8010638c <vector52>:
.globl vector52
vector52:
  pushl $0 # padding
8010638c:	6a 00                	push   $0x0
  pushl $52 # trapno
8010638e:	6a 34                	push   $0x34
  jmp alltraps
80106390:	e9 60 f8 ff ff       	jmp    80105bf5 <alltraps>

80106395 <vector53>:
.globl vector53
vector53:
  pushl $0 # padding
80106395:	6a 00                	push   $0x0
  pushl $53 # trapno
80106397:	6a 35                	push   $0x35
  jmp alltraps
80106399:	e9 57 f8 ff ff       	jmp    80105bf5 <alltraps>

8010639e <vector54>:
.globl vector54
vector54:
  pushl $0 # padding
8010639e:	6a 00                	push   $0x0
  pushl $54 # trapno
801063a0:	6a 36                	push   $0x36
  jmp alltraps
801063a2:	e9 4e f8 ff ff       	jmp    80105bf5 <alltraps>

801063a7 <vector55>:
.globl vector55
vector55:
  pushl $0 # padding
801063a7:	6a 00                	push   $0x0
  pushl $55 # trapno
801063a9:	6a 37                	push   $0x37
  jmp alltraps
801063ab:	e9 45 f8 ff ff       	jmp    80105bf5 <alltraps>

801063b0 <vector56>:
.globl vector56
vector56:
  pushl $0 # padding
801063b0:	6a 00                	push   $0x0
  pushl $56 # trapno
801063b2:	6a 38                	push   $0x38
  jmp alltraps
801063b4:	e9 3c f8 ff ff       	jmp    80105bf5 <alltraps>

801063b9 <vector57>:
.globl vector57
vector57:
  pushl $0 # padding
801063b9:	6a 00                	push   $0x0
  pushl $57 # trapno
801063bb:	6a 39                	push   $0x39
  jmp alltraps
801063bd:	e9 33 f8 ff ff       	jmp    80105bf5 <alltraps>

801063c2 <vector58>:
.globl vector58
vector58:
  pushl $0 # padding
801063c2:	6a 00                	push   $0x0
  pushl $58 # trapno
801063c4:	6a 3a                	push   $0x3a
  jmp alltraps
801063c6:	e9 2a f8 ff ff       	jmp    80105bf5 <alltraps>

801063cb <vector59>:
.globl vector59
vector59:
  pushl $0 # padding
801063cb:	6a 00                	push   $0x0
  pushl $59 # trapno
801063cd:	6a 3b                	push   $0x3b
  jmp alltraps
801063cf:	e9 21 f8 ff ff       	jmp    80105bf5 <alltraps>

801063d4 <vector60>:
.globl vector60
vector60:
  pushl $0 # padding
801063d4:	6a 00                	push   $0x0
  pushl $60 # trapno
801063d6:	6a 3c                	push   $0x3c
  jmp alltraps
801063d8:	e9 18 f8 ff ff       	jmp    80105bf5 <alltraps>

801063dd <vector61>:
.globl vector61
vector61:
  pushl $0 # padding
801063dd:	6a 00                	push   $0x0
  pushl $61 # trapno
801063df:	6a 3d                	push   $0x3d
  jmp alltraps
801063e1:	e9 0f f8 ff ff       	jmp    80105bf5 <alltraps>

801063e6 <vector62>:
.globl vector62
vector62:
  pushl $0 # padding
801063e6:	6a 00                	push   $0x0
  pushl $62 # trapno
801063e8:	6a 3e                	push   $0x3e
  jmp alltraps
801063ea:	e9 06 f8 ff ff       	jmp    80105bf5 <alltraps>

801063ef <vector63>:
.globl vector63
vector63:
  pushl $0 # padding
801063ef:	6a 00                	push   $0x0
  pushl $63 # trapno
801063f1:	6a 3f                	push   $0x3f
  jmp alltraps
801063f3:	e9 fd f7 ff ff       	jmp    80105bf5 <alltraps>

801063f8 <vector64>:
.globl vector64
vector64:
  pushl $0 # padding
801063f8:	6a 00                	push   $0x0
  pushl $64 # trapno
801063fa:	6a 40                	push   $0x40
  jmp alltraps
801063fc:	e9 f4 f7 ff ff       	jmp    80105bf5 <alltraps>

80106401 <vector65>:
.globl vector65
vector65:
  pushl $0 # padding
80106401:	6a 00                	push   $0x0
  pushl $65 # trapno
80106403:	6a 41                	push   $0x41
  jmp alltraps
80106405:	e9 eb f7 ff ff       	jmp    80105bf5 <alltraps>

8010640a <vector66>:
.globl vector66
vector66:
  pushl $0 # padding
8010640a:	6a 00                	push   $0x0
  pushl $66 # trapno
8010640c:	6a 42                	push   $0x42
  jmp alltraps
8010640e:	e9 e2 f7 ff ff       	jmp    80105bf5 <alltraps>

80106413 <vector67>:
.globl vector67
vector67:
  pushl $0 # padding
80106413:	6a 00                	push   $0x0
  pushl $67 # trapno
80106415:	6a 43                	push   $0x43
  jmp alltraps
80106417:	e9 d9 f7 ff ff       	jmp    80105bf5 <alltraps>

8010641c <vector68>:
.globl vector68
vector68:
  pushl $0 # padding
8010641c:	6a 00                	push   $0x0
  pushl $68 # trapno
8010641e:	6a 44                	push   $0x44
  jmp alltraps
80106420:	e9 d0 f7 ff ff       	jmp    80105bf5 <alltraps>

80106425 <vector69>:
.globl vector69
vector69:
  pushl $0 # padding
80106425:	6a 00                	push   $0x0
  pushl $69 # trapno
80106427:	6a 45                	push   $0x45
  jmp alltraps
80106429:	e9 c7 f7 ff ff       	jmp    80105bf5 <alltraps>

8010642e <vector70>:
.globl vector70
vector70:
  pushl $0 # padding
8010642e:	6a 00                	push   $0x0
  pushl $70 # trapno
80106430:	6a 46                	push   $0x46
  jmp alltraps
80106432:	e9 be f7 ff ff       	jmp    80105bf5 <alltraps>

80106437 <vector71>:
.globl vector71
vector71:
  pushl $0 # padding
80106437:	6a 00                	push   $0x0
  pushl $71 # trapno
80106439:	6a 47                	push   $0x47
  jmp alltraps
8010643b:	e9 b5 f7 ff ff       	jmp    80105bf5 <alltraps>

80106440 <vector72>:
.globl vector72
vector72:
  pushl $0 # padding
80106440:	6a 00                	push   $0x0
  pushl $72 # trapno
80106442:	6a 48                	push   $0x48
  jmp alltraps
80106444:	e9 ac f7 ff ff       	jmp    80105bf5 <alltraps>

80106449 <vector73>:
.globl vector73
vector73:
  pushl $0 # padding
80106449:	6a 00                	push   $0x0
  pushl $73 # trapno
8010644b:	6a 49                	push   $0x49
  jmp alltraps
8010644d:	e9 a3 f7 ff ff       	jmp    80105bf5 <alltraps>

80106452 <vector74>:
.globl vector74
vector74:
  pushl $0 # padding
80106452:	6a 00                	push   $0x0
  pushl $74 # trapno
80106454:	6a 4a                	push   $0x4a
  jmp alltraps
80106456:	e9 9a f7 ff ff       	jmp    80105bf5 <alltraps>

8010645b <vector75>:
.globl vector75
vector75:
  pushl $0 # padding
8010645b:	6a 00                	push   $0x0
  pushl $75 # trapno
8010645d:	6a 4b                	push   $0x4b
  jmp alltraps
8010645f:	e9 91 f7 ff ff       	jmp    80105bf5 <alltraps>

80106464 <vector76>:
.globl vector76
vector76:
  pushl $0 # padding
80106464:	6a 00                	push   $0x0
  pushl $76 # trapno
80106466:	6a 4c                	push   $0x4c
  jmp alltraps
80106468:	e9 88 f7 ff ff       	jmp    80105bf5 <alltraps>

8010646d <vector77>:
.globl vector77
vector77:
  pushl $0 # padding
8010646d:	6a 00                	push   $0x0
  pushl $77 # trapno
8010646f:	6a 4d                	push   $0x4d
  jmp alltraps
80106471:	e9 7f f7 ff ff       	jmp    80105bf5 <alltraps>

80106476 <vector78>:
.globl vector78
vector78:
  pushl $0 # padding
80106476:	6a 00                	push   $0x0
  pushl $78 # trapno
80106478:	6a 4e                	push   $0x4e
  jmp alltraps
8010647a:	e9 76 f7 ff ff       	jmp    80105bf5 <alltraps>

8010647f <vector79>:
.globl vector79
vector79:
  pushl $0 # padding
8010647f:	6a 00                	push   $0x0
  pushl $79 # trapno
80106481:	6a 4f                	push   $0x4f
  jmp alltraps
80106483:	e9 6d f7 ff ff       	jmp    80105bf5 <alltraps>

80106488 <vector80>:
.globl vector80
vector80:
  pushl $0 # padding
80106488:	6a 00                	push   $0x0
  pushl $80 # trapno
8010648a:	6a 50                	push   $0x50
  jmp alltraps
8010648c:	e9 64 f7 ff ff       	jmp    80105bf5 <alltraps>

80106491 <vector81>:
.globl vector81
vector81:
  pushl $0 # padding
80106491:	6a 00                	push   $0x0
  pushl $81 # trapno
80106493:	6a 51                	push   $0x51
  jmp alltraps
80106495:	e9 5b f7 ff ff       	jmp    80105bf5 <alltraps>

8010649a <vector82>:
.globl vector82
vector82:
  pushl $0 # padding
8010649a:	6a 00                	push   $0x0
  pushl $82 # trapno
8010649c:	6a 52                	push   $0x52
  jmp alltraps
8010649e:	e9 52 f7 ff ff       	jmp    80105bf5 <alltraps>

801064a3 <vector83>:
.globl vector83
vector83:
  pushl $0 # padding
801064a3:	6a 00                	push   $0x0
  pushl $83 # trapno
801064a5:	6a 53                	push   $0x53
  jmp alltraps
801064a7:	e9 49 f7 ff ff       	jmp    80105bf5 <alltraps>

801064ac <vector84>:
.globl vector84
vector84:
  pushl $0 # padding
801064ac:	6a 00                	push   $0x0
  pushl $84 # trapno
801064ae:	6a 54                	push   $0x54
  jmp alltraps
801064b0:	e9 40 f7 ff ff       	jmp    80105bf5 <alltraps>

801064b5 <vector85>:
.globl vector85
vector85:
  pushl $0 # padding
801064b5:	6a 00                	push   $0x0
  pushl $85 # trapno
801064b7:	6a 55                	push   $0x55
  jmp alltraps
801064b9:	e9 37 f7 ff ff       	jmp    80105bf5 <alltraps>

801064be <vector86>:
.globl vector86
vector86:
  pushl $0 # padding
801064be:	6a 00                	push   $0x0
  pushl $86 # trapno
801064c0:	6a 56                	push   $0x56
  jmp alltraps
801064c2:	e9 2e f7 ff ff       	jmp    80105bf5 <alltraps>

801064c7 <vector87>:
.globl vector87
vector87:
  pushl $0 # padding
801064c7:	6a 00                	push   $0x0
  pushl $87 # trapno
801064c9:	6a 57                	push   $0x57
  jmp alltraps
801064cb:	e9 25 f7 ff ff       	jmp    80105bf5 <alltraps>

801064d0 <vector88>:
.globl vector88
vector88:
  pushl $0 # padding
801064d0:	6a 00                	push   $0x0
  pushl $88 # trapno
801064d2:	6a 58                	push   $0x58
  jmp alltraps
801064d4:	e9 1c f7 ff ff       	jmp    80105bf5 <alltraps>

801064d9 <vector89>:
.globl vector89
vector89:
  pushl $0 # padding
801064d9:	6a 00                	push   $0x0
  pushl $89 # trapno
801064db:	6a 59                	push   $0x59
  jmp alltraps
801064dd:	e9 13 f7 ff ff       	jmp    80105bf5 <alltraps>

801064e2 <vector90>:
.globl vector90
vector90:
  pushl $0 # padding
801064e2:	6a 00                	push   $0x0
  pushl $90 # trapno
801064e4:	6a 5a                	push   $0x5a
  jmp alltraps
801064e6:	e9 0a f7 ff ff       	jmp    80105bf5 <alltraps>

801064eb <vector91>:
.globl vector91
vector91:
  pushl $0 # padding
801064eb:	6a 00                	push   $0x0
  pushl $91 # trapno
801064ed:	6a 5b                	push   $0x5b
  jmp alltraps
801064ef:	e9 01 f7 ff ff       	jmp    80105bf5 <alltraps>

801064f4 <vector92>:
.globl vector92
vector92:
  pushl $0 # padding
801064f4:	6a 00                	push   $0x0
  pushl $92 # trapno
801064f6:	6a 5c                	push   $0x5c
  jmp alltraps
801064f8:	e9 f8 f6 ff ff       	jmp    80105bf5 <alltraps>

801064fd <vector93>:
.globl vector93
vector93:
  pushl $0 # padding
801064fd:	6a 00                	push   $0x0
  pushl $93 # trapno
801064ff:	6a 5d                	push   $0x5d
  jmp alltraps
80106501:	e9 ef f6 ff ff       	jmp    80105bf5 <alltraps>

80106506 <vector94>:
.globl vector94
vector94:
  pushl $0 # padding
80106506:	6a 00                	push   $0x0
  pushl $94 # trapno
80106508:	6a 5e                	push   $0x5e
  jmp alltraps
8010650a:	e9 e6 f6 ff ff       	jmp    80105bf5 <alltraps>

8010650f <vector95>:
.globl vector95
vector95:
  pushl $0 # padding
8010650f:	6a 00                	push   $0x0
  pushl $95 # trapno
80106511:	6a 5f                	push   $0x5f
  jmp alltraps
80106513:	e9 dd f6 ff ff       	jmp    80105bf5 <alltraps>

80106518 <vector96>:
.globl vector96
vector96:
  pushl $0 # padding
80106518:	6a 00                	push   $0x0
  pushl $96 # trapno
8010651a:	6a 60                	push   $0x60
  jmp alltraps
8010651c:	e9 d4 f6 ff ff       	jmp    80105bf5 <alltraps>

80106521 <vector97>:
.globl vector97
vector97:
  pushl $0 # padding
80106521:	6a 00                	push   $0x0
  pushl $97 # trapno
80106523:	6a 61                	push   $0x61
  jmp alltraps
80106525:	e9 cb f6 ff ff       	jmp    80105bf5 <alltraps>

8010652a <vector98>:
.globl vector98
vector98:
  pushl $0 # padding
8010652a:	6a 00                	push   $0x0
  pushl $98 # trapno
8010652c:	6a 62                	push   $0x62
  jmp alltraps
8010652e:	e9 c2 f6 ff ff       	jmp    80105bf5 <alltraps>

80106533 <vector99>:
.globl vector99
vector99:
  pushl $0 # padding
80106533:	6a 00                	push   $0x0
  pushl $99 # trapno
80106535:	6a 63                	push   $0x63
  jmp alltraps
80106537:	e9 b9 f6 ff ff       	jmp    80105bf5 <alltraps>

8010653c <vector100>:
.globl vector100
vector100:
  pushl $0 # padding
8010653c:	6a 00                	push   $0x0
  pushl $100 # trapno
8010653e:	6a 64                	push   $0x64
  jmp alltraps
80106540:	e9 b0 f6 ff ff       	jmp    80105bf5 <alltraps>

80106545 <vector101>:
.globl vector101
vector101:
  pushl $0 # padding
80106545:	6a 00                	push   $0x0
  pushl $101 # trapno
80106547:	6a 65                	push   $0x65
  jmp alltraps
80106549:	e9 a7 f6 ff ff       	jmp    80105bf5 <alltraps>

8010654e <vector102>:
.globl vector102
vector102:
  pushl $0 # padding
8010654e:	6a 00                	push   $0x0
  pushl $102 # trapno
80106550:	6a 66                	push   $0x66
  jmp alltraps
80106552:	e9 9e f6 ff ff       	jmp    80105bf5 <alltraps>

80106557 <vector103>:
.globl vector103
vector103:
  pushl $0 # padding
80106557:	6a 00                	push   $0x0
  pushl $103 # trapno
80106559:	6a 67                	push   $0x67
  jmp alltraps
8010655b:	e9 95 f6 ff ff       	jmp    80105bf5 <alltraps>

80106560 <vector104>:
.globl vector104
vector104:
  pushl $0 # padding
80106560:	6a 00                	push   $0x0
  pushl $104 # trapno
80106562:	6a 68                	push   $0x68
  jmp alltraps
80106564:	e9 8c f6 ff ff       	jmp    80105bf5 <alltraps>

80106569 <vector105>:
.globl vector105
vector105:
  pushl $0 # padding
80106569:	6a 00                	push   $0x0
  pushl $105 # trapno
8010656b:	6a 69                	push   $0x69
  jmp alltraps
8010656d:	e9 83 f6 ff ff       	jmp    80105bf5 <alltraps>

80106572 <vector106>:
.globl vector106
vector106:
  pushl $0 # padding
80106572:	6a 00                	push   $0x0
  pushl $106 # trapno
80106574:	6a 6a                	push   $0x6a
  jmp alltraps
80106576:	e9 7a f6 ff ff       	jmp    80105bf5 <alltraps>

8010657b <vector107>:
.globl vector107
vector107:
  pushl $0 # padding
8010657b:	6a 00                	push   $0x0
  pushl $107 # trapno
8010657d:	6a 6b                	push   $0x6b
  jmp alltraps
8010657f:	e9 71 f6 ff ff       	jmp    80105bf5 <alltraps>

80106584 <vector108>:
.globl vector108
vector108:
  pushl $0 # padding
80106584:	6a 00                	push   $0x0
  pushl $108 # trapno
80106586:	6a 6c                	push   $0x6c
  jmp alltraps
80106588:	e9 68 f6 ff ff       	jmp    80105bf5 <alltraps>

8010658d <vector109>:
.globl vector109
vector109:
  pushl $0 # padding
8010658d:	6a 00                	push   $0x0
  pushl $109 # trapno
8010658f:	6a 6d                	push   $0x6d
  jmp alltraps
80106591:	e9 5f f6 ff ff       	jmp    80105bf5 <alltraps>

80106596 <vector110>:
.globl vector110
vector110:
  pushl $0 # padding
80106596:	6a 00                	push   $0x0
  pushl $110 # trapno
80106598:	6a 6e                	push   $0x6e
  jmp alltraps
8010659a:	e9 56 f6 ff ff       	jmp    80105bf5 <alltraps>

8010659f <vector111>:
.globl vector111
vector111:
  pushl $0 # padding
8010659f:	6a 00                	push   $0x0
  pushl $111 # trapno
801065a1:	6a 6f                	push   $0x6f
  jmp alltraps
801065a3:	e9 4d f6 ff ff       	jmp    80105bf5 <alltraps>

801065a8 <vector112>:
.globl vector112
vector112:
  pushl $0 # padding
801065a8:	6a 00                	push   $0x0
  pushl $112 # trapno
801065aa:	6a 70                	push   $0x70
  jmp alltraps
801065ac:	e9 44 f6 ff ff       	jmp    80105bf5 <alltraps>

801065b1 <vector113>:
.globl vector113
vector113:
  pushl $0 # padding
801065b1:	6a 00                	push   $0x0
  pushl $113 # trapno
801065b3:	6a 71                	push   $0x71
  jmp alltraps
801065b5:	e9 3b f6 ff ff       	jmp    80105bf5 <alltraps>

801065ba <vector114>:
.globl vector114
vector114:
  pushl $0 # padding
801065ba:	6a 00                	push   $0x0
  pushl $114 # trapno
801065bc:	6a 72                	push   $0x72
  jmp alltraps
801065be:	e9 32 f6 ff ff       	jmp    80105bf5 <alltraps>

801065c3 <vector115>:
.globl vector115
vector115:
  pushl $0 # padding
801065c3:	6a 00                	push   $0x0
  pushl $115 # trapno
801065c5:	6a 73                	push   $0x73
  jmp alltraps
801065c7:	e9 29 f6 ff ff       	jmp    80105bf5 <alltraps>

801065cc <vector116>:
.globl vector116
vector116:
  pushl $0 # padding
801065cc:	6a 00                	push   $0x0
  pushl $116 # trapno
801065ce:	6a 74                	push   $0x74
  jmp alltraps
801065d0:	e9 20 f6 ff ff       	jmp    80105bf5 <alltraps>

801065d5 <vector117>:
.globl vector117
vector117:
  pushl $0 # padding
801065d5:	6a 00                	push   $0x0
  pushl $117 # trapno
801065d7:	6a 75                	push   $0x75
  jmp alltraps
801065d9:	e9 17 f6 ff ff       	jmp    80105bf5 <alltraps>

801065de <vector118>:
.globl vector118
vector118:
  pushl $0 # padding
801065de:	6a 00                	push   $0x0
  pushl $118 # trapno
801065e0:	6a 76                	push   $0x76
  jmp alltraps
801065e2:	e9 0e f6 ff ff       	jmp    80105bf5 <alltraps>

801065e7 <vector119>:
.globl vector119
vector119:
  pushl $0 # padding
801065e7:	6a 00                	push   $0x0
  pushl $119 # trapno
801065e9:	6a 77                	push   $0x77
  jmp alltraps
801065eb:	e9 05 f6 ff ff       	jmp    80105bf5 <alltraps>

801065f0 <vector120>:
.globl vector120
vector120:
  pushl $0 # padding
801065f0:	6a 00                	push   $0x0
  pushl $120 # trapno
801065f2:	6a 78                	push   $0x78
  jmp alltraps
801065f4:	e9 fc f5 ff ff       	jmp    80105bf5 <alltraps>

801065f9 <vector121>:
.globl vector121
vector121:
  pushl $0 # padding
801065f9:	6a 00                	push   $0x0
  pushl $121 # trapno
801065fb:	6a 79                	push   $0x79
  jmp alltraps
801065fd:	e9 f3 f5 ff ff       	jmp    80105bf5 <alltraps>

80106602 <vector122>:
.globl vector122
vector122:
  pushl $0 # padding
80106602:	6a 00                	push   $0x0
  pushl $122 # trapno
80106604:	6a 7a                	push   $0x7a
  jmp alltraps
80106606:	e9 ea f5 ff ff       	jmp    80105bf5 <alltraps>

8010660b <vector123>:
.globl vector123
vector123:
  pushl $0 # padding
8010660b:	6a 00                	push   $0x0
  pushl $123 # trapno
8010660d:	6a 7b                	push   $0x7b
  jmp alltraps
8010660f:	e9 e1 f5 ff ff       	jmp    80105bf5 <alltraps>

80106614 <vector124>:
.globl vector124
vector124:
  pushl $0 # padding
80106614:	6a 00                	push   $0x0
  pushl $124 # trapno
80106616:	6a 7c                	push   $0x7c
  jmp alltraps
80106618:	e9 d8 f5 ff ff       	jmp    80105bf5 <alltraps>

8010661d <vector125>:
.globl vector125
vector125:
  pushl $0 # padding
8010661d:	6a 00                	push   $0x0
  pushl $125 # trapno
8010661f:	6a 7d                	push   $0x7d
  jmp alltraps
80106621:	e9 cf f5 ff ff       	jmp    80105bf5 <alltraps>

80106626 <vector126>:
.globl vector126
vector126:
  pushl $0 # padding
80106626:	6a 00                	push   $0x0
  pushl $126 # trapno
80106628:	6a 7e                	push   $0x7e
  jmp alltraps
8010662a:	e9 c6 f5 ff ff       	jmp    80105bf5 <alltraps>

8010662f <vector127>:
.globl vector127
vector127:
  pushl $0 # padding
8010662f:	6a 00                	push   $0x0
  pushl $127 # trapno
80106631:	6a 7f                	push   $0x7f
  jmp alltraps
80106633:	e9 bd f5 ff ff       	jmp    80105bf5 <alltraps>

80106638 <vector128>:
.globl vector128
vector128:
  pushl $0 # padding
80106638:	6a 00                	push   $0x0
  pushl $128 # trapno
8010663a:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010663f:	e9 b1 f5 ff ff       	jmp    80105bf5 <alltraps>

80106644 <vector129>:
.globl vector129
vector129:
  pushl $0 # padding
80106644:	6a 00                	push   $0x0
  pushl $129 # trapno
80106646:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010664b:	e9 a5 f5 ff ff       	jmp    80105bf5 <alltraps>

80106650 <vector130>:
.globl vector130
vector130:
  pushl $0 # padding
80106650:	6a 00                	push   $0x0
  pushl $130 # trapno
80106652:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106657:	e9 99 f5 ff ff       	jmp    80105bf5 <alltraps>

8010665c <vector131>:
.globl vector131
vector131:
  pushl $0 # padding
8010665c:	6a 00                	push   $0x0
  pushl $131 # trapno
8010665e:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106663:	e9 8d f5 ff ff       	jmp    80105bf5 <alltraps>

80106668 <vector132>:
.globl vector132
vector132:
  pushl $0 # padding
80106668:	6a 00                	push   $0x0
  pushl $132 # trapno
8010666a:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010666f:	e9 81 f5 ff ff       	jmp    80105bf5 <alltraps>

80106674 <vector133>:
.globl vector133
vector133:
  pushl $0 # padding
80106674:	6a 00                	push   $0x0
  pushl $133 # trapno
80106676:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010667b:	e9 75 f5 ff ff       	jmp    80105bf5 <alltraps>

80106680 <vector134>:
.globl vector134
vector134:
  pushl $0 # padding
80106680:	6a 00                	push   $0x0
  pushl $134 # trapno
80106682:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106687:	e9 69 f5 ff ff       	jmp    80105bf5 <alltraps>

8010668c <vector135>:
.globl vector135
vector135:
  pushl $0 # padding
8010668c:	6a 00                	push   $0x0
  pushl $135 # trapno
8010668e:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106693:	e9 5d f5 ff ff       	jmp    80105bf5 <alltraps>

80106698 <vector136>:
.globl vector136
vector136:
  pushl $0 # padding
80106698:	6a 00                	push   $0x0
  pushl $136 # trapno
8010669a:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010669f:	e9 51 f5 ff ff       	jmp    80105bf5 <alltraps>

801066a4 <vector137>:
.globl vector137
vector137:
  pushl $0 # padding
801066a4:	6a 00                	push   $0x0
  pushl $137 # trapno
801066a6:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801066ab:	e9 45 f5 ff ff       	jmp    80105bf5 <alltraps>

801066b0 <vector138>:
.globl vector138
vector138:
  pushl $0 # padding
801066b0:	6a 00                	push   $0x0
  pushl $138 # trapno
801066b2:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801066b7:	e9 39 f5 ff ff       	jmp    80105bf5 <alltraps>

801066bc <vector139>:
.globl vector139
vector139:
  pushl $0 # padding
801066bc:	6a 00                	push   $0x0
  pushl $139 # trapno
801066be:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801066c3:	e9 2d f5 ff ff       	jmp    80105bf5 <alltraps>

801066c8 <vector140>:
.globl vector140
vector140:
  pushl $0 # padding
801066c8:	6a 00                	push   $0x0
  pushl $140 # trapno
801066ca:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801066cf:	e9 21 f5 ff ff       	jmp    80105bf5 <alltraps>

801066d4 <vector141>:
.globl vector141
vector141:
  pushl $0 # padding
801066d4:	6a 00                	push   $0x0
  pushl $141 # trapno
801066d6:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801066db:	e9 15 f5 ff ff       	jmp    80105bf5 <alltraps>

801066e0 <vector142>:
.globl vector142
vector142:
  pushl $0 # padding
801066e0:	6a 00                	push   $0x0
  pushl $142 # trapno
801066e2:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801066e7:	e9 09 f5 ff ff       	jmp    80105bf5 <alltraps>

801066ec <vector143>:
.globl vector143
vector143:
  pushl $0 # padding
801066ec:	6a 00                	push   $0x0
  pushl $143 # trapno
801066ee:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801066f3:	e9 fd f4 ff ff       	jmp    80105bf5 <alltraps>

801066f8 <vector144>:
.globl vector144
vector144:
  pushl $0 # padding
801066f8:	6a 00                	push   $0x0
  pushl $144 # trapno
801066fa:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801066ff:	e9 f1 f4 ff ff       	jmp    80105bf5 <alltraps>

80106704 <vector145>:
.globl vector145
vector145:
  pushl $0 # padding
80106704:	6a 00                	push   $0x0
  pushl $145 # trapno
80106706:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010670b:	e9 e5 f4 ff ff       	jmp    80105bf5 <alltraps>

80106710 <vector146>:
.globl vector146
vector146:
  pushl $0 # padding
80106710:	6a 00                	push   $0x0
  pushl $146 # trapno
80106712:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106717:	e9 d9 f4 ff ff       	jmp    80105bf5 <alltraps>

8010671c <vector147>:
.globl vector147
vector147:
  pushl $0 # padding
8010671c:	6a 00                	push   $0x0
  pushl $147 # trapno
8010671e:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106723:	e9 cd f4 ff ff       	jmp    80105bf5 <alltraps>

80106728 <vector148>:
.globl vector148
vector148:
  pushl $0 # padding
80106728:	6a 00                	push   $0x0
  pushl $148 # trapno
8010672a:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010672f:	e9 c1 f4 ff ff       	jmp    80105bf5 <alltraps>

80106734 <vector149>:
.globl vector149
vector149:
  pushl $0 # padding
80106734:	6a 00                	push   $0x0
  pushl $149 # trapno
80106736:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010673b:	e9 b5 f4 ff ff       	jmp    80105bf5 <alltraps>

80106740 <vector150>:
.globl vector150
vector150:
  pushl $0 # padding
80106740:	6a 00                	push   $0x0
  pushl $150 # trapno
80106742:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106747:	e9 a9 f4 ff ff       	jmp    80105bf5 <alltraps>

8010674c <vector151>:
.globl vector151
vector151:
  pushl $0 # padding
8010674c:	6a 00                	push   $0x0
  pushl $151 # trapno
8010674e:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106753:	e9 9d f4 ff ff       	jmp    80105bf5 <alltraps>

80106758 <vector152>:
.globl vector152
vector152:
  pushl $0 # padding
80106758:	6a 00                	push   $0x0
  pushl $152 # trapno
8010675a:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010675f:	e9 91 f4 ff ff       	jmp    80105bf5 <alltraps>

80106764 <vector153>:
.globl vector153
vector153:
  pushl $0 # padding
80106764:	6a 00                	push   $0x0
  pushl $153 # trapno
80106766:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010676b:	e9 85 f4 ff ff       	jmp    80105bf5 <alltraps>

80106770 <vector154>:
.globl vector154
vector154:
  pushl $0 # padding
80106770:	6a 00                	push   $0x0
  pushl $154 # trapno
80106772:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106777:	e9 79 f4 ff ff       	jmp    80105bf5 <alltraps>

8010677c <vector155>:
.globl vector155
vector155:
  pushl $0 # padding
8010677c:	6a 00                	push   $0x0
  pushl $155 # trapno
8010677e:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106783:	e9 6d f4 ff ff       	jmp    80105bf5 <alltraps>

80106788 <vector156>:
.globl vector156
vector156:
  pushl $0 # padding
80106788:	6a 00                	push   $0x0
  pushl $156 # trapno
8010678a:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010678f:	e9 61 f4 ff ff       	jmp    80105bf5 <alltraps>

80106794 <vector157>:
.globl vector157
vector157:
  pushl $0 # padding
80106794:	6a 00                	push   $0x0
  pushl $157 # trapno
80106796:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010679b:	e9 55 f4 ff ff       	jmp    80105bf5 <alltraps>

801067a0 <vector158>:
.globl vector158
vector158:
  pushl $0 # padding
801067a0:	6a 00                	push   $0x0
  pushl $158 # trapno
801067a2:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801067a7:	e9 49 f4 ff ff       	jmp    80105bf5 <alltraps>

801067ac <vector159>:
.globl vector159
vector159:
  pushl $0 # padding
801067ac:	6a 00                	push   $0x0
  pushl $159 # trapno
801067ae:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801067b3:	e9 3d f4 ff ff       	jmp    80105bf5 <alltraps>

801067b8 <vector160>:
.globl vector160
vector160:
  pushl $0 # padding
801067b8:	6a 00                	push   $0x0
  pushl $160 # trapno
801067ba:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801067bf:	e9 31 f4 ff ff       	jmp    80105bf5 <alltraps>

801067c4 <vector161>:
.globl vector161
vector161:
  pushl $0 # padding
801067c4:	6a 00                	push   $0x0
  pushl $161 # trapno
801067c6:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801067cb:	e9 25 f4 ff ff       	jmp    80105bf5 <alltraps>

801067d0 <vector162>:
.globl vector162
vector162:
  pushl $0 # padding
801067d0:	6a 00                	push   $0x0
  pushl $162 # trapno
801067d2:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801067d7:	e9 19 f4 ff ff       	jmp    80105bf5 <alltraps>

801067dc <vector163>:
.globl vector163
vector163:
  pushl $0 # padding
801067dc:	6a 00                	push   $0x0
  pushl $163 # trapno
801067de:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801067e3:	e9 0d f4 ff ff       	jmp    80105bf5 <alltraps>

801067e8 <vector164>:
.globl vector164
vector164:
  pushl $0 # padding
801067e8:	6a 00                	push   $0x0
  pushl $164 # trapno
801067ea:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801067ef:	e9 01 f4 ff ff       	jmp    80105bf5 <alltraps>

801067f4 <vector165>:
.globl vector165
vector165:
  pushl $0 # padding
801067f4:	6a 00                	push   $0x0
  pushl $165 # trapno
801067f6:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801067fb:	e9 f5 f3 ff ff       	jmp    80105bf5 <alltraps>

80106800 <vector166>:
.globl vector166
vector166:
  pushl $0 # padding
80106800:	6a 00                	push   $0x0
  pushl $166 # trapno
80106802:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106807:	e9 e9 f3 ff ff       	jmp    80105bf5 <alltraps>

8010680c <vector167>:
.globl vector167
vector167:
  pushl $0 # padding
8010680c:	6a 00                	push   $0x0
  pushl $167 # trapno
8010680e:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106813:	e9 dd f3 ff ff       	jmp    80105bf5 <alltraps>

80106818 <vector168>:
.globl vector168
vector168:
  pushl $0 # padding
80106818:	6a 00                	push   $0x0
  pushl $168 # trapno
8010681a:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010681f:	e9 d1 f3 ff ff       	jmp    80105bf5 <alltraps>

80106824 <vector169>:
.globl vector169
vector169:
  pushl $0 # padding
80106824:	6a 00                	push   $0x0
  pushl $169 # trapno
80106826:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010682b:	e9 c5 f3 ff ff       	jmp    80105bf5 <alltraps>

80106830 <vector170>:
.globl vector170
vector170:
  pushl $0 # padding
80106830:	6a 00                	push   $0x0
  pushl $170 # trapno
80106832:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106837:	e9 b9 f3 ff ff       	jmp    80105bf5 <alltraps>

8010683c <vector171>:
.globl vector171
vector171:
  pushl $0 # padding
8010683c:	6a 00                	push   $0x0
  pushl $171 # trapno
8010683e:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106843:	e9 ad f3 ff ff       	jmp    80105bf5 <alltraps>

80106848 <vector172>:
.globl vector172
vector172:
  pushl $0 # padding
80106848:	6a 00                	push   $0x0
  pushl $172 # trapno
8010684a:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010684f:	e9 a1 f3 ff ff       	jmp    80105bf5 <alltraps>

80106854 <vector173>:
.globl vector173
vector173:
  pushl $0 # padding
80106854:	6a 00                	push   $0x0
  pushl $173 # trapno
80106856:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010685b:	e9 95 f3 ff ff       	jmp    80105bf5 <alltraps>

80106860 <vector174>:
.globl vector174
vector174:
  pushl $0 # padding
80106860:	6a 00                	push   $0x0
  pushl $174 # trapno
80106862:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106867:	e9 89 f3 ff ff       	jmp    80105bf5 <alltraps>

8010686c <vector175>:
.globl vector175
vector175:
  pushl $0 # padding
8010686c:	6a 00                	push   $0x0
  pushl $175 # trapno
8010686e:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106873:	e9 7d f3 ff ff       	jmp    80105bf5 <alltraps>

80106878 <vector176>:
.globl vector176
vector176:
  pushl $0 # padding
80106878:	6a 00                	push   $0x0
  pushl $176 # trapno
8010687a:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010687f:	e9 71 f3 ff ff       	jmp    80105bf5 <alltraps>

80106884 <vector177>:
.globl vector177
vector177:
  pushl $0 # padding
80106884:	6a 00                	push   $0x0
  pushl $177 # trapno
80106886:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010688b:	e9 65 f3 ff ff       	jmp    80105bf5 <alltraps>

80106890 <vector178>:
.globl vector178
vector178:
  pushl $0 # padding
80106890:	6a 00                	push   $0x0
  pushl $178 # trapno
80106892:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106897:	e9 59 f3 ff ff       	jmp    80105bf5 <alltraps>

8010689c <vector179>:
.globl vector179
vector179:
  pushl $0 # padding
8010689c:	6a 00                	push   $0x0
  pushl $179 # trapno
8010689e:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801068a3:	e9 4d f3 ff ff       	jmp    80105bf5 <alltraps>

801068a8 <vector180>:
.globl vector180
vector180:
  pushl $0 # padding
801068a8:	6a 00                	push   $0x0
  pushl $180 # trapno
801068aa:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801068af:	e9 41 f3 ff ff       	jmp    80105bf5 <alltraps>

801068b4 <vector181>:
.globl vector181
vector181:
  pushl $0 # padding
801068b4:	6a 00                	push   $0x0
  pushl $181 # trapno
801068b6:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801068bb:	e9 35 f3 ff ff       	jmp    80105bf5 <alltraps>

801068c0 <vector182>:
.globl vector182
vector182:
  pushl $0 # padding
801068c0:	6a 00                	push   $0x0
  pushl $182 # trapno
801068c2:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801068c7:	e9 29 f3 ff ff       	jmp    80105bf5 <alltraps>

801068cc <vector183>:
.globl vector183
vector183:
  pushl $0 # padding
801068cc:	6a 00                	push   $0x0
  pushl $183 # trapno
801068ce:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801068d3:	e9 1d f3 ff ff       	jmp    80105bf5 <alltraps>

801068d8 <vector184>:
.globl vector184
vector184:
  pushl $0 # padding
801068d8:	6a 00                	push   $0x0
  pushl $184 # trapno
801068da:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801068df:	e9 11 f3 ff ff       	jmp    80105bf5 <alltraps>

801068e4 <vector185>:
.globl vector185
vector185:
  pushl $0 # padding
801068e4:	6a 00                	push   $0x0
  pushl $185 # trapno
801068e6:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801068eb:	e9 05 f3 ff ff       	jmp    80105bf5 <alltraps>

801068f0 <vector186>:
.globl vector186
vector186:
  pushl $0 # padding
801068f0:	6a 00                	push   $0x0
  pushl $186 # trapno
801068f2:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801068f7:	e9 f9 f2 ff ff       	jmp    80105bf5 <alltraps>

801068fc <vector187>:
.globl vector187
vector187:
  pushl $0 # padding
801068fc:	6a 00                	push   $0x0
  pushl $187 # trapno
801068fe:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106903:	e9 ed f2 ff ff       	jmp    80105bf5 <alltraps>

80106908 <vector188>:
.globl vector188
vector188:
  pushl $0 # padding
80106908:	6a 00                	push   $0x0
  pushl $188 # trapno
8010690a:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010690f:	e9 e1 f2 ff ff       	jmp    80105bf5 <alltraps>

80106914 <vector189>:
.globl vector189
vector189:
  pushl $0 # padding
80106914:	6a 00                	push   $0x0
  pushl $189 # trapno
80106916:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010691b:	e9 d5 f2 ff ff       	jmp    80105bf5 <alltraps>

80106920 <vector190>:
.globl vector190
vector190:
  pushl $0 # padding
80106920:	6a 00                	push   $0x0
  pushl $190 # trapno
80106922:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106927:	e9 c9 f2 ff ff       	jmp    80105bf5 <alltraps>

8010692c <vector191>:
.globl vector191
vector191:
  pushl $0 # padding
8010692c:	6a 00                	push   $0x0
  pushl $191 # trapno
8010692e:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106933:	e9 bd f2 ff ff       	jmp    80105bf5 <alltraps>

80106938 <vector192>:
.globl vector192
vector192:
  pushl $0 # padding
80106938:	6a 00                	push   $0x0
  pushl $192 # trapno
8010693a:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010693f:	e9 b1 f2 ff ff       	jmp    80105bf5 <alltraps>

80106944 <vector193>:
.globl vector193
vector193:
  pushl $0 # padding
80106944:	6a 00                	push   $0x0
  pushl $193 # trapno
80106946:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010694b:	e9 a5 f2 ff ff       	jmp    80105bf5 <alltraps>

80106950 <vector194>:
.globl vector194
vector194:
  pushl $0 # padding
80106950:	6a 00                	push   $0x0
  pushl $194 # trapno
80106952:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106957:	e9 99 f2 ff ff       	jmp    80105bf5 <alltraps>

8010695c <vector195>:
.globl vector195
vector195:
  pushl $0 # padding
8010695c:	6a 00                	push   $0x0
  pushl $195 # trapno
8010695e:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106963:	e9 8d f2 ff ff       	jmp    80105bf5 <alltraps>

80106968 <vector196>:
.globl vector196
vector196:
  pushl $0 # padding
80106968:	6a 00                	push   $0x0
  pushl $196 # trapno
8010696a:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010696f:	e9 81 f2 ff ff       	jmp    80105bf5 <alltraps>

80106974 <vector197>:
.globl vector197
vector197:
  pushl $0 # padding
80106974:	6a 00                	push   $0x0
  pushl $197 # trapno
80106976:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010697b:	e9 75 f2 ff ff       	jmp    80105bf5 <alltraps>

80106980 <vector198>:
.globl vector198
vector198:
  pushl $0 # padding
80106980:	6a 00                	push   $0x0
  pushl $198 # trapno
80106982:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106987:	e9 69 f2 ff ff       	jmp    80105bf5 <alltraps>

8010698c <vector199>:
.globl vector199
vector199:
  pushl $0 # padding
8010698c:	6a 00                	push   $0x0
  pushl $199 # trapno
8010698e:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106993:	e9 5d f2 ff ff       	jmp    80105bf5 <alltraps>

80106998 <vector200>:
.globl vector200
vector200:
  pushl $0 # padding
80106998:	6a 00                	push   $0x0
  pushl $200 # trapno
8010699a:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010699f:	e9 51 f2 ff ff       	jmp    80105bf5 <alltraps>

801069a4 <vector201>:
.globl vector201
vector201:
  pushl $0 # padding
801069a4:	6a 00                	push   $0x0
  pushl $201 # trapno
801069a6:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801069ab:	e9 45 f2 ff ff       	jmp    80105bf5 <alltraps>

801069b0 <vector202>:
.globl vector202
vector202:
  pushl $0 # padding
801069b0:	6a 00                	push   $0x0
  pushl $202 # trapno
801069b2:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801069b7:	e9 39 f2 ff ff       	jmp    80105bf5 <alltraps>

801069bc <vector203>:
.globl vector203
vector203:
  pushl $0 # padding
801069bc:	6a 00                	push   $0x0
  pushl $203 # trapno
801069be:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801069c3:	e9 2d f2 ff ff       	jmp    80105bf5 <alltraps>

801069c8 <vector204>:
.globl vector204
vector204:
  pushl $0 # padding
801069c8:	6a 00                	push   $0x0
  pushl $204 # trapno
801069ca:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801069cf:	e9 21 f2 ff ff       	jmp    80105bf5 <alltraps>

801069d4 <vector205>:
.globl vector205
vector205:
  pushl $0 # padding
801069d4:	6a 00                	push   $0x0
  pushl $205 # trapno
801069d6:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801069db:	e9 15 f2 ff ff       	jmp    80105bf5 <alltraps>

801069e0 <vector206>:
.globl vector206
vector206:
  pushl $0 # padding
801069e0:	6a 00                	push   $0x0
  pushl $206 # trapno
801069e2:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801069e7:	e9 09 f2 ff ff       	jmp    80105bf5 <alltraps>

801069ec <vector207>:
.globl vector207
vector207:
  pushl $0 # padding
801069ec:	6a 00                	push   $0x0
  pushl $207 # trapno
801069ee:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801069f3:	e9 fd f1 ff ff       	jmp    80105bf5 <alltraps>

801069f8 <vector208>:
.globl vector208
vector208:
  pushl $0 # padding
801069f8:	6a 00                	push   $0x0
  pushl $208 # trapno
801069fa:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801069ff:	e9 f1 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a04 <vector209>:
.globl vector209
vector209:
  pushl $0 # padding
80106a04:	6a 00                	push   $0x0
  pushl $209 # trapno
80106a06:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a0b:	e9 e5 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a10 <vector210>:
.globl vector210
vector210:
  pushl $0 # padding
80106a10:	6a 00                	push   $0x0
  pushl $210 # trapno
80106a12:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106a17:	e9 d9 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a1c <vector211>:
.globl vector211
vector211:
  pushl $0 # padding
80106a1c:	6a 00                	push   $0x0
  pushl $211 # trapno
80106a1e:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a23:	e9 cd f1 ff ff       	jmp    80105bf5 <alltraps>

80106a28 <vector212>:
.globl vector212
vector212:
  pushl $0 # padding
80106a28:	6a 00                	push   $0x0
  pushl $212 # trapno
80106a2a:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a2f:	e9 c1 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a34 <vector213>:
.globl vector213
vector213:
  pushl $0 # padding
80106a34:	6a 00                	push   $0x0
  pushl $213 # trapno
80106a36:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106a3b:	e9 b5 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a40 <vector214>:
.globl vector214
vector214:
  pushl $0 # padding
80106a40:	6a 00                	push   $0x0
  pushl $214 # trapno
80106a42:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106a47:	e9 a9 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a4c <vector215>:
.globl vector215
vector215:
  pushl $0 # padding
80106a4c:	6a 00                	push   $0x0
  pushl $215 # trapno
80106a4e:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106a53:	e9 9d f1 ff ff       	jmp    80105bf5 <alltraps>

80106a58 <vector216>:
.globl vector216
vector216:
  pushl $0 # padding
80106a58:	6a 00                	push   $0x0
  pushl $216 # trapno
80106a5a:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106a5f:	e9 91 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a64 <vector217>:
.globl vector217
vector217:
  pushl $0 # padding
80106a64:	6a 00                	push   $0x0
  pushl $217 # trapno
80106a66:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106a6b:	e9 85 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a70 <vector218>:
.globl vector218
vector218:
  pushl $0 # padding
80106a70:	6a 00                	push   $0x0
  pushl $218 # trapno
80106a72:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106a77:	e9 79 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a7c <vector219>:
.globl vector219
vector219:
  pushl $0 # padding
80106a7c:	6a 00                	push   $0x0
  pushl $219 # trapno
80106a7e:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106a83:	e9 6d f1 ff ff       	jmp    80105bf5 <alltraps>

80106a88 <vector220>:
.globl vector220
vector220:
  pushl $0 # padding
80106a88:	6a 00                	push   $0x0
  pushl $220 # trapno
80106a8a:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106a8f:	e9 61 f1 ff ff       	jmp    80105bf5 <alltraps>

80106a94 <vector221>:
.globl vector221
vector221:
  pushl $0 # padding
80106a94:	6a 00                	push   $0x0
  pushl $221 # trapno
80106a96:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106a9b:	e9 55 f1 ff ff       	jmp    80105bf5 <alltraps>

80106aa0 <vector222>:
.globl vector222
vector222:
  pushl $0 # padding
80106aa0:	6a 00                	push   $0x0
  pushl $222 # trapno
80106aa2:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106aa7:	e9 49 f1 ff ff       	jmp    80105bf5 <alltraps>

80106aac <vector223>:
.globl vector223
vector223:
  pushl $0 # padding
80106aac:	6a 00                	push   $0x0
  pushl $223 # trapno
80106aae:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106ab3:	e9 3d f1 ff ff       	jmp    80105bf5 <alltraps>

80106ab8 <vector224>:
.globl vector224
vector224:
  pushl $0 # padding
80106ab8:	6a 00                	push   $0x0
  pushl $224 # trapno
80106aba:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106abf:	e9 31 f1 ff ff       	jmp    80105bf5 <alltraps>

80106ac4 <vector225>:
.globl vector225
vector225:
  pushl $0 # padding
80106ac4:	6a 00                	push   $0x0
  pushl $225 # trapno
80106ac6:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106acb:	e9 25 f1 ff ff       	jmp    80105bf5 <alltraps>

80106ad0 <vector226>:
.globl vector226
vector226:
  pushl $0 # padding
80106ad0:	6a 00                	push   $0x0
  pushl $226 # trapno
80106ad2:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ad7:	e9 19 f1 ff ff       	jmp    80105bf5 <alltraps>

80106adc <vector227>:
.globl vector227
vector227:
  pushl $0 # padding
80106adc:	6a 00                	push   $0x0
  pushl $227 # trapno
80106ade:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ae3:	e9 0d f1 ff ff       	jmp    80105bf5 <alltraps>

80106ae8 <vector228>:
.globl vector228
vector228:
  pushl $0 # padding
80106ae8:	6a 00                	push   $0x0
  pushl $228 # trapno
80106aea:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106aef:	e9 01 f1 ff ff       	jmp    80105bf5 <alltraps>

80106af4 <vector229>:
.globl vector229
vector229:
  pushl $0 # padding
80106af4:	6a 00                	push   $0x0
  pushl $229 # trapno
80106af6:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106afb:	e9 f5 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b00 <vector230>:
.globl vector230
vector230:
  pushl $0 # padding
80106b00:	6a 00                	push   $0x0
  pushl $230 # trapno
80106b02:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b07:	e9 e9 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b0c <vector231>:
.globl vector231
vector231:
  pushl $0 # padding
80106b0c:	6a 00                	push   $0x0
  pushl $231 # trapno
80106b0e:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b13:	e9 dd f0 ff ff       	jmp    80105bf5 <alltraps>

80106b18 <vector232>:
.globl vector232
vector232:
  pushl $0 # padding
80106b18:	6a 00                	push   $0x0
  pushl $232 # trapno
80106b1a:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106b1f:	e9 d1 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b24 <vector233>:
.globl vector233
vector233:
  pushl $0 # padding
80106b24:	6a 00                	push   $0x0
  pushl $233 # trapno
80106b26:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b2b:	e9 c5 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b30 <vector234>:
.globl vector234
vector234:
  pushl $0 # padding
80106b30:	6a 00                	push   $0x0
  pushl $234 # trapno
80106b32:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106b37:	e9 b9 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b3c <vector235>:
.globl vector235
vector235:
  pushl $0 # padding
80106b3c:	6a 00                	push   $0x0
  pushl $235 # trapno
80106b3e:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106b43:	e9 ad f0 ff ff       	jmp    80105bf5 <alltraps>

80106b48 <vector236>:
.globl vector236
vector236:
  pushl $0 # padding
80106b48:	6a 00                	push   $0x0
  pushl $236 # trapno
80106b4a:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106b4f:	e9 a1 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b54 <vector237>:
.globl vector237
vector237:
  pushl $0 # padding
80106b54:	6a 00                	push   $0x0
  pushl $237 # trapno
80106b56:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106b5b:	e9 95 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b60 <vector238>:
.globl vector238
vector238:
  pushl $0 # padding
80106b60:	6a 00                	push   $0x0
  pushl $238 # trapno
80106b62:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106b67:	e9 89 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b6c <vector239>:
.globl vector239
vector239:
  pushl $0 # padding
80106b6c:	6a 00                	push   $0x0
  pushl $239 # trapno
80106b6e:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106b73:	e9 7d f0 ff ff       	jmp    80105bf5 <alltraps>

80106b78 <vector240>:
.globl vector240
vector240:
  pushl $0 # padding
80106b78:	6a 00                	push   $0x0
  pushl $240 # trapno
80106b7a:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106b7f:	e9 71 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b84 <vector241>:
.globl vector241
vector241:
  pushl $0 # padding
80106b84:	6a 00                	push   $0x0
  pushl $241 # trapno
80106b86:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106b8b:	e9 65 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b90 <vector242>:
.globl vector242
vector242:
  pushl $0 # padding
80106b90:	6a 00                	push   $0x0
  pushl $242 # trapno
80106b92:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106b97:	e9 59 f0 ff ff       	jmp    80105bf5 <alltraps>

80106b9c <vector243>:
.globl vector243
vector243:
  pushl $0 # padding
80106b9c:	6a 00                	push   $0x0
  pushl $243 # trapno
80106b9e:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ba3:	e9 4d f0 ff ff       	jmp    80105bf5 <alltraps>

80106ba8 <vector244>:
.globl vector244
vector244:
  pushl $0 # padding
80106ba8:	6a 00                	push   $0x0
  pushl $244 # trapno
80106baa:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106baf:	e9 41 f0 ff ff       	jmp    80105bf5 <alltraps>

80106bb4 <vector245>:
.globl vector245
vector245:
  pushl $0 # padding
80106bb4:	6a 00                	push   $0x0
  pushl $245 # trapno
80106bb6:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106bbb:	e9 35 f0 ff ff       	jmp    80105bf5 <alltraps>

80106bc0 <vector246>:
.globl vector246
vector246:
  pushl $0 # padding
80106bc0:	6a 00                	push   $0x0
  pushl $246 # trapno
80106bc2:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106bc7:	e9 29 f0 ff ff       	jmp    80105bf5 <alltraps>

80106bcc <vector247>:
.globl vector247
vector247:
  pushl $0 # padding
80106bcc:	6a 00                	push   $0x0
  pushl $247 # trapno
80106bce:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106bd3:	e9 1d f0 ff ff       	jmp    80105bf5 <alltraps>

80106bd8 <vector248>:
.globl vector248
vector248:
  pushl $0 # padding
80106bd8:	6a 00                	push   $0x0
  pushl $248 # trapno
80106bda:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106bdf:	e9 11 f0 ff ff       	jmp    80105bf5 <alltraps>

80106be4 <vector249>:
.globl vector249
vector249:
  pushl $0 # padding
80106be4:	6a 00                	push   $0x0
  pushl $249 # trapno
80106be6:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106beb:	e9 05 f0 ff ff       	jmp    80105bf5 <alltraps>

80106bf0 <vector250>:
.globl vector250
vector250:
  pushl $0 # padding
80106bf0:	6a 00                	push   $0x0
  pushl $250 # trapno
80106bf2:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106bf7:	e9 f9 ef ff ff       	jmp    80105bf5 <alltraps>

80106bfc <vector251>:
.globl vector251
vector251:
  pushl $0 # padding
80106bfc:	6a 00                	push   $0x0
  pushl $251 # trapno
80106bfe:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c03:	e9 ed ef ff ff       	jmp    80105bf5 <alltraps>

80106c08 <vector252>:
.globl vector252
vector252:
  pushl $0 # padding
80106c08:	6a 00                	push   $0x0
  pushl $252 # trapno
80106c0a:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c0f:	e9 e1 ef ff ff       	jmp    80105bf5 <alltraps>

80106c14 <vector253>:
.globl vector253
vector253:
  pushl $0 # padding
80106c14:	6a 00                	push   $0x0
  pushl $253 # trapno
80106c16:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106c1b:	e9 d5 ef ff ff       	jmp    80105bf5 <alltraps>

80106c20 <vector254>:
.globl vector254
vector254:
  pushl $0 # padding
80106c20:	6a 00                	push   $0x0
  pushl $254 # trapno
80106c22:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c27:	e9 c9 ef ff ff       	jmp    80105bf5 <alltraps>

80106c2c <vector255>:
.globl vector255
vector255:
  pushl $0 # padding
80106c2c:	6a 00                	push   $0x0
  pushl $255 # trapno
80106c2e:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106c33:	e9 bd ef ff ff       	jmp    80105bf5 <alltraps>
80106c38:	66 90                	xchg   %ax,%ax
80106c3a:	66 90                	xchg   %ax,%ax
80106c3c:	66 90                	xchg   %ax,%ax
80106c3e:	66 90                	xchg   %ax,%ax

80106c40 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106c46:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106c4c:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80106c4f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106c55:	39 d3                	cmp    %edx,%ebx
80106c57:	73 76                	jae    80106ccf <deallocuvm.part.0+0x8f>
80106c59:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106c5c:	89 c6                	mov    %eax,%esi
80106c5e:	89 d7                	mov    %edx,%edi
80106c60:	eb 10                	jmp    80106c72 <deallocuvm.part.0+0x32>
80106c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106c68:	42                   	inc    %edx
80106c69:	89 d3                	mov    %edx,%ebx
80106c6b:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106c6e:	39 fb                	cmp    %edi,%ebx
80106c70:	73 5a                	jae    80106ccc <deallocuvm.part.0+0x8c>
  pde = &pgdir[PDX(va)];
80106c72:	89 da                	mov    %ebx,%edx
80106c74:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106c77:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106c7a:	a8 01                	test   $0x1,%al
80106c7c:	74 ea                	je     80106c68 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106c7e:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c80:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106c85:	c1 e9 0a             	shr    $0xa,%ecx
80106c88:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106c8e:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106c95:	85 c0                	test   %eax,%eax
80106c97:	74 cf                	je     80106c68 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106c99:	8b 10                	mov    (%eax),%edx
80106c9b:	f6 c2 01             	test   $0x1,%dl
80106c9e:	74 22                	je     80106cc2 <deallocuvm.part.0+0x82>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106ca0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ca6:	74 31                	je     80106cd9 <deallocuvm.part.0+0x99>
80106ca8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        panic("kfree");
      char *v = P2V(pa);
80106cab:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106cb1:	89 14 24             	mov    %edx,(%esp)
80106cb4:	e8 77 b9 ff ff       	call   80102630 <kfree>
      *pte = 0;
80106cb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106cbc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106cc2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cc8:	39 fb                	cmp    %edi,%ebx
80106cca:	72 a6                	jb     80106c72 <deallocuvm.part.0+0x32>
80106ccc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    }
  }
  return newsz;
}
80106ccf:	83 c4 2c             	add    $0x2c,%esp
80106cd2:	89 c8                	mov    %ecx,%eax
80106cd4:	5b                   	pop    %ebx
80106cd5:	5e                   	pop    %esi
80106cd6:	5f                   	pop    %edi
80106cd7:	5d                   	pop    %ebp
80106cd8:	c3                   	ret    
        panic("kfree");
80106cd9:	c7 04 24 a2 7a 10 80 	movl   $0x80107aa2,(%esp)
80106ce0:	e8 6b 96 ff ff       	call   80100350 <panic>
80106ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <mappages>:
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106cf6:	89 d3                	mov    %edx,%ebx
{
80106cf8:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80106cfb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106d01:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106d04:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d10:	8b 45 08             	mov    0x8(%ebp),%eax
80106d13:	29 d8                	sub    %ebx,%eax
80106d15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d18:	eb 41                	jmp    80106d5b <mappages+0x6b>
80106d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106d20:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d27:	c1 ea 0a             	shr    $0xa,%edx
80106d2a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106d30:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106d37:	85 c0                	test   %eax,%eax
80106d39:	74 7d                	je     80106db8 <mappages+0xc8>
    if(*pte & PTE_P)
80106d3b:	f6 00 01             	testb  $0x1,(%eax)
80106d3e:	0f 85 8e 00 00 00    	jne    80106dd2 <mappages+0xe2>
    *pte = pa | perm | PTE_P;
80106d44:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d47:	09 d6                	or     %edx,%esi
80106d49:	83 ce 01             	or     $0x1,%esi
80106d4c:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106d4e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106d51:	39 c3                	cmp    %eax,%ebx
80106d53:	74 73                	je     80106dc8 <mappages+0xd8>
    a += PGSIZE;
80106d55:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106d5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106d5e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106d61:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106d64:	89 d8                	mov    %ebx,%eax
80106d66:	c1 e8 16             	shr    $0x16,%eax
80106d69:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106d6c:	8b 07                	mov    (%edi),%eax
80106d6e:	a8 01                	test   $0x1,%al
80106d70:	75 ae                	jne    80106d20 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106d72:	e8 29 bb ff ff       	call   801028a0 <kalloc>
80106d77:	85 c0                	test   %eax,%eax
80106d79:	89 c2                	mov    %eax,%edx
80106d7b:	74 3b                	je     80106db8 <mappages+0xc8>
    memset(pgtab, 0, PGSIZE);
80106d7d:	89 14 24             	mov    %edx,(%esp)
80106d80:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d85:	31 c0                	xor    %eax,%eax
80106d87:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106d8b:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d8f:	89 55 d8             	mov    %edx,-0x28(%ebp)
80106d92:	e8 89 dc ff ff       	call   80104a20 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106d97:	8b 55 d8             	mov    -0x28(%ebp),%edx
80106d9a:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106da0:	83 c8 07             	or     $0x7,%eax
80106da3:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106da5:	89 d8                	mov    %ebx,%eax
80106da7:	c1 e8 0a             	shr    $0xa,%eax
80106daa:	25 fc 0f 00 00       	and    $0xffc,%eax
80106daf:	01 d0                	add    %edx,%eax
80106db1:	eb 88                	jmp    80106d3b <mappages+0x4b>
80106db3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106db7:	90                   	nop
}
80106db8:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80106dbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106dc0:	5b                   	pop    %ebx
80106dc1:	5e                   	pop    %esi
80106dc2:	5f                   	pop    %edi
80106dc3:	5d                   	pop    %ebp
80106dc4:	c3                   	ret    
80106dc5:	8d 76 00             	lea    0x0(%esi),%esi
80106dc8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80106dcb:	31 c0                	xor    %eax,%eax
}
80106dcd:	5b                   	pop    %ebx
80106dce:	5e                   	pop    %esi
80106dcf:	5f                   	pop    %edi
80106dd0:	5d                   	pop    %ebp
80106dd1:	c3                   	ret    
      panic("remap");
80106dd2:	c7 04 24 bc 81 10 80 	movl   $0x801081bc,(%esp)
80106dd9:	e8 72 95 ff ff       	call   80100350 <panic>
80106dde:	66 90                	xchg   %ax,%ax

80106de0 <seginit>:
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106de6:	e8 b5 ce ff ff       	call   80103ca0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106deb:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80106df0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80106df6:	8d 14 80             	lea    (%eax,%eax,4),%edx
80106df9:	8d 04 50             	lea    (%eax,%edx,2),%eax
80106dfc:	ba ff ff 00 00       	mov    $0xffff,%edx
80106e01:	c1 e0 04             	shl    $0x4,%eax
80106e04:	89 90 18 a8 14 80    	mov    %edx,-0x7feb57e8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e0a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e0f:	89 88 1c a8 14 80    	mov    %ecx,-0x7feb57e4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e15:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
80106e1a:	89 90 20 a8 14 80    	mov    %edx,-0x7feb57e0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e20:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e25:	89 88 24 a8 14 80    	mov    %ecx,-0x7feb57dc(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e2b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80106e30:	89 90 28 a8 14 80    	mov    %edx,-0x7feb57d8(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e36:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e3b:	89 88 2c a8 14 80    	mov    %ecx,-0x7feb57d4(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e41:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80106e46:	89 90 30 a8 14 80    	mov    %edx,-0x7feb57d0(%eax)
80106e4c:	89 88 34 a8 14 80    	mov    %ecx,-0x7feb57cc(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106e52:	05 10 a8 14 80       	add    $0x8014a810,%eax
  pd[1] = (uint)p;
80106e57:	0f b7 d0             	movzwl %ax,%edx
80106e5a:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106e5e:	c1 e8 10             	shr    $0x10,%eax
80106e61:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106e65:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106e68:	0f 01 10             	lgdtl  (%eax)
}
80106e6b:	89 ec                	mov    %ebp,%esp
80106e6d:	5d                   	pop    %ebp
80106e6e:	c3                   	ret    
80106e6f:	90                   	nop

80106e70 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e70:	a1 c4 d4 14 80       	mov    0x8014d4c4,%eax
80106e75:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e7a:	0f 22 d8             	mov    %eax,%cr3
}
80106e7d:	c3                   	ret    
80106e7e:	66 90                	xchg   %ax,%ax

80106e80 <switchuvm>:
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 2c             	sub    $0x2c,%esp
80106e89:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106e8c:	85 f6                	test   %esi,%esi
80106e8e:	0f 84 c5 00 00 00    	je     80106f59 <switchuvm+0xd9>
  if(p->kstack == 0)
80106e94:	8b 7e 08             	mov    0x8(%esi),%edi
80106e97:	85 ff                	test   %edi,%edi
80106e99:	0f 84 d2 00 00 00    	je     80106f71 <switchuvm+0xf1>
  if(p->pgdir == 0)
80106e9f:	8b 5e 04             	mov    0x4(%esi),%ebx
80106ea2:	85 db                	test   %ebx,%ebx
80106ea4:	0f 84 bb 00 00 00    	je     80106f65 <switchuvm+0xe5>
  pushcli();
80106eaa:	e8 21 d9 ff ff       	call   801047d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106eaf:	e8 7c cd ff ff       	call   80103c30 <mycpu>
80106eb4:	89 c3                	mov    %eax,%ebx
80106eb6:	e8 75 cd ff ff       	call   80103c30 <mycpu>
80106ebb:	89 c7                	mov    %eax,%edi
80106ebd:	e8 6e cd ff ff       	call   80103c30 <mycpu>
80106ec2:	83 c7 08             	add    $0x8,%edi
80106ec5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ec8:	e8 63 cd ff ff       	call   80103c30 <mycpu>
80106ecd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ed0:	ba 67 00 00 00       	mov    $0x67,%edx
80106ed5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106edc:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106ee3:	83 c1 08             	add    $0x8,%ecx
80106ee6:	c1 e9 10             	shr    $0x10,%ecx
80106ee9:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106eef:	83 c0 08             	add    $0x8,%eax
80106ef2:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106ef7:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80106efe:	c1 e8 18             	shr    $0x18,%eax
80106f01:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
80106f07:	e8 24 cd ff ff       	call   80103c30 <mycpu>
80106f0c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f13:	e8 18 cd ff ff       	call   80103c30 <mycpu>
80106f18:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106f1e:	8b 5e 08             	mov    0x8(%esi),%ebx
80106f21:	e8 0a cd ff ff       	call   80103c30 <mycpu>
80106f26:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f2c:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106f2f:	e8 fc cc ff ff       	call   80103c30 <mycpu>
80106f34:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106f3a:	b8 28 00 00 00       	mov    $0x28,%eax
80106f3f:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106f42:	8b 46 04             	mov    0x4(%esi),%eax
80106f45:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f4a:	0f 22 d8             	mov    %eax,%cr3
}
80106f4d:	83 c4 2c             	add    $0x2c,%esp
80106f50:	5b                   	pop    %ebx
80106f51:	5e                   	pop    %esi
80106f52:	5f                   	pop    %edi
80106f53:	5d                   	pop    %ebp
  popcli();
80106f54:	e9 c7 d8 ff ff       	jmp    80104820 <popcli>
    panic("switchuvm: no process");
80106f59:	c7 04 24 c2 81 10 80 	movl   $0x801081c2,(%esp)
80106f60:	e8 eb 93 ff ff       	call   80100350 <panic>
    panic("switchuvm: no pgdir");
80106f65:	c7 04 24 ed 81 10 80 	movl   $0x801081ed,(%esp)
80106f6c:	e8 df 93 ff ff       	call   80100350 <panic>
    panic("switchuvm: no kstack");
80106f71:	c7 04 24 d8 81 10 80 	movl   $0x801081d8,(%esp)
80106f78:	e8 d3 93 ff ff       	call   80100350 <panic>
80106f7d:	8d 76 00             	lea    0x0(%esi),%esi

80106f80 <inituvm>:
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	83 ec 38             	sub    $0x38,%esp
80106f86:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106f89:	8b 75 10             	mov    0x10(%ebp),%esi
80106f8c:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106f8f:	8b 45 08             	mov    0x8(%ebp),%eax
80106f92:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106f95:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106f98:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106f9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106fa1:	77 59                	ja     80106ffc <inituvm+0x7c>
  mem = kalloc();
80106fa3:	e8 f8 b8 ff ff       	call   801028a0 <kalloc>
  memset(mem, 0, PGSIZE);
80106fa8:	31 d2                	xor    %edx,%edx
80106faa:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
80106fae:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106fb0:	b8 00 10 00 00       	mov    $0x1000,%eax
80106fb5:	89 1c 24             	mov    %ebx,(%esp)
80106fb8:	89 44 24 08          	mov    %eax,0x8(%esp)
80106fbc:	e8 5f da ff ff       	call   80104a20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106fc1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106fc7:	b9 06 00 00 00       	mov    $0x6,%ecx
80106fcc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106fd0:	31 d2                	xor    %edx,%edx
80106fd2:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fd7:	89 04 24             	mov    %eax,(%esp)
80106fda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fdd:	e8 0e fd ff ff       	call   80106cf0 <mappages>
  memmove(mem, init, sz);
80106fe2:	89 75 10             	mov    %esi,0x10(%ebp)
}
80106fe5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80106fe8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
80106feb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
80106fee:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106ff1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106ff4:	89 ec                	mov    %ebp,%esp
80106ff6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106ff7:	e9 b4 da ff ff       	jmp    80104ab0 <memmove>
    panic("inituvm: more than a page");
80106ffc:	c7 04 24 01 82 10 80 	movl   $0x80108201,(%esp)
80107003:	e8 48 93 ff ff       	call   80100350 <panic>
80107008:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010700f:	90                   	nop

80107010 <loaduvm>:
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80107019:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010701c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010701f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107025:	0f 85 ba 00 00 00    	jne    801070e5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010702b:	85 ff                	test   %edi,%edi
8010702d:	0f 84 96 00 00 00    	je     801070c9 <loaduvm+0xb9>
80107033:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
80107040:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107043:	8b 55 08             	mov    0x8(%ebp),%edx
80107046:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107048:	89 c1                	mov    %eax,%ecx
8010704a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010704d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107050:	f6 c1 01             	test   $0x1,%cl
80107053:	75 13                	jne    80107068 <loaduvm+0x58>
      panic("loaduvm: address should exist");
80107055:	c7 04 24 1b 82 10 80 	movl   $0x8010821b,(%esp)
8010705c:	e8 ef 92 ff ff       	call   80100350 <panic>
80107061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107068:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010706b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107071:	25 fc 0f 00 00       	and    $0xffc,%eax
80107076:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010707d:	85 c9                	test   %ecx,%ecx
8010707f:	74 d4                	je     80107055 <loaduvm+0x45>
    if(sz - i < PGSIZE)
80107081:	89 fb                	mov    %edi,%ebx
80107083:	b8 00 10 00 00       	mov    $0x1000,%eax
80107088:	29 f3                	sub    %esi,%ebx
8010708a:	39 c3                	cmp    %eax,%ebx
8010708c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010708f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80107093:	8b 45 14             	mov    0x14(%ebp),%eax
80107096:	01 f0                	add    %esi,%eax
80107098:	89 44 24 08          	mov    %eax,0x8(%esp)
    pa = PTE_ADDR(*pte);
8010709c:	8b 01                	mov    (%ecx),%eax
8010709e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070a3:	05 00 00 00 80       	add    $0x80000000,%eax
801070a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801070ac:	8b 45 10             	mov    0x10(%ebp),%eax
801070af:	89 04 24             	mov    %eax,(%esp)
801070b2:	e8 b9 aa ff ff       	call   80101b70 <readi>
801070b7:	39 d8                	cmp    %ebx,%eax
801070b9:	75 1d                	jne    801070d8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801070bb:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070c1:	39 fe                	cmp    %edi,%esi
801070c3:	0f 82 77 ff ff ff    	jb     80107040 <loaduvm+0x30>
}
801070c9:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801070cc:	31 c0                	xor    %eax,%eax
}
801070ce:	5b                   	pop    %ebx
801070cf:	5e                   	pop    %esi
801070d0:	5f                   	pop    %edi
801070d1:	5d                   	pop    %ebp
801070d2:	c3                   	ret    
801070d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070d7:	90                   	nop
801070d8:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801070db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070e0:	5b                   	pop    %ebx
801070e1:	5e                   	pop    %esi
801070e2:	5f                   	pop    %edi
801070e3:	5d                   	pop    %ebp
801070e4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801070e5:	c7 04 24 d4 82 10 80 	movl   $0x801082d4,(%esp)
801070ec:	e8 5f 92 ff ff       	call   80100350 <panic>
801070f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ff:	90                   	nop

80107100 <allocuvm>:
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 2c             	sub    $0x2c,%esp
80107109:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010710c:	85 f6                	test   %esi,%esi
8010710e:	0f 88 9b 00 00 00    	js     801071af <allocuvm+0xaf>
  if(newsz < oldsz)
80107114:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107117:	89 f2                	mov    %esi,%edx
80107119:	0f 82 a1 00 00 00    	jb     801071c0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010711f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107122:	05 ff 0f 00 00       	add    $0xfff,%eax
80107127:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; a < newsz; a += PGSIZE){
8010712c:	39 f0                	cmp    %esi,%eax
  a = PGROUNDUP(oldsz);
8010712e:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80107130:	0f 83 8d 00 00 00    	jae    801071c3 <allocuvm+0xc3>
80107136:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107139:	eb 4b                	jmp    80107186 <allocuvm+0x86>
8010713b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010713f:	90                   	nop
    memset(mem, 0, PGSIZE);
80107140:	89 1c 24             	mov    %ebx,(%esp)
80107143:	31 d2                	xor    %edx,%edx
80107145:	b8 00 10 00 00       	mov    $0x1000,%eax
8010714a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010714e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107152:	e8 c9 d8 ff ff       	call   80104a20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107157:	b9 06 00 00 00       	mov    $0x6,%ecx
8010715c:	89 fa                	mov    %edi,%edx
8010715e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107162:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107168:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010716d:	89 04 24             	mov    %eax,(%esp)
80107170:	8b 45 08             	mov    0x8(%ebp),%eax
80107173:	e8 78 fb ff ff       	call   80106cf0 <mappages>
80107178:	85 c0                	test   %eax,%eax
8010717a:	78 54                	js     801071d0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
8010717c:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107182:	39 f7                	cmp    %esi,%edi
80107184:	73 7a                	jae    80107200 <allocuvm+0x100>
    mem = kalloc();
80107186:	e8 15 b7 ff ff       	call   801028a0 <kalloc>
    if(mem == 0){
8010718b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010718d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
8010718f:	75 af                	jne    80107140 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107191:	c7 04 24 39 82 10 80 	movl   $0x80108239,(%esp)
80107198:	e8 e3 94 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
8010719d:	3b 75 0c             	cmp    0xc(%ebp),%esi
801071a0:	74 0d                	je     801071af <allocuvm+0xaf>
801071a2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801071a5:	89 f2                	mov    %esi,%edx
801071a7:	8b 45 08             	mov    0x8(%ebp),%eax
801071aa:	e8 91 fa ff ff       	call   80106c40 <deallocuvm.part.0>
    return 0;
801071af:	31 d2                	xor    %edx,%edx
}
801071b1:	83 c4 2c             	add    $0x2c,%esp
801071b4:	89 d0                	mov    %edx,%eax
801071b6:	5b                   	pop    %ebx
801071b7:	5e                   	pop    %esi
801071b8:	5f                   	pop    %edi
801071b9:	5d                   	pop    %ebp
801071ba:	c3                   	ret    
801071bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071bf:	90                   	nop
    return oldsz;
801071c0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801071c3:	83 c4 2c             	add    $0x2c,%esp
801071c6:	89 d0                	mov    %edx,%eax
801071c8:	5b                   	pop    %ebx
801071c9:	5e                   	pop    %esi
801071ca:	5f                   	pop    %edi
801071cb:	5d                   	pop    %ebp
801071cc:	c3                   	ret    
801071cd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801071d0:	c7 04 24 51 82 10 80 	movl   $0x80108251,(%esp)
801071d7:	e8 a4 94 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
801071dc:	3b 75 0c             	cmp    0xc(%ebp),%esi
801071df:	74 0d                	je     801071ee <allocuvm+0xee>
801071e1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801071e4:	89 f2                	mov    %esi,%edx
801071e6:	8b 45 08             	mov    0x8(%ebp),%eax
801071e9:	e8 52 fa ff ff       	call   80106c40 <deallocuvm.part.0>
      kfree(mem);
801071ee:	89 1c 24             	mov    %ebx,(%esp)
801071f1:	e8 3a b4 ff ff       	call   80102630 <kfree>
    return 0;
801071f6:	31 d2                	xor    %edx,%edx
801071f8:	eb b7                	jmp    801071b1 <allocuvm+0xb1>
801071fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107200:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80107203:	83 c4 2c             	add    $0x2c,%esp
80107206:	5b                   	pop    %ebx
80107207:	5e                   	pop    %esi
80107208:	89 d0                	mov    %edx,%eax
8010720a:	5f                   	pop    %edi
8010720b:	5d                   	pop    %ebp
8010720c:	c3                   	ret    
8010720d:	8d 76 00             	lea    0x0(%esi),%esi

80107210 <deallocuvm>:
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	8b 55 0c             	mov    0xc(%ebp),%edx
80107216:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107219:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010721c:	39 d1                	cmp    %edx,%ecx
8010721e:	73 10                	jae    80107230 <deallocuvm+0x20>
}
80107220:	5d                   	pop    %ebp
80107221:	e9 1a fa ff ff       	jmp    80106c40 <deallocuvm.part.0>
80107226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010722d:	8d 76 00             	lea    0x0(%esi),%esi
80107230:	5d                   	pop    %ebp
80107231:	89 d0                	mov    %edx,%eax
80107233:	c3                   	ret    
80107234:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010723b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010723f:	90                   	nop

80107240 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
80107249:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010724c:	85 f6                	test   %esi,%esi
8010724e:	74 55                	je     801072a5 <freevm+0x65>
  if(newsz >= oldsz)
80107250:	31 c9                	xor    %ecx,%ecx
80107252:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107257:	89 f0                	mov    %esi,%eax
80107259:	89 f3                	mov    %esi,%ebx
8010725b:	e8 e0 f9 ff ff       	call   80106c40 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107260:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107266:	eb 0f                	jmp    80107277 <freevm+0x37>
80107268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010726f:	90                   	nop
80107270:	83 c3 04             	add    $0x4,%ebx
80107273:	39 fb                	cmp    %edi,%ebx
80107275:	74 1f                	je     80107296 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80107277:	8b 03                	mov    (%ebx),%eax
80107279:	a8 01                	test   $0x1,%al
8010727b:	74 f3                	je     80107270 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010727d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(i = 0; i < NPDENTRIES; i++){
80107282:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107285:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010728a:	89 04 24             	mov    %eax,(%esp)
8010728d:	e8 9e b3 ff ff       	call   80102630 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80107292:	39 fb                	cmp    %edi,%ebx
80107294:	75 e1                	jne    80107277 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107296:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107299:	83 c4 1c             	add    $0x1c,%esp
8010729c:	5b                   	pop    %ebx
8010729d:	5e                   	pop    %esi
8010729e:	5f                   	pop    %edi
8010729f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801072a0:	e9 8b b3 ff ff       	jmp    80102630 <kfree>
    panic("freevm: no pgdir");
801072a5:	c7 04 24 6d 82 10 80 	movl   $0x8010826d,(%esp)
801072ac:	e8 9f 90 ff ff       	call   80100350 <panic>
801072b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bf:	90                   	nop

801072c0 <setupkvm>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	57                   	push   %edi
801072c4:	56                   	push   %esi
801072c5:	53                   	push   %ebx
801072c6:	83 ec 1c             	sub    $0x1c,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
801072c9:	e8 d2 b5 ff ff       	call   801028a0 <kalloc>
801072ce:	85 c0                	test   %eax,%eax
801072d0:	74 5e                	je     80107330 <setupkvm+0x70>
801072d2:	89 c6                	mov    %eax,%esi
  memset(pgdir, 0, PGSIZE);
801072d4:	31 d2                	xor    %edx,%edx
801072d6:	89 54 24 04          	mov    %edx,0x4(%esp)
801072da:	b8 00 10 00 00       	mov    $0x1000,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801072df:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801072e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801072e8:	89 34 24             	mov    %esi,(%esp)
801072eb:	e8 30 d7 ff ff       	call   80104a20 <memset>
                (uint)k->phys_start, k->perm) < 0) {
801072f0:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801072f3:	8b 4b 08             	mov    0x8(%ebx),%ecx
801072f6:	8b 7b 0c             	mov    0xc(%ebx),%edi
801072f9:	8b 13                	mov    (%ebx),%edx
801072fb:	89 04 24             	mov    %eax,(%esp)
801072fe:	29 c1                	sub    %eax,%ecx
80107300:	89 f0                	mov    %esi,%eax
80107302:	89 7c 24 04          	mov    %edi,0x4(%esp)
80107306:	e8 e5 f9 ff ff       	call   80106cf0 <mappages>
8010730b:	85 c0                	test   %eax,%eax
8010730d:	78 19                	js     80107328 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010730f:	83 c3 10             	add    $0x10,%ebx
80107312:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107318:	75 d6                	jne    801072f0 <setupkvm+0x30>
}
8010731a:	83 c4 1c             	add    $0x1c,%esp
8010731d:	89 f0                	mov    %esi,%eax
8010731f:	5b                   	pop    %ebx
80107320:	5e                   	pop    %esi
80107321:	5f                   	pop    %edi
80107322:	5d                   	pop    %ebp
80107323:	c3                   	ret    
80107324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107328:	89 34 24             	mov    %esi,(%esp)
8010732b:	e8 10 ff ff ff       	call   80107240 <freevm>
}
80107330:	83 c4 1c             	add    $0x1c,%esp
    return 0;
80107333:	31 f6                	xor    %esi,%esi
}
80107335:	5b                   	pop    %ebx
80107336:	89 f0                	mov    %esi,%eax
80107338:	5e                   	pop    %esi
80107339:	5f                   	pop    %edi
8010733a:	5d                   	pop    %ebp
8010733b:	c3                   	ret    
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107340 <kvmalloc>:
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107346:	e8 75 ff ff ff       	call   801072c0 <setupkvm>
8010734b:	a3 c4 d4 14 80       	mov    %eax,0x8014d4c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107350:	05 00 00 00 80       	add    $0x80000000,%eax
80107355:	0f 22 d8             	mov    %eax,%cr3
}
80107358:	89 ec                	mov    %ebp,%esp
8010735a:	5d                   	pop    %ebp
8010735b:	c3                   	ret    
8010735c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107360 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107360:	55                   	push   %ebp
80107361:	89 e5                	mov    %esp,%ebp
80107363:	83 ec 18             	sub    $0x18,%esp
80107366:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107369:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010736c:	89 c1                	mov    %eax,%ecx
8010736e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107371:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107374:	f6 c2 01             	test   $0x1,%dl
80107377:	75 0f                	jne    80107388 <clearpteu+0x28>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107379:	c7 04 24 7e 82 10 80 	movl   $0x8010827e,(%esp)
80107380:	e8 cb 8f ff ff       	call   80100350 <panic>
80107385:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107388:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010738b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107391:	25 fc 0f 00 00       	and    $0xffc,%eax
80107396:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
8010739d:	85 c0                	test   %eax,%eax
8010739f:	74 d8                	je     80107379 <clearpteu+0x19>
  *pte &= ~PTE_U;
801073a1:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801073a4:	89 ec                	mov    %ebp,%esp
801073a6:	5d                   	pop    %ebp
801073a7:	c3                   	ret    
801073a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073af:	90                   	nop

801073b0 <if_present_T_PGFLT>:

int if_present_T_PGFLT(pde_t* pgdir, const void *va)
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801073b6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801073b9:	89 c1                	mov    %eax,%ecx
801073bb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801073be:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801073c1:	f6 c2 01             	test   $0x1,%dl
801073c4:	0f 84 e8 03 00 00    	je     801077b2 <if_present_T_PGFLT.cold>
  return &pgtab[PTX(va)];
801073ca:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073cd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    pte_t *pte;
    pte=walkpgdir(pgdir, va, 0);
    uint flags=PTE_FLAGS(pte);
    // cprintf("flags: %d\n", flags);
    return !(*pte & PTE_P);
}
801073d3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801073d4:	25 ff 03 00 00       	and    $0x3ff,%eax
    return !(*pte & PTE_P);
801073d9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
801073e0:	f7 d0                	not    %eax
801073e2:	83 e0 01             	and    $0x1,%eax
}
801073e5:	c3                   	ret    
801073e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ed:	8d 76 00             	lea    0x0(%esi),%esi

801073f0 <if_read_T_PGFLT>:

int if_read_T_PGFLT(pde_t *pgdir, const void *va)
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801073f6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801073f9:	89 c1                	mov    %eax,%ecx
801073fb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801073fe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107401:	f6 c2 01             	test   $0x1,%dl
80107404:	0f 84 af 03 00 00    	je     801077b9 <if_read_T_PGFLT.cold>
  return &pgtab[PTX(va)];
8010740a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010740d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    pte_t *pte;
    pte=walkpgdir(pgdir, va, 0);
    uint flags=PTE_FLAGS(pte);
    // cprintf("flags: %d\n", flags);
    return !(*pte & PTE_W);
}
80107413:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107414:	25 ff 03 00 00       	and    $0x3ff,%eax
    return !(*pte & PTE_W);
80107419:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
80107420:	d1 e8                	shr    %eax
80107422:	83 f0 01             	xor    $0x1,%eax
80107425:	83 e0 01             	and    $0x1,%eax
}
80107428:	c3                   	ret    
80107429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107430 <copyuvm>:
// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107430:	55                   	push   %ebp
80107431:	89 e5                	mov    %esp,%ebp
80107433:	57                   	push   %edi
80107434:	56                   	push   %esi
80107435:	53                   	push   %ebx
80107436:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107439:	e8 82 fe ff ff       	call   801072c0 <setupkvm>
8010743e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107441:	85 c0                	test   %eax,%eax
80107443:	0f 84 2d 01 00 00    	je     80107576 <copyuvm+0x146>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107449:	8b 55 0c             	mov    0xc(%ebp),%edx
8010744c:	85 d2                	test   %edx,%edx
8010744e:	0f 84 a3 00 00 00    	je     801074f7 <copyuvm+0xc7>
80107454:	31 ff                	xor    %edi,%edi
80107456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107460:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107463:	89 f8                	mov    %edi,%eax
80107465:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107468:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010746b:	a8 01                	test   $0x1,%al
8010746d:	75 11                	jne    80107480 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010746f:	c7 04 24 88 82 10 80 	movl   $0x80108288,(%esp)
80107476:	e8 d5 8e ff ff       	call   80100350 <panic>
8010747b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010747f:	90                   	nop
  return &pgtab[PTX(va)];
80107480:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107482:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107487:	c1 ea 0a             	shr    $0xa,%edx
8010748a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107490:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107497:	85 c0                	test   %eax,%eax
80107499:	74 d4                	je     8010746f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010749b:	8b 18                	mov    (%eax),%ebx
8010749d:	f6 c3 01             	test   $0x1,%bl
801074a0:	0f 84 e2 00 00 00    	je     80107588 <copyuvm+0x158>
      panic("copyuvm: page not present");
    //only for user pages
    if (*pte & PTE_U){
      *pte=*pte& ~PTE_W; ///UPDATE THE FLAG TO RDONLY
      pa = PTE_ADDR(*pte);
801074a6:	89 da                	mov    %ebx,%edx
801074a8:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    if (*pte & PTE_U){
801074ae:	f6 c3 04             	test   $0x4,%bl
801074b1:	74 5d                	je     80107510 <copyuvm+0xe0>
      *pte=*pte& ~PTE_W; ///UPDATE THE FLAG TO RDONLY
801074b3:	89 d9                	mov    %ebx,%ecx
      flags = PTE_FLAGS(*pte);
801074b5:	81 e3 fd 0f 00 00    	and    $0xffd,%ebx
      *pte=*pte& ~PTE_W; ///UPDATE THE FLAG TO RDONLY
801074bb:	83 e1 fd             	and    $0xfffffffd,%ecx
801074be:	89 08                	mov    %ecx,(%eax)
      // if((mem = kalloc()) == 0)
      //   goto bad;
      // memmove(mem, (char*)P2V(pa), PGSIZE);
      increase_ref(pa);
801074c0:	89 14 24             	mov    %edx,(%esp)
801074c3:	89 55 e0             	mov    %edx,-0x20(%ebp)
801074c6:	e8 75 b4 ff ff       	call   80102940 <increase_ref>
      if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801074cb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801074cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
801074d2:	89 14 24             	mov    %edx,(%esp)
      pa = PTE_ADDR(*pte);
      flags = PTE_FLAGS(*pte);
      if((mem = kalloc()) == 0)
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801074d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074d8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074dd:	89 fa                	mov    %edi,%edx
801074df:	e8 0c f8 ff ff       	call   80106cf0 <mappages>
801074e4:	85 c0                	test   %eax,%eax
801074e6:	78 70                	js     80107558 <copyuvm+0x128>
  for(i = 0; i < sz; i += PGSIZE){
801074e8:	81 c7 00 10 00 00    	add    $0x1000,%edi
801074ee:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801074f1:	0f 82 69 ff ff ff    	jb     80107460 <copyuvm+0x30>
        kfree(mem);
        goto bad;
      }
    }
  }
  lcr3(V2P(pgdir));
801074f7:	8b 45 08             	mov    0x8(%ebp),%eax
801074fa:	05 00 00 00 80       	add    $0x80000000,%eax
801074ff:	0f 22 d8             	mov    %eax,%cr3

bad:
  lcr3(V2P(pgdir));
  freevm(d);
  return 0;
}
80107502:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107505:	83 c4 2c             	add    $0x2c,%esp
80107508:	5b                   	pop    %ebx
80107509:	5e                   	pop    %esi
8010750a:	5f                   	pop    %edi
8010750b:	5d                   	pop    %ebp
8010750c:	c3                   	ret    
8010750d:	8d 76 00             	lea    0x0(%esi),%esi
80107510:	89 55 e0             	mov    %edx,-0x20(%ebp)
      flags = PTE_FLAGS(*pte);
80107513:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
      if((mem = kalloc()) == 0)
80107519:	e8 82 b3 ff ff       	call   801028a0 <kalloc>
8010751e:	85 c0                	test   %eax,%eax
80107520:	89 c6                	mov    %eax,%esi
80107522:	74 3c                	je     80107560 <copyuvm+0x130>
      memmove(mem, (char*)P2V(pa), PGSIZE);
80107524:	b8 00 10 00 00       	mov    $0x1000,%eax
80107529:	89 44 24 08          	mov    %eax,0x8(%esp)
8010752d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107530:	89 34 24             	mov    %esi,(%esp)
80107533:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107539:	89 54 24 04          	mov    %edx,0x4(%esp)
8010753d:	e8 6e d5 ff ff       	call   80104ab0 <memmove>
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107542:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107548:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010754c:	89 04 24             	mov    %eax,(%esp)
8010754f:	eb 84                	jmp    801074d5 <copyuvm+0xa5>
80107551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(mem);
80107558:	89 34 24             	mov    %esi,(%esp)
8010755b:	e8 d0 b0 ff ff       	call   80102630 <kfree>
  lcr3(V2P(pgdir));
80107560:	8b 45 08             	mov    0x8(%ebp),%eax
80107563:	05 00 00 00 80       	add    $0x80000000,%eax
80107568:	0f 22 d8             	mov    %eax,%cr3
  freevm(d);
8010756b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010756e:	89 04 24             	mov    %eax,(%esp)
80107571:	e8 ca fc ff ff       	call   80107240 <freevm>
    return 0;
80107576:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
8010757d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107580:	83 c4 2c             	add    $0x2c,%esp
80107583:	5b                   	pop    %ebx
80107584:	5e                   	pop    %esi
80107585:	5f                   	pop    %edi
80107586:	5d                   	pop    %ebp
80107587:	c3                   	ret    
      panic("copyuvm: page not present");
80107588:	c7 04 24 a2 82 10 80 	movl   $0x801082a2,(%esp)
8010758f:	e8 bc 8d ff ff       	call   80100350 <panic>
80107594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010759b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010759f:	90                   	nop

801075a0 <_handle_T_PGFLT_COW>:

int _handle_T_PGFLT_COW(pde_t *pgdir, uint va){
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	83 ec 38             	sub    $0x38,%esp
801075a6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801075a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801075ac:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801075af:	8b 75 08             	mov    0x8(%ebp),%esi
801075b2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde = &pgdir[PDX(va)];
801075b5:	89 c2                	mov    %eax,%edx
801075b7:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801075ba:	8b 14 96             	mov    (%esi,%edx,4),%edx
801075bd:	f6 c2 01             	test   $0x1,%dl
801075c0:	0f 84 fa 01 00 00    	je     801077c0 <_handle_T_PGFLT_COW.cold>
  return &pgtab[PTX(va)];
801075c6:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075c9:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801075cf:	25 fc 0f 00 00       	and    $0xffc,%eax
801075d4:	8d bc 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edi
    pte_t* pte=walkpgdir(pgdir, (char*)va, 0);
    uint pa=PTE_ADDR(*pte);
801075db:	8b 1f                	mov    (%edi),%ebx
801075dd:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    uint flags=PTE_FLAGS(*pte);
    if (pa>PHYSTOP)
801075e3:	81 fb 00 00 00 0e    	cmp    $0xe000000,%ebx
801075e9:	77 79                	ja     80107664 <_handle_T_PGFLT_COW+0xc4>
    {
      panic("_handle_T_PGFLT_COW 1");
    }
    if (get_ref(pa)<=1)
801075eb:	89 1c 24             	mov    %ebx,(%esp)
801075ee:	e8 8d b4 ff ff       	call   80102a80 <get_ref>
801075f3:	48                   	dec    %eax
801075f4:	7e 52                	jle    80107648 <_handle_T_PGFLT_COW+0xa8>
    {
      // panic("_handle_T_PGFLT_COW 2");
      //here we will have to kalloc and make a new page for the curproc
      char *mem;
      flags=flags|PTE_W;
      if((mem = kalloc()) == 0)
801075f6:	e8 a5 b2 ff ff       	call   801028a0 <kalloc>
      *pte =  PTE_U | PTE_W | PTE_P | V2P(mem);
      lcr3(V2P(pgdir));
      return 0;
    }
    ends:
    lcr3(V2P(pgdir));
801075fb:	81 c6 00 00 00 80    	add    $0x80000000,%esi
      if((mem = kalloc()) == 0)
80107601:	85 c0                	test   %eax,%eax
80107603:	89 c2                	mov    %eax,%edx
80107605:	74 69                	je     80107670 <_handle_T_PGFLT_COW+0xd0>
      memmove(mem, (char*)P2V(pa), PGSIZE);
80107607:	89 14 24             	mov    %edx,(%esp)
8010760a:	b8 00 10 00 00       	mov    $0x1000,%eax
8010760f:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107615:	89 44 24 08          	mov    %eax,0x8(%esp)
80107619:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010761d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107620:	e8 8b d4 ff ff       	call   80104ab0 <memmove>
      *pte =  PTE_U | PTE_W | PTE_P | V2P(mem);
80107625:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107628:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010762e:	83 ca 07             	or     $0x7,%edx
80107631:	0f 22 de             	mov    %esi,%cr3
80107634:	89 17                	mov    %edx,(%edi)
      return 0;
80107636:	31 c0                	xor    %eax,%eax
    return -1;
}
80107638:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010763b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010763e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107641:	89 ec                	mov    %ebp,%esp
80107643:	5d                   	pop    %ebp
80107644:	c3                   	ret    
80107645:	8d 76 00             	lea    0x0(%esi),%esi
      if (get_ref(pa)==0) return -1;
80107648:	89 1c 24             	mov    %ebx,(%esp)
8010764b:	e8 30 b4 ff ff       	call   80102a80 <get_ref>
80107650:	85 c0                	test   %eax,%eax
80107652:	74 1f                	je     80107673 <_handle_T_PGFLT_COW+0xd3>
      *pte = *pte | PTE_W;
80107654:	8b 17                	mov    (%edi),%edx
      lcr3(V2P(pgdir));
80107656:	81 c6 00 00 00 80    	add    $0x80000000,%esi
      *pte = *pte | PTE_W;
8010765c:	83 ca 02             	or     $0x2,%edx
8010765f:	0f 22 de             	mov    %esi,%cr3
      return 0;
80107662:	eb d0                	jmp    80107634 <_handle_T_PGFLT_COW+0x94>
      panic("_handle_T_PGFLT_COW 1");
80107664:	c7 04 24 bc 82 10 80 	movl   $0x801082bc,(%esp)
8010766b:	e8 e0 8c ff ff       	call   80100350 <panic>
80107670:	0f 22 de             	mov    %esi,%cr3
      if (get_ref(pa)==0) return -1;
80107673:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107678:	eb be                	jmp    80107638 <_handle_T_PGFLT_COW+0x98>
8010767a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107680 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107686:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107689:	89 c1                	mov    %eax,%ecx
8010768b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010768e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107691:	f6 c2 01             	test   $0x1,%dl
80107694:	0f 84 2d 01 00 00    	je     801077c7 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010769a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010769d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801076a3:	25 ff 03 00 00       	and    $0x3ff,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
801076a8:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801076af:	89 c2                	mov    %eax,%edx
801076b1:	83 e2 05             	and    $0x5,%edx
801076b4:	83 fa 05             	cmp    $0x5,%edx
801076b7:	75 0f                	jne    801076c8 <uva2ka+0x48>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801076b9:	5d                   	pop    %ebp
  return (char*)P2V(PTE_ADDR(*pte));
801076ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076bf:	05 00 00 00 80       	add    $0x80000000,%eax
}
801076c4:	c3                   	ret    
801076c5:	8d 76 00             	lea    0x0(%esi),%esi
801076c8:	5d                   	pop    %ebp
    return 0;
801076c9:	31 c0                	xor    %eax,%eax
}
801076cb:	c3                   	ret    
801076cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801076d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 2c             	sub    $0x2c,%esp
801076d9:	8b 75 14             	mov    0x14(%ebp),%esi
801076dc:	8b 7d 08             	mov    0x8(%ebp),%edi
801076df:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801076e2:	85 f6                	test   %esi,%esi
801076e4:	75 5f                	jne    80107745 <copyout+0x75>
801076e6:	e9 bd 00 00 00       	jmp    801077a8 <copyout+0xd8>
801076eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076ef:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801076f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076f5:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    if(_handle_T_PGFLT_COW(pgdir,va0)<0){
      return -1;
    }
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801076fb:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  return (char*)P2V(PTE_ADDR(*pte));
80107700:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    if(pa0 == 0)
80107703:	0f 84 8f 00 00 00    	je     80107798 <copyout+0xc8>
      return -1;
    n = PGSIZE - (va - va0);
80107709:	89 cb                	mov    %ecx,%ebx
8010770b:	29 d3                	sub    %edx,%ebx
8010770d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107713:	39 f3                	cmp    %esi,%ebx
80107715:	0f 47 de             	cmova  %esi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107718:	29 ca                	sub    %ecx,%edx
8010771a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010771e:	8b 45 10             	mov    0x10(%ebp),%eax
80107721:	89 44 24 04          	mov    %eax,0x4(%esp)
80107725:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107728:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010772b:	01 d0                	add    %edx,%eax
8010772d:	89 04 24             	mov    %eax,(%esp)
80107730:	e8 7b d3 ff ff       	call   80104ab0 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80107735:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    buf += n;
80107738:	01 5d 10             	add    %ebx,0x10(%ebp)
  while(len > 0){
8010773b:	29 de                	sub    %ebx,%esi
    va = va0 + PGSIZE;
8010773d:	8d 91 00 10 00 00    	lea    0x1000(%ecx),%edx
  while(len > 0){
80107743:	74 63                	je     801077a8 <copyout+0xd8>
80107745:	89 55 0c             	mov    %edx,0xc(%ebp)
    if(_handle_T_PGFLT_COW(pgdir,va0)<0){
80107748:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010774c:	89 3c 24             	mov    %edi,(%esp)
8010774f:	e8 4c fe ff ff       	call   801075a0 <_handle_T_PGFLT_COW>
80107754:	85 c0                	test   %eax,%eax
80107756:	78 40                	js     80107798 <copyout+0xc8>
    va0 = (uint)PGROUNDDOWN(va);
80107758:	8b 55 0c             	mov    0xc(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010775b:	89 d0                	mov    %edx,%eax
    va0 = (uint)PGROUNDDOWN(va);
8010775d:	89 d1                	mov    %edx,%ecx
  pde = &pgdir[PDX(va)];
8010775f:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107762:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  if(*pde & PTE_P){
80107768:	8b 04 87             	mov    (%edi,%eax,4),%eax
8010776b:	a8 01                	test   $0x1,%al
8010776d:	0f 84 5b 00 00 00    	je     801077ce <copyout.cold>
  return &pgtab[PTX(va)];
80107773:	89 cb                	mov    %ecx,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107775:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
8010777a:	c1 eb 0c             	shr    $0xc,%ebx
8010777d:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107783:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
  if((*pte & PTE_U) == 0)
8010778a:	89 c3                	mov    %eax,%ebx
8010778c:	83 e3 05             	and    $0x5,%ebx
8010778f:	83 fb 05             	cmp    $0x5,%ebx
80107792:	0f 84 58 ff ff ff    	je     801076f0 <copyout+0x20>
  }
  return 0;
}
80107798:	83 c4 2c             	add    $0x2c,%esp
      return -1;
8010779b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801077a0:	5b                   	pop    %ebx
801077a1:	5e                   	pop    %esi
801077a2:	5f                   	pop    %edi
801077a3:	5d                   	pop    %ebp
801077a4:	c3                   	ret    
801077a5:	8d 76 00             	lea    0x0(%esi),%esi
801077a8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801077ab:	31 c0                	xor    %eax,%eax
}
801077ad:	5b                   	pop    %ebx
801077ae:	5e                   	pop    %esi
801077af:	5f                   	pop    %edi
801077b0:	5d                   	pop    %ebp
801077b1:	c3                   	ret    

801077b2 <if_present_T_PGFLT.cold>:
    return !(*pte & PTE_P);
801077b2:	a1 00 00 00 00       	mov    0x0,%eax
801077b7:	0f 0b                	ud2    

801077b9 <if_read_T_PGFLT.cold>:
    return !(*pte & PTE_W);
801077b9:	a1 00 00 00 00       	mov    0x0,%eax
801077be:	0f 0b                	ud2    

801077c0 <_handle_T_PGFLT_COW.cold>:
    uint pa=PTE_ADDR(*pte);
801077c0:	a1 00 00 00 00       	mov    0x0,%eax
801077c5:	0f 0b                	ud2    

801077c7 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801077c7:	a1 00 00 00 00       	mov    0x0,%eax
801077cc:	0f 0b                	ud2    

801077ce <copyout.cold>:
801077ce:	a1 00 00 00 00       	mov    0x0,%eax
801077d3:	0f 0b                	ud2    
