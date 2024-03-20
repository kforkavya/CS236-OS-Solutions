
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){ // hey the just 'ls' command is ls .
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 19                	jle    35 <main+0x35>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]); // ls every directory. Nice.
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    ls(argv[i]); // ls every directory. Nice.
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 c4 00 00 00       	call   f0 <ls>
  for(i=1; i<argc; i++)
  2c:	39 de                	cmp    %ebx,%esi
  2e:	75 f0                	jne    20 <main+0x20>
  exit();
  30:	e8 7e 05 00 00       	call   5b3 <exit>
    ls(".");
  35:	c7 04 24 f0 0a 00 00 	movl   $0xaf0,(%esp)
  3c:	e8 af 00 00 00       	call   f0 <ls>
    exit();
  41:	e8 6d 05 00 00       	call   5b3 <exit>
  46:	66 90                	xchg   %ax,%ax
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 34 24             	mov    %esi,(%esp)
  5e:	e8 8d 03 00 00       	call   3f0 <strlen>
  63:	01 f0                	add    %esi,%eax
  65:	89 c3                	mov    %eax,%ebx
  67:	73 10                	jae    79 <fmtname+0x29>
  69:	eb 13                	jmp    7e <fmtname+0x2e>
  6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  6f:	90                   	nop
  70:	8d 43 ff             	lea    -0x1(%ebx),%eax
  73:	39 f0                	cmp    %esi,%eax
  75:	72 08                	jb     7f <fmtname+0x2f>
  77:	89 c3                	mov    %eax,%ebx
  79:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  7c:	75 f2                	jne    70 <fmtname+0x20>
  p++;
  7e:	43                   	inc    %ebx
  if(strlen(p) >= DIRSIZ)
  7f:	89 1c 24             	mov    %ebx,(%esp)
  82:	e8 69 03 00 00       	call   3f0 <strlen>
  87:	83 f8 0d             	cmp    $0xd,%eax
  8a:	77 54                	ja     e0 <fmtname+0x90>
  memmove(buf, p, strlen(p));
  8c:	89 1c 24             	mov    %ebx,(%esp)
  8f:	e8 5c 03 00 00       	call   3f0 <strlen>
  94:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  98:	c7 04 24 68 0b 00 00 	movl   $0xb68,(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	e8 d8 04 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a8:	89 1c 24             	mov    %ebx,(%esp)
  ab:	e8 40 03 00 00       	call   3f0 <strlen>
  b0:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b3:	bb 68 0b 00 00       	mov    $0xb68,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 c6                	mov    %eax,%esi
  ba:	e8 31 03 00 00       	call   3f0 <strlen>
  bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  c4:	29 f2                	sub    %esi,%edx
  c6:	89 54 24 08          	mov    %edx,0x8(%esp)
  ca:	ba 20 00 00 00       	mov    $0x20,%edx
  cf:	89 54 24 04          	mov    %edx,0x4(%esp)
  d3:	05 68 0b 00 00       	add    $0xb68,%eax
  d8:	89 04 24             	mov    %eax,(%esp)
  db:	e8 40 03 00 00       	call   420 <memset>
}
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	89 d8                	mov    %ebx,%eax
  e5:	5b                   	pop    %ebx
  e6:	5e                   	pop    %esi
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <ls>:
{
  f0:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	57                   	push   %edi
  f6:	56                   	push   %esi
  f7:	53                   	push   %ebx
  f8:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
  fe:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 101:	89 44 24 04          	mov    %eax,0x4(%esp)
 105:	89 3c 24             	mov    %edi,(%esp)
 108:	e8 e6 04 00 00       	call   5f3 <open>
 10d:	85 c0                	test   %eax,%eax
 10f:	0f 88 bb 01 00 00    	js     2d0 <ls+0x1e0>
  if(fstat(fd, &st) < 0){ // try to get file metadata
 115:	89 04 24             	mov    %eax,(%esp)
 118:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 11e:	89 c3                	mov    %eax,%ebx
 120:	89 74 24 04          	mov    %esi,0x4(%esp)
 124:	e8 e2 04 00 00       	call   60b <fstat>
 129:	85 c0                	test   %eax,%eax
 12b:	0f 88 e7 01 00 00    	js     318 <ls+0x228>
  switch(st.type){ // based on the file
 131:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 138:	83 f8 01             	cmp    $0x1,%eax
 13b:	74 6b                	je     1a8 <ls+0xb8>
 13d:	83 f8 02             	cmp    $0x2,%eax
 140:	74 16                	je     158 <ls+0x68>
  close(fd);
 142:	89 1c 24             	mov    %ebx,(%esp)
 145:	e8 91 04 00 00       	call   5db <close>
}
 14a:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 158:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 15e:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 164:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 16a:	89 3c 24             	mov    %edi,(%esp)
 16d:	e8 de fe ff ff       	call   50 <fmtname>
 172:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 178:	b9 d0 0a 00 00       	mov    $0xad0,%ecx
 17d:	89 74 24 10          	mov    %esi,0x10(%esp)
 181:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 185:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18c:	89 54 24 14          	mov    %edx,0x14(%esp)
 190:	ba 02 00 00 00       	mov    $0x2,%edx
 195:	89 54 24 0c          	mov    %edx,0xc(%esp)
 199:	89 44 24 08          	mov    %eax,0x8(%esp)
 19d:	e8 7e 05 00 00       	call   720 <printf>
    break;
 1a2:	eb 9e                	jmp    142 <ls+0x52>
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a8:	89 3c 24             	mov    %edi,(%esp)
 1ab:	e8 40 02 00 00       	call   3f0 <strlen>
 1b0:	83 c0 10             	add    $0x10,%eax
 1b3:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b8:	0f 87 3a 01 00 00    	ja     2f8 <ls+0x208>
    strcpy(buf, path);
 1be:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1c2:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c8:	89 3c 24             	mov    %edi,(%esp)
 1cb:	e8 a0 01 00 00       	call   370 <strcpy>
    p = buf+strlen(buf);
 1d0:	89 3c 24             	mov    %edi,(%esp)
 1d3:	e8 18 02 00 00       	call   3f0 <strlen>
 1d8:	8d 0c 07             	lea    (%edi,%eax,1),%ecx
 1db:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
 1e1:	8d 44 07 01          	lea    0x1(%edi,%eax,1),%eax
 1e5:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
 1eb:	c6 01 2f             	movb   $0x2f,(%ecx)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ee:	66 90                	xchg   %ax,%ax
 1f0:	89 1c 24             	mov    %ebx,(%esp)
 1f3:	b8 10 00 00 00       	mov    $0x10,%eax
 1f8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fc:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 202:	89 44 24 04          	mov    %eax,0x4(%esp)
 206:	e8 c0 03 00 00       	call   5cb <read>
 20b:	83 f8 10             	cmp    $0x10,%eax
 20e:	0f 85 2e ff ff ff    	jne    142 <ls+0x52>
      if(de.inum == 0)
 214:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 21b:	00 
 21c:	74 d2                	je     1f0 <ls+0x100>
      memmove(p, de.name, DIRSIZ); // copy the name of the subdirectory
 21e:	b8 0e 00 00 00       	mov    $0xe,%eax
 223:	89 44 24 08          	mov    %eax,0x8(%esp)
 227:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 41 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 23f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 245:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){ // stat the name of the file
 249:	89 74 24 04          	mov    %esi,0x4(%esp)
 24d:	89 3c 24             	mov    %edi,(%esp)
 250:	e8 8b 02 00 00       	call   4e0 <stat>
 255:	85 c0                	test   %eax,%eax
 257:	0f 88 eb 00 00 00    	js     348 <ls+0x258>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 25d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 263:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 269:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 270:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 276:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 27c:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 282:	89 3c 24             	mov    %edi,(%esp)
 285:	e8 c6 fd ff ff       	call   50 <fmtname>
 28a:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 290:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 294:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 29a:	89 54 24 10          	mov    %edx,0x10(%esp)
 29e:	ba d0 0a 00 00       	mov    $0xad0,%edx
 2a3:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 2a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 2ad:	89 54 24 04          	mov    %edx,0x4(%esp)
 2b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2b8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 2bc:	e8 5f 04 00 00       	call   720 <printf>
 2c1:	e9 2a ff ff ff       	jmp    1f0 <ls+0x100>
 2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 2d0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2d4:	bf a8 0a 00 00       	mov    $0xaa8,%edi
 2d9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2e4:	e8 37 04 00 00       	call   720 <printf>
}
 2e9:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 2ef:	5b                   	pop    %ebx
 2f0:	5e                   	pop    %esi
 2f1:	5f                   	pop    %edi
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ff:	b8 dd 0a 00 00       	mov    $0xadd,%eax
 304:	89 44 24 04          	mov    %eax,0x4(%esp)
 308:	e8 13 04 00 00       	call   720 <printf>
      break;
 30d:	e9 30 fe ff ff       	jmp    142 <ls+0x52>
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
 318:	89 7c 24 08          	mov    %edi,0x8(%esp)
 31c:	be bc 0a 00 00       	mov    $0xabc,%esi
 321:	89 74 24 04          	mov    %esi,0x4(%esp)
 325:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 32c:	e8 ef 03 00 00       	call   720 <printf>
    close(fd);
 331:	89 1c 24             	mov    %ebx,(%esp)
 334:	e8 a2 02 00 00       	call   5db <close>
}
 339:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5f                   	pop    %edi
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 348:	89 7c 24 08          	mov    %edi,0x8(%esp)
 34c:	b9 bc 0a 00 00       	mov    $0xabc,%ecx
 351:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 355:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35c:	e8 bf 03 00 00       	call   720 <printf>
        continue;
 361:	e9 8a fe ff ff       	jmp    1f0 <ls+0x100>
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 370:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 371:	31 c0                	xor    %eax,%eax
{
 373:	89 e5                	mov    %esp,%ebp
 375:	53                   	push   %ebx
 376:	8b 4d 08             	mov    0x8(%ebp),%ecx
 379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 380:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 384:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 387:	40                   	inc    %eax
 388:	84 d2                	test   %dl,%dl
 38a:	75 f4                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38c:	5b                   	pop    %ebx
 38d:	89 c8                	mov    %ecx,%eax
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret    
 391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	8b 55 08             	mov    0x8(%ebp),%edx
 3a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3aa:	0f b6 02             	movzbl (%edx),%eax
 3ad:	84 c0                	test   %al,%al
 3af:	75 15                	jne    3c6 <strcmp+0x26>
 3b1:	eb 30                	jmp    3e3 <strcmp+0x43>
 3b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b7:	90                   	nop
 3b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3bc:	8d 4b 01             	lea    0x1(%ebx),%ecx
 3bf:	42                   	inc    %edx
  while(*p && *p == *q)
 3c0:	84 c0                	test   %al,%al
 3c2:	74 14                	je     3d8 <strcmp+0x38>
    p++, q++;
 3c4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 3c6:	0f b6 0b             	movzbl (%ebx),%ecx
 3c9:	38 c1                	cmp    %al,%cl
 3cb:	74 eb                	je     3b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 3cd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3ce:	29 c8                	sub    %ecx,%eax
}
 3d0:	5d                   	pop    %ebp
 3d1:	c3                   	ret    
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 3d8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 3dc:	31 c0                	xor    %eax,%eax
}
 3de:	5b                   	pop    %ebx
 3df:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 3e0:	29 c8                	sub    %ecx,%eax
}
 3e2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 3e3:	0f b6 0b             	movzbl (%ebx),%ecx
 3e6:	31 c0                	xor    %eax,%eax
 3e8:	eb e3                	jmp    3cd <strcmp+0x2d>
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <strlen>:

