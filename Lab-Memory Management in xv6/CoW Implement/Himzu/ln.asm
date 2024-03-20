
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   a:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
{
   e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
  11:	74 19                	je     2c <main+0x2c>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 a8 07 00 	movl   $0x7a8,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 f9 03 00 00       	call   420 <printf>
    exit();
  27:	e8 87 02 00 00       	call   2b3 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2c:	8b 43 08             	mov    0x8(%ebx),%eax
  2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  33:	8b 43 04             	mov    0x4(%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 d5 02 00 00       	call   313 <link>
  3e:	85 c0                	test   %eax,%eax
  40:	78 05                	js     47 <main+0x47>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  42:	e8 6c 02 00 00       	call   2b3 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  47:	8b 43 08             	mov    0x8(%ebx),%eax
  4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	c7 44 24 04 bb 07 00 	movl   $0x7bb,0x4(%esp)
  58:	00 
  59:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  60:	89 44 24 08          	mov    %eax,0x8(%esp)
  64:	e8 b7 03 00 00       	call   420 <printf>
  69:	eb d7                	jmp    42 <main+0x42>
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  71:	31 c0                	xor    %eax,%eax
{
  73:	89 e5                	mov    %esp,%ebp
  75:	53                   	push   %ebx
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	40                   	inc    %eax
  88:	84 d2                	test   %dl,%dl
  8a:	75 f4                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8c:	5b                   	pop    %ebx
  8d:	89 c8                	mov    %ecx,%eax
  8f:	5d                   	pop    %ebp
  90:	c3                   	ret    
  91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9f:	90                   	nop

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	75 15                	jne    c6 <strcmp+0x26>
  b1:	eb 30                	jmp    e3 <strcmp+0x43>
  b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b7:	90                   	nop
  b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  bc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  bf:	42                   	inc    %edx
  while(*p && *p == *q)
  c0:	84 c0                	test   %al,%al
  c2:	74 14                	je     d8 <strcmp+0x38>
    p++, q++;
  c4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  c6:	0f b6 0b             	movzbl (%ebx),%ecx
  c9:	38 c1                	cmp    %al,%cl
  cb:	74 eb                	je     b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  cd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  ce:	29 c8                	sub    %ecx,%eax
}
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret    
  d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  d8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  dc:	31 c0                	xor    %eax,%eax
}
  de:	5b                   	pop    %ebx
  df:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  e0:	29 c8                	sub    %ecx,%eax
}
  e2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  e3:	0f b6 0b             	movzbl (%ebx),%ecx
  e6:	31 c0                	xor    %eax,%eax
  e8:	eb e3                	jmp    cd <strcmp+0x2d>
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 3a 00             	cmpb   $0x0,(%edx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 c0                	xor    %eax,%eax
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	40                   	inc    %eax
 101:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 105:	89 c1                	mov    %eax,%ecx
 107:	75 f7                	jne    100 <strlen+0x10>
    ;
  return n;
}
 109:	5d                   	pop    %ebp
 10a:	89 c8                	mov    %ecx,%eax
 10c:	c3                   	ret    
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 111:	31 c9                	xor    %ecx,%ecx
}
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret    
 116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	5f                   	pop    %edi
 133:	89 d0                	mov    %edx,%eax
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13e:	66 90                	xchg   %ax,%ax

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 10                	jne    161 <strchr+0x21>
 151:	eb 1d                	jmp    170 <strchr+0x30>
 153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 157:	90                   	nop
 158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 15c:	40                   	inc    %eax
 15d:	84 d2                	test   %dl,%dl
 15f:	74 0f                	je     170 <strchr+0x30>
    if(*s == c)
 161:	38 d1                	cmp    %dl,%cl
 163:	75 f3                	jne    158 <strchr+0x18>
      return (char*)s;
  return 0;
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax
 170:	5d                   	pop    %ebp
  return 0;
 171:	31 c0                	xor    %eax,%eax
}
 173:	c3                   	ret    
 174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 185:	31 f6                	xor    %esi,%esi
{
 187:	53                   	push   %ebx
    cc = read(0, &c, 1);
 188:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 18b:	83 ec 3c             	sub    $0x3c,%esp
 18e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 191:	eb 32                	jmp    1c5 <gets+0x45>
 193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 197:	90                   	nop
    cc = read(0, &c, 1);
 198:	89 7c 24 04          	mov    %edi,0x4(%esp)
 19c:	b8 01 00 00 00       	mov    $0x1,%eax
 1a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ac:	e8 1a 01 00 00       	call   2cb <read>
    if(cc < 1)
 1b1:	85 c0                	test   %eax,%eax
 1b3:	7e 19                	jle    1ce <gets+0x4e>
      break;
    buf[i++] = c;
 1b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1bd:	3c 0a                	cmp    $0xa,%al
 1bf:	74 10                	je     1d1 <gets+0x51>
 1c1:	3c 0d                	cmp    $0xd,%al
 1c3:	74 0c                	je     1d1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1c8:	46                   	inc    %esi
 1c9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1cc:	7c ca                	jl     198 <gets+0x18>
 1ce:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1d1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1d5:	83 c4 3c             	add    $0x3c,%esp
 1d8:	89 d8                	mov    %ebx,%eax
 1da:	5b                   	pop    %ebx
 1db:	5e                   	pop    %esi
 1dc:	5f                   	pop    %edi
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    
 1df:	90                   	nop

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 18             	sub    $0x18,%esp
 1e8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1eb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	89 04 24             	mov    %eax,(%esp)
 1f8:	e8 f6 00 00 00       	call   2f3 <open>
  if(fd < 0)
 1fd:	85 c0                	test   %eax,%eax
 1ff:	78 2f                	js     230 <stat+0x50>
 201:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 203:	8b 45 0c             	mov    0xc(%ebp),%eax
 206:	89 1c 24             	mov    %ebx,(%esp)
 209:	89 44 24 04          	mov    %eax,0x4(%esp)
 20d:	e8 f9 00 00 00       	call   30b <fstat>
  close(fd);
 212:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 215:	89 c6                	mov    %eax,%esi
  close(fd);
 217:	e8 bf 00 00 00       	call   2db <close>
  return r;
}
 21c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 21f:	89 f0                	mov    %esi,%eax
 221:	8b 75 fc             	mov    -0x4(%ebp),%esi
 224:	89 ec                	mov    %ebp,%esp
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
 228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb e5                	jmp    21c <stat+0x3c>
 237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23e:	66 90                	xchg   %ax,%ax

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	88 c1                	mov    %al,%cl
 24c:	80 e9 30             	sub    $0x30,%cl
 24f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 252:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 257:	77 1c                	ja     275 <atoi+0x35>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 260:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 263:	42                   	inc    %edx
 264:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 268:	0f be 02             	movsbl (%edx),%eax
 26b:	88 c3                	mov    %al,%bl
 26d:	80 eb 30             	sub    $0x30,%bl
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	89 c8                	mov    %ecx,%eax
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
 285:	8b 45 10             	mov    0x10(%ebp),%eax
 288:	8b 55 08             	mov    0x8(%ebp),%edx
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 c0                	test   %eax,%eax
 290:	7e 13                	jle    2a5 <memmove+0x25>
 292:	01 d0                	add    %edx,%eax
  dst = vdst;
 294:	89 d7                	mov    %edx,%edi
 296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2a1:	39 f8                	cmp    %edi,%eax
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
  return vdst;
}
 2a5:	5e                   	pop    %esi
 2a6:	89 d0                	mov    %edx,%eax
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    

