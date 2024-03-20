
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
   1:	ba 68 08 00 00       	mov    $0x868,%edx
{
   6:	89 e5                	mov    %esp,%ebp
  char path[] = "stressfs0";
   8:	b8 73 74 72 65       	mov    $0x65727473,%eax
{
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  memset(data, 'a', sizeof(data));
  10:	bb 61 00 00 00       	mov    $0x61,%ebx
{
  15:	83 e4 f0             	and    $0xfffffff0,%esp
  18:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  1e:	89 44 24 16          	mov    %eax,0x16(%esp)
  memset(data, 'a', sizeof(data));
  22:	8d 74 24 20          	lea    0x20(%esp),%esi
  char path[] = "stressfs0";
  26:	b8 73 73 66 73       	mov    $0x73667373,%eax
  printf(1, "stressfs starting\n");
  2b:	89 54 24 04          	mov    %edx,0x4(%esp)
  2f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char path[] = "stressfs0";
  36:	89 44 24 1a          	mov    %eax,0x1a(%esp)
  3a:	66 c7 44 24 1e 30 00 	movw   $0x30,0x1e(%esp)
  printf(1, "stressfs starting\n");
  41:	e8 9a 04 00 00       	call   4e0 <printf>
  memset(data, 'a', sizeof(data));
  46:	b9 00 02 00 00       	mov    $0x200,%ecx
  4b:	89 5c 24 04          	mov    %ebx,0x4(%esp)

  for(i = 0; i < 4; i++)
  4f:	31 db                	xor    %ebx,%ebx
  memset(data, 'a', sizeof(data));
  51:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  55:	89 34 24             	mov    %esi,(%esp)
  58:	e8 83 01 00 00       	call   1e0 <memset>
    if(fork() > 0)
  5d:	e8 09 03 00 00       	call   36b <fork>
  62:	85 c0                	test   %eax,%eax
  64:	7f 06                	jg     6c <main+0x6c>
  for(i = 0; i < 4; i++)
  66:	43                   	inc    %ebx
  67:	83 fb 04             	cmp    $0x4,%ebx
  6a:	75 f1                	jne    5d <main+0x5d>
      break;

  printf(1, "write %d\n", i);
  6c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  70:	b8 7b 08 00 00       	mov    $0x87b,%eax
  75:	89 44 24 04          	mov    %eax,0x4(%esp)
  79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  80:	e8 5b 04 00 00       	call   4e0 <printf>

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  85:	b8 02 02 00 00       	mov    $0x202,%eax
  8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  8e:	8d 44 24 16          	lea    0x16(%esp),%eax
  92:	89 04 24             	mov    %eax,(%esp)
  path[8] += i;
  95:	00 5c 24 1e          	add    %bl,0x1e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  99:	bb 14 00 00 00       	mov    $0x14,%ebx
  9e:	e8 10 03 00 00       	call   3b3 <open>
  a3:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	89 74 24 04          	mov    %esi,0x4(%esp)
  b4:	b8 00 02 00 00       	mov    $0x200,%eax
  b9:	89 44 24 08          	mov    %eax,0x8(%esp)
  bd:	89 3c 24             	mov    %edi,(%esp)
  c0:	e8 ce 02 00 00       	call   393 <write>
  for(i = 0; i < 20; i++)
  c5:	4b                   	dec    %ebx
  c6:	75 e8                	jne    b0 <main+0xb0>
  close(fd);
  c8:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  cb:	bb 14 00 00 00       	mov    $0x14,%ebx
  close(fd);
  d0:	e8 c6 02 00 00       	call   39b <close>
  printf(1, "read\n");
  d5:	ba 85 08 00 00       	mov    $0x885,%edx
  da:	89 54 24 04          	mov    %edx,0x4(%esp)
  de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e5:	e8 f6 03 00 00       	call   4e0 <printf>
  fd = open(path, O_RDONLY);
  ea:	8d 44 24 16          	lea    0x16(%esp),%eax
  ee:	31 c9                	xor    %ecx,%ecx
  f0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  f4:	89 04 24             	mov    %eax,(%esp)
  f7:	e8 b7 02 00 00       	call   3b3 <open>
  fc:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
  fe:	66 90                	xchg   %ax,%ax
    read(fd, data, sizeof(data));
 100:	89 74 24 04          	mov    %esi,0x4(%esp)
 104:	b8 00 02 00 00       	mov    $0x200,%eax
 109:	89 44 24 08          	mov    %eax,0x8(%esp)
 10d:	89 3c 24             	mov    %edi,(%esp)
 110:	e8 76 02 00 00       	call   38b <read>
  for (i = 0; i < 20; i++)
 115:	4b                   	dec    %ebx
 116:	75 e8                	jne    100 <main+0x100>
  close(fd);
 118:	89 3c 24             	mov    %edi,(%esp)
 11b:	e8 7b 02 00 00       	call   39b <close>

  wait();
 120:	e8 56 02 00 00       	call   37b <wait>

  exit();
 125:	e8 49 02 00 00       	call   373 <exit>
 12a:	66 90                	xchg   %ax,%ax
 12c:	66 90                	xchg   %ax,%ax
 12e:	66 90                	xchg   %ax,%ax

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 130:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 131:	31 c0                	xor    %eax,%eax
{
 133:	89 e5                	mov    %esp,%ebp
 135:	53                   	push   %ebx
 136:	8b 4d 08             	mov    0x8(%ebp),%ecx
 139:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 140:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 144:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 147:	40                   	inc    %eax
 148:	84 d2                	test   %dl,%dl
 14a:	75 f4                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 14c:	5b                   	pop    %ebx
 14d:	89 c8                	mov    %ecx,%eax
 14f:	5d                   	pop    %ebp
 150:	c3                   	ret    
 151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15f:	90                   	nop

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	8b 55 08             	mov    0x8(%ebp),%edx
 167:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 16a:	0f b6 02             	movzbl (%edx),%eax
 16d:	84 c0                	test   %al,%al
 16f:	75 15                	jne    186 <strcmp+0x26>
 171:	eb 30                	jmp    1a3 <strcmp+0x43>
 173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 177:	90                   	nop
 178:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 17c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 17f:	42                   	inc    %edx
  while(*p && *p == *q)
 180:	84 c0                	test   %al,%al
 182:	74 14                	je     198 <strcmp+0x38>
    p++, q++;
 184:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 186:	0f b6 0b             	movzbl (%ebx),%ecx
 189:	38 c1                	cmp    %al,%cl
 18b:	74 eb                	je     178 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 18d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 18e:	29 c8                	sub    %ecx,%eax
}
 190:	5d                   	pop    %ebp
 191:	c3                   	ret    
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 198:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 19c:	31 c0                	xor    %eax,%eax
}
 19e:	5b                   	pop    %ebx
 19f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 1a0:	29 c8                	sub    %ecx,%eax
}
 1a2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 1a3:	0f b6 0b             	movzbl (%ebx),%ecx
 1a6:	31 c0                	xor    %eax,%eax
 1a8:	eb e3                	jmp    18d <strcmp+0x2d>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	40                   	inc    %eax
 1c1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c5:	89 c1                	mov    %eax,%ecx
 1c7:	75 f7                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1c9:	5d                   	pop    %ebp
 1ca:	89 c8                	mov    %ecx,%eax
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1d1:	31 c9                	xor    %ecx,%ecx
}
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	c3                   	ret    
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	5f                   	pop    %edi
 1f3:	89 d0                	mov    %edx,%eax
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 10                	jne    221 <strchr+0x21>
 211:	eb 1d                	jmp    230 <strchr+0x30>
 213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 217:	90                   	nop
 218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 21c:	40                   	inc    %eax
 21d:	84 d2                	test   %dl,%dl
 21f:	74 0f                	je     230 <strchr+0x30>
    if(*s == c)
 221:	38 d1                	cmp    %dl,%cl
 223:	75 f3                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax
 230:	5d                   	pop    %ebp
  return 0;
 231:	31 c0                	xor    %eax,%eax
}
 233:	c3                   	ret    
 234:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 245:	31 f6                	xor    %esi,%esi
{
 247:	53                   	push   %ebx
    cc = read(0, &c, 1);
 248:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 24b:	83 ec 3c             	sub    $0x3c,%esp
 24e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 251:	eb 32                	jmp    285 <gets+0x45>
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
    cc = read(0, &c, 1);
 258:	89 7c 24 04          	mov    %edi,0x4(%esp)
 25c:	b8 01 00 00 00       	mov    $0x1,%eax
 261:	89 44 24 08          	mov    %eax,0x8(%esp)
 265:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 26c:	e8 1a 01 00 00       	call   38b <read>
    if(cc < 1)
 271:	85 c0                	test   %eax,%eax
 273:	7e 19                	jle    28e <gets+0x4e>
      break;
    buf[i++] = c;
 275:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 279:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 27d:	3c 0a                	cmp    $0xa,%al
 27f:	74 10                	je     291 <gets+0x51>
 281:	3c 0d                	cmp    $0xd,%al
 283:	74 0c                	je     291 <gets+0x51>
  for(i=0; i+1 < max; ){
 285:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 288:	46                   	inc    %esi
 289:	3b 75 0c             	cmp    0xc(%ebp),%esi
 28c:	7c ca                	jl     258 <gets+0x18>
 28e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 291:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 295:	83 c4 3c             	add    $0x3c,%esp
 298:	89 d8                	mov    %ebx,%eax
 29a:	5b                   	pop    %ebx
 29b:	5e                   	pop    %esi
 29c:	5f                   	pop    %edi
 29d:	5d                   	pop    %ebp
 29e:	c3                   	ret    
 29f:	90                   	nop

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a1:	31 c0                	xor    %eax,%eax
{
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 18             	sub    $0x18,%esp
 2a8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2ab:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	89 04 24             	mov    %eax,(%esp)
 2b8:	e8 f6 00 00 00       	call   3b3 <open>
  if(fd < 0)
 2bd:	85 c0                	test   %eax,%eax
 2bf:	78 2f                	js     2f0 <stat+0x50>
 2c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c6:	89 1c 24             	mov    %ebx,(%esp)
 2c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cd:	e8 f9 00 00 00       	call   3cb <fstat>
  close(fd);
 2d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2d5:	89 c6                	mov    %eax,%esi
  close(fd);
 2d7:	e8 bf 00 00 00       	call   39b <close>
  return r;
}
 2dc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2df:	89 f0                	mov    %esi,%eax
 2e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2e4:	89 ec                	mov    %ebp,%esp
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop
    return -1;
 2f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f5:	eb e5                	jmp    2dc <stat+0x3c>
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 02             	movsbl (%edx),%eax
 30a:	88 c1                	mov    %al,%cl
 30c:	80 e9 30             	sub    $0x30,%cl
 30f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 312:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 317:	77 1c                	ja     335 <atoi+0x35>
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 320:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 323:	42                   	inc    %edx
 324:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 328:	0f be 02             	movsbl (%edx),%eax
 32b:	88 c3                	mov    %al,%bl
 32d:	80 eb 30             	sub    $0x30,%bl
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	5b                   	pop    %ebx
 336:	89 c8                	mov    %ecx,%eax
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	8b 45 10             	mov    0x10(%ebp),%eax
 348:	8b 55 08             	mov    0x8(%ebp),%edx
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 c0                	test   %eax,%eax
 350:	7e 13                	jle    365 <memmove+0x25>
 352:	01 d0                	add    %edx,%eax
  dst = vdst;
 354:	89 d7                	mov    %edx,%edi
 356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <getNumFreePages>:
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
 428:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 42b:	89 d1                	mov    %edx,%ecx
{
 42d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 430:	89 d0                	mov    %edx,%eax
 432:	c1 e8 1f             	shr    $0x1f,%eax
 435:	84 c0                	test   %al,%al
 437:	0f 84 93 00 00 00    	je     4d0 <printint+0xb0>
 43d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 441:	0f 84 89 00 00 00    	je     4d0 <printint+0xb0>
    x = -xx;
 447:	f7 d9                	neg    %ecx
    neg = 1;
 449:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 44e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 455:	8d 75 d7             	lea    -0x29(%ebp),%esi
 458:	89 45 b8             	mov    %eax,-0x48(%ebp)
 45b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 460:	89 c8                	mov    %ecx,%eax
 462:	31 d2                	xor    %edx,%edx
 464:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 467:	f7 f3                	div    %ebx
 469:	89 45 c0             	mov    %eax,-0x40(%ebp)
 46c:	0f b6 92 ec 08 00 00 	movzbl 0x8ec(%edx),%edx
 473:	8d 47 01             	lea    0x1(%edi),%eax
 476:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 479:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 47d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 47f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 482:	39 da                	cmp    %ebx,%edx
 484:	73 da                	jae    460 <printint+0x40>
  if(neg)
 486:	8b 45 b8             	mov    -0x48(%ebp),%eax
 489:	85 c0                	test   %eax,%eax
 48b:	74 0a                	je     497 <printint+0x77>
    buf[i++] = '-';
 48d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 490:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 495:	89 c7                	mov    %eax,%edi
 497:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 49a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 49e:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 4a0:	0f b6 07             	movzbl (%edi),%eax
 4a3:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 4a6:	b8 01 00 00 00       	mov    $0x1,%eax
 4ab:	89 44 24 08          	mov    %eax,0x8(%esp)
 4af:	89 74 24 04          	mov    %esi,0x4(%esp)
 4b3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 4b6:	89 04 24             	mov    %eax,(%esp)
 4b9:	e8 d5 fe ff ff       	call   393 <write>
  while(--i >= 0)
 4be:	89 f8                	mov    %edi,%eax
 4c0:	4f                   	dec    %edi
 4c1:	39 d8                	cmp    %ebx,%eax
 4c3:	75 db                	jne    4a0 <printint+0x80>
}
 4c5:	83 c4 4c             	add    $0x4c,%esp
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret    
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4d0:	31 c0                	xor    %eax,%eax
 4d2:	e9 77 ff ff ff       	jmp    44e <printint+0x2e>
 4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4ef:	0f b6 1e             	movzbl (%esi),%ebx
 4f2:	84 db                	test   %bl,%bl
 4f4:	74 6f                	je     565 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 4f6:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 4f9:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 4fe:	88 d9                	mov    %bl,%cl
 500:	46                   	inc    %esi
 501:	89 d3                	mov    %edx,%ebx
 503:	eb 2b                	jmp    530 <printf+0x50>
 505:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 508:	83 f8 25             	cmp    $0x25,%eax
 50b:	74 4b                	je     558 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 50d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 510:	b8 01 00 00 00       	mov    $0x1,%eax
 515:	89 44 24 08          	mov    %eax,0x8(%esp)
 519:	8d 45 e7             	lea    -0x19(%ebp),%eax
 51c:	89 44 24 04          	mov    %eax,0x4(%esp)
 520:	89 3c 24             	mov    %edi,(%esp)
 523:	e8 6b fe ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 528:	0f b6 0e             	movzbl (%esi),%ecx
 52b:	46                   	inc    %esi
 52c:	84 c9                	test   %cl,%cl
 52e:	74 35                	je     565 <printf+0x85>
    if(state == 0){
 530:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 532:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 535:	74 d1                	je     508 <printf+0x28>
      }
    } else if(state == '%'){
 537:	83 fb 25             	cmp    $0x25,%ebx
 53a:	75 ec                	jne    528 <printf+0x48>
      if(c == 'd'){
 53c:	83 f8 25             	cmp    $0x25,%eax
 53f:	0f 84 53 01 00 00    	je     698 <printf+0x1b8>
 545:	83 e8 63             	sub    $0x63,%eax
 548:	83 f8 15             	cmp    $0x15,%eax
 54b:	77 23                	ja     570 <printf+0x90>
 54d:	ff 24 85 94 08 00 00 	jmp    *0x894(,%eax,4)
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 558:	0f b6 0e             	movzbl (%esi),%ecx
 55b:	46                   	inc    %esi
        state = '%';
 55c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 561:	84 c9                	test   %cl,%cl
 563:	75 cb                	jne    530 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 565:	83 c4 3c             	add    $0x3c,%esp
 568:	5b                   	pop    %ebx
 569:	5e                   	pop    %esi
 56a:	5f                   	pop    %edi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret    
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 573:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 576:	b8 01 00 00 00       	mov    $0x1,%eax
 57b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 57f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 583:	89 44 24 08          	mov    %eax,0x8(%esp)
 587:	89 3c 24             	mov    %edi,(%esp)
 58a:	e8 04 fe ff ff       	call   393 <write>
        putc(fd, c);
 58f:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 593:	ba 01 00 00 00       	mov    $0x1,%edx
 598:	88 4d e7             	mov    %cl,-0x19(%ebp)
 59b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 59f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 5a1:	89 54 24 08          	mov    %edx,0x8(%esp)
 5a5:	89 3c 24             	mov    %edi,(%esp)
 5a8:	e8 e6 fd ff ff       	call   393 <write>
 5ad:	e9 76 ff ff ff       	jmp    528 <printf+0x48>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5b8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5bb:	b9 10 00 00 00       	mov    $0x10,%ecx
 5c0:	8b 13                	mov    (%ebx),%edx
 5c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 5c9:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5cc:	89 f8                	mov    %edi,%eax
 5ce:	e8 4d fe ff ff       	call   420 <printint>
        ap++;
 5d3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 5d6:	31 db                	xor    %ebx,%ebx
 5d8:	e9 4b ff ff ff       	jmp    528 <printf+0x48>
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5e3:	8b 08                	mov    (%eax),%ecx
        ap++;
 5e5:	83 c0 04             	add    $0x4,%eax
 5e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5eb:	85 c9                	test   %ecx,%ecx
 5ed:	0f 84 cd 00 00 00    	je     6c0 <printf+0x1e0>
        while(*s != 0){
 5f3:	0f b6 01             	movzbl (%ecx),%eax
 5f6:	84 c0                	test   %al,%al
 5f8:	0f 84 ce 00 00 00    	je     6cc <printf+0x1ec>
 5fe:	89 75 d0             	mov    %esi,-0x30(%ebp)
 601:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 604:	89 ce                	mov    %ecx,%esi
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 610:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 613:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 618:	46                   	inc    %esi
  write(fd, &c, 1);
 619:	89 44 24 08          	mov    %eax,0x8(%esp)
 61d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 621:	89 3c 24             	mov    %edi,(%esp)
 624:	e8 6a fd ff ff       	call   393 <write>
        while(*s != 0){
 629:	0f b6 06             	movzbl (%esi),%eax
 62c:	84 c0                	test   %al,%al
 62e:	75 e0                	jne    610 <printf+0x130>
      state = 0;
 630:	8b 75 d0             	mov    -0x30(%ebp),%esi
 633:	31 db                	xor    %ebx,%ebx
 635:	e9 ee fe ff ff       	jmp    528 <printf+0x48>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 640:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 643:	b9 0a 00 00 00       	mov    $0xa,%ecx
 648:	8b 13                	mov    (%ebx),%edx
 64a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 651:	e9 73 ff ff ff       	jmp    5c9 <printf+0xe9>
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 660:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 663:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 668:	8b 10                	mov    (%eax),%edx
 66a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 66d:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 671:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 674:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 678:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 67b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 67f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 681:	89 3c 24             	mov    %edi,(%esp)
 684:	e8 0a fd ff ff       	call   393 <write>
        ap++;
 689:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 68d:	e9 96 fe ff ff       	jmp    528 <printf+0x48>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 698:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 69b:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 69e:	b9 01 00 00 00       	mov    $0x1,%ecx
 6a3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 6a7:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 6a9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6ad:	89 3c 24             	mov    %edi,(%esp)
 6b0:	e8 de fc ff ff       	call   393 <write>
 6b5:	e9 6e fe ff ff       	jmp    528 <printf+0x48>
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c0:	b0 28                	mov    $0x28,%al
          s = "(null)";
 6c2:	b9 8b 08 00 00       	mov    $0x88b,%ecx
 6c7:	e9 32 ff ff ff       	jmp    5fe <printf+0x11e>
      state = 0;
 6cc:	31 db                	xor    %ebx,%ebx
 6ce:	66 90                	xchg   %ax,%ax
 6d0:	e9 53 fe ff ff       	jmp    528 <printf+0x48>
 6d5:	66 90                	xchg   %ax,%ax
 6d7:	66 90                	xchg   %ax,%ax
 6d9:	66 90                	xchg   %ax,%ax
 6db:	66 90                	xchg   %ax,%ax
 6dd:	66 90                	xchg   %ax,%ax
 6df:	90                   	nop

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	a1 00 09 00 00       	mov    0x900,%eax
{
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	57                   	push   %edi
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
 700:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 704:	39 ca                	cmp    %ecx,%edx
 706:	73 30                	jae    738 <free+0x58>
 708:	39 c1                	cmp    %eax,%ecx
 70a:	72 04                	jb     710 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	39 c2                	cmp    %eax,%edx
 70e:	72 f0                	jb     700 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 716:	39 f8                	cmp    %edi,%eax
 718:	74 26                	je     740 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 71a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 71d:	8b 42 04             	mov    0x4(%edx),%eax
 720:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	74 32                	je     759 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 727:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 729:	5b                   	pop    %ebx
  freep = p;
 72a:	89 15 00 09 00 00    	mov    %edx,0x900
}
 730:	5e                   	pop    %esi
 731:	5f                   	pop    %edi
 732:	5d                   	pop    %ebp
 733:	c3                   	ret    
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 738:	39 c1                	cmp    %eax,%ecx
 73a:	72 d0                	jb     70c <free+0x2c>
 73c:	eb c2                	jmp    700 <free+0x20>
 73e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 740:	8b 78 04             	mov    0x4(%eax),%edi
 743:	01 fe                	add    %edi,%esi
 745:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 748:	8b 02                	mov    (%edx),%eax
 74a:	8b 00                	mov    (%eax),%eax
 74c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 74f:	8b 42 04             	mov    0x4(%edx),%eax
 752:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 755:	39 f1                	cmp    %esi,%ecx
 757:	75 ce                	jne    727 <free+0x47>
  freep = p;
 759:	89 15 00 09 00 00    	mov    %edx,0x900
    p->s.size += bp->s.size;
 75f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 762:	01 c8                	add    %ecx,%eax
 764:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 767:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 76a:	89 0a                	mov    %ecx,(%edx)
}
 76c:	5b                   	pop    %ebx
 76d:	5e                   	pop    %esi
 76e:	5f                   	pop    %edi
 76f:	5d                   	pop    %ebp
 770:	c3                   	ret    
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 15 00 09 00 00    	mov    0x900,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 78 07             	lea    0x7(%eax),%edi
 795:	c1 ef 03             	shr    $0x3,%edi
 798:	47                   	inc    %edi
  if((prevp = freep) == 0){
 799:	85 d2                	test   %edx,%edx
 79b:	0f 84 8f 00 00 00    	je     830 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a3:	8b 48 04             	mov    0x4(%eax),%ecx
 7a6:	39 f9                	cmp    %edi,%ecx
 7a8:	73 5e                	jae    808 <malloc+0x88>
  if(nu < 4096)
 7aa:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7af:	39 df                	cmp    %ebx,%edi
 7b1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7b4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7bb:	eb 0c                	jmp    7c9 <malloc+0x49>
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7c2:	8b 48 04             	mov    0x4(%eax),%ecx
 7c5:	39 f9                	cmp    %edi,%ecx
 7c7:	73 3f                	jae    808 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c9:	39 05 00 09 00 00    	cmp    %eax,0x900
 7cf:	89 c2                	mov    %eax,%edx
 7d1:	75 ed                	jne    7c0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7d3:	89 34 24             	mov    %esi,(%esp)
 7d6:	e8 20 fc ff ff       	call   3fb <sbrk>
  if(p == (char*)-1)
 7db:	83 f8 ff             	cmp    $0xffffffff,%eax
 7de:	74 18                	je     7f8 <malloc+0x78>
  hp->s.size = nu;
 7e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7e3:	83 c0 08             	add    $0x8,%eax
 7e6:	89 04 24             	mov    %eax,(%esp)
 7e9:	e8 f2 fe ff ff       	call   6e0 <free>
  return freep;
 7ee:	8b 15 00 09 00 00    	mov    0x900,%edx
      if((p = morecore(nunits)) == 0)
 7f4:	85 d2                	test   %edx,%edx
 7f6:	75 c8                	jne    7c0 <malloc+0x40>
        return 0;
  }
}
 7f8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7fb:	31 c0                	xor    %eax,%eax
}
 7fd:	5b                   	pop    %ebx
 7fe:	5e                   	pop    %esi
 7ff:	5f                   	pop    %edi
 800:	5d                   	pop    %ebp
 801:	c3                   	ret    
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 808:	39 cf                	cmp    %ecx,%edi
 80a:	74 54                	je     860 <malloc+0xe0>
        p->s.size -= nunits;
 80c:	29 f9                	sub    %edi,%ecx
 80e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 811:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 814:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 817:	89 15 00 09 00 00    	mov    %edx,0x900
}
 81d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 820:	83 c0 08             	add    $0x8,%eax
}
 823:	5b                   	pop    %ebx
 824:	5e                   	pop    %esi
 825:	5f                   	pop    %edi
 826:	5d                   	pop    %ebp
 827:	c3                   	ret    
 828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 830:	b8 04 09 00 00       	mov    $0x904,%eax
 835:	ba 04 09 00 00       	mov    $0x904,%edx
 83a:	a3 00 09 00 00       	mov    %eax,0x900
    base.s.size = 0;
 83f:	31 c9                	xor    %ecx,%ecx
 841:	b8 04 09 00 00       	mov    $0x904,%eax
    base.s.ptr = freep = prevp = &base;
 846:	89 15 04 09 00 00    	mov    %edx,0x904
    base.s.size = 0;
 84c:	89 0d 08 09 00 00    	mov    %ecx,0x908
    if(p->s.size >= nunits){
 852:	e9 53 ff ff ff       	jmp    7aa <malloc+0x2a>
 857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 860:	8b 08                	mov    (%eax),%ecx
 862:	89 0a                	mov    %ecx,(%edx)
 864:	eb b1                	jmp    817 <malloc+0x97>