uint
strlen(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3f6:	80 3a 00             	cmpb   $0x0,(%edx)
 3f9:	74 15                	je     410 <strlen+0x20>
 3fb:	31 c0                	xor    %eax,%eax
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	40                   	inc    %eax
 401:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 405:	89 c1                	mov    %eax,%ecx
 407:	75 f7                	jne    400 <strlen+0x10>
    ;
  return n;
}
 409:	5d                   	pop    %ebp
 40a:	89 c8                	mov    %ecx,%eax
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 411:	31 c9                	xor    %ecx,%ecx
}
 413:	89 c8                	mov    %ecx,%eax
 415:	c3                   	ret    
 416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 d7                	mov    %edx,%edi
 42f:	fc                   	cld    
 430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 432:	5f                   	pop    %edi
 433:	89 d0                	mov    %edx,%eax
 435:	5d                   	pop    %ebp
 436:	c3                   	ret    
 437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43e:	66 90                	xchg   %ax,%ax

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 10                	jne    461 <strchr+0x21>
 451:	eb 1d                	jmp    470 <strchr+0x30>
 453:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 457:	90                   	nop
 458:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 45c:	40                   	inc    %eax
 45d:	84 d2                	test   %dl,%dl
 45f:	74 0f                	je     470 <strchr+0x30>
    if(*s == c)
 461:	38 d1                	cmp    %dl,%cl
 463:	75 f3                	jne    458 <strchr+0x18>
      return (char*)s;
  return 0;
}
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46e:	66 90                	xchg   %ax,%ax
 470:	5d                   	pop    %ebp
  return 0;
 471:	31 c0                	xor    %eax,%eax
}
 473:	c3                   	ret    
 474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop

