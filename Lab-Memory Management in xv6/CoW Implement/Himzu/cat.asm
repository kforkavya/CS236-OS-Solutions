
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  int fd, i;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  10:	7e 61                	jle    73 <main+0x73>
  12:	8b 45 0c             	mov    0xc(%ebp),%eax
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  15:	be 01 00 00 00       	mov    $0x1,%esi
  1a:	8d 78 04             	lea    0x4(%eax),%edi
  1d:	eb 1a                	jmp    39 <main+0x39>
  1f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  20:	89 04 24             	mov    %eax,(%esp)
  for(i = 1; i < argc; i++){
  23:	46                   	inc    %esi
  24:	83 c7 04             	add    $0x4,%edi
    cat(fd);
  27:	e8 64 00 00 00       	call   90 <cat>
    close(fd);
  2c:	89 1c 24             	mov    %ebx,(%esp)
  2f:	e8 57 03 00 00       	call   38b <close>
  for(i = 1; i < argc; i++){
  34:	39 75 08             	cmp    %esi,0x8(%ebp)
  37:	74 35                	je     6e <main+0x6e>
    if((fd = open(argv[i], 0)) < 0){
  39:	31 c0                	xor    %eax,%eax
  3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  3f:	8b 07                	mov    (%edi),%eax
  41:	89 04 24             	mov    %eax,(%esp)
  44:	e8 5a 03 00 00       	call   3a3 <open>
  49:	85 c0                	test   %eax,%eax
  4b:	89 c3                	mov    %eax,%ebx
  4d:	79 d1                	jns    20 <main+0x20>
      printf(1, "cat: cannot open %s\n", argv[i]);
  4f:	8b 07                	mov    (%edi),%eax
  51:	c7 44 24 04 7b 08 00 	movl   $0x87b,0x4(%esp)
  58:	00 
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	89 44 24 08          	mov    %eax,0x8(%esp)
  64:	e8 67 04 00 00       	call   4d0 <printf>
      exit();
  69:	e8 f5 02 00 00       	call   363 <exit>
  }
  exit();
  6e:	e8 f0 02 00 00       	call   363 <exit>
    cat(0);
  73:	31 d2                	xor    %edx,%edx
  75:	89 14 24             	mov    %edx,(%esp)
  78:	e8 13 00 00 00       	call   90 <cat>
    exit();
  7d:	e8 e1 02 00 00       	call   363 <exit>
  82:	66 90                	xchg   %ax,%ax
  84:	66 90                	xchg   %ax,%ax
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	83 ec 10             	sub    $0x10,%esp
  98:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  9b:	eb 20                	jmp    bd <cat+0x2d>
  9d:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  a4:	b8 20 09 00 00       	mov    $0x920,%eax
  a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b4:	e8 ca 02 00 00       	call   383 <write>
  b9:	39 d8                	cmp    %ebx,%eax
  bb:	75 29                	jne    e6 <cat+0x56>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  bd:	89 34 24             	mov    %esi,(%esp)
  c0:	b8 00 02 00 00       	mov    $0x200,%eax
  c5:	ba 20 09 00 00       	mov    $0x920,%edx
  ca:	89 44 24 08          	mov    %eax,0x8(%esp)
  ce:	89 54 24 04          	mov    %edx,0x4(%esp)
  d2:	e8 a4 02 00 00       	call   37b <read>
  d7:	85 c0                	test   %eax,%eax
  d9:	89 c3                	mov    %eax,%ebx
  db:	7f c3                	jg     a0 <cat+0x10>
  if(n < 0){
  dd:	75 21                	jne    100 <cat+0x70>
}
  df:	83 c4 10             	add    $0x10,%esp
  e2:	5b                   	pop    %ebx
  e3:	5e                   	pop    %esi
  e4:	5d                   	pop    %ebp
  e5:	c3                   	ret    
      printf(1, "cat: write error\n");
  e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ed:	b9 58 08 00 00       	mov    $0x858,%ecx
  f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  f6:	e8 d5 03 00 00       	call   4d0 <printf>
      exit();
  fb:	e8 63 02 00 00       	call   363 <exit>
    printf(1, "cat: read error\n");
 100:	c7 44 24 04 6a 08 00 	movl   $0x86a,0x4(%esp)
 107:	00 
 108:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10f:	e8 bc 03 00 00       	call   4d0 <printf>
    exit();
 114:	e8 4a 02 00 00       	call   363 <exit>
 119:	66 90                	xchg   %ax,%ax
 11b:	66 90                	xchg   %ax,%ax
 11d:	66 90                	xchg   %ax,%ax
 11f:	90                   	nop

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	40                   	inc    %eax
 138:	84 d2                	test   %dl,%dl
 13a:	75 f4                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13c:	5b                   	pop    %ebx
 13d:	89 c8                	mov    %ecx,%eax
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 15                	jne    176 <strcmp+0x26>
 161:	eb 30                	jmp    193 <strcmp+0x43>
 163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 167:	90                   	nop
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 16c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 16f:	42                   	inc    %edx
  while(*p && *p == *q)
 170:	84 c0                	test   %al,%al
 172:	74 14                	je     188 <strcmp+0x38>
    p++, q++;
 174:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 176:	0f b6 0b             	movzbl (%ebx),%ecx
 179:	38 c1                	cmp    %al,%cl
 17b:	74 eb                	je     168 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 17d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 17e:	29 c8                	sub    %ecx,%eax
}
 180:	5d                   	pop    %ebp
 181:	c3                   	ret    
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 188:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 18c:	31 c0                	xor    %eax,%eax
}
 18e:	5b                   	pop    %ebx
 18f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 190:	29 c8                	sub    %ecx,%eax
}
 192:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 193:	0f b6 0b             	movzbl (%ebx),%ecx
 196:	31 c0                	xor    %eax,%eax
 198:	eb e3                	jmp    17d <strcmp+0x2d>
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	40                   	inc    %eax
 1b1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b5:	89 c1                	mov    %eax,%ecx
 1b7:	75 f7                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1b9:	5d                   	pop    %ebp
 1ba:	89 c8                	mov    %ecx,%eax
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1c1:	31 c9                	xor    %ecx,%ecx
}
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 10                	jne    211 <strchr+0x21>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 207:	90                   	nop
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	40                   	inc    %eax
 20d:	84 d2                	test   %dl,%dl
 20f:	74 0f                	je     220 <strchr+0x30>
    if(*s == c)
 211:	38 d1                	cmp    %dl,%cl
 213:	75 f3                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
 220:	5d                   	pop    %ebp
  return 0;
 221:	31 c0                	xor    %eax,%eax
}
 223:	c3                   	ret    
 224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	31 f6                	xor    %esi,%esi
{
 237:	53                   	push   %ebx
    cc = read(0, &c, 1);
 238:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 23b:	83 ec 3c             	sub    $0x3c,%esp
 23e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 241:	eb 32                	jmp    275 <gets+0x45>
 243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 247:	90                   	nop
    cc = read(0, &c, 1);
 248:	89 7c 24 04          	mov    %edi,0x4(%esp)
 24c:	b8 01 00 00 00       	mov    $0x1,%eax
 251:	89 44 24 08          	mov    %eax,0x8(%esp)
 255:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 25c:	e8 1a 01 00 00       	call   37b <read>
    if(cc < 1)
 261:	85 c0                	test   %eax,%eax
 263:	7e 19                	jle    27e <gets+0x4e>
      break;
    buf[i++] = c;
 265:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 269:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 10                	je     281 <gets+0x51>
 271:	3c 0d                	cmp    $0xd,%al
 273:	74 0c                	je     281 <gets+0x51>
  for(i=0; i+1 < max; ){
 275:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 278:	46                   	inc    %esi
 279:	3b 75 0c             	cmp    0xc(%ebp),%esi
 27c:	7c ca                	jl     248 <gets+0x18>
 27e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 281:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 285:	83 c4 3c             	add    $0x3c,%esp
 288:	89 d8                	mov    %ebx,%eax
 28a:	5b                   	pop    %ebx
 28b:	5e                   	pop    %esi
 28c:	5f                   	pop    %edi
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret    
 28f:	90                   	nop

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	31 c0                	xor    %eax,%eax
{
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 18             	sub    $0x18,%esp
 298:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 29b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 29e:	89 44 24 04          	mov    %eax,0x4(%esp)
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	89 04 24             	mov    %eax,(%esp)
 2a8:	e8 f6 00 00 00       	call   3a3 <open>
  if(fd < 0)
 2ad:	85 c0                	test   %eax,%eax
 2af:	78 2f                	js     2e0 <stat+0x50>
 2b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b6:	89 1c 24             	mov    %ebx,(%esp)
 2b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bd:	e8 f9 00 00 00       	call   3bb <fstat>
  close(fd);
 2c2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2c5:	89 c6                	mov    %eax,%esi
  close(fd);
 2c7:	e8 bf 00 00 00       	call   38b <close>
  return r;
}
 2cc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2cf:	89 f0                	mov    %esi,%eax
 2d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2d4:	89 ec                	mov    %ebp,%esp
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2df:	90                   	nop
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb e5                	jmp    2cc <stat+0x3c>
 2e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ee:	66 90                	xchg   %ax,%ax

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 02             	movsbl (%edx),%eax
 2fa:	88 c1                	mov    %al,%cl
 2fc:	80 e9 30             	sub    $0x30,%cl
 2ff:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 302:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 307:	77 1c                	ja     325 <atoi+0x35>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 310:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 313:	42                   	inc    %edx
 314:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 318:	0f be 02             	movsbl (%edx),%eax
 31b:	88 c3                	mov    %al,%bl
 31d:	80 eb 30             	sub    $0x30,%bl
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	5b                   	pop    %ebx
 326:	89 c8                	mov    %ecx,%eax
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	8b 45 10             	mov    0x10(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c0                	test   %eax,%eax
 340:	7e 13                	jle    355 <memmove+0x25>
 342:	01 d0                	add    %edx,%eax
  dst = vdst;
 344:	89 d7                	mov    %edx,%edi
 346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 351:	39 f8                	cmp    %edi,%eax
 353:	75 fb                	jne    350 <memmove+0x20>
  return vdst;
}
 355:	5e                   	pop    %esi
 356:	89 d0                	mov    %edx,%eax
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret    

0000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <uptime>:
SYSCALL(uptime)
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <getNumFreePages>:
 403:	b8 16 00 00 00       	mov    $0x16,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	89 cb                	mov    %ecx,%ebx
 418:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41b:	89 d1                	mov    %edx,%ecx
{
 41d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 420:	89 d0                	mov    %edx,%eax
 422:	c1 e8 1f             	shr    $0x1f,%eax
 425:	84 c0                	test   %al,%al
 427:	0f 84 93 00 00 00    	je     4c0 <printint+0xb0>
 42d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 431:	0f 84 89 00 00 00    	je     4c0 <printint+0xb0>
    x = -xx;
 437:	f7 d9                	neg    %ecx
    neg = 1;
 439:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 43e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 445:	8d 75 d7             	lea    -0x29(%ebp),%esi
 448:	89 45 b8             	mov    %eax,-0x48(%ebp)
 44b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 450:	89 c8                	mov    %ecx,%eax
 452:	31 d2                	xor    %edx,%edx
 454:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 457:	f7 f3                	div    %ebx
 459:	89 45 c0             	mov    %eax,-0x40(%ebp)
 45c:	0f b6 92 f0 08 00 00 	movzbl 0x8f0(%edx),%edx
 463:	8d 47 01             	lea    0x1(%edi),%eax
 466:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 469:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 46d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 46f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 472:	39 da                	cmp    %ebx,%edx
 474:	73 da                	jae    450 <printint+0x40>
  if(neg)
 476:	8b 45 b8             	mov    -0x48(%ebp),%eax
 479:	85 c0                	test   %eax,%eax
 47b:	74 0a                	je     487 <printint+0x77>
    buf[i++] = '-';
 47d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 480:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 485:	89 c7                	mov    %eax,%edi
 487:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 48a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 48e:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 490:	0f b6 07             	movzbl (%edi),%eax
 493:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 496:	b8 01 00 00 00       	mov    $0x1,%eax
 49b:	89 44 24 08          	mov    %eax,0x8(%esp)
 49f:	89 74 24 04          	mov    %esi,0x4(%esp)
 4a3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 4a6:	89 04 24             	mov    %eax,(%esp)
 4a9:	e8 d5 fe ff ff       	call   383 <write>
  while(--i >= 0)
 4ae:	89 f8                	mov    %edi,%eax
 4b0:	4f                   	dec    %edi
 4b1:	39 d8                	cmp    %ebx,%eax
 4b3:	75 db                	jne    490 <printint+0x80>
}
 4b5:	83 c4 4c             	add    $0x4c,%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4c0:	31 c0                	xor    %eax,%eax
 4c2:	e9 77 ff ff ff       	jmp    43e <printint+0x2e>
 4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ce:	66 90                	xchg   %ax,%ax

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4dc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4df:	0f b6 1e             	movzbl (%esi),%ebx
 4e2:	84 db                	test   %bl,%bl
 4e4:	74 6f                	je     555 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 4e6:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 4e9:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4eb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 4ee:	88 d9                	mov    %bl,%cl
 4f0:	46                   	inc    %esi
 4f1:	89 d3                	mov    %edx,%ebx
 4f3:	eb 2b                	jmp    520 <printf+0x50>
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	74 4b                	je     548 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 4fd:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 500:	b8 01 00 00 00       	mov    $0x1,%eax
 505:	89 44 24 08          	mov    %eax,0x8(%esp)
 509:	8d 45 e7             	lea    -0x19(%ebp),%eax
 50c:	89 44 24 04          	mov    %eax,0x4(%esp)
 510:	89 3c 24             	mov    %edi,(%esp)
 513:	e8 6b fe ff ff       	call   383 <write>
  for(i = 0; fmt[i]; i++){
 518:	0f b6 0e             	movzbl (%esi),%ecx
 51b:	46                   	inc    %esi
 51c:	84 c9                	test   %cl,%cl
 51e:	74 35                	je     555 <printf+0x85>
    if(state == 0){
 520:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 522:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 525:	74 d1                	je     4f8 <printf+0x28>
      }
    } else if(state == '%'){
 527:	83 fb 25             	cmp    $0x25,%ebx
 52a:	75 ec                	jne    518 <printf+0x48>
      if(c == 'd'){
 52c:	83 f8 25             	cmp    $0x25,%eax
 52f:	0f 84 53 01 00 00    	je     688 <printf+0x1b8>
 535:	83 e8 63             	sub    $0x63,%eax
 538:	83 f8 15             	cmp    $0x15,%eax
 53b:	77 23                	ja     560 <printf+0x90>
 53d:	ff 24 85 98 08 00 00 	jmp    *0x898(,%eax,4)
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 548:	0f b6 0e             	movzbl (%esi),%ecx
 54b:	46                   	inc    %esi
        state = '%';
 54c:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 551:	84 c9                	test   %cl,%cl
 553:	75 cb                	jne    520 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 555:	83 c4 3c             	add    $0x3c,%esp
 558:	5b                   	pop    %ebx
 559:	5e                   	pop    %esi
 55a:	5f                   	pop    %edi
 55b:	5d                   	pop    %ebp
 55c:	c3                   	ret    
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 563:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 566:	b8 01 00 00 00       	mov    $0x1,%eax
 56b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 56f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 573:	89 44 24 08          	mov    %eax,0x8(%esp)
 577:	89 3c 24             	mov    %edi,(%esp)
 57a:	e8 04 fe ff ff       	call   383 <write>
        putc(fd, c);
 57f:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 583:	ba 01 00 00 00       	mov    $0x1,%edx
 588:	88 4d e7             	mov    %cl,-0x19(%ebp)
 58b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 58f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 591:	89 54 24 08          	mov    %edx,0x8(%esp)
 595:	89 3c 24             	mov    %edi,(%esp)
 598:	e8 e6 fd ff ff       	call   383 <write>
 59d:	e9 76 ff ff ff       	jmp    518 <printf+0x48>
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5a8:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5ab:	b9 10 00 00 00       	mov    $0x10,%ecx
 5b0:	8b 13                	mov    (%ebx),%edx
 5b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 5b9:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5bc:	89 f8                	mov    %edi,%eax
 5be:	e8 4d fe ff ff       	call   410 <printint>
        ap++;
 5c3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 5c6:	31 db                	xor    %ebx,%ebx
 5c8:	e9 4b ff ff ff       	jmp    518 <printf+0x48>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5d3:	8b 08                	mov    (%eax),%ecx
        ap++;
 5d5:	83 c0 04             	add    $0x4,%eax
 5d8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5db:	85 c9                	test   %ecx,%ecx
 5dd:	0f 84 cd 00 00 00    	je     6b0 <printf+0x1e0>
        while(*s != 0){
 5e3:	0f b6 01             	movzbl (%ecx),%eax
 5e6:	84 c0                	test   %al,%al
 5e8:	0f 84 ce 00 00 00    	je     6bc <printf+0x1ec>
 5ee:	89 75 d0             	mov    %esi,-0x30(%ebp)
 5f1:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5f4:	89 ce                	mov    %ecx,%esi
 5f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 600:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 603:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 608:	46                   	inc    %esi
  write(fd, &c, 1);
 609:	89 44 24 08          	mov    %eax,0x8(%esp)
 60d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 611:	89 3c 24             	mov    %edi,(%esp)
 614:	e8 6a fd ff ff       	call   383 <write>
        while(*s != 0){
 619:	0f b6 06             	movzbl (%esi),%eax
 61c:	84 c0                	test   %al,%al
 61e:	75 e0                	jne    600 <printf+0x130>
      state = 0;
 620:	8b 75 d0             	mov    -0x30(%ebp),%esi
 623:	31 db                	xor    %ebx,%ebx
 625:	e9 ee fe ff ff       	jmp    518 <printf+0x48>
 62a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 630:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 633:	b9 0a 00 00 00       	mov    $0xa,%ecx
 638:	8b 13                	mov    (%ebx),%edx
 63a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 641:	e9 73 ff ff ff       	jmp    5b9 <printf+0xe9>
 646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 650:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 653:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 658:	8b 10                	mov    (%eax),%edx
 65a:	89 55 d0             	mov    %edx,-0x30(%ebp)
 65d:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 661:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 664:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 668:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 66b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 66f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 671:	89 3c 24             	mov    %edi,(%esp)
 674:	e8 0a fd ff ff       	call   383 <write>
        ap++;
 679:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 67d:	e9 96 fe ff ff       	jmp    518 <printf+0x48>
 682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 688:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 68b:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 68e:	b9 01 00 00 00       	mov    $0x1,%ecx
 693:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 697:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 699:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 69d:	89 3c 24             	mov    %edi,(%esp)
 6a0:	e8 de fc ff ff       	call   383 <write>
 6a5:	e9 6e fe ff ff       	jmp    518 <printf+0x48>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6b0:	b0 28                	mov    $0x28,%al
          s = "(null)";
 6b2:	b9 90 08 00 00       	mov    $0x890,%ecx
 6b7:	e9 32 ff ff ff       	jmp    5ee <printf+0x11e>
      state = 0;
 6bc:	31 db                	xor    %ebx,%ebx
 6be:	66 90                	xchg   %ax,%ax
 6c0:	e9 53 fe ff ff       	jmp    518 <printf+0x48>
 6c5:	66 90                	xchg   %ax,%ax
 6c7:	66 90                	xchg   %ax,%ax
 6c9:	66 90                	xchg   %ax,%ax
 6cb:	66 90                	xchg   %ax,%ax
 6cd:	66 90                	xchg   %ax,%ax
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 20 0b 00 00       	mov    0xb20,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop
 6f0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f4:	39 ca                	cmp    %ecx,%edx
 6f6:	73 30                	jae    728 <free+0x58>
 6f8:	39 c1                	cmp    %eax,%ecx
 6fa:	72 04                	jb     700 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	39 c2                	cmp    %eax,%edx
 6fe:	72 f0                	jb     6f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 f8                	cmp    %edi,%eax
 708:	74 26                	je     730 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 70a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 70d:	8b 42 04             	mov    0x4(%edx),%eax
 710:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	74 32                	je     749 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 717:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 719:	5b                   	pop    %ebx
  freep = p;
 71a:	89 15 20 0b 00 00    	mov    %edx,0xb20
}
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret    
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 728:	39 c1                	cmp    %eax,%ecx
 72a:	72 d0                	jb     6fc <free+0x2c>
 72c:	eb c2                	jmp    6f0 <free+0x20>
 72e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 730:	8b 78 04             	mov    0x4(%eax),%edi
 733:	01 fe                	add    %edi,%esi
 735:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 738:	8b 02                	mov    (%edx),%eax
 73a:	8b 00                	mov    (%eax),%eax
 73c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 73f:	8b 42 04             	mov    0x4(%edx),%eax
 742:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 745:	39 f1                	cmp    %esi,%ecx
 747:	75 ce                	jne    717 <free+0x47>
  freep = p;
 749:	89 15 20 0b 00 00    	mov    %edx,0xb20
    p->s.size += bp->s.size;
 74f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 752:	01 c8                	add    %ecx,%eax
 754:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 757:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 75a:	89 0a                	mov    %ecx,(%edx)
}
 75c:	5b                   	pop    %ebx
 75d:	5e                   	pop    %esi
 75e:	5f                   	pop    %edi
 75f:	5d                   	pop    %ebp
 760:	c3                   	ret    
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop

00000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 77c:	8b 15 20 0b 00 00    	mov    0xb20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8d 78 07             	lea    0x7(%eax),%edi
 785:	c1 ef 03             	shr    $0x3,%edi
 788:	47                   	inc    %edi
  if((prevp = freep) == 0){
 789:	85 d2                	test   %edx,%edx
 78b:	0f 84 8f 00 00 00    	je     820 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 791:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 793:	8b 48 04             	mov    0x4(%eax),%ecx
 796:	39 f9                	cmp    %edi,%ecx
 798:	73 5e                	jae    7f8 <malloc+0x88>
  if(nu < 4096)
 79a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 79f:	39 df                	cmp    %ebx,%edi
 7a1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7a4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7ab:	eb 0c                	jmp    7b9 <malloc+0x49>
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7b2:	8b 48 04             	mov    0x4(%eax),%ecx
 7b5:	39 f9                	cmp    %edi,%ecx
 7b7:	73 3f                	jae    7f8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b9:	39 05 20 0b 00 00    	cmp    %eax,0xb20
 7bf:	89 c2                	mov    %eax,%edx
 7c1:	75 ed                	jne    7b0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7c3:	89 34 24             	mov    %esi,(%esp)
 7c6:	e8 20 fc ff ff       	call   3eb <sbrk>
  if(p == (char*)-1)
 7cb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ce:	74 18                	je     7e8 <malloc+0x78>
  hp->s.size = nu;
 7d0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7d3:	83 c0 08             	add    $0x8,%eax
 7d6:	89 04 24             	mov    %eax,(%esp)
 7d9:	e8 f2 fe ff ff       	call   6d0 <free>
  return freep;
 7de:	8b 15 20 0b 00 00    	mov    0xb20,%edx
      if((p = morecore(nunits)) == 0)
 7e4:	85 d2                	test   %edx,%edx
 7e6:	75 c8                	jne    7b0 <malloc+0x40>
        return 0;
  }
}
 7e8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7eb:	31 c0                	xor    %eax,%eax
}
 7ed:	5b                   	pop    %ebx
 7ee:	5e                   	pop    %esi
 7ef:	5f                   	pop    %edi
 7f0:	5d                   	pop    %ebp
 7f1:	c3                   	ret    
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f8:	39 cf                	cmp    %ecx,%edi
 7fa:	74 54                	je     850 <malloc+0xe0>
        p->s.size -= nunits;
 7fc:	29 f9                	sub    %edi,%ecx
 7fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 801:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 804:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 807:	89 15 20 0b 00 00    	mov    %edx,0xb20
}
 80d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 810:	83 c0 08             	add    $0x8,%eax
}
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
 818:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 820:	b8 24 0b 00 00       	mov    $0xb24,%eax
 825:	ba 24 0b 00 00       	mov    $0xb24,%edx
 82a:	a3 20 0b 00 00       	mov    %eax,0xb20
    base.s.size = 0;
 82f:	31 c9                	xor    %ecx,%ecx
 831:	b8 24 0b 00 00       	mov    $0xb24,%eax
    base.s.ptr = freep = prevp = &base;
 836:	89 15 24 0b 00 00    	mov    %edx,0xb24
    base.s.size = 0;
 83c:	89 0d 28 0b 00 00    	mov    %ecx,0xb28
    if(p->s.size >= nunits){
 842:	e9 53 ff ff ff       	jmp    79a <malloc+0x2a>
 847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84e:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb b1                	jmp    807 <malloc+0x97>
