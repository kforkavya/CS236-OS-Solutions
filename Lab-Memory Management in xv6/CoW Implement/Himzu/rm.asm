
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 49                	jle    5d <main+0x5d>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	eb 0f                	jmp    30 <main+0x30>
  21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  28:	46                   	inc    %esi
  29:	83 c3 04             	add    $0x4,%ebx
  2c:	39 f7                	cmp    %esi,%edi
  2e:	74 28                	je     58 <main+0x58>
    if(unlink(argv[i]) < 0){
  30:	8b 03                	mov    (%ebx),%eax
  32:	89 04 24             	mov    %eax,(%esp)
  35:	e8 d9 02 00 00       	call   313 <unlink>
  3a:	85 c0                	test   %eax,%eax
  3c:	79 ea                	jns    28 <main+0x28>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  3e:	8b 03                	mov    (%ebx),%eax
  40:	c7 44 24 04 cc 07 00 	movl   $0x7cc,0x4(%esp)
  47:	00 
  48:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 d8 03 00 00       	call   430 <printf>
      break;
    }
  }

  exit();
  58:	e8 66 02 00 00       	call   2c3 <exit>
    printf(2, "Usage: rm files...\n");
  5d:	c7 44 24 04 b8 07 00 	movl   $0x7b8,0x4(%esp)
  64:	00 
  65:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6c:	e8 bf 03 00 00       	call   430 <printf>
    exit();
  71:	e8 4d 02 00 00       	call   2c3 <exit>
  76:	66 90                	xchg   %ax,%ax
  78:	66 90                	xchg   %ax,%ax
  7a:	66 90                	xchg   %ax,%ax
  7c:	66 90                	xchg   %ax,%ax
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	40                   	inc    %eax
  98:	84 d2                	test   %dl,%dl
  9a:	75 f4                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9c:	5b                   	pop    %ebx
  9d:	89 c8                	mov    %ecx,%eax
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 15                	jne    d6 <strcmp+0x26>
  c1:	eb 30                	jmp    f3 <strcmp+0x43>
  c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c7:	90                   	nop
  c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  cc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  cf:	42                   	inc    %edx
  while(*p && *p == *q)
  d0:	84 c0                	test   %al,%al
  d2:	74 14                	je     e8 <strcmp+0x38>
    p++, q++;
  d4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  d6:	0f b6 0b             	movzbl (%ebx),%ecx
  d9:	38 c1                	cmp    %al,%cl
  db:	74 eb                	je     c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  dd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  de:	29 c8                	sub    %ecx,%eax
}
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  e8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  ec:	31 c0                	xor    %eax,%eax
}
  ee:	5b                   	pop    %ebx
  ef:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  f0:	29 c8                	sub    %ecx,%eax
}
  f2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  f3:	0f b6 0b             	movzbl (%ebx),%ecx
  f6:	31 c0                	xor    %eax,%eax
  f8:	eb e3                	jmp    dd <strcmp+0x2d>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	40                   	inc    %eax
 111:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 115:	89 c1                	mov    %eax,%ecx
 117:	75 f7                	jne    110 <strlen+0x10>
    ;
  return n;
}
 119:	5d                   	pop    %ebp
 11a:	89 c8                	mov    %ecx,%eax
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 121:	31 c9                	xor    %ecx,%ecx
}
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret    
 126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	5f                   	pop    %edi
 143:	89 d0                	mov    %edx,%eax
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 10                	jne    171 <strchr+0x21>
 161:	eb 1d                	jmp    180 <strchr+0x30>
 163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 167:	90                   	nop
 168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 16c:	40                   	inc    %eax
 16d:	84 d2                	test   %dl,%dl
 16f:	74 0f                	je     180 <strchr+0x30>
    if(*s == c)
 171:	38 d1                	cmp    %dl,%cl
 173:	75 f3                	jne    168 <strchr+0x18>
      return (char*)s;
  return 0;
}
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17e:	66 90                	xchg   %ax,%ax
 180:	5d                   	pop    %ebp
  return 0;
 181:	31 c0                	xor    %eax,%eax
}
 183:	c3                   	ret    
 184:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
    cc = read(0, &c, 1);
 198:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 19b:	83 ec 3c             	sub    $0x3c,%esp
 19e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1a1:	eb 32                	jmp    1d5 <gets+0x45>
 1a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a7:	90                   	nop
    cc = read(0, &c, 1);
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	b8 01 00 00 00       	mov    $0x1,%eax
 1b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1bc:	e8 1a 01 00 00       	call   2db <read>
    if(cc < 1)
 1c1:	85 c0                	test   %eax,%eax
 1c3:	7e 19                	jle    1de <gets+0x4e>
      break;
    buf[i++] = c;
 1c5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 10                	je     1e1 <gets+0x51>
 1d1:	3c 0d                	cmp    $0xd,%al
 1d3:	74 0c                	je     1e1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1d5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1d8:	46                   	inc    %esi
 1d9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1dc:	7c ca                	jl     1a8 <gets+0x18>
 1de:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1e1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1e5:	83 c4 3c             	add    $0x3c,%esp
 1e8:	89 d8                	mov    %ebx,%eax
 1ea:	5b                   	pop    %ebx
 1eb:	5e                   	pop    %esi
 1ec:	5f                   	pop    %edi
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret    
 1ef:	90                   	nop

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	31 c0                	xor    %eax,%eax
{
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
 1f8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	89 04 24             	mov    %eax,(%esp)
 208:	e8 f6 00 00 00       	call   303 <open>
  if(fd < 0)
 20d:	85 c0                	test   %eax,%eax
 20f:	78 2f                	js     240 <stat+0x50>
 211:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	89 1c 24             	mov    %ebx,(%esp)
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	e8 f9 00 00 00       	call   31b <fstat>
  close(fd);
 222:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 225:	89 c6                	mov    %eax,%esi
  close(fd);
 227:	e8 bf 00 00 00       	call   2eb <close>
  return r;
}
 22c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 22f:	89 f0                	mov    %esi,%eax
 231:	8b 75 fc             	mov    -0x4(%ebp),%esi
 234:	89 ec                	mov    %ebp,%esp
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
 238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb e5                	jmp    22c <stat+0x3c>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 02             	movsbl (%edx),%eax
 25a:	88 c1                	mov    %al,%cl
 25c:	80 e9 30             	sub    $0x30,%cl
 25f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 262:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 267:	77 1c                	ja     285 <atoi+0x35>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 270:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 273:	42                   	inc    %edx
 274:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 278:	0f be 02             	movsbl (%edx),%eax
 27b:	88 c3                	mov    %al,%bl
 27d:	80 eb 30             	sub    $0x30,%bl
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	5b                   	pop    %ebx
 286:	89 c8                	mov    %ecx,%eax
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	8b 45 10             	mov    0x10(%ebp),%eax
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7e 13                	jle    2b5 <memmove+0x25>
 2a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a4:	89 d7                	mov    %edx,%edi
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
  return vdst;
}
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret    

