
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
   6:	e8 35 00 00 00       	call   40 <forktest>
  exit();
   b:	e8 83 03 00 00       	call   393 <exit>

00000010 <printf>:
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	83 ec 18             	sub    $0x18,%esp
  16:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  1c:	89 1c 24             	mov    %ebx,(%esp)
  1f:	e8 ac 01 00 00       	call   1d0 <strlen>
  24:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  28:	89 44 24 08          	mov    %eax,0x8(%esp)
  2c:	8b 45 08             	mov    0x8(%ebp),%eax
  2f:	89 04 24             	mov    %eax,(%esp)
  32:	e8 7c 03 00 00       	call   3b3 <write>
}
  37:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  3a:	89 ec                	mov    %ebp,%esp
  3c:	5d                   	pop    %ebp
  3d:	c3                   	ret    
  3e:	66 90                	xchg   %ax,%ax

00000040 <forktest>:
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 18             	sub    $0x18,%esp
  46:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  for(n=0; n<N; n++){
  49:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
  4b:	c7 04 24 3c 04 00 00 	movl   $0x43c,(%esp)
  52:	e8 79 01 00 00       	call   1d0 <strlen>
  57:	b9 3c 04 00 00       	mov    $0x43c,%ecx
  5c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  60:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  67:	89 44 24 08          	mov    %eax,0x8(%esp)
  6b:	e8 43 03 00 00       	call   3b3 <write>
  for(n=0; n<N; n++){
  70:	eb 15                	jmp    87 <forktest+0x47>
  72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
  78:	0f 84 82 00 00 00    	je     100 <forktest+0xc0>
  for(n=0; n<N; n++){
  7e:	43                   	inc    %ebx
  7f:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  85:	74 5d                	je     e4 <forktest+0xa4>
    pid = fork();
  87:	e8 ff 02 00 00       	call   38b <fork>
    if(pid < 0)
  8c:	85 c0                	test   %eax,%eax
  8e:	79 e8                	jns    78 <forktest+0x38>
  for(; n > 0; n--){
  90:	85 db                	test   %ebx,%ebx
  92:	74 18                	je     ac <forktest+0x6c>
  94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  9f:	90                   	nop
    if(wait() < 0){
  a0:	e8 f6 02 00 00       	call   39b <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 5c                	js     105 <forktest+0xc5>
  for(; n > 0; n--){
  a9:	4b                   	dec    %ebx
  aa:	75 f4                	jne    a0 <forktest+0x60>
  if(wait() != -1){
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b0:	e8 e6 02 00 00       	call   39b <wait>
  b5:	40                   	inc    %eax
  b6:	75 77                	jne    12f <forktest+0xef>
  write(fd, s, strlen(s));
  b8:	c7 04 24 6e 04 00 00 	movl   $0x46e,(%esp)
  bf:	e8 0c 01 00 00       	call   1d0 <strlen>
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	89 44 24 08          	mov    %eax,0x8(%esp)
  cf:	b8 6e 04 00 00       	mov    $0x46e,%eax
  d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  d8:	e8 d6 02 00 00       	call   3b3 <write>
}
  dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e0:	89 ec                	mov    %ebp,%esp
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    
    printf(1, "fork claimed to work N times!\n", N);
  e4:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
  eb:	00 
  ec:	c7 44 24 04 7c 04 00 	movl   $0x47c,0x4(%esp)
  f3:	00 
  f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fb:	e8 10 ff ff ff       	call   10 <printf>
    exit();
 100:	e8 8e 02 00 00       	call   393 <exit>
  write(fd, s, strlen(s));
 105:	c7 04 24 47 04 00 00 	movl   $0x447,(%esp)
 10c:	e8 bf 00 00 00       	call   1d0 <strlen>
 111:	ba 47 04 00 00       	mov    $0x447,%edx
 116:	89 54 24 04          	mov    %edx,0x4(%esp)
 11a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 121:	89 44 24 08          	mov    %eax,0x8(%esp)
 125:	e8 89 02 00 00       	call   3b3 <write>
      exit();
 12a:	e8 64 02 00 00       	call   393 <exit>
    printf(1, "wait got too many\n");
 12f:	c7 44 24 04 5b 04 00 	movl   $0x45b,0x4(%esp)
 136:	00 
 137:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13e:	e8 cd fe ff ff       	call   10 <printf>
    exit();
 143:	e8 4b 02 00 00       	call   393 <exit>
 148:	66 90                	xchg   %ax,%ax
 14a:	66 90                	xchg   %ax,%ax
 14c:	66 90                	xchg   %ax,%ax
 14e:	66 90                	xchg   %ax,%ax

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 150:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 151:	31 c0                	xor    %eax,%eax
{
 153:	89 e5                	mov    %esp,%ebp
 155:	53                   	push   %ebx
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 160:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 164:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 167:	40                   	inc    %eax
 168:	84 d2                	test   %dl,%dl
 16a:	75 f4                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16c:	5b                   	pop    %ebx
 16d:	89 c8                	mov    %ecx,%eax
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 55 08             	mov    0x8(%ebp),%edx
 187:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 18a:	0f b6 02             	movzbl (%edx),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 15                	jne    1a6 <strcmp+0x26>
 191:	eb 30                	jmp    1c3 <strcmp+0x43>
 193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 197:	90                   	nop
 198:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 19c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 19f:	42                   	inc    %edx
  while(*p && *p == *q)
 1a0:	84 c0                	test   %al,%al
 1a2:	74 14                	je     1b8 <strcmp+0x38>
    p++, q++;
 1a4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 1a6:	0f b6 0b             	movzbl (%ebx),%ecx
 1a9:	38 c1                	cmp    %al,%cl
 1ab:	74 eb                	je     198 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 1ad:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1ae:	29 c8                	sub    %ecx,%eax
}
 1b0:	5d                   	pop    %ebp
 1b1:	c3                   	ret    
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1b8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 1bc:	31 c0                	xor    %eax,%eax
}
 1be:	5b                   	pop    %ebx
 1bf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 1c0:	29 c8                	sub    %ecx,%eax
}
 1c2:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 1c3:	0f b6 0b             	movzbl (%ebx),%ecx
 1c6:	31 c0                	xor    %eax,%eax
 1c8:	eb e3                	jmp    1ad <strcmp+0x2d>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 3a 00             	cmpb   $0x0,(%edx)
 1d9:	74 15                	je     1f0 <strlen+0x20>
 1db:	31 c0                	xor    %eax,%eax
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	40                   	inc    %eax
 1e1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1e5:	89 c1                	mov    %eax,%ecx
 1e7:	75 f7                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1e9:	5d                   	pop    %ebp
 1ea:	89 c8                	mov    %ecx,%eax
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1f1:	31 c9                	xor    %ecx,%ecx
}
 1f3:	89 c8                	mov    %ecx,%eax
 1f5:	c3                   	ret    
 1f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	5f                   	pop    %edi
 213:	89 d0                	mov    %edx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	75 10                	jne    241 <strchr+0x21>
 231:	eb 1d                	jmp    250 <strchr+0x30>
 233:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 237:	90                   	nop
 238:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 23c:	40                   	inc    %eax
 23d:	84 d2                	test   %dl,%dl
 23f:	74 0f                	je     250 <strchr+0x30>
    if(*s == c)
 241:	38 d1                	cmp    %dl,%cl
 243:	75 f3                	jne    238 <strchr+0x18>
      return (char*)s;
  return 0;
}
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
 250:	5d                   	pop    %ebp
  return 0;
 251:	31 c0                	xor    %eax,%eax
}
 253:	c3                   	ret    
 254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 265:	31 f6                	xor    %esi,%esi
{
 267:	53                   	push   %ebx
    cc = read(0, &c, 1);
 268:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 26b:	83 ec 3c             	sub    $0x3c,%esp
 26e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 271:	eb 32                	jmp    2a5 <gets+0x45>
 273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 277:	90                   	nop
    cc = read(0, &c, 1);
 278:	89 7c 24 04          	mov    %edi,0x4(%esp)
 27c:	b8 01 00 00 00       	mov    $0x1,%eax
 281:	89 44 24 08          	mov    %eax,0x8(%esp)
 285:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 28c:	e8 1a 01 00 00       	call   3ab <read>
    if(cc < 1)
 291:	85 c0                	test   %eax,%eax
 293:	7e 19                	jle    2ae <gets+0x4e>
      break;
    buf[i++] = c;
 295:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 299:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 29d:	3c 0a                	cmp    $0xa,%al
 29f:	74 10                	je     2b1 <gets+0x51>
 2a1:	3c 0d                	cmp    $0xd,%al
 2a3:	74 0c                	je     2b1 <gets+0x51>
  for(i=0; i+1 < max; ){
 2a5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2a8:	46                   	inc    %esi
 2a9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2ac:	7c ca                	jl     278 <gets+0x18>
 2ae:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 2b1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 2b5:	83 c4 3c             	add    $0x3c,%esp
 2b8:	89 d8                	mov    %ebx,%eax
 2ba:	5b                   	pop    %ebx
 2bb:	5e                   	pop    %esi
 2bc:	5f                   	pop    %edi
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret    
 2bf:	90                   	nop

000002c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c1:	31 c0                	xor    %eax,%eax
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	83 ec 18             	sub    $0x18,%esp
 2c8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2cb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d2:	8b 45 08             	mov    0x8(%ebp),%eax
 2d5:	89 04 24             	mov    %eax,(%esp)
 2d8:	e8 f6 00 00 00       	call   3d3 <open>
  if(fd < 0)
 2dd:	85 c0                	test   %eax,%eax
 2df:	78 2f                	js     310 <stat+0x50>
 2e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e6:	89 1c 24             	mov    %ebx,(%esp)
 2e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ed:	e8 f9 00 00 00       	call   3eb <fstat>
  close(fd);
 2f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2f5:	89 c6                	mov    %eax,%esi
  close(fd);
 2f7:	e8 bf 00 00 00       	call   3bb <close>
  return r;
}
 2fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2ff:	89 f0                	mov    %esi,%eax
 301:	8b 75 fc             	mov    -0x4(%ebp),%esi
 304:	89 ec                	mov    %ebp,%esp
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30f:	90                   	nop
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb e5                	jmp    2fc <stat+0x3c>
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	88 c1                	mov    %al,%cl
 32c:	80 e9 30             	sub    $0x30,%cl
 32f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 332:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 337:	77 1c                	ja     355 <atoi+0x35>
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 340:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 343:	42                   	inc    %edx
 344:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 348:	0f be 02             	movsbl (%edx),%eax
 34b:	88 c3                	mov    %al,%bl
 34d:	80 eb 30             	sub    $0x30,%bl
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	89 c8                	mov    %ecx,%eax
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	8b 45 10             	mov    0x10(%ebp),%eax
 368:	8b 55 08             	mov    0x8(%ebp),%edx
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c0                	test   %eax,%eax
 370:	7e 13                	jle    385 <memmove+0x25>
 372:	01 d0                	add    %edx,%eax
  dst = vdst;
 374:	89 d7                	mov    %edx,%edi
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret    

0000038b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <exit>:
SYSCALL(exit)
 393:	b8 02 00 00 00       	mov    $0x2,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <wait>:
SYSCALL(wait)
 39b:	b8 03 00 00 00       	mov    $0x3,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <pipe>:
SYSCALL(pipe)
 3a3:	b8 04 00 00 00       	mov    $0x4,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <read>:
SYSCALL(read)
 3ab:	b8 05 00 00 00       	mov    $0x5,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <write>:
SYSCALL(write)
 3b3:	b8 10 00 00 00       	mov    $0x10,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <close>:
SYSCALL(close)
 3bb:	b8 15 00 00 00       	mov    $0x15,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <kill>:
SYSCALL(kill)
 3c3:	b8 06 00 00 00       	mov    $0x6,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <exec>:
SYSCALL(exec)
 3cb:	b8 07 00 00 00       	mov    $0x7,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <open>:
SYSCALL(open)
 3d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mknod>:
SYSCALL(mknod)
 3db:	b8 11 00 00 00       	mov    $0x11,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <unlink>:
SYSCALL(unlink)
 3e3:	b8 12 00 00 00       	mov    $0x12,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <fstat>:
SYSCALL(fstat)
 3eb:	b8 08 00 00 00       	mov    $0x8,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <link>:
SYSCALL(link)
 3f3:	b8 13 00 00 00       	mov    $0x13,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mkdir>:
SYSCALL(mkdir)
 3fb:	b8 14 00 00 00       	mov    $0x14,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <chdir>:
SYSCALL(chdir)
 403:	b8 09 00 00 00       	mov    $0x9,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <dup>:
SYSCALL(dup)
 40b:	b8 0a 00 00 00       	mov    $0xa,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <getpid>:
SYSCALL(getpid)
 413:	b8 0b 00 00 00       	mov    $0xb,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getNumFreePages>:
 433:	b8 16 00 00 00       	mov    $0x16,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    
