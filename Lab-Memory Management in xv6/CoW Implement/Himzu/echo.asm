
_echo:     file format elf32-i386


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
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  for(i = 1; i < argc; i++)
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 66                	jle    7d <main+0x7d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  17:	83 fe 02             	cmp    $0x2,%esi
  1a:	8b 47 04             	mov    0x4(%edi),%eax
  1d:	74 3c                	je     5b <main+0x5b>
  1f:	bb 02 00 00 00       	mov    $0x2,%ebx
  24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop
  30:	89 44 24 08          	mov    %eax,0x8(%esp)
  34:	ba c8 07 00 00       	mov    $0x7c8,%edx
  39:	b9 ca 07 00 00       	mov    $0x7ca,%ecx
  3e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  42:	43                   	inc    %ebx
  43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 ed 03 00 00       	call   440 <printf>
  53:	39 f3                	cmp    %esi,%ebx
  55:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  59:	75 d5                	jne    30 <main+0x30>
  5b:	89 44 24 08          	mov    %eax,0x8(%esp)
  5f:	ba cf 07 00 00       	mov    $0x7cf,%edx
  64:	b9 ca 07 00 00       	mov    $0x7ca,%ecx
  69:	89 54 24 0c          	mov    %edx,0xc(%esp)
  6d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 c3 03 00 00       	call   440 <printf>
  exit();
  7d:	e8 51 02 00 00       	call   2d3 <exit>
  82:	66 90                	xchg   %ax,%ax
  84:	66 90                	xchg   %ax,%ax
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  91:	31 c0                	xor    %eax,%eax
{
  93:	89 e5                	mov    %esp,%ebp
  95:	53                   	push   %ebx
  96:	8b 4d 08             	mov    0x8(%ebp),%ecx
  99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  a7:	40                   	inc    %eax
  a8:	84 d2                	test   %dl,%dl
  aa:	75 f4                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  ac:	5b                   	pop    %ebx
  ad:	89 c8                	mov    %ecx,%eax
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    
  b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bf:	90                   	nop

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
  c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ca:	0f b6 02             	movzbl (%edx),%eax
  cd:	84 c0                	test   %al,%al
  cf:	75 15                	jne    e6 <strcmp+0x26>
  d1:	eb 30                	jmp    103 <strcmp+0x43>
  d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d7:	90                   	nop
  d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  dc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  df:	42                   	inc    %edx
  while(*p && *p == *q)
  e0:	84 c0                	test   %al,%al
  e2:	74 14                	je     f8 <strcmp+0x38>
    p++, q++;
  e4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
  e6:	0f b6 0b             	movzbl (%ebx),%ecx
  e9:	38 c1                	cmp    %al,%cl
  eb:	74 eb                	je     d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  ed:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  ee:	29 c8                	sub    %ecx,%eax
}
  f0:	5d                   	pop    %ebp
  f1:	c3                   	ret    
  f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  f8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  fc:	31 c0                	xor    %eax,%eax
}
  fe:	5b                   	pop    %ebx
  ff:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 100:	29 c8                	sub    %ecx,%eax
}
 102:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 103:	0f b6 0b             	movzbl (%ebx),%ecx
 106:	31 c0                	xor    %eax,%eax
 108:	eb e3                	jmp    ed <strcmp+0x2d>
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	40                   	inc    %eax
 121:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 125:	89 c1                	mov    %eax,%ecx
 127:	75 f7                	jne    120 <strlen+0x10>
    ;
  return n;
}
 129:	5d                   	pop    %ebp
 12a:	89 c8                	mov    %ecx,%eax
 12c:	c3                   	ret    
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 131:	31 c9                	xor    %ecx,%ecx
}
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	5f                   	pop    %edi
 153:	89 d0                	mov    %edx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 10                	jne    181 <strchr+0x21>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 177:	90                   	nop
 178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 17c:	40                   	inc    %eax
 17d:	84 d2                	test   %dl,%dl
 17f:	74 0f                	je     190 <strchr+0x30>
    if(*s == c)
 181:	38 d1                	cmp    %dl,%cl
 183:	75 f3                	jne    178 <strchr+0x18>
      return (char*)s;
  return 0;
}
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax
 190:	5d                   	pop    %ebp
  return 0;
 191:	31 c0                	xor    %eax,%eax
}
 193:	c3                   	ret    
 194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a5:	31 f6                	xor    %esi,%esi
{
 1a7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 1a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1ab:	83 ec 3c             	sub    $0x3c,%esp
 1ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1b1:	eb 32                	jmp    1e5 <gets+0x45>
 1b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b7:	90                   	nop
    cc = read(0, &c, 1);
 1b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1bc:	b8 01 00 00 00       	mov    $0x1,%eax
 1c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1cc:	e8 1a 01 00 00       	call   2eb <read>
    if(cc < 1)
 1d1:	85 c0                	test   %eax,%eax
 1d3:	7e 19                	jle    1ee <gets+0x4e>
      break;
    buf[i++] = c;
 1d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1dd:	3c 0a                	cmp    $0xa,%al
 1df:	74 10                	je     1f1 <gets+0x51>
 1e1:	3c 0d                	cmp    $0xd,%al
 1e3:	74 0c                	je     1f1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1e8:	46                   	inc    %esi
 1e9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1ec:	7c ca                	jl     1b8 <gets+0x18>
 1ee:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1f1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1f5:	83 c4 3c             	add    $0x3c,%esp
 1f8:	89 d8                	mov    %ebx,%eax
 1fa:	5b                   	pop    %ebx
 1fb:	5e                   	pop    %esi
 1fc:	5f                   	pop    %edi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 201:	31 c0                	xor    %eax,%eax
{
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 18             	sub    $0x18,%esp
 208:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 20b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 20e:	89 44 24 04          	mov    %eax,0x4(%esp)
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	89 04 24             	mov    %eax,(%esp)
 218:	e8 f6 00 00 00       	call   313 <open>
  if(fd < 0)
 21d:	85 c0                	test   %eax,%eax
 21f:	78 2f                	js     250 <stat+0x50>
 221:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 223:	8b 45 0c             	mov    0xc(%ebp),%eax
 226:	89 1c 24             	mov    %ebx,(%esp)
 229:	89 44 24 04          	mov    %eax,0x4(%esp)
 22d:	e8 f9 00 00 00       	call   32b <fstat>
  close(fd);
 232:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 235:	89 c6                	mov    %eax,%esi
  close(fd);
 237:	e8 bf 00 00 00       	call   2fb <close>
  return r;
}
 23c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 23f:	89 f0                	mov    %esi,%eax
 241:	8b 75 fc             	mov    -0x4(%ebp),%esi
 244:	89 ec                	mov    %ebp,%esp
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24f:	90                   	nop
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb e5                	jmp    23c <stat+0x3c>
 257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25e:	66 90                	xchg   %ax,%ax

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	88 c1                	mov    %al,%cl
 26c:	80 e9 30             	sub    $0x30,%cl
 26f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 272:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 277:	77 1c                	ja     295 <atoi+0x35>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 280:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 283:	42                   	inc    %edx
 284:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 288:	0f be 02             	movsbl (%edx),%eax
 28b:	88 c3                	mov    %al,%bl
 28d:	80 eb 30             	sub    $0x30,%bl
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	89 c8                	mov    %ecx,%eax
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	8b 45 10             	mov    0x10(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2b4:	89 d7                	mov    %edx,%edi
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
  return vdst;
}
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    

000002cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <exit>:
SYSCALL(exit)
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <wait>:
SYSCALL(wait)
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <pipe>:
SYSCALL(pipe)
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <read>:
SYSCALL(read)
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <write>:
SYSCALL(write)
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <close>:
SYSCALL(close)
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <kill>:
SYSCALL(kill)
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <exec>:
SYSCALL(exec)
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <open>:
SYSCALL(open)
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <mknod>:
SYSCALL(mknod)
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <unlink>:
SYSCALL(unlink)
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <fstat>:
SYSCALL(fstat)
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <link>:
SYSCALL(link)
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mkdir>:
SYSCALL(mkdir)
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <chdir>:
SYSCALL(chdir)
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <dup>:
SYSCALL(dup)
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <getpid>:
SYSCALL(getpid)
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <sbrk>:
SYSCALL(sbrk)
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <sleep>:
SYSCALL(sleep)
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <uptime>:
SYSCALL(uptime)
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <getNumFreePages>:
 373:	b8 16 00 00 00       	mov    $0x16,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	89 cb                	mov    %ecx,%ebx
 388:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 38b:	89 d1                	mov    %edx,%ecx
{
 38d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 390:	89 d0                	mov    %edx,%eax
 392:	c1 e8 1f             	shr    $0x1f,%eax
 395:	84 c0                	test   %al,%al
 397:	0f 84 93 00 00 00    	je     430 <printint+0xb0>
 39d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3a1:	0f 84 89 00 00 00    	je     430 <printint+0xb0>
    x = -xx;
 3a7:	f7 d9                	neg    %ecx
    neg = 1;
 3a9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3ae:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3b5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3b8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3bf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3c0:	89 c8                	mov    %ecx,%eax
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3c7:	f7 f3                	div    %ebx
 3c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3cc:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
 3d3:	8d 47 01             	lea    0x1(%edi),%eax
 3d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3d9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3dd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3df:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3e2:	39 da                	cmp    %ebx,%edx
 3e4:	73 da                	jae    3c0 <printint+0x40>
  if(neg)
 3e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3e9:	85 c0                	test   %eax,%eax
 3eb:	74 0a                	je     3f7 <printint+0x77>
    buf[i++] = '-';
 3ed:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3f0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3f5:	89 c7                	mov    %eax,%edi
 3f7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3fa:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3fe:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 400:	0f b6 07             	movzbl (%edi),%eax
 403:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 406:	b8 01 00 00 00       	mov    $0x1,%eax
 40b:	89 44 24 08          	mov    %eax,0x8(%esp)
 40f:	89 74 24 04          	mov    %esi,0x4(%esp)
 413:	8b 45 bc             	mov    -0x44(%ebp),%eax
 416:	89 04 24             	mov    %eax,(%esp)
 419:	e8 d5 fe ff ff       	call   2f3 <write>
  while(--i >= 0)
 41e:	89 f8                	mov    %edi,%eax
 420:	4f                   	dec    %edi
 421:	39 d8                	cmp    %ebx,%eax
 423:	75 db                	jne    400 <printint+0x80>
}
 425:	83 c4 4c             	add    $0x4c,%esp
 428:	5b                   	pop    %ebx
 429:	5e                   	pop    %esi
 42a:	5f                   	pop    %edi
 42b:	5d                   	pop    %ebp
 42c:	c3                   	ret    
 42d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 430:	31 c0                	xor    %eax,%eax
 432:	e9 77 ff ff ff       	jmp    3ae <printint+0x2e>
 437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43e:	66 90                	xchg   %ax,%ax

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 449:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 44c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 44f:	0f b6 1e             	movzbl (%esi),%ebx
 452:	84 db                	test   %bl,%bl
 454:	74 6f                	je     4c5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 456:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 459:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 45b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 45e:	88 d9                	mov    %bl,%cl
 460:	46                   	inc    %esi
 461:	89 d3                	mov    %edx,%ebx
 463:	eb 2b                	jmp    490 <printf+0x50>
 465:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	74 4b                	je     4b8 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 46d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 470:	b8 01 00 00 00       	mov    $0x1,%eax
 475:	89 44 24 08          	mov    %eax,0x8(%esp)
 479:	8d 45 e7             	lea    -0x19(%ebp),%eax
 47c:	89 44 24 04          	mov    %eax,0x4(%esp)
 480:	89 3c 24             	mov    %edi,(%esp)
 483:	e8 6b fe ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 488:	0f b6 0e             	movzbl (%esi),%ecx
 48b:	46                   	inc    %esi
 48c:	84 c9                	test   %cl,%cl
 48e:	74 35                	je     4c5 <printf+0x85>
    if(state == 0){
 490:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 492:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 495:	74 d1                	je     468 <printf+0x28>
      }
    } else if(state == '%'){
 497:	83 fb 25             	cmp    $0x25,%ebx
 49a:	75 ec                	jne    488 <printf+0x48>
      if(c == 'd'){
 49c:	83 f8 25             	cmp    $0x25,%eax
 49f:	0f 84 53 01 00 00    	je     5f8 <printf+0x1b8>
 4a5:	83 e8 63             	sub    $0x63,%eax
 4a8:	83 f8 15             	cmp    $0x15,%eax
 4ab:	77 23                	ja     4d0 <printf+0x90>
 4ad:	ff 24 85 d8 07 00 00 	jmp    *0x7d8(,%eax,4)
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4b8:	0f b6 0e             	movzbl (%esi),%ecx
 4bb:	46                   	inc    %esi
        state = '%';
 4bc:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 4c1:	84 c9                	test   %cl,%cl
 4c3:	75 cb                	jne    490 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c5:	83 c4 3c             	add    $0x3c,%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
 4d0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 4d3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 4d6:	b8 01 00 00 00       	mov    $0x1,%eax
 4db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4df:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4e7:	89 3c 24             	mov    %edi,(%esp)
 4ea:	e8 04 fe ff ff       	call   2f3 <write>
        putc(fd, c);
 4ef:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 4f3:	ba 01 00 00 00       	mov    $0x1,%edx
 4f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 4fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 4ff:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 501:	89 54 24 08          	mov    %edx,0x8(%esp)
 505:	89 3c 24             	mov    %edi,(%esp)
 508:	e8 e6 fd ff ff       	call   2f3 <write>
 50d:	e9 76 ff ff ff       	jmp    488 <printf+0x48>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 518:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 51b:	b9 10 00 00 00       	mov    $0x10,%ecx
 520:	8b 13                	mov    (%ebx),%edx
 522:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 529:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 52c:	89 f8                	mov    %edi,%eax
 52e:	e8 4d fe ff ff       	call   380 <printint>
        ap++;
 533:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 536:	31 db                	xor    %ebx,%ebx
 538:	e9 4b ff ff ff       	jmp    488 <printf+0x48>
 53d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 540:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 543:	8b 08                	mov    (%eax),%ecx
        ap++;
 545:	83 c0 04             	add    $0x4,%eax
 548:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 54b:	85 c9                	test   %ecx,%ecx
 54d:	0f 84 cd 00 00 00    	je     620 <printf+0x1e0>
        while(*s != 0){
 553:	0f b6 01             	movzbl (%ecx),%eax
 556:	84 c0                	test   %al,%al
 558:	0f 84 ce 00 00 00    	je     62c <printf+0x1ec>
 55e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 561:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 564:	89 ce                	mov    %ecx,%esi
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 570:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 573:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 578:	46                   	inc    %esi
  write(fd, &c, 1);
 579:	89 44 24 08          	mov    %eax,0x8(%esp)
 57d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 581:	89 3c 24             	mov    %edi,(%esp)
 584:	e8 6a fd ff ff       	call   2f3 <write>
        while(*s != 0){
 589:	0f b6 06             	movzbl (%esi),%eax
 58c:	84 c0                	test   %al,%al
 58e:	75 e0                	jne    570 <printf+0x130>
      state = 0;
 590:	8b 75 d0             	mov    -0x30(%ebp),%esi
 593:	31 db                	xor    %ebx,%ebx
 595:	e9 ee fe ff ff       	jmp    488 <printf+0x48>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5a0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5a8:	8b 13                	mov    (%ebx),%edx
 5aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5b1:	e9 73 ff ff ff       	jmp    529 <printf+0xe9>
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5c3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 5c8:	8b 10                	mov    (%eax),%edx
 5ca:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5cd:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 5d8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5db:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 5df:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5e1:	89 3c 24             	mov    %edi,(%esp)
 5e4:	e8 0a fd ff ff       	call   2f3 <write>
        ap++;
 5e9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5ed:	e9 96 fe ff ff       	jmp    488 <printf+0x48>
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 5f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 5fb:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5fe:	b9 01 00 00 00       	mov    $0x1,%ecx
 603:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 607:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 609:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 60d:	89 3c 24             	mov    %edi,(%esp)
 610:	e8 de fc ff ff       	call   2f3 <write>
 615:	e9 6e fe ff ff       	jmp    488 <printf+0x48>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 620:	b0 28                	mov    $0x28,%al
          s = "(null)";
 622:	b9 d1 07 00 00       	mov    $0x7d1,%ecx
 627:	e9 32 ff ff ff       	jmp    55e <printf+0x11e>
      state = 0;
 62c:	31 db                	xor    %ebx,%ebx
 62e:	66 90                	xchg   %ax,%ax
 630:	e9 53 fe ff ff       	jmp    488 <printf+0x48>
 635:	66 90                	xchg   %ax,%ax
 637:	66 90                	xchg   %ax,%ax
 639:	66 90                	xchg   %ax,%ax
 63b:	66 90                	xchg   %ax,%ax
 63d:	66 90                	xchg   %ax,%ax
 63f:	90                   	nop

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 44 08 00 00       	mov    0x844,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
 660:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 664:	39 ca                	cmp    %ecx,%edx
 666:	73 30                	jae    698 <free+0x58>
 668:	39 c1                	cmp    %eax,%ecx
 66a:	72 04                	jb     670 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 c2                	cmp    %eax,%edx
 66e:	72 f0                	jb     660 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 676:	39 f8                	cmp    %edi,%eax
 678:	74 26                	je     6a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 67a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 67d:	8b 42 04             	mov    0x4(%edx),%eax
 680:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	74 32                	je     6b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 687:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 689:	5b                   	pop    %ebx
  freep = p;
 68a:	89 15 44 08 00 00    	mov    %edx,0x844
}
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 698:	39 c1                	cmp    %eax,%ecx
 69a:	72 d0                	jb     66c <free+0x2c>
 69c:	eb c2                	jmp    660 <free+0x20>
 69e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 6a0:	8b 78 04             	mov    0x4(%eax),%edi
 6a3:	01 fe                	add    %edi,%esi
 6a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a8:	8b 02                	mov    (%edx),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6af:	8b 42 04             	mov    0x4(%edx),%eax
 6b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6b5:	39 f1                	cmp    %esi,%ecx
 6b7:	75 ce                	jne    687 <free+0x47>
  freep = p;
 6b9:	89 15 44 08 00 00    	mov    %edx,0x844
    p->s.size += bp->s.size;
 6bf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6c2:	01 c8                	add    %ecx,%eax
 6c4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6c7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6ca:	89 0a                	mov    %ecx,(%edx)
}
 6cc:	5b                   	pop    %ebx
 6cd:	5e                   	pop    %esi
 6ce:	5f                   	pop    %edi
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 15 44 08 00 00    	mov    0x844,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8d 78 07             	lea    0x7(%eax),%edi
 6f5:	c1 ef 03             	shr    $0x3,%edi
 6f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6f9:	85 d2                	test   %edx,%edx
 6fb:	0f 84 8f 00 00 00    	je     790 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 701:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 703:	8b 48 04             	mov    0x4(%eax),%ecx
 706:	39 f9                	cmp    %edi,%ecx
 708:	73 5e                	jae    768 <malloc+0x88>
  if(nu < 4096)
 70a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 70f:	39 df                	cmp    %ebx,%edi
 711:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 714:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 71b:	eb 0c                	jmp    729 <malloc+0x49>
 71d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 722:	8b 48 04             	mov    0x4(%eax),%ecx
 725:	39 f9                	cmp    %edi,%ecx
 727:	73 3f                	jae    768 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 729:	39 05 44 08 00 00    	cmp    %eax,0x844
 72f:	89 c2                	mov    %eax,%edx
 731:	75 ed                	jne    720 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 733:	89 34 24             	mov    %esi,(%esp)
 736:	e8 20 fc ff ff       	call   35b <sbrk>
  if(p == (char*)-1)
 73b:	83 f8 ff             	cmp    $0xffffffff,%eax
 73e:	74 18                	je     758 <malloc+0x78>
  hp->s.size = nu;
 740:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 743:	83 c0 08             	add    $0x8,%eax
 746:	89 04 24             	mov    %eax,(%esp)
 749:	e8 f2 fe ff ff       	call   640 <free>
  return freep;
 74e:	8b 15 44 08 00 00    	mov    0x844,%edx
      if((p = morecore(nunits)) == 0)
 754:	85 d2                	test   %edx,%edx
 756:	75 c8                	jne    720 <malloc+0x40>
        return 0;
  }
}
 758:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 75b:	31 c0                	xor    %eax,%eax
}
 75d:	5b                   	pop    %ebx
 75e:	5e                   	pop    %esi
 75f:	5f                   	pop    %edi
 760:	5d                   	pop    %ebp
 761:	c3                   	ret    
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 768:	39 cf                	cmp    %ecx,%edi
 76a:	74 54                	je     7c0 <malloc+0xe0>
        p->s.size -= nunits;
 76c:	29 f9                	sub    %edi,%ecx
 76e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 771:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 774:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 777:	89 15 44 08 00 00    	mov    %edx,0x844
}
 77d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 780:	83 c0 08             	add    $0x8,%eax
}
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 790:	b8 48 08 00 00       	mov    $0x848,%eax
 795:	ba 48 08 00 00       	mov    $0x848,%edx
 79a:	a3 44 08 00 00       	mov    %eax,0x844
    base.s.size = 0;
 79f:	31 c9                	xor    %ecx,%ecx
 7a1:	b8 48 08 00 00       	mov    $0x848,%eax
    base.s.ptr = freep = prevp = &base;
 7a6:	89 15 48 08 00 00    	mov    %edx,0x848
    base.s.size = 0;
 7ac:	89 0d 4c 08 00 00    	mov    %ecx,0x84c
    if(p->s.size >= nunits){
 7b2:	e9 53 ff ff ff       	jmp    70a <malloc+0x2a>
 7b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7be:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 7c0:	8b 08                	mov    (%eax),%ecx
 7c2:	89 0a                	mov    %ecx,(%edx)
 7c4:	eb b1                	jmp    777 <malloc+0x97>
