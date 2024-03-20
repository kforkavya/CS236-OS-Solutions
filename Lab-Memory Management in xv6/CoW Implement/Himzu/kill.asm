
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 21                	jle    3d <main+0x3d>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    kill(atoi(argv[i]));
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 04 02 00 00       	call   230 <atoi>
  2c:	89 04 24             	mov    %eax,(%esp)
  2f:	e8 9f 02 00 00       	call   2d3 <kill>
  for(i=1; i<argc; i++)
  34:	39 de                	cmp    %ebx,%esi
  36:	75 e8                	jne    20 <main+0x20>
  exit();
  38:	e8 66 02 00 00       	call   2a3 <exit>
    printf(2, "usage: kill pid...\n");
  3d:	c7 44 24 04 98 07 00 	movl   $0x798,0x4(%esp)
  44:	00 
  45:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4c:	e8 bf 03 00 00       	call   410 <printf>
    exit();
  51:	e8 4d 02 00 00       	call   2a3 <exit>
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	40                   	inc    %eax
  78:	84 d2                	test   %dl,%dl
  7a:	75 f4                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7c:	5b                   	pop    %ebx
  7d:	89 c8                	mov    %ecx,%eax
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret    
  81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8f:	90                   	nop

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 15                	jne    b6 <strcmp+0x26>
  a1:	eb 30                	jmp    d3 <strcmp+0x43>
  a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a7:	90                   	nop
  a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  ac:	8d 4b 01             	lea    0x1(%ebx),%ecx
  af:	42                   	inc    %edx
  while(*p && *p == *q)
  b0:	84 c0                	test   %al,%al
  b2:	74 14                	je     c8 <strcmp+0x38>
    p++, q++;
  b4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  b6:	0f b6 0b             	movzbl (%ebx),%ecx
  b9:	38 c1                	cmp    %al,%cl
  bb:	74 eb                	je     a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  bd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  be:	29 c8                	sub    %ecx,%eax
}
  c0:	5d                   	pop    %ebp
  c1:	c3                   	ret    
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  c8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  cc:	31 c0                	xor    %eax,%eax
}
  ce:	5b                   	pop    %ebx
  cf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  d0:	29 c8                	sub    %ecx,%eax
}
  d2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  d3:	0f b6 0b             	movzbl (%ebx),%ecx
  d6:	31 c0                	xor    %eax,%eax
  d8:	eb e3                	jmp    bd <strcmp+0x2d>
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 3a 00             	cmpb   $0x0,(%edx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 c0                	xor    %eax,%eax
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	40                   	inc    %eax
  f1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  f5:	89 c1                	mov    %eax,%ecx
  f7:	75 f7                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  f9:	5d                   	pop    %ebp
  fa:	89 c8                	mov    %ecx,%eax
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 101:	31 c9                	xor    %ecx,%ecx
}
 103:	89 c8                	mov    %ecx,%eax
 105:	c3                   	ret    
 106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10d:	8d 76 00             	lea    0x0(%esi),%esi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	5f                   	pop    %edi
 123:	89 d0                	mov    %edx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 10                	jne    151 <strchr+0x21>
 141:	eb 1d                	jmp    160 <strchr+0x30>
 143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 147:	90                   	nop
 148:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 14c:	40                   	inc    %eax
 14d:	84 d2                	test   %dl,%dl
 14f:	74 0f                	je     160 <strchr+0x30>
    if(*s == c)
 151:	38 d1                	cmp    %dl,%cl
 153:	75 f3                	jne    148 <strchr+0x18>
      return (char*)s;
  return 0;
}
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax
 160:	5d                   	pop    %ebp
  return 0;
 161:	31 c0                	xor    %eax,%eax
}
 163:	c3                   	ret    
 164:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 16f:	90                   	nop

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	31 f6                	xor    %esi,%esi
{
 177:	53                   	push   %ebx
    cc = read(0, &c, 1);
 178:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 17b:	83 ec 3c             	sub    $0x3c,%esp
 17e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 181:	eb 32                	jmp    1b5 <gets+0x45>
 183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 187:	90                   	nop
    cc = read(0, &c, 1);
 188:	89 7c 24 04          	mov    %edi,0x4(%esp)
 18c:	b8 01 00 00 00       	mov    $0x1,%eax
 191:	89 44 24 08          	mov    %eax,0x8(%esp)
 195:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19c:	e8 1a 01 00 00       	call   2bb <read>
    if(cc < 1)
 1a1:	85 c0                	test   %eax,%eax
 1a3:	7e 19                	jle    1be <gets+0x4e>
      break;
    buf[i++] = c;
 1a5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1ad:	3c 0a                	cmp    $0xa,%al
 1af:	74 10                	je     1c1 <gets+0x51>
 1b1:	3c 0d                	cmp    $0xd,%al
 1b3:	74 0c                	je     1c1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1b8:	46                   	inc    %esi
 1b9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1bc:	7c ca                	jl     188 <gets+0x18>
 1be:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1c1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1c5:	83 c4 3c             	add    $0x3c,%esp
 1c8:	89 d8                	mov    %ebx,%eax
 1ca:	5b                   	pop    %ebx
 1cb:	5e                   	pop    %esi
 1cc:	5f                   	pop    %edi
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d1:	31 c0                	xor    %eax,%eax
{
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	83 ec 18             	sub    $0x18,%esp
 1d8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1db:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1de:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 f6 00 00 00       	call   2e3 <open>
  if(fd < 0)
 1ed:	85 c0                	test   %eax,%eax
 1ef:	78 2f                	js     220 <stat+0x50>
 1f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f6:	89 1c 24             	mov    %ebx,(%esp)
 1f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fd:	e8 f9 00 00 00       	call   2fb <fstat>
  close(fd);
 202:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 205:	89 c6                	mov    %eax,%esi
  close(fd);
 207:	e8 bf 00 00 00       	call   2cb <close>
  return r;
}
 20c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 20f:	89 f0                	mov    %esi,%eax
 211:	8b 75 fc             	mov    -0x4(%ebp),%esi
 214:	89 ec                	mov    %ebp,%esp
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb e5                	jmp    20c <stat+0x3c>
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 02             	movsbl (%edx),%eax
 23a:	88 c1                	mov    %al,%cl
 23c:	80 e9 30             	sub    $0x30,%cl
 23f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 242:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 247:	77 1c                	ja     265 <atoi+0x35>
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 250:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 253:	42                   	inc    %edx
 254:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 258:	0f be 02             	movsbl (%edx),%eax
 25b:	88 c3                	mov    %al,%bl
 25d:	80 eb 30             	sub    $0x30,%bl
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	5b                   	pop    %ebx
 266:	89 c8                	mov    %ecx,%eax
 268:	5d                   	pop    %ebp
 269:	c3                   	ret    
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
 275:	8b 45 10             	mov    0x10(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c0                	test   %eax,%eax
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	01 d0                	add    %edx,%eax
  dst = vdst;
 284:	89 d7                	mov    %edx,%edi
 286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 290:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 291:	39 f8                	cmp    %edi,%eax
 293:	75 fb                	jne    290 <memmove+0x20>
  return vdst;
}
 295:	5e                   	pop    %esi
 296:	89 d0                	mov    %edx,%eax
 298:	5f                   	pop    %edi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret    

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <getNumFreePages>:
 343:	b8 16 00 00 00       	mov    $0x16,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    
 34b:	66 90                	xchg   %ax,%ax
 34d:	66 90                	xchg   %ax,%ax
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	89 cb                	mov    %ecx,%ebx
 358:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35b:	89 d1                	mov    %edx,%ecx
{
 35d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 360:	89 d0                	mov    %edx,%eax
 362:	c1 e8 1f             	shr    $0x1f,%eax
 365:	84 c0                	test   %al,%al
 367:	0f 84 93 00 00 00    	je     400 <printint+0xb0>
 36d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 371:	0f 84 89 00 00 00    	je     400 <printint+0xb0>
    x = -xx;
 377:	f7 d9                	neg    %ecx
    neg = 1;
 379:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 37e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 385:	8d 75 d7             	lea    -0x29(%ebp),%esi
 388:	89 45 b8             	mov    %eax,-0x48(%ebp)
 38b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 38f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 390:	89 c8                	mov    %ecx,%eax
 392:	31 d2                	xor    %edx,%edx
 394:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 397:	f7 f3                	div    %ebx
 399:	89 45 c0             	mov    %eax,-0x40(%ebp)
 39c:	0f b6 92 0c 08 00 00 	movzbl 0x80c(%edx),%edx
 3a3:	8d 47 01             	lea    0x1(%edi),%eax
 3a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3a9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3ad:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3af:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3b2:	39 da                	cmp    %ebx,%edx
 3b4:	73 da                	jae    390 <printint+0x40>
  if(neg)
 3b6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3b9:	85 c0                	test   %eax,%eax
 3bb:	74 0a                	je     3c7 <printint+0x77>
    buf[i++] = '-';
 3bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3c5:	89 c7                	mov    %eax,%edi
 3c7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3ca:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3ce:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 3d0:	0f b6 07             	movzbl (%edi),%eax
 3d3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3d6:	b8 01 00 00 00       	mov    $0x1,%eax
 3db:	89 44 24 08          	mov    %eax,0x8(%esp)
 3df:	89 74 24 04          	mov    %esi,0x4(%esp)
 3e3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 3e6:	89 04 24             	mov    %eax,(%esp)
 3e9:	e8 d5 fe ff ff       	call   2c3 <write>
  while(--i >= 0)
 3ee:	89 f8                	mov    %edi,%eax
 3f0:	4f                   	dec    %edi
 3f1:	39 d8                	cmp    %ebx,%eax
 3f3:	75 db                	jne    3d0 <printint+0x80>
}
 3f5:	83 c4 4c             	add    $0x4c,%esp
 3f8:	5b                   	pop    %ebx
 3f9:	5e                   	pop    %esi
 3fa:	5f                   	pop    %edi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 400:	31 c0                	xor    %eax,%eax
 402:	e9 77 ff ff ff       	jmp    37e <printint+0x2e>
 407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40e:	66 90                	xchg   %ax,%ax

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 41c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 41f:	0f b6 1e             	movzbl (%esi),%ebx
 422:	84 db                	test   %bl,%bl
 424:	74 6f                	je     495 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 426:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 429:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 42b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 42e:	88 d9                	mov    %bl,%cl
 430:	46                   	inc    %esi
 431:	89 d3                	mov    %edx,%ebx
 433:	eb 2b                	jmp    460 <printf+0x50>
 435:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	74 4b                	je     488 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 43d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	89 44 24 08          	mov    %eax,0x8(%esp)
 449:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44c:	89 44 24 04          	mov    %eax,0x4(%esp)
 450:	89 3c 24             	mov    %edi,(%esp)
 453:	e8 6b fe ff ff       	call   2c3 <write>
  for(i = 0; fmt[i]; i++){
 458:	0f b6 0e             	movzbl (%esi),%ecx
 45b:	46                   	inc    %esi
 45c:	84 c9                	test   %cl,%cl
 45e:	74 35                	je     495 <printf+0x85>
    if(state == 0){
 460:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 462:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 465:	74 d1                	je     438 <printf+0x28>
      }
    } else if(state == '%'){
 467:	83 fb 25             	cmp    $0x25,%ebx
 46a:	75 ec                	jne    458 <printf+0x48>
      if(c == 'd'){
 46c:	83 f8 25             	cmp    $0x25,%eax
 46f:	0f 84 53 01 00 00    	je     5c8 <printf+0x1b8>
 475:	83 e8 63             	sub    $0x63,%eax
 478:	83 f8 15             	cmp    $0x15,%eax
 47b:	77 23                	ja     4a0 <printf+0x90>
 47d:	ff 24 85 b4 07 00 00 	jmp    *0x7b4(,%eax,4)
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 488:	0f b6 0e             	movzbl (%esi),%ecx
 48b:	46                   	inc    %esi
        state = '%';
 48c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 491:	84 c9                	test   %cl,%cl
 493:	75 cb                	jne    460 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 495:	83 c4 3c             	add    $0x3c,%esp
 498:	5b                   	pop    %ebx
 499:	5e                   	pop    %esi
 49a:	5f                   	pop    %edi
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 4a3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 4a6:	b8 01 00 00 00       	mov    $0x1,%eax
 4ab:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4af:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b7:	89 3c 24             	mov    %edi,(%esp)
 4ba:	e8 04 fe ff ff       	call   2c3 <write>
        putc(fd, c);
 4bf:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 4c3:	ba 01 00 00 00       	mov    $0x1,%edx
 4c8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 4cb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 4cf:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 4d1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4d5:	89 3c 24             	mov    %edi,(%esp)
 4d8:	e8 e6 fd ff ff       	call   2c3 <write>
 4dd:	e9 76 ff ff ff       	jmp    458 <printf+0x48>
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4e8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 4eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f0:	8b 13                	mov    (%ebx),%edx
 4f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 4f9:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 4fc:	89 f8                	mov    %edi,%eax
 4fe:	e8 4d fe ff ff       	call   350 <printint>
        ap++;
 503:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 506:	31 db                	xor    %ebx,%ebx
 508:	e9 4b ff ff ff       	jmp    458 <printf+0x48>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 510:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 513:	8b 08                	mov    (%eax),%ecx
        ap++;
 515:	83 c0 04             	add    $0x4,%eax
 518:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 51b:	85 c9                	test   %ecx,%ecx
 51d:	0f 84 cd 00 00 00    	je     5f0 <printf+0x1e0>
        while(*s != 0){
 523:	0f b6 01             	movzbl (%ecx),%eax
 526:	84 c0                	test   %al,%al
 528:	0f 84 ce 00 00 00    	je     5fc <printf+0x1ec>
 52e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 531:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 534:	89 ce                	mov    %ecx,%esi
 536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 540:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 543:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 548:	46                   	inc    %esi
  write(fd, &c, 1);
 549:	89 44 24 08          	mov    %eax,0x8(%esp)
 54d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 551:	89 3c 24             	mov    %edi,(%esp)
 554:	e8 6a fd ff ff       	call   2c3 <write>
        while(*s != 0){
 559:	0f b6 06             	movzbl (%esi),%eax
 55c:	84 c0                	test   %al,%al
 55e:	75 e0                	jne    540 <printf+0x130>
      state = 0;
 560:	8b 75 d0             	mov    -0x30(%ebp),%esi
 563:	31 db                	xor    %ebx,%ebx
 565:	e9 ee fe ff ff       	jmp    458 <printf+0x48>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 570:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
 578:	8b 13                	mov    (%ebx),%edx
 57a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 581:	e9 73 ff ff ff       	jmp    4f9 <printf+0xe9>
 586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 590:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 593:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 598:	8b 10                	mov    (%eax),%edx
 59a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 59d:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5a1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 5a8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5af:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5b1:	89 3c 24             	mov    %edi,(%esp)
 5b4:	e8 0a fd ff ff       	call   2c3 <write>
        ap++;
 5b9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5bd:	e9 96 fe ff ff       	jmp    458 <printf+0x48>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 5c8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 5cb:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5ce:	b9 01 00 00 00       	mov    $0x1,%ecx
 5d3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5d7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5d9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5dd:	89 3c 24             	mov    %edi,(%esp)
 5e0:	e8 de fc ff ff       	call   2c3 <write>
 5e5:	e9 6e fe ff ff       	jmp    458 <printf+0x48>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5f0:	b0 28                	mov    $0x28,%al
          s = "(null)";
 5f2:	b9 ac 07 00 00       	mov    $0x7ac,%ecx
 5f7:	e9 32 ff ff ff       	jmp    52e <printf+0x11e>
      state = 0;
 5fc:	31 db                	xor    %ebx,%ebx
 5fe:	66 90                	xchg   %ax,%ax
 600:	e9 53 fe ff ff       	jmp    458 <printf+0x48>
 605:	66 90                	xchg   %ax,%ax
 607:	66 90                	xchg   %ax,%ax
 609:	66 90                	xchg   %ax,%ax
 60b:	66 90                	xchg   %ax,%ax
 60d:	66 90                	xchg   %ax,%ax
 60f:	90                   	nop

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 20 08 00 00       	mov    0x820,%eax
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 61e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop
 630:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 632:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 634:	39 ca                	cmp    %ecx,%edx
 636:	73 30                	jae    668 <free+0x58>
 638:	39 c1                	cmp    %eax,%ecx
 63a:	72 04                	jb     640 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63c:	39 c2                	cmp    %eax,%edx
 63e:	72 f0                	jb     630 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 640:	8b 73 fc             	mov    -0x4(%ebx),%esi
 643:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 646:	39 f8                	cmp    %edi,%eax
 648:	74 26                	je     670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 64a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 64d:	8b 42 04             	mov    0x4(%edx),%eax
 650:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	74 32                	je     689 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 657:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 659:	5b                   	pop    %ebx
  freep = p;
 65a:	89 15 20 08 00 00    	mov    %edx,0x820
}
 660:	5e                   	pop    %esi
 661:	5f                   	pop    %edi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 668:	39 c1                	cmp    %eax,%ecx
 66a:	72 d0                	jb     63c <free+0x2c>
 66c:	eb c2                	jmp    630 <free+0x20>
 66e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 670:	8b 78 04             	mov    0x4(%eax),%edi
 673:	01 fe                	add    %edi,%esi
 675:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 678:	8b 02                	mov    (%edx),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 67f:	8b 42 04             	mov    0x4(%edx),%eax
 682:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 685:	39 f1                	cmp    %esi,%ecx
 687:	75 ce                	jne    657 <free+0x47>
  freep = p;
 689:	89 15 20 08 00 00    	mov    %edx,0x820
    p->s.size += bp->s.size;
 68f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 692:	01 c8                	add    %ecx,%eax
 694:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 697:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 69a:	89 0a                	mov    %ecx,(%edx)
}
 69c:	5b                   	pop    %ebx
 69d:	5e                   	pop    %esi
 69e:	5f                   	pop    %edi
 69f:	5d                   	pop    %ebp
 6a0:	c3                   	ret    
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 15 20 08 00 00    	mov    0x820,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 78 07             	lea    0x7(%eax),%edi
 6c5:	c1 ef 03             	shr    $0x3,%edi
 6c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6c9:	85 d2                	test   %edx,%edx
 6cb:	0f 84 8f 00 00 00    	je     760 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d3:	8b 48 04             	mov    0x4(%eax),%ecx
 6d6:	39 f9                	cmp    %edi,%ecx
 6d8:	73 5e                	jae    738 <malloc+0x88>
  if(nu < 4096)
 6da:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6df:	39 df                	cmp    %ebx,%edi
 6e1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6e4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6eb:	eb 0c                	jmp    6f9 <malloc+0x49>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f2:	8b 48 04             	mov    0x4(%eax),%ecx
 6f5:	39 f9                	cmp    %edi,%ecx
 6f7:	73 3f                	jae    738 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f9:	39 05 20 08 00 00    	cmp    %eax,0x820
 6ff:	89 c2                	mov    %eax,%edx
 701:	75 ed                	jne    6f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 703:	89 34 24             	mov    %esi,(%esp)
 706:	e8 20 fc ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 70b:	83 f8 ff             	cmp    $0xffffffff,%eax
 70e:	74 18                	je     728 <malloc+0x78>
  hp->s.size = nu;
 710:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 713:	83 c0 08             	add    $0x8,%eax
 716:	89 04 24             	mov    %eax,(%esp)
 719:	e8 f2 fe ff ff       	call   610 <free>
  return freep;
 71e:	8b 15 20 08 00 00    	mov    0x820,%edx
      if((p = morecore(nunits)) == 0)
 724:	85 d2                	test   %edx,%edx
 726:	75 c8                	jne    6f0 <malloc+0x40>
        return 0;
  }
}
 728:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 72b:	31 c0                	xor    %eax,%eax
}
 72d:	5b                   	pop    %ebx
 72e:	5e                   	pop    %esi
 72f:	5f                   	pop    %edi
 730:	5d                   	pop    %ebp
 731:	c3                   	ret    
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 738:	39 cf                	cmp    %ecx,%edi
 73a:	74 54                	je     790 <malloc+0xe0>
        p->s.size -= nunits;
 73c:	29 f9                	sub    %edi,%ecx
 73e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 741:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 744:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 747:	89 15 20 08 00 00    	mov    %edx,0x820
}
 74d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 750:	83 c0 08             	add    $0x8,%eax
}
 753:	5b                   	pop    %ebx
 754:	5e                   	pop    %esi
 755:	5f                   	pop    %edi
 756:	5d                   	pop    %ebp
 757:	c3                   	ret    
 758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 760:	b8 24 08 00 00       	mov    $0x824,%eax
 765:	ba 24 08 00 00       	mov    $0x824,%edx
 76a:	a3 20 08 00 00       	mov    %eax,0x820
    base.s.size = 0;
 76f:	31 c9                	xor    %ecx,%ecx
 771:	b8 24 08 00 00       	mov    $0x824,%eax
    base.s.ptr = freep = prevp = &base;
 776:	89 15 24 08 00 00    	mov    %edx,0x824
    base.s.size = 0;
 77c:	89 0d 28 08 00 00    	mov    %ecx,0x828
    if(p->s.size >= nunits){
 782:	e9 53 ff ff ff       	jmp    6da <malloc+0x2a>
 787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb b1                	jmp    747 <malloc+0x97>