00000480 <gets>:

char*
gets(char *buf, int max)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 485:	31 f6                	xor    %esi,%esi
{
 487:	53                   	push   %ebx
    cc = read(0, &c, 1);
 488:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 48b:	83 ec 3c             	sub    $0x3c,%esp
 48e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 491:	eb 32                	jmp    4c5 <gets+0x45>
 493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 497:	90                   	nop
    cc = read(0, &c, 1);
 498:	89 7c 24 04          	mov    %edi,0x4(%esp)
 49c:	b8 01 00 00 00       	mov    $0x1,%eax
 4a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4ac:	e8 1a 01 00 00       	call   5cb <read>
    if(cc < 1)
 4b1:	85 c0                	test   %eax,%eax
 4b3:	7e 19                	jle    4ce <gets+0x4e>
      break;
    buf[i++] = c;
 4b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4b9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 4bd:	3c 0a                	cmp    $0xa,%al
 4bf:	74 10                	je     4d1 <gets+0x51>
 4c1:	3c 0d                	cmp    $0xd,%al
 4c3:	74 0c                	je     4d1 <gets+0x51>
  for(i=0; i+1 < max; ){
 4c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4c8:	46                   	inc    %esi
 4c9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4cc:	7c ca                	jl     498 <gets+0x18>
 4ce:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 4d1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 4d5:	83 c4 3c             	add    $0x3c,%esp
 4d8:	89 d8                	mov    %ebx,%eax
 4da:	5b                   	pop    %ebx
 4db:	5e                   	pop    %esi
 4dc:	5f                   	pop    %edi
 4dd:	5d                   	pop    %ebp
 4de:	c3                   	ret    
 4df:	90                   	nop

000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e1:	31 c0                	xor    %eax,%eax
{
 4e3:	89 e5                	mov    %esp,%ebp
 4e5:	83 ec 18             	sub    $0x18,%esp
 4e8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4eb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f2:	8b 45 08             	mov    0x8(%ebp),%eax
 4f5:	89 04 24             	mov    %eax,(%esp)
 4f8:	e8 f6 00 00 00       	call   5f3 <open>
  if(fd < 0)
 4fd:	85 c0                	test   %eax,%eax
 4ff:	78 2f                	js     530 <stat+0x50>
 501:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 503:	8b 45 0c             	mov    0xc(%ebp),%eax
 506:	89 1c 24             	mov    %ebx,(%esp)
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	e8 f9 00 00 00       	call   60b <fstat>
  close(fd);
 512:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 515:	89 c6                	mov    %eax,%esi
  close(fd);
 517:	e8 bf 00 00 00       	call   5db <close>
  return r;
}
 51c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 51f:	89 f0                	mov    %esi,%eax
 521:	8b 75 fc             	mov    -0x4(%ebp),%esi
 524:	89 ec                	mov    %ebp,%esp
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
 528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop
    return -1;
 530:	be ff ff ff ff       	mov    $0xffffffff,%esi
 535:	eb e5                	jmp    51c <stat+0x3c>
 537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53e:	66 90                	xchg   %ax,%ax

00000540 <atoi>:

int
atoi(const char *s)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 547:	0f be 02             	movsbl (%edx),%eax
 54a:	88 c1                	mov    %al,%cl
 54c:	80 e9 30             	sub    $0x30,%cl
 54f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 552:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 557:	77 1c                	ja     575 <atoi+0x35>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 560:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 563:	42                   	inc    %edx
 564:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 568:	0f be 02             	movsbl (%edx),%eax
 56b:	88 c3                	mov    %al,%bl
 56d:	80 eb 30             	sub    $0x30,%bl
 570:	80 fb 09             	cmp    $0x9,%bl
 573:	76 eb                	jbe    560 <atoi+0x20>
  return n;
}
 575:	5b                   	pop    %ebx
 576:	89 c8                	mov    %ecx,%eax
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	8b 45 10             	mov    0x10(%ebp),%eax
 588:	8b 55 08             	mov    0x8(%ebp),%edx
 58b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 58e:	85 c0                	test   %eax,%eax
 590:	7e 13                	jle    5a5 <memmove+0x25>
 592:	01 d0                	add    %edx,%eax
  dst = vdst;
 594:	89 d7                	mov    %edx,%edi
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5a1:	39 f8                	cmp    %edi,%eax
 5a3:	75 fb                	jne    5a0 <memmove+0x20>
  return vdst;
}
 5a5:	5e                   	pop    %esi
 5a6:	89 d0                	mov    %edx,%eax
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret    