000002ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ab:	b8 01 00 00 00       	mov    $0x1,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <exit>:
SYSCALL(exit)
 2b3:	b8 02 00 00 00       	mov    $0x2,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <wait>:
SYSCALL(wait)
 2bb:	b8 03 00 00 00       	mov    $0x3,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <pipe>:
SYSCALL(pipe)
 2c3:	b8 04 00 00 00       	mov    $0x4,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <read>:
SYSCALL(read)
 2cb:	b8 05 00 00 00       	mov    $0x5,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <write>:
SYSCALL(write)
 2d3:	b8 10 00 00 00       	mov    $0x10,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <close>:
SYSCALL(close)
 2db:	b8 15 00 00 00       	mov    $0x15,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <kill>:
SYSCALL(kill)
 2e3:	b8 06 00 00 00       	mov    $0x6,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <exec>:
SYSCALL(exec)
 2eb:	b8 07 00 00 00       	mov    $0x7,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <open>:
SYSCALL(open)
 2f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <mknod>:
SYSCALL(mknod)
 2fb:	b8 11 00 00 00       	mov    $0x11,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <unlink>:
SYSCALL(unlink)
 303:	b8 12 00 00 00       	mov    $0x12,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <fstat>:
SYSCALL(fstat)
 30b:	b8 08 00 00 00       	mov    $0x8,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <link>:
SYSCALL(link)
 313:	b8 13 00 00 00       	mov    $0x13,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <mkdir>:
SYSCALL(mkdir)
 31b:	b8 14 00 00 00       	mov    $0x14,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <chdir>:
SYSCALL(chdir)
 323:	b8 09 00 00 00       	mov    $0x9,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <dup>:
SYSCALL(dup)
 32b:	b8 0a 00 00 00       	mov    $0xa,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <getpid>:
SYSCALL(getpid)
 333:	b8 0b 00 00 00       	mov    $0xb,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <sbrk>:
SYSCALL(sbrk)
 33b:	b8 0c 00 00 00       	mov    $0xc,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <sleep>:
SYSCALL(sleep)
 343:	b8 0d 00 00 00       	mov    $0xd,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <uptime>:
SYSCALL(uptime)
 34b:	b8 0e 00 00 00       	mov    $0xe,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <getNumFreePages>:
 353:	b8 16 00 00 00       	mov    $0x16,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    
 35b:	66 90                	xchg   %ax,%ax
 35d:	66 90                	xchg   %ax,%ax
 35f:	90                   	nop

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	89 cb                	mov    %ecx,%ebx
 368:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 36b:	89 d1                	mov    %edx,%ecx
{
 36d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 370:	89 d0                	mov    %edx,%eax
 372:	c1 e8 1f             	shr    $0x1f,%eax
 375:	84 c0                	test   %al,%al
 377:	0f 84 93 00 00 00    	je     410 <printint+0xb0>
 37d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 381:	0f 84 89 00 00 00    	je     410 <printint+0xb0>
    x = -xx;
 387:	f7 d9                	neg    %ecx
    neg = 1;
 389:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 38e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 395:	8d 75 d7             	lea    -0x29(%ebp),%esi
 398:	89 45 b8             	mov    %eax,-0x48(%ebp)
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3a0:	89 c8                	mov    %ecx,%eax
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3a7:	f7 f3                	div    %ebx
 3a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3ac:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
 3b3:	8d 47 01             	lea    0x1(%edi),%eax
 3b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3b9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3bd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3bf:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3c2:	39 da                	cmp    %ebx,%edx
 3c4:	73 da                	jae    3a0 <printint+0x40>
  if(neg)
 3c6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3c9:	85 c0                	test   %eax,%eax
 3cb:	74 0a                	je     3d7 <printint+0x77>
    buf[i++] = '-';
 3cd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3d0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3d5:	89 c7                	mov    %eax,%edi
 3d7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3da:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3de:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 3e0:	0f b6 07             	movzbl (%edi),%eax
 3e3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3e6:	b8 01 00 00 00       	mov    $0x1,%eax
 3eb:	89 44 24 08          	mov    %eax,0x8(%esp)
 3ef:	89 74 24 04          	mov    %esi,0x4(%esp)
 3f3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 3f6:	89 04 24             	mov    %eax,(%esp)
 3f9:	e8 d5 fe ff ff       	call   2d3 <write>
  while(--i >= 0)
 3fe:	89 f8                	mov    %edi,%eax
 400:	4f                   	dec    %edi
 401:	39 d8                	cmp    %ebx,%eax
 403:	75 db                	jne    3e0 <printint+0x80>
}
 405:	83 c4 4c             	add    $0x4c,%esp
 408:	5b                   	pop    %ebx
 409:	5e                   	pop    %esi
 40a:	5f                   	pop    %edi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 410:	31 c0                	xor    %eax,%eax
 412:	e9 77 ff ff ff       	jmp    38e <printint+0x2e>
 417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41e:	66 90                	xchg   %ax,%ax

