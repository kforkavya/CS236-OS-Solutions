
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 5d 02 00 00       	call   26b <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 e5 02 00 00       	call   303 <sleep>
  exit();
  1e:	e8 50 02 00 00       	call   273 <exit>
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	40                   	inc    %eax
  48:	84 d2                	test   %dl,%dl
  4a:	75 f4                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4c:	5b                   	pop    %ebx
  4d:	89 c8                	mov    %ecx,%eax
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    
  51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5f:	90                   	nop

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 15                	jne    86 <strcmp+0x26>
  71:	eb 30                	jmp    a3 <strcmp+0x43>
  73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  77:	90                   	nop
  78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  7c:	8d 4b 01             	lea    0x1(%ebx),%ecx
  7f:	42                   	inc    %edx
  while(*p && *p == *q)
  80:	84 c0                	test   %al,%al
  82:	74 14                	je     98 <strcmp+0x38>
    p++, q++;
  84:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  86:	0f b6 0b             	movzbl (%ebx),%ecx
  89:	38 c1                	cmp    %al,%cl
  8b:	74 eb                	je     78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  8d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  8e:	29 c8                	sub    %ecx,%eax
}
  90:	5d                   	pop    %ebp
  91:	c3                   	ret    
  92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  98:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  9c:	31 c0                	xor    %eax,%eax
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  a0:	29 c8                	sub    %ecx,%eax
}
  a2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  a3:	0f b6 0b             	movzbl (%ebx),%ecx
  a6:	31 c0                	xor    %eax,%eax
  a8:	eb e3                	jmp    8d <strcmp+0x2d>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 3a 00             	cmpb   $0x0,(%edx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 c0                	xor    %eax,%eax
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	40                   	inc    %eax
  c1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  c5:	89 c1                	mov    %eax,%ecx
  c7:	75 f7                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  c9:	5d                   	pop    %ebp
  ca:	89 c8                	mov    %ecx,%eax
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  d1:	31 c9                	xor    %ecx,%ecx
}
  d3:	89 c8                	mov    %ecx,%eax
  d5:	c3                   	ret    
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	5f                   	pop    %edi
  f3:	89 d0                	mov    %edx,%eax
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fe:	66 90                	xchg   %ax,%ax

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 10                	jne    121 <strchr+0x21>
 111:	eb 1d                	jmp    130 <strchr+0x30>
 113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 117:	90                   	nop
 118:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 11c:	40                   	inc    %eax
 11d:	84 d2                	test   %dl,%dl
 11f:	74 0f                	je     130 <strchr+0x30>
    if(*s == c)
 121:	38 d1                	cmp    %dl,%cl
 123:	75 f3                	jne    118 <strchr+0x18>
      return (char*)s;
  return 0;
}
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax
 130:	5d                   	pop    %ebp
  return 0;
 131:	31 c0                	xor    %eax,%eax
}
 133:	c3                   	ret    
 134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
    cc = read(0, &c, 1);
 148:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 14b:	83 ec 3c             	sub    $0x3c,%esp
 14e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 151:	eb 32                	jmp    185 <gets+0x45>
 153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 157:	90                   	nop
    cc = read(0, &c, 1);
 158:	89 7c 24 04          	mov    %edi,0x4(%esp)
 15c:	b8 01 00 00 00       	mov    $0x1,%eax
 161:	89 44 24 08          	mov    %eax,0x8(%esp)
 165:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 16c:	e8 1a 01 00 00       	call   28b <read>
    if(cc < 1)
 171:	85 c0                	test   %eax,%eax
 173:	7e 19                	jle    18e <gets+0x4e>
      break;
    buf[i++] = c;
 175:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 179:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 17d:	3c 0a                	cmp    $0xa,%al
 17f:	74 10                	je     191 <gets+0x51>
 181:	3c 0d                	cmp    $0xd,%al
 183:	74 0c                	je     191 <gets+0x51>
  for(i=0; i+1 < max; ){
 185:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 188:	46                   	inc    %esi
 189:	3b 75 0c             	cmp    0xc(%ebp),%esi
 18c:	7c ca                	jl     158 <gets+0x18>
 18e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 191:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 195:	83 c4 3c             	add    $0x3c,%esp
 198:	89 d8                	mov    %ebx,%eax
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 18             	sub    $0x18,%esp
 1a8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1ab:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b2:	8b 45 08             	mov    0x8(%ebp),%eax
 1b5:	89 04 24             	mov    %eax,(%esp)
 1b8:	e8 f6 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1bd:	85 c0                	test   %eax,%eax
 1bf:	78 2f                	js     1f0 <stat+0x50>
 1c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c6:	89 1c 24             	mov    %ebx,(%esp)
 1c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cd:	e8 f9 00 00 00       	call   2cb <fstat>
  close(fd);
 1d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1d5:	89 c6                	mov    %eax,%esi
  close(fd);
 1d7:	e8 bf 00 00 00       	call   29b <close>
  return r;
}
 1dc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1df:	89 f0                	mov    %esi,%eax
 1e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1e4:	89 ec                	mov    %ebp,%esp
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb e5                	jmp    1dc <stat+0x3c>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	88 c1                	mov    %al,%cl
 20c:	80 e9 30             	sub    $0x30,%cl
 20f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 212:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 217:	77 1c                	ja     235 <atoi+0x35>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 220:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 223:	42                   	inc    %edx
 224:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 228:	0f be 02             	movsbl (%edx),%eax
 22b:	88 c3                	mov    %al,%bl
 22d:	80 eb 30             	sub    $0x30,%bl
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	5b                   	pop    %ebx
 236:	89 c8                	mov    %ecx,%eax
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	8b 45 10             	mov    0x10(%ebp),%eax
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <getNumFreePages>:
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	89 cb                	mov    %ecx,%ebx
 328:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 32b:	89 d1                	mov    %edx,%ecx
{
 32d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 330:	89 d0                	mov    %edx,%eax
 332:	c1 e8 1f             	shr    $0x1f,%eax
 335:	84 c0                	test   %al,%al
 337:	0f 84 93 00 00 00    	je     3d0 <printint+0xb0>
 33d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 341:	0f 84 89 00 00 00    	je     3d0 <printint+0xb0>
    x = -xx;
 347:	f7 d9                	neg    %ecx
    neg = 1;
 349:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 34e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 355:	8d 75 d7             	lea    -0x29(%ebp),%esi
 358:	89 45 b8             	mov    %eax,-0x48(%ebp)
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 360:	89 c8                	mov    %ecx,%eax
 362:	31 d2                	xor    %edx,%edx
 364:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 367:	f7 f3                	div    %ebx
 369:	89 45 c0             	mov    %eax,-0x40(%ebp)
 36c:	0f b6 92 c8 07 00 00 	movzbl 0x7c8(%edx),%edx
 373:	8d 47 01             	lea    0x1(%edi),%eax
 376:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 379:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 37d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 37f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 382:	39 da                	cmp    %ebx,%edx
 384:	73 da                	jae    360 <printint+0x40>
  if(neg)
 386:	8b 45 b8             	mov    -0x48(%ebp),%eax
 389:	85 c0                	test   %eax,%eax
 38b:	74 0a                	je     397 <printint+0x77>
    buf[i++] = '-';
 38d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 390:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 395:	89 c7                	mov    %eax,%edi
 397:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 39a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 39e:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 3a0:	0f b6 07             	movzbl (%edi),%eax
 3a3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3a6:	b8 01 00 00 00       	mov    $0x1,%eax
 3ab:	89 44 24 08          	mov    %eax,0x8(%esp)
 3af:	89 74 24 04          	mov    %esi,0x4(%esp)
 3b3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 3b6:	89 04 24             	mov    %eax,(%esp)
 3b9:	e8 d5 fe ff ff       	call   293 <write>
  while(--i >= 0)
 3be:	89 f8                	mov    %edi,%eax
 3c0:	4f                   	dec    %edi
 3c1:	39 d8                	cmp    %ebx,%eax
 3c3:	75 db                	jne    3a0 <printint+0x80>
}
 3c5:	83 c4 4c             	add    $0x4c,%esp
 3c8:	5b                   	pop    %ebx
 3c9:	5e                   	pop    %esi
 3ca:	5f                   	pop    %edi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 3d0:	31 c0                	xor    %eax,%eax
 3d2:	e9 77 ff ff ff       	jmp    34e <printint+0x2e>
 3d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3de:	66 90                	xchg   %ax,%ax