000002bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bb:	b8 01 00 00 00       	mov    $0x1,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exit>:
SYSCALL(exit)
 2c3:	b8 02 00 00 00       	mov    $0x2,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <wait>:
SYSCALL(wait)
 2cb:	b8 03 00 00 00       	mov    $0x3,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <pipe>:
SYSCALL(pipe)
 2d3:	b8 04 00 00 00       	mov    $0x4,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <read>:
SYSCALL(read)
 2db:	b8 05 00 00 00       	mov    $0x5,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <write>:
SYSCALL(write)
 2e3:	b8 10 00 00 00       	mov    $0x10,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <close>:
SYSCALL(close)
 2eb:	b8 15 00 00 00       	mov    $0x15,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <kill>:
SYSCALL(kill)
 2f3:	b8 06 00 00 00       	mov    $0x6,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <exec>:
SYSCALL(exec)
 2fb:	b8 07 00 00 00       	mov    $0x7,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <open>:
SYSCALL(open)
 303:	b8 0f 00 00 00       	mov    $0xf,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mknod>:
SYSCALL(mknod)
 30b:	b8 11 00 00 00       	mov    $0x11,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <unlink>:
SYSCALL(unlink)
 313:	b8 12 00 00 00       	mov    $0x12,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <fstat>:
SYSCALL(fstat)
 31b:	b8 08 00 00 00       	mov    $0x8,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <link>:
SYSCALL(link)
 323:	b8 13 00 00 00       	mov    $0x13,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mkdir>:
SYSCALL(mkdir)
 32b:	b8 14 00 00 00       	mov    $0x14,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <chdir>:
SYSCALL(chdir)
 333:	b8 09 00 00 00       	mov    $0x9,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <dup>:
SYSCALL(dup)
 33b:	b8 0a 00 00 00       	mov    $0xa,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <getpid>:
SYSCALL(getpid)
 343:	b8 0b 00 00 00       	mov    $0xb,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sbrk>:
SYSCALL(sbrk)
 34b:	b8 0c 00 00 00       	mov    $0xc,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <sleep>:
SYSCALL(sleep)
 353:	b8 0d 00 00 00       	mov    $0xd,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <uptime>:
SYSCALL(uptime)
 35b:	b8 0e 00 00 00       	mov    $0xe,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getNumFreePages>:
 363:	b8 16 00 00 00       	mov    $0x16,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	90                   	nop

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 cb                	mov    %ecx,%ebx
 378:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 37b:	89 d1                	mov    %edx,%ecx
{
 37d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 380:	89 d0                	mov    %edx,%eax
 382:	c1 e8 1f             	shr    $0x1f,%eax
 385:	84 c0                	test   %al,%al
 387:	0f 84 93 00 00 00    	je     420 <printint+0xb0>
 38d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 391:	0f 84 89 00 00 00    	je     420 <printint+0xb0>
    x = -xx;
 397:	f7 d9                	neg    %ecx
    neg = 1;
 399:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 39e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3a5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3a8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3af:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3b0:	89 c8                	mov    %ecx,%eax
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3b7:	f7 f3                	div    %ebx
 3b9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3bc:	0f b6 92 44 08 00 00 	movzbl 0x844(%edx),%edx
 3c3:	8d 47 01             	lea    0x1(%edi),%eax
 3c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3c9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3cd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3cf:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	73 da                	jae    3b0 <printint+0x40>
  if(neg)
 3d6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3d9:	85 c0                	test   %eax,%eax
 3db:	74 0a                	je     3e7 <printint+0x77>
    buf[i++] = '-';
 3dd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3e0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3e5:	89 c7                	mov    %eax,%edi
 3e7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3ea:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3ee:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 3f0:	0f b6 07             	movzbl (%edi),%eax
 3f3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3f6:	b8 01 00 00 00       	mov    $0x1,%eax
 3fb:	89 44 24 08          	mov    %eax,0x8(%esp)
 3ff:	89 74 24 04          	mov    %esi,0x4(%esp)
 403:	8b 45 bc             	mov    -0x44(%ebp),%eax
 406:	89 04 24             	mov    %eax,(%esp)
 409:	e8 d5 fe ff ff       	call   2e3 <write>
  while(--i >= 0)
 40e:	89 f8                	mov    %edi,%eax
 410:	4f                   	dec    %edi
 411:	39 d8                	cmp    %ebx,%eax
 413:	75 db                	jne    3f0 <printint+0x80>
}
 415:	83 c4 4c             	add    $0x4c,%esp
 418:	5b                   	pop    %ebx
 419:	5e                   	pop    %esi
 41a:	5f                   	pop    %edi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 420:	31 c0                	xor    %eax,%eax
 422:	e9 77 ff ff ff       	jmp    39e <printint+0x2e>
 427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42e:	66 90                	xchg   %ax,%ax

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 43c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 43f:	0f b6 1e             	movzbl (%esi),%ebx
 442:	84 db                	test   %bl,%bl
 444:	74 6f                	je     4b5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 446:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 449:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 44b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 44e:	88 d9                	mov    %bl,%cl
 450:	46                   	inc    %esi
 451:	89 d3                	mov    %edx,%ebx
 453:	eb 2b                	jmp    480 <printf+0x50>
 455:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 458:	83 f8 25             	cmp    $0x25,%eax
 45b:	74 4b                	je     4a8 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 45d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 460:	b8 01 00 00 00       	mov    $0x1,%eax
 465:	89 44 24 08          	mov    %eax,0x8(%esp)
 469:	8d 45 e7             	lea    -0x19(%ebp),%eax
 46c:	89 44 24 04          	mov    %eax,0x4(%esp)
 470:	89 3c 24             	mov    %edi,(%esp)
 473:	e8 6b fe ff ff       	call   2e3 <write>
  for(i = 0; fmt[i]; i++){
 478:	0f b6 0e             	movzbl (%esi),%ecx
 47b:	46                   	inc    %esi
 47c:	84 c9                	test   %cl,%cl
 47e:	74 35                	je     4b5 <printf+0x85>
    if(state == 0){
 480:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 482:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 485:	74 d1                	je     458 <printf+0x28>
      }
    } else if(state == '%'){
 487:	83 fb 25             	cmp    $0x25,%ebx
 48a:	75 ec                	jne    478 <printf+0x48>
      if(c == 'd'){
 48c:	83 f8 25             	cmp    $0x25,%eax
 48f:	0f 84 53 01 00 00    	je     5e8 <printf+0x1b8>
 495:	83 e8 63             	sub    $0x63,%eax
 498:	83 f8 15             	cmp    $0x15,%eax
 49b:	77 23                	ja     4c0 <printf+0x90>
 49d:	ff 24 85 ec 07 00 00 	jmp    *0x7ec(,%eax,4)
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4a8:	0f b6 0e             	movzbl (%esi),%ecx
 4ab:	46                   	inc    %esi
        state = '%';
 4ac:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 4b1:	84 c9                	test   %cl,%cl
 4b3:	75 cb                	jne    480 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b5:	83 c4 3c             	add    $0x3c,%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 4c3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 4c6:	b8 01 00 00 00       	mov    $0x1,%eax
 4cb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4cf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d7:	89 3c 24             	mov    %edi,(%esp)
 4da:	e8 04 fe ff ff       	call   2e3 <write>
        putc(fd, c);
 4df:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 4e3:	ba 01 00 00 00       	mov    $0x1,%edx
 4e8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 4eb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 4ef:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 4f1:	89 54 24 08          	mov    %edx,0x8(%esp)
 4f5:	89 3c 24             	mov    %edi,(%esp)
 4f8:	e8 e6 fd ff ff       	call   2e3 <write>
 4fd:	e9 76 ff ff ff       	jmp    478 <printf+0x48>
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 508:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 50b:	b9 10 00 00 00       	mov    $0x10,%ecx
 510:	8b 13                	mov    (%ebx),%edx
 512:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 519:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 51c:	89 f8                	mov    %edi,%eax
 51e:	e8 4d fe ff ff       	call   370 <printint>
        ap++;
 523:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 526:	31 db                	xor    %ebx,%ebx
 528:	e9 4b ff ff ff       	jmp    478 <printf+0x48>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 530:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 533:	8b 08                	mov    (%eax),%ecx
        ap++;
 535:	83 c0 04             	add    $0x4,%eax
 538:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 53b:	85 c9                	test   %ecx,%ecx
 53d:	0f 84 cd 00 00 00    	je     610 <printf+0x1e0>
        while(*s != 0){
 543:	0f b6 01             	movzbl (%ecx),%eax
 546:	84 c0                	test   %al,%al
 548:	0f 84 ce 00 00 00    	je     61c <printf+0x1ec>
 54e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 551:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 554:	89 ce                	mov    %ecx,%esi
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 560:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 563:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 568:	46                   	inc    %esi
  write(fd, &c, 1);
 569:	89 44 24 08          	mov    %eax,0x8(%esp)
 56d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 571:	89 3c 24             	mov    %edi,(%esp)
 574:	e8 6a fd ff ff       	call   2e3 <write>
        while(*s != 0){
 579:	0f b6 06             	movzbl (%esi),%eax
 57c:	84 c0                	test   %al,%al
 57e:	75 e0                	jne    560 <printf+0x130>
      state = 0;
 580:	8b 75 d0             	mov    -0x30(%ebp),%esi
 583:	31 db                	xor    %ebx,%ebx
 585:	e9 ee fe ff ff       	jmp    478 <printf+0x48>
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 590:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
 598:	8b 13                	mov    (%ebx),%edx
 59a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a1:	e9 73 ff ff ff       	jmp    519 <printf+0xe9>
 5a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5b3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 5b8:	8b 10                	mov    (%eax),%edx
 5ba:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5bd:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5c1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5c4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 5c8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5cb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5cf:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5d1:	89 3c 24             	mov    %edi,(%esp)
 5d4:	e8 0a fd ff ff       	call   2e3 <write>
        ap++;
 5d9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5dd:	e9 96 fe ff ff       	jmp    478 <printf+0x48>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 5e8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 5eb:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5ee:	b9 01 00 00 00       	mov    $0x1,%ecx
 5f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5f7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5f9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5fd:	89 3c 24             	mov    %edi,(%esp)
 600:	e8 de fc ff ff       	call   2e3 <write>
 605:	e9 6e fe ff ff       	jmp    478 <printf+0x48>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 610:	b0 28                	mov    $0x28,%al
          s = "(null)";
 612:	b9 e5 07 00 00       	mov    $0x7e5,%ecx
 617:	e9 32 ff ff ff       	jmp    54e <printf+0x11e>
      state = 0;
 61c:	31 db                	xor    %ebx,%ebx
 61e:	66 90                	xchg   %ax,%ax
 620:	e9 53 fe ff ff       	jmp    478 <printf+0x48>
 625:	66 90                	xchg   %ax,%ax
 627:	66 90                	xchg   %ax,%ax
 629:	66 90                	xchg   %ax,%ax
 62b:	66 90                	xchg   %ax,%ax
 62d:	66 90                	xchg   %ax,%ax
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 58 08 00 00       	mov    0x858,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
 650:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 652:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 654:	39 ca                	cmp    %ecx,%edx
 656:	73 30                	jae    688 <free+0x58>
 658:	39 c1                	cmp    %eax,%ecx
 65a:	72 04                	jb     660 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65c:	39 c2                	cmp    %eax,%edx
 65e:	72 f0                	jb     650 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 660:	8b 73 fc             	mov    -0x4(%ebx),%esi
 663:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 666:	39 f8                	cmp    %edi,%eax
 668:	74 26                	je     690 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 66a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 66d:	8b 42 04             	mov    0x4(%edx),%eax
 670:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 673:	39 f1                	cmp    %esi,%ecx
 675:	74 32                	je     6a9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 677:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 679:	5b                   	pop    %ebx
  freep = p;
 67a:	89 15 58 08 00 00    	mov    %edx,0x858
}
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 688:	39 c1                	cmp    %eax,%ecx
 68a:	72 d0                	jb     65c <free+0x2c>
 68c:	eb c2                	jmp    650 <free+0x20>
 68e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 690:	8b 78 04             	mov    0x4(%eax),%edi
 693:	01 fe                	add    %edi,%esi
 695:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	8b 02                	mov    (%edx),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 69f:	8b 42 04             	mov    0x4(%edx),%eax
 6a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a5:	39 f1                	cmp    %esi,%ecx
 6a7:	75 ce                	jne    677 <free+0x47>
  freep = p;
 6a9:	89 15 58 08 00 00    	mov    %edx,0x858
    p->s.size += bp->s.size;
 6af:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6b2:	01 c8                	add    %ecx,%eax
 6b4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6b7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6ba:	89 0a                	mov    %ecx,(%edx)
}
 6bc:	5b                   	pop    %ebx
 6bd:	5e                   	pop    %esi
 6be:	5f                   	pop    %edi
 6bf:	5d                   	pop    %ebp
 6c0:	c3                   	ret    
 6c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 15 58 08 00 00    	mov    0x858,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 78 07             	lea    0x7(%eax),%edi
 6e5:	c1 ef 03             	shr    $0x3,%edi
 6e8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6e9:	85 d2                	test   %edx,%edx
 6eb:	0f 84 8f 00 00 00    	je     780 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f3:	8b 48 04             	mov    0x4(%eax),%ecx
 6f6:	39 f9                	cmp    %edi,%ecx
 6f8:	73 5e                	jae    758 <malloc+0x88>
  if(nu < 4096)
 6fa:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6ff:	39 df                	cmp    %ebx,%edi
 701:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 704:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 70b:	eb 0c                	jmp    719 <malloc+0x49>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 712:	8b 48 04             	mov    0x4(%eax),%ecx
 715:	39 f9                	cmp    %edi,%ecx
 717:	73 3f                	jae    758 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 719:	39 05 58 08 00 00    	cmp    %eax,0x858
 71f:	89 c2                	mov    %eax,%edx
 721:	75 ed                	jne    710 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 723:	89 34 24             	mov    %esi,(%esp)
 726:	e8 20 fc ff ff       	call   34b <sbrk>
  if(p == (char*)-1)
 72b:	83 f8 ff             	cmp    $0xffffffff,%eax
 72e:	74 18                	je     748 <malloc+0x78>
  hp->s.size = nu;
 730:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 733:	83 c0 08             	add    $0x8,%eax
 736:	89 04 24             	mov    %eax,(%esp)
 739:	e8 f2 fe ff ff       	call   630 <free>
  return freep;
 73e:	8b 15 58 08 00 00    	mov    0x858,%edx
      if((p = morecore(nunits)) == 0)
 744:	85 d2                	test   %edx,%edx
 746:	75 c8                	jne    710 <malloc+0x40>
        return 0;
  }
}
 748:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 74b:	31 c0                	xor    %eax,%eax
}
 74d:	5b                   	pop    %ebx
 74e:	5e                   	pop    %esi
 74f:	5f                   	pop    %edi
 750:	5d                   	pop    %ebp
 751:	c3                   	ret    
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 758:	39 cf                	cmp    %ecx,%edi
 75a:	74 54                	je     7b0 <malloc+0xe0>
        p->s.size -= nunits;
 75c:	29 f9                	sub    %edi,%ecx
 75e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 761:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 764:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 767:	89 15 58 08 00 00    	mov    %edx,0x858
}
 76d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 770:	83 c0 08             	add    $0x8,%eax
}
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
 778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 780:	b8 5c 08 00 00       	mov    $0x85c,%eax
 785:	ba 5c 08 00 00       	mov    $0x85c,%edx
 78a:	a3 58 08 00 00       	mov    %eax,0x858
    base.s.size = 0;
 78f:	31 c9                	xor    %ecx,%ecx
 791:	b8 5c 08 00 00       	mov    $0x85c,%eax
    base.s.ptr = freep = prevp = &base;
 796:	89 15 5c 08 00 00    	mov    %edx,0x85c
    base.s.size = 0;
 79c:	89 0d 60 08 00 00    	mov    %ecx,0x860
    if(p->s.size >= nunits){
 7a2:	e9 53 ff ff ff       	jmp    6fa <malloc+0x2a>
 7a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ae:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b1                	jmp    767 <malloc+0x97>