000005ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ab:	b8 01 00 00 00       	mov    $0x1,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <exit>:
SYSCALL(exit)
 5b3:	b8 02 00 00 00       	mov    $0x2,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <wait>:
SYSCALL(wait)
 5bb:	b8 03 00 00 00       	mov    $0x3,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <pipe>:
SYSCALL(pipe)
 5c3:	b8 04 00 00 00       	mov    $0x4,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <read>:
SYSCALL(read)
 5cb:	b8 05 00 00 00       	mov    $0x5,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <write>:
SYSCALL(write)
 5d3:	b8 10 00 00 00       	mov    $0x10,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <close>:
SYSCALL(close)
 5db:	b8 15 00 00 00       	mov    $0x15,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <kill>:
SYSCALL(kill)
 5e3:	b8 06 00 00 00       	mov    $0x6,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <exec>:
SYSCALL(exec)
 5eb:	b8 07 00 00 00       	mov    $0x7,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <open>:
SYSCALL(open)
 5f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <mknod>:
SYSCALL(mknod)
 5fb:	b8 11 00 00 00       	mov    $0x11,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <unlink>:
SYSCALL(unlink)
 603:	b8 12 00 00 00       	mov    $0x12,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <fstat>:
SYSCALL(fstat)
 60b:	b8 08 00 00 00       	mov    $0x8,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <link>:
SYSCALL(link)
 613:	b8 13 00 00 00       	mov    $0x13,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <mkdir>:
SYSCALL(mkdir)
 61b:	b8 14 00 00 00       	mov    $0x14,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <chdir>:
SYSCALL(chdir)
 623:	b8 09 00 00 00       	mov    $0x9,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <dup>:
SYSCALL(dup)
 62b:	b8 0a 00 00 00       	mov    $0xa,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <getpid>:
SYSCALL(getpid)
 633:	b8 0b 00 00 00       	mov    $0xb,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <sbrk>:
SYSCALL(sbrk)
 63b:	b8 0c 00 00 00       	mov    $0xc,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <sleep>:
SYSCALL(sleep)
 643:	b8 0d 00 00 00       	mov    $0xd,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <uptime>:
SYSCALL(uptime)
 64b:	b8 0e 00 00 00       	mov    $0xe,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <getNumFreePages>:
 653:	b8 16 00 00 00       	mov    $0x16,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    
 65b:	66 90                	xchg   %ax,%ax
 65d:	66 90                	xchg   %ax,%ax
 65f:	90                   	nop

00000660 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	89 cb                	mov    %ecx,%ebx
 668:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 66b:	89 d1                	mov    %edx,%ecx
{
 66d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 670:	89 d0                	mov    %edx,%eax
 672:	c1 e8 1f             	shr    $0x1f,%eax
 675:	84 c0                	test   %al,%al
 677:	0f 84 93 00 00 00    	je     710 <printint+0xb0>
 67d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 681:	0f 84 89 00 00 00    	je     710 <printint+0xb0>
    x = -xx;
 687:	f7 d9                	neg    %ecx
    neg = 1;
 689:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 68e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 695:	8d 75 d7             	lea    -0x29(%ebp),%esi
 698:	89 45 b8             	mov    %eax,-0x48(%ebp)
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 6a0:	89 c8                	mov    %ecx,%eax
 6a2:	31 d2                	xor    %edx,%edx
 6a4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 6a7:	f7 f3                	div    %ebx
 6a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6ac:	0f b6 92 54 0b 00 00 	movzbl 0xb54(%edx),%edx
 6b3:	8d 47 01             	lea    0x1(%edi),%eax
 6b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 6b9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 6bd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 6bf:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 6c2:	39 da                	cmp    %ebx,%edx
 6c4:	73 da                	jae    6a0 <printint+0x40>
  if(neg)
 6c6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 6c9:	85 c0                	test   %eax,%eax
 6cb:	74 0a                	je     6d7 <printint+0x77>
    buf[i++] = '-';
 6cd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6d0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 6d5:	89 c7                	mov    %eax,%edi
 6d7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 6da:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 6de:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 6e0:	0f b6 07             	movzbl (%edi),%eax
 6e3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 6e6:	b8 01 00 00 00       	mov    $0x1,%eax
 6eb:	89 44 24 08          	mov    %eax,0x8(%esp)
 6ef:	89 74 24 04          	mov    %esi,0x4(%esp)
 6f3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 6f6:	89 04 24             	mov    %eax,(%esp)
 6f9:	e8 d5 fe ff ff       	call   5d3 <write>
  while(--i >= 0)
 6fe:	89 f8                	mov    %edi,%eax
 700:	4f                   	dec    %edi
 701:	39 d8                	cmp    %ebx,%eax
 703:	75 db                	jne    6e0 <printint+0x80>
}
 705:	83 c4 4c             	add    $0x4c,%esp
 708:	5b                   	pop    %ebx
 709:	5e                   	pop    %esi
 70a:	5f                   	pop    %edi
 70b:	5d                   	pop    %ebp
 70c:	c3                   	ret    
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 710:	31 c0                	xor    %eax,%eax
 712:	e9 77 ff ff ff       	jmp    68e <printint+0x2e>
 717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71e:	66 90                	xchg   %ax,%ax