000003e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 3ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 3ef:	0f b6 1e             	movzbl (%esi),%ebx
 3f2:	84 db                	test   %bl,%bl
 3f4:	74 6f                	je     465 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 3f6:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 3f9:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 3fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 3fe:	88 d9                	mov    %bl,%cl
 400:	46                   	inc    %esi
 401:	89 d3                	mov    %edx,%ebx
 403:	eb 2b                	jmp    430 <printf+0x50>
 405:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 f8 25             	cmp    $0x25,%eax
 40b:	74 4b                	je     458 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 40d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 410:	b8 01 00 00 00       	mov    $0x1,%eax
 415:	89 44 24 08          	mov    %eax,0x8(%esp)
 419:	8d 45 e7             	lea    -0x19(%ebp),%eax
 41c:	89 44 24 04          	mov    %eax,0x4(%esp)
 420:	89 3c 24             	mov    %edi,(%esp)
 423:	e8 6b fe ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 428:	0f b6 0e             	movzbl (%esi),%ecx
 42b:	46                   	inc    %esi
 42c:	84 c9                	test   %cl,%cl
 42e:	74 35                	je     465 <printf+0x85>
    if(state == 0){
 430:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 432:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 435:	74 d1                	je     408 <printf+0x28>
      }
    } else if(state == '%'){
 437:	83 fb 25             	cmp    $0x25,%ebx
 43a:	75 ec                	jne    428 <printf+0x48>
      if(c == 'd'){
 43c:	83 f8 25             	cmp    $0x25,%eax
 43f:	0f 84 53 01 00 00    	je     598 <printf+0x1b8>
 445:	83 e8 63             	sub    $0x63,%eax
 448:	83 f8 15             	cmp    $0x15,%eax
 44b:	77 23                	ja     470 <printf+0x90>
 44d:	ff 24 85 70 07 00 00 	jmp    *0x770(,%eax,4)
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 458:	0f b6 0e             	movzbl (%esi),%ecx
 45b:	46                   	inc    %esi
        state = '%';
 45c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 461:	84 c9                	test   %cl,%cl
 463:	75 cb                	jne    430 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 465:	83 c4 3c             	add    $0x3c,%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 473:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 476:	b8 01 00 00 00       	mov    $0x1,%eax
 47b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 47f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 483:	89 44 24 08          	mov    %eax,0x8(%esp)
 487:	89 3c 24             	mov    %edi,(%esp)
 48a:	e8 04 fe ff ff       	call   293 <write>
        putc(fd, c);
 48f:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 493:	ba 01 00 00 00       	mov    $0x1,%edx
 498:	88 4d e7             	mov    %cl,-0x19(%ebp)
 49b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 49f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 4a1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4a5:	89 3c 24             	mov    %edi,(%esp)
 4a8:	e8 e6 fd ff ff       	call   293 <write>
 4ad:	e9 76 ff ff ff       	jmp    428 <printf+0x48>
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4b8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 4bb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4c0:	8b 13                	mov    (%ebx),%edx
 4c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 4c9:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 4cc:	89 f8                	mov    %edi,%eax
 4ce:	e8 4d fe ff ff       	call   320 <printint>
        ap++;
 4d3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 4d6:	31 db                	xor    %ebx,%ebx
 4d8:	e9 4b ff ff ff       	jmp    428 <printf+0x48>
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 4e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e3:	8b 08                	mov    (%eax),%ecx
        ap++;
 4e5:	83 c0 04             	add    $0x4,%eax
 4e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4eb:	85 c9                	test   %ecx,%ecx
 4ed:	0f 84 cd 00 00 00    	je     5c0 <printf+0x1e0>
        while(*s != 0){
 4f3:	0f b6 01             	movzbl (%ecx),%eax
 4f6:	84 c0                	test   %al,%al
 4f8:	0f 84 ce 00 00 00    	je     5cc <printf+0x1ec>
 4fe:	89 75 d0             	mov    %esi,-0x30(%ebp)
 501:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 504:	89 ce                	mov    %ecx,%esi
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 510:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 513:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 518:	46                   	inc    %esi
  write(fd, &c, 1);
 519:	89 44 24 08          	mov    %eax,0x8(%esp)
 51d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 521:	89 3c 24             	mov    %edi,(%esp)
 524:	e8 6a fd ff ff       	call   293 <write>
        while(*s != 0){
 529:	0f b6 06             	movzbl (%esi),%eax
 52c:	84 c0                	test   %al,%al
 52e:	75 e0                	jne    510 <printf+0x130>
      state = 0;
 530:	8b 75 d0             	mov    -0x30(%ebp),%esi
 533:	31 db                	xor    %ebx,%ebx
 535:	e9 ee fe ff ff       	jmp    428 <printf+0x48>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 540:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 543:	b9 0a 00 00 00       	mov    $0xa,%ecx
 548:	8b 13                	mov    (%ebx),%edx
 54a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 551:	e9 73 ff ff ff       	jmp    4c9 <printf+0xe9>
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 560:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 563:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 568:	8b 10                	mov    (%eax),%edx
 56a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 56d:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 571:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 574:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 578:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 57b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 57f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 581:	89 3c 24             	mov    %edi,(%esp)
 584:	e8 0a fd ff ff       	call   293 <write>
        ap++;
 589:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 58d:	e9 96 fe ff ff       	jmp    428 <printf+0x48>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 598:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 59b:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 59e:	b9 01 00 00 00       	mov    $0x1,%ecx
 5a3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5a7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5a9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5ad:	89 3c 24             	mov    %edi,(%esp)
 5b0:	e8 de fc ff ff       	call   293 <write>
 5b5:	e9 6e fe ff ff       	jmp    428 <printf+0x48>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5c0:	b0 28                	mov    $0x28,%al
          s = "(null)";
 5c2:	b9 68 07 00 00       	mov    $0x768,%ecx
 5c7:	e9 32 ff ff ff       	jmp    4fe <printf+0x11e>
      state = 0;
 5cc:	31 db                	xor    %ebx,%ebx
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	e9 53 fe ff ff       	jmp    428 <printf+0x48>
 5d5:	66 90                	xchg   %ax,%ax
 5d7:	66 90                	xchg   %ax,%ax
 5d9:	66 90                	xchg   %ax,%ax
 5db:	66 90                	xchg   %ax,%ax
 5dd:	66 90                	xchg   %ax,%ax
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 dc 07 00 00       	mov    0x7dc,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
 600:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 602:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 604:	39 ca                	cmp    %ecx,%edx
 606:	73 30                	jae    638 <free+0x58>
 608:	39 c1                	cmp    %eax,%ecx
 60a:	72 04                	jb     610 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60c:	39 c2                	cmp    %eax,%edx
 60e:	72 f0                	jb     600 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 610:	8b 73 fc             	mov    -0x4(%ebx),%esi
 613:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 616:	39 f8                	cmp    %edi,%eax
 618:	74 26                	je     640 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 61a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 61d:	8b 42 04             	mov    0x4(%edx),%eax
 620:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 623:	39 f1                	cmp    %esi,%ecx
 625:	74 32                	je     659 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 627:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 629:	5b                   	pop    %ebx
  freep = p;
 62a:	89 15 dc 07 00 00    	mov    %edx,0x7dc
}
 630:	5e                   	pop    %esi
 631:	5f                   	pop    %edi
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	39 c1                	cmp    %eax,%ecx
 63a:	72 d0                	jb     60c <free+0x2c>
 63c:	eb c2                	jmp    600 <free+0x20>
 63e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 640:	8b 78 04             	mov    0x4(%eax),%edi
 643:	01 fe                	add    %edi,%esi
 645:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 648:	8b 02                	mov    (%edx),%eax
 64a:	8b 00                	mov    (%eax),%eax
 64c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 64f:	8b 42 04             	mov    0x4(%edx),%eax
 652:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 655:	39 f1                	cmp    %esi,%ecx
 657:	75 ce                	jne    627 <free+0x47>
  freep = p;
 659:	89 15 dc 07 00 00    	mov    %edx,0x7dc
    p->s.size += bp->s.size;
 65f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 662:	01 c8                	add    %ecx,%eax
 664:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 667:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 66a:	89 0a                	mov    %ecx,(%edx)
}
 66c:	5b                   	pop    %ebx
 66d:	5e                   	pop    %esi
 66e:	5f                   	pop    %edi
 66f:	5d                   	pop    %ebp
 670:	c3                   	ret    
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 68c:	8b 15 dc 07 00 00    	mov    0x7dc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	8d 78 07             	lea    0x7(%eax),%edi
 695:	c1 ef 03             	shr    $0x3,%edi
 698:	47                   	inc    %edi
  if((prevp = freep) == 0){
 699:	85 d2                	test   %edx,%edx
 69b:	0f 84 8f 00 00 00    	je     730 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6a1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6a3:	8b 48 04             	mov    0x4(%eax),%ecx
 6a6:	39 f9                	cmp    %edi,%ecx
 6a8:	73 5e                	jae    708 <malloc+0x88>
  if(nu < 4096)
 6aa:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6af:	39 df                	cmp    %ebx,%edi
 6b1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6b4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6bb:	eb 0c                	jmp    6c9 <malloc+0x49>
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6c2:	8b 48 04             	mov    0x4(%eax),%ecx
 6c5:	39 f9                	cmp    %edi,%ecx
 6c7:	73 3f                	jae    708 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6c9:	39 05 dc 07 00 00    	cmp    %eax,0x7dc
 6cf:	89 c2                	mov    %eax,%edx
 6d1:	75 ed                	jne    6c0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 6d3:	89 34 24             	mov    %esi,(%esp)
 6d6:	e8 20 fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 6db:	83 f8 ff             	cmp    $0xffffffff,%eax
 6de:	74 18                	je     6f8 <malloc+0x78>
  hp->s.size = nu;
 6e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6e3:	83 c0 08             	add    $0x8,%eax
 6e6:	89 04 24             	mov    %eax,(%esp)
 6e9:	e8 f2 fe ff ff       	call   5e0 <free>
  return freep;
 6ee:	8b 15 dc 07 00 00    	mov    0x7dc,%edx
      if((p = morecore(nunits)) == 0)
 6f4:	85 d2                	test   %edx,%edx
 6f6:	75 c8                	jne    6c0 <malloc+0x40>
        return 0;
  }
}
 6f8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 6fb:	31 c0                	xor    %eax,%eax
}
 6fd:	5b                   	pop    %ebx
 6fe:	5e                   	pop    %esi
 6ff:	5f                   	pop    %edi
 700:	5d                   	pop    %ebp
 701:	c3                   	ret    
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 708:	39 cf                	cmp    %ecx,%edi
 70a:	74 54                	je     760 <malloc+0xe0>
        p->s.size -= nunits;
 70c:	29 f9                	sub    %edi,%ecx
 70e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 711:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 714:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 717:	89 15 dc 07 00 00    	mov    %edx,0x7dc
}
 71d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 720:	83 c0 08             	add    $0x8,%eax
}
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 730:	b8 e0 07 00 00       	mov    $0x7e0,%eax
 735:	ba e0 07 00 00       	mov    $0x7e0,%edx
 73a:	a3 dc 07 00 00       	mov    %eax,0x7dc
    base.s.size = 0;
 73f:	31 c9                	xor    %ecx,%ecx
 741:	b8 e0 07 00 00       	mov    $0x7e0,%eax
    base.s.ptr = freep = prevp = &base;
 746:	89 15 e0 07 00 00    	mov    %edx,0x7e0
    base.s.size = 0;
 74c:	89 0d e4 07 00 00    	mov    %ecx,0x7e4
    if(p->s.size >= nunits){
 752:	e9 53 ff ff ff       	jmp    6aa <malloc+0x2a>
 757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 760:	8b 08                	mov    (%eax),%ecx
 762:	89 0a                	mov    %ecx,(%edx)
 764:	eb b1                	jmp    717 <malloc+0x97>