00000420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 42c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 42f:	0f b6 1e             	movzbl (%esi),%ebx
 432:	84 db                	test   %bl,%bl
 434:	74 6f                	je     4a5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 436:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 439:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 43b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 43e:	88 d9                	mov    %bl,%cl
 440:	46                   	inc    %esi
 441:	89 d3                	mov    %edx,%ebx
 443:	eb 2b                	jmp    470 <printf+0x50>
 445:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 f8 25             	cmp    $0x25,%eax
 44b:	74 4b                	je     498 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 44d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 450:	b8 01 00 00 00       	mov    $0x1,%eax
 455:	89 44 24 08          	mov    %eax,0x8(%esp)
 459:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45c:	89 44 24 04          	mov    %eax,0x4(%esp)
 460:	89 3c 24             	mov    %edi,(%esp)
 463:	e8 6b fe ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 468:	0f b6 0e             	movzbl (%esi),%ecx
 46b:	46                   	inc    %esi
 46c:	84 c9                	test   %cl,%cl
 46e:	74 35                	je     4a5 <printf+0x85>
    if(state == 0){
 470:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 472:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 475:	74 d1                	je     448 <printf+0x28>
      }
    } else if(state == '%'){
 477:	83 fb 25             	cmp    $0x25,%ebx
 47a:	75 ec                	jne    468 <printf+0x48>
      if(c == 'd'){
 47c:	83 f8 25             	cmp    $0x25,%eax
 47f:	0f 84 53 01 00 00    	je     5d8 <printf+0x1b8>
 485:	83 e8 63             	sub    $0x63,%eax
 488:	83 f8 15             	cmp    $0x15,%eax
 48b:	77 23                	ja     4b0 <printf+0x90>
 48d:	ff 24 85 d8 07 00 00 	jmp    *0x7d8(,%eax,4)
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 498:	0f b6 0e             	movzbl (%esi),%ecx
 49b:	46                   	inc    %esi
        state = '%';
 49c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 4a1:	84 c9                	test   %cl,%cl
 4a3:	75 cb                	jne    470 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4a5:	83 c4 3c             	add    $0x3c,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5f                   	pop    %edi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 4b3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 4b6:	b8 01 00 00 00       	mov    $0x1,%eax
 4bb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4bf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c7:	89 3c 24             	mov    %edi,(%esp)
 4ca:	e8 04 fe ff ff       	call   2d3 <write>
        putc(fd, c);
 4cf:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 4d3:	ba 01 00 00 00       	mov    $0x1,%edx
 4d8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 4db:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 4df:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 4e1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4e5:	89 3c 24             	mov    %edi,(%esp)
 4e8:	e8 e6 fd ff ff       	call   2d3 <write>
 4ed:	e9 76 ff ff ff       	jmp    468 <printf+0x48>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4f8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 4fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 500:	8b 13                	mov    (%ebx),%edx
 502:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 509:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 50c:	89 f8                	mov    %edi,%eax
 50e:	e8 4d fe ff ff       	call   360 <printint>
        ap++;
 513:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 516:	31 db                	xor    %ebx,%ebx
 518:	e9 4b ff ff ff       	jmp    468 <printf+0x48>
 51d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 520:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 523:	8b 08                	mov    (%eax),%ecx
        ap++;
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 52b:	85 c9                	test   %ecx,%ecx
 52d:	0f 84 cd 00 00 00    	je     600 <printf+0x1e0>
        while(*s != 0){
 533:	0f b6 01             	movzbl (%ecx),%eax
 536:	84 c0                	test   %al,%al
 538:	0f 84 ce 00 00 00    	je     60c <printf+0x1ec>
 53e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 541:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 544:	89 ce                	mov    %ecx,%esi
 546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 550:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 553:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 558:	46                   	inc    %esi
  write(fd, &c, 1);
 559:	89 44 24 08          	mov    %eax,0x8(%esp)
 55d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 561:	89 3c 24             	mov    %edi,(%esp)
 564:	e8 6a fd ff ff       	call   2d3 <write>
        while(*s != 0){
 569:	0f b6 06             	movzbl (%esi),%eax
 56c:	84 c0                	test   %al,%al
 56e:	75 e0                	jne    550 <printf+0x130>
      state = 0;
 570:	8b 75 d0             	mov    -0x30(%ebp),%esi
 573:	31 db                	xor    %ebx,%ebx
 575:	e9 ee fe ff ff       	jmp    468 <printf+0x48>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 580:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
 588:	8b 13                	mov    (%ebx),%edx
 58a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 591:	e9 73 ff ff ff       	jmp    509 <printf+0xe9>
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5a3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 5a8:	8b 10                	mov    (%eax),%edx
 5aa:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5ad:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5b1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5b4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 5b8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5bf:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5c1:	89 3c 24             	mov    %edi,(%esp)
 5c4:	e8 0a fd ff ff       	call   2d3 <write>
        ap++;
 5c9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5cd:	e9 96 fe ff ff       	jmp    468 <printf+0x48>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 5d8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 5db:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5de:	b9 01 00 00 00       	mov    $0x1,%ecx
 5e3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5e7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5e9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5ed:	89 3c 24             	mov    %edi,(%esp)
 5f0:	e8 de fc ff ff       	call   2d3 <write>
 5f5:	e9 6e fe ff ff       	jmp    468 <printf+0x48>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 600:	b0 28                	mov    $0x28,%al
          s = "(null)";
 602:	b9 cf 07 00 00       	mov    $0x7cf,%ecx
 607:	e9 32 ff ff ff       	jmp    53e <printf+0x11e>
      state = 0;
 60c:	31 db                	xor    %ebx,%ebx
 60e:	66 90                	xchg   %ax,%ax
 610:	e9 53 fe ff ff       	jmp    468 <printf+0x48>
 615:	66 90                	xchg   %ax,%ax
 617:	66 90                	xchg   %ax,%ax
 619:	66 90                	xchg   %ax,%ax
 61b:	66 90                	xchg   %ax,%ax
 61d:	66 90                	xchg   %ax,%ax
 61f:	90                   	nop

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 44 08 00 00       	mov    0x844,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
 640:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 644:	39 ca                	cmp    %ecx,%edx
 646:	73 30                	jae    678 <free+0x58>
 648:	39 c1                	cmp    %eax,%ecx
 64a:	72 04                	jb     650 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64c:	39 c2                	cmp    %eax,%edx
 64e:	72 f0                	jb     640 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 650:	8b 73 fc             	mov    -0x4(%ebx),%esi
 653:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 656:	39 f8                	cmp    %edi,%eax
 658:	74 26                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 65a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 65d:	8b 42 04             	mov    0x4(%edx),%eax
 660:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 663:	39 f1                	cmp    %esi,%ecx
 665:	74 32                	je     699 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 667:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 669:	5b                   	pop    %ebx
  freep = p;
 66a:	89 15 44 08 00 00    	mov    %edx,0x844
}
 670:	5e                   	pop    %esi
 671:	5f                   	pop    %edi
 672:	5d                   	pop    %ebp
 673:	c3                   	ret    
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 c1                	cmp    %eax,%ecx
 67a:	72 d0                	jb     64c <free+0x2c>
 67c:	eb c2                	jmp    640 <free+0x20>
 67e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 680:	8b 78 04             	mov    0x4(%eax),%edi
 683:	01 fe                	add    %edi,%esi
 685:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 688:	8b 02                	mov    (%edx),%eax
 68a:	8b 00                	mov    (%eax),%eax
 68c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 68f:	8b 42 04             	mov    0x4(%edx),%eax
 692:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 695:	39 f1                	cmp    %esi,%ecx
 697:	75 ce                	jne    667 <free+0x47>
  freep = p;
 699:	89 15 44 08 00 00    	mov    %edx,0x844
    p->s.size += bp->s.size;
 69f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6a2:	01 c8                	add    %ecx,%eax
 6a4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6a7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6aa:	89 0a                	mov    %ecx,(%edx)
}
 6ac:	5b                   	pop    %ebx
 6ad:	5e                   	pop    %esi
 6ae:	5f                   	pop    %edi
 6af:	5d                   	pop    %ebp
 6b0:	c3                   	ret    
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 44 08 00 00    	mov    0x844,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6d9:	85 d2                	test   %edx,%edx
 6db:	0f 84 8f 00 00 00    	je     770 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e3:	8b 48 04             	mov    0x4(%eax),%ecx
 6e6:	39 f9                	cmp    %edi,%ecx
 6e8:	73 5e                	jae    748 <malloc+0x88>
  if(nu < 4096)
 6ea:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6ef:	39 df                	cmp    %ebx,%edi
 6f1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6f4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6fb:	eb 0c                	jmp    709 <malloc+0x49>
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 48 04             	mov    0x4(%eax),%ecx
 705:	39 f9                	cmp    %edi,%ecx
 707:	73 3f                	jae    748 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 709:	39 05 44 08 00 00    	cmp    %eax,0x844
 70f:	89 c2                	mov    %eax,%edx
 711:	75 ed                	jne    700 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 713:	89 34 24             	mov    %esi,(%esp)
 716:	e8 20 fc ff ff       	call   33b <sbrk>
  if(p == (char*)-1)
 71b:	83 f8 ff             	cmp    $0xffffffff,%eax
 71e:	74 18                	je     738 <malloc+0x78>
  hp->s.size = nu;
 720:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 723:	83 c0 08             	add    $0x8,%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 f2 fe ff ff       	call   620 <free>
  return freep;
 72e:	8b 15 44 08 00 00    	mov    0x844,%edx
      if((p = morecore(nunits)) == 0)
 734:	85 d2                	test   %edx,%edx
 736:	75 c8                	jne    700 <malloc+0x40>
        return 0;
  }
}
 738:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 73b:	31 c0                	xor    %eax,%eax
}
 73d:	5b                   	pop    %ebx
 73e:	5e                   	pop    %esi
 73f:	5f                   	pop    %edi
 740:	5d                   	pop    %ebp
 741:	c3                   	ret    
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 748:	39 cf                	cmp    %ecx,%edi
 74a:	74 54                	je     7a0 <malloc+0xe0>
        p->s.size -= nunits;
 74c:	29 f9                	sub    %edi,%ecx
 74e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 751:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 754:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 757:	89 15 44 08 00 00    	mov    %edx,0x844
}
 75d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 760:	83 c0 08             	add    $0x8,%eax
}
 763:	5b                   	pop    %ebx
 764:	5e                   	pop    %esi
 765:	5f                   	pop    %edi
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
 768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 770:	b8 48 08 00 00       	mov    $0x848,%eax
 775:	ba 48 08 00 00       	mov    $0x848,%edx
 77a:	a3 44 08 00 00       	mov    %eax,0x844
    base.s.size = 0;
 77f:	31 c9                	xor    %ecx,%ecx
 781:	b8 48 08 00 00       	mov    $0x848,%eax
    base.s.ptr = freep = prevp = &base;
 786:	89 15 48 08 00 00    	mov    %edx,0x848
    base.s.size = 0;
 78c:	89 0d 4c 08 00 00    	mov    %ecx,0x84c
    if(p->s.size >= nunits){
 792:	e9 53 ff ff ff       	jmp    6ea <malloc+0x2a>
 797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 08                	mov    (%eax),%ecx
 7a2:	89 0a                	mov    %ecx,(%edx)
 7a4:	eb b1                	jmp    757 <malloc+0x97>