00000720 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 729:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 72c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 72f:	0f b6 1e             	movzbl (%esi),%ebx
 732:	84 db                	test   %bl,%bl
 734:	74 6f                	je     7a5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 736:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 739:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 73b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 73e:	88 d9                	mov    %bl,%cl
 740:	46                   	inc    %esi
 741:	89 d3                	mov    %edx,%ebx
 743:	eb 2b                	jmp    770 <printf+0x50>
 745:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 748:	83 f8 25             	cmp    $0x25,%eax
 74b:	74 4b                	je     798 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 74d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 750:	b8 01 00 00 00       	mov    $0x1,%eax
 755:	89 44 24 08          	mov    %eax,0x8(%esp)
 759:	8d 45 e7             	lea    -0x19(%ebp),%eax
 75c:	89 44 24 04          	mov    %eax,0x4(%esp)
 760:	89 3c 24             	mov    %edi,(%esp)
 763:	e8 6b fe ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 768:	0f b6 0e             	movzbl (%esi),%ecx
 76b:	46                   	inc    %esi
 76c:	84 c9                	test   %cl,%cl
 76e:	74 35                	je     7a5 <printf+0x85>
    if(state == 0){
 770:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 772:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 775:	74 d1                	je     748 <printf+0x28>
      }
    } else if(state == '%'){
 777:	83 fb 25             	cmp    $0x25,%ebx
 77a:	75 ec                	jne    768 <printf+0x48>
      if(c == 'd'){
 77c:	83 f8 25             	cmp    $0x25,%eax
 77f:	0f 84 53 01 00 00    	je     8d8 <printf+0x1b8>
 785:	83 e8 63             	sub    $0x63,%eax
 788:	83 f8 15             	cmp    $0x15,%eax
 78b:	77 23                	ja     7b0 <printf+0x90>
 78d:	ff 24 85 fc 0a 00 00 	jmp    *0xafc(,%eax,4)
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 798:	0f b6 0e             	movzbl (%esi),%ecx
 79b:	46                   	inc    %esi
        state = '%';
 79c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 7a1:	84 c9                	test   %cl,%cl
 7a3:	75 cb                	jne    770 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a5:	83 c4 3c             	add    $0x3c,%esp
 7a8:	5b                   	pop    %ebx
 7a9:	5e                   	pop    %esi
 7aa:	5f                   	pop    %edi
 7ab:	5d                   	pop    %ebp
 7ac:	c3                   	ret    
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
 7b0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 7b3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 7b6:	b8 01 00 00 00       	mov    $0x1,%eax
 7bb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7bf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 7c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 7c7:	89 3c 24             	mov    %edi,(%esp)
 7ca:	e8 04 fe ff ff       	call   5d3 <write>
        putc(fd, c);
 7cf:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 7d3:	ba 01 00 00 00       	mov    $0x1,%edx
 7d8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 7db:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 7df:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 7e1:	89 54 24 08          	mov    %edx,0x8(%esp)
 7e5:	89 3c 24             	mov    %edi,(%esp)
 7e8:	e8 e6 fd ff ff       	call   5d3 <write>
 7ed:	e9 76 ff ff ff       	jmp    768 <printf+0x48>
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7f8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 7fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 800:	8b 13                	mov    (%ebx),%edx
 802:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 809:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 80c:	89 f8                	mov    %edi,%eax
 80e:	e8 4d fe ff ff       	call   660 <printint>
        ap++;
 813:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 816:	31 db                	xor    %ebx,%ebx
 818:	e9 4b ff ff ff       	jmp    768 <printf+0x48>
 81d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 820:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 823:	8b 08                	mov    (%eax),%ecx
        ap++;
 825:	83 c0 04             	add    $0x4,%eax
 828:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 82b:	85 c9                	test   %ecx,%ecx
 82d:	0f 84 cd 00 00 00    	je     900 <printf+0x1e0>
        while(*s != 0){
 833:	0f b6 01             	movzbl (%ecx),%eax
 836:	84 c0                	test   %al,%al
 838:	0f 84 ce 00 00 00    	je     90c <printf+0x1ec>
 83e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 841:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 844:	89 ce                	mov    %ecx,%esi
 846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 850:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 853:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 858:	46                   	inc    %esi
  write(fd, &c, 1);
 859:	89 44 24 08          	mov    %eax,0x8(%esp)
 85d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 861:	89 3c 24             	mov    %edi,(%esp)
 864:	e8 6a fd ff ff       	call   5d3 <write>
        while(*s != 0){
 869:	0f b6 06             	movzbl (%esi),%eax
 86c:	84 c0                	test   %al,%al
 86e:	75 e0                	jne    850 <printf+0x130>
      state = 0;
 870:	8b 75 d0             	mov    -0x30(%ebp),%esi
 873:	31 db                	xor    %ebx,%ebx
 875:	e9 ee fe ff ff       	jmp    768 <printf+0x48>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 880:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 883:	b9 0a 00 00 00       	mov    $0xa,%ecx
 888:	8b 13                	mov    (%ebx),%edx
 88a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 891:	e9 73 ff ff ff       	jmp    809 <printf+0xe9>
 896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 8a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 8a3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 8a8:	8b 10                	mov    (%eax),%edx
 8aa:	89 55 d0             	mov    %edx,-0x30(%ebp)
 8ad:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 8b1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8b4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 8b8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 8bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 8bf:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 8c1:	89 3c 24             	mov    %edi,(%esp)
 8c4:	e8 0a fd ff ff       	call   5d3 <write>
        ap++;
 8c9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8cd:	e9 96 fe ff ff       	jmp    768 <printf+0x48>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 8d8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 8db:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 8de:	b9 01 00 00 00       	mov    $0x1,%ecx
 8e3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 8e7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 8e9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8ed:	89 3c 24             	mov    %edi,(%esp)
 8f0:	e8 de fc ff ff       	call   5d3 <write>
 8f5:	e9 6e fe ff ff       	jmp    768 <printf+0x48>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 900:	b0 28                	mov    $0x28,%al
          s = "(null)";
 902:	b9 f2 0a 00 00       	mov    $0xaf2,%ecx
 907:	e9 32 ff ff ff       	jmp    83e <printf+0x11e>
      state = 0;
 90c:	31 db                	xor    %ebx,%ebx
 90e:	66 90                	xchg   %ax,%ax
 910:	e9 53 fe ff ff       	jmp    768 <printf+0x48>
 915:	66 90                	xchg   %ax,%ax
 917:	66 90                	xchg   %ax,%ax
 919:	66 90                	xchg   %ax,%ax
 91b:	66 90                	xchg   %ax,%ax
 91d:	66 90                	xchg   %ax,%ax
 91f:	90                   	nop

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	a1 78 0b 00 00       	mov    0xb78,%eax
{
 926:	89 e5                	mov    %esp,%ebp
 928:	57                   	push   %edi
 929:	56                   	push   %esi
 92a:	53                   	push   %ebx
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 92e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 93f:	90                   	nop
 940:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 942:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 944:	39 ca                	cmp    %ecx,%edx
 946:	73 30                	jae    978 <free+0x58>
 948:	39 c1                	cmp    %eax,%ecx
 94a:	72 04                	jb     950 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94c:	39 c2                	cmp    %eax,%edx
 94e:	72 f0                	jb     940 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 950:	8b 73 fc             	mov    -0x4(%ebx),%esi
 953:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 956:	39 f8                	cmp    %edi,%eax
 958:	74 26                	je     980 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 95a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 95d:	8b 42 04             	mov    0x4(%edx),%eax
 960:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 963:	39 f1                	cmp    %esi,%ecx
 965:	74 32                	je     999 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 967:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 969:	5b                   	pop    %ebx
  freep = p;
 96a:	89 15 78 0b 00 00    	mov    %edx,0xb78
}
 970:	5e                   	pop    %esi
 971:	5f                   	pop    %edi
 972:	5d                   	pop    %ebp
 973:	c3                   	ret    
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	39 c1                	cmp    %eax,%ecx
 97a:	72 d0                	jb     94c <free+0x2c>
 97c:	eb c2                	jmp    940 <free+0x20>
 97e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 980:	8b 78 04             	mov    0x4(%eax),%edi
 983:	01 fe                	add    %edi,%esi
 985:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 988:	8b 02                	mov    (%edx),%eax
 98a:	8b 00                	mov    (%eax),%eax
 98c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 98f:	8b 42 04             	mov    0x4(%edx),%eax
 992:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 995:	39 f1                	cmp    %esi,%ecx
 997:	75 ce                	jne    967 <free+0x47>
  freep = p;
 999:	89 15 78 0b 00 00    	mov    %edx,0xb78
    p->s.size += bp->s.size;
 99f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 9a2:	01 c8                	add    %ecx,%eax
 9a4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 9a7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9aa:	89 0a                	mov    %ecx,(%edx)
}
 9ac:	5b                   	pop    %ebx
 9ad:	5e                   	pop    %esi
 9ae:	5f                   	pop    %edi
 9af:	5d                   	pop    %ebp
 9b0:	c3                   	ret    
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9bf:	90                   	nop

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9cc:	8b 15 78 0b 00 00    	mov    0xb78,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	8d 78 07             	lea    0x7(%eax),%edi
 9d5:	c1 ef 03             	shr    $0x3,%edi
 9d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9d9:	85 d2                	test   %edx,%edx
 9db:	0f 84 8f 00 00 00    	je     a70 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9e3:	8b 48 04             	mov    0x4(%eax),%ecx
 9e6:	39 f9                	cmp    %edi,%ecx
 9e8:	73 5e                	jae    a48 <malloc+0x88>
  if(nu < 4096)
 9ea:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9ef:	39 df                	cmp    %ebx,%edi
 9f1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9f4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9fb:	eb 0c                	jmp    a09 <malloc+0x49>
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a02:	8b 48 04             	mov    0x4(%eax),%ecx
 a05:	39 f9                	cmp    %edi,%ecx
 a07:	73 3f                	jae    a48 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a09:	39 05 78 0b 00 00    	cmp    %eax,0xb78
 a0f:	89 c2                	mov    %eax,%edx
 a11:	75 ed                	jne    a00 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a13:	89 34 24             	mov    %esi,(%esp)
 a16:	e8 20 fc ff ff       	call   63b <sbrk>
  if(p == (char*)-1)
 a1b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a1e:	74 18                	je     a38 <malloc+0x78>
  hp->s.size = nu;
 a20:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a23:	83 c0 08             	add    $0x8,%eax
 a26:	89 04 24             	mov    %eax,(%esp)
 a29:	e8 f2 fe ff ff       	call   920 <free>
  return freep;
 a2e:	8b 15 78 0b 00 00    	mov    0xb78,%edx
      if((p = morecore(nunits)) == 0)
 a34:	85 d2                	test   %edx,%edx
 a36:	75 c8                	jne    a00 <malloc+0x40>
        return 0;
  }
}
 a38:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 a3b:	31 c0                	xor    %eax,%eax
}
 a3d:	5b                   	pop    %ebx
 a3e:	5e                   	pop    %esi
 a3f:	5f                   	pop    %edi
 a40:	5d                   	pop    %ebp
 a41:	c3                   	ret    
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a48:	39 cf                	cmp    %ecx,%edi
 a4a:	74 54                	je     aa0 <malloc+0xe0>
        p->s.size -= nunits;
 a4c:	29 f9                	sub    %edi,%ecx
 a4e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a51:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a54:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a57:	89 15 78 0b 00 00    	mov    %edx,0xb78
}
 a5d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a60:	83 c0 08             	add    $0x8,%eax
}
 a63:	5b                   	pop    %ebx
 a64:	5e                   	pop    %esi
 a65:	5f                   	pop    %edi
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    
 a68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a6f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 a70:	b8 7c 0b 00 00       	mov    $0xb7c,%eax
 a75:	ba 7c 0b 00 00       	mov    $0xb7c,%edx
 a7a:	a3 78 0b 00 00       	mov    %eax,0xb78
    base.s.size = 0;
 a7f:	31 c9                	xor    %ecx,%ecx
 a81:	b8 7c 0b 00 00       	mov    $0xb7c,%eax
    base.s.ptr = freep = prevp = &base;
 a86:	89 15 7c 0b 00 00    	mov    %edx,0xb7c
    base.s.size = 0;
 a8c:	89 0d 80 0b 00 00    	mov    %ecx,0xb80
    if(p->s.size >= nunits){
 a92:	e9 53 ff ff ff       	jmp    9ea <malloc+0x2a>
 a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a9e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 08                	mov    (%eax),%ecx
 aa2:	89 0a                	mov    %ecx,(%edx)
 aa4:	eb b1                	jmp    a57 <malloc+0x97>
