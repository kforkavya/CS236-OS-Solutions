
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  10:	7e 65                	jle    77 <main+0x77>
  12:	8b 45 0c             	mov    0xc(%ebp),%eax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  15:	be 01 00 00 00       	mov    $0x1,%esi
  1a:	8d 78 04             	lea    0x4(%eax),%edi
  1d:	eb 1e                	jmp    3d <main+0x3d>
  1f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  20:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 1; i < argc; i++){
  24:	46                   	inc    %esi
  25:	83 c7 04             	add    $0x4,%edi
    wc(fd, argv[i]);
  28:	89 1c 24             	mov    %ebx,(%esp)
  2b:	e8 60 00 00 00       	call   90 <wc>
    close(fd);
  30:	89 1c 24             	mov    %ebx,(%esp)
  33:	e8 d3 03 00 00       	call   40b <close>
  for(i = 1; i < argc; i++){
  38:	39 75 08             	cmp    %esi,0x8(%ebp)
  3b:	74 35                	je     72 <main+0x72>
    if((fd = open(argv[i], 0)) < 0){
  3d:	31 c0                	xor    %eax,%eax
  3f:	89 44 24 04          	mov    %eax,0x4(%esp)
  43:	8b 07                	mov    (%edi),%eax
  45:	89 04 24             	mov    %eax,(%esp)
  48:	e8 d6 03 00 00       	call   423 <open>
  4d:	89 c3                	mov    %eax,%ebx
      printf(1, "wc: cannot open %s\n", argv[i]);
  4f:	8b 07                	mov    (%edi),%eax
    if((fd = open(argv[i], 0)) < 0){
  51:	85 db                	test   %ebx,%ebx
  53:	79 cb                	jns    20 <main+0x20>
      printf(1, "wc: cannot open %s\n", argv[i]);
  55:	89 44 24 08          	mov    %eax,0x8(%esp)
  59:	c7 44 24 04 fb 08 00 	movl   $0x8fb,0x4(%esp)
  60:	00 
  61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  68:	e8 e3 04 00 00       	call   550 <printf>
      exit();
  6d:	e8 71 03 00 00       	call   3e3 <exit>
  }
  exit();
  72:	e8 6c 03 00 00       	call   3e3 <exit>
    wc(0, "");
  77:	c7 44 24 04 ed 08 00 	movl   $0x8ed,0x4(%esp)
  7e:	00 
  7f:	31 d2                	xor    %edx,%edx
  81:	89 14 24             	mov    %edx,(%esp)
  84:	e8 07 00 00 00       	call   90 <wc>
    exit();
  89:	e8 55 03 00 00       	call   3e3 <exit>
  8e:	66 90                	xchg   %ax,%ax

00000090 <wc>:
{
  90:	55                   	push   %ebp
  l = w = c = 0;
  91:	31 d2                	xor    %edx,%edx
{
  93:	89 e5                	mov    %esp,%ebp
  95:	57                   	push   %edi
  96:	56                   	push   %esi
  97:	53                   	push   %ebx
  l = w = c = 0;
  98:	31 db                	xor    %ebx,%ebx
{
  9a:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  9d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  a4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  ab:	89 55 dc             	mov    %edx,-0x24(%ebp)
  ae:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
  b0:	ba 00 02 00 00       	mov    $0x200,%edx
  b5:	b9 a0 09 00 00       	mov    $0x9a0,%ecx
  ba:	89 54 24 08          	mov    %edx,0x8(%esp)
  be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  c2:	8b 45 08             	mov    0x8(%ebp),%eax
  c5:	89 04 24             	mov    %eax,(%esp)
  c8:	e8 2e 03 00 00       	call   3fb <read>
  cd:	85 c0                	test   %eax,%eax
  cf:	89 c6                	mov    %eax,%esi
  d1:	7e 6d                	jle    140 <wc+0xb0>
    for(i=0; i<n; i++){
  d3:	31 ff                	xor    %edi,%edi
  d5:	eb 15                	jmp    ec <wc+0x5c>
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax
        inword = 0; // if we encounter a whitespace character, we are no longer in a word
  e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  e7:	47                   	inc    %edi
  e8:	39 fe                	cmp    %edi,%esi
  ea:	74 44                	je     130 <wc+0xa0>
      if(strchr(" \r\t\n\v", buf[i]))
  ec:	c7 04 24 d8 08 00 00 	movl   $0x8d8,(%esp)
      if(buf[i] == '\n')
  f3:	0f be 87 a0 09 00 00 	movsbl 0x9a0(%edi),%eax
        l++; // num_lines++
  fa:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  fc:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++; // num_lines++
 100:	3c 0a                	cmp    $0xa,%al
 102:	0f 94 c1             	sete   %cl
 105:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 107:	e8 64 01 00 00       	call   270 <strchr>
 10c:	85 c0                	test   %eax,%eax
 10e:	75 d0                	jne    e0 <wc+0x50>
      else if(!inword){
 110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 113:	85 c0                	test   %eax,%eax
 115:	75 d0                	jne    e7 <wc+0x57>
        w++; // num_words++
 117:	ff 45 e0             	incl   -0x20(%ebp)
    for(i=0; i<n; i++){
 11a:	47                   	inc    %edi
 11b:	39 fe                	cmp    %edi,%esi
        inword = 1; // we are in a word till further notice
 11d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 124:	75 c6                	jne    ec <wc+0x5c>
 126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12d:	8d 76 00             	lea    0x0(%esi),%esi
      c++; // num_chars++ (white space included)
 130:	01 75 dc             	add    %esi,-0x24(%ebp)
 133:	e9 78 ff ff ff       	jmp    b0 <wc+0x20>
 138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 33                	jne    178 <wc+0xe8>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 145:	8b 45 0c             	mov    0xc(%ebp),%eax
 148:	89 54 24 10          	mov    %edx,0x10(%esp)
 14c:	89 44 24 14          	mov    %eax,0x14(%esp)
 150:	8b 45 e0             	mov    -0x20(%ebp),%eax
 153:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 157:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 162:	b8 ee 08 00 00       	mov    $0x8ee,%eax
 167:	89 44 24 04          	mov    %eax,0x4(%esp)
 16b:	e8 e0 03 00 00       	call   550 <printf>
}
 170:	83 c4 3c             	add    $0x3c,%esp
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
    printf(1, "wc: read error\n");
 178:	c7 44 24 04 de 08 00 	movl   $0x8de,0x4(%esp)
 17f:	00 
 180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 187:	e8 c4 03 00 00       	call   550 <printf>
    exit();
 18c:	e8 52 02 00 00       	call   3e3 <exit>
 191:	66 90                	xchg   %ax,%ax
 193:	66 90                	xchg   %ax,%ax
 195:	66 90                	xchg   %ax,%ax
 197:	66 90                	xchg   %ax,%ax
 199:	66 90                	xchg   %ax,%ax
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	53                   	push   %ebx
 1a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1b7:	40                   	inc    %eax
 1b8:	84 d2                	test   %dl,%dl
 1ba:	75 f4                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bc:	5b                   	pop    %ebx
 1bd:	89 c8                	mov    %ecx,%eax
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1da:	0f b6 02             	movzbl (%edx),%eax
 1dd:	84 c0                	test   %al,%al
 1df:	75 15                	jne    1f6 <strcmp+0x26>
 1e1:	eb 30                	jmp    213 <strcmp+0x43>
 1e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e7:	90                   	nop
 1e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1ec:	8d 4b 01             	lea    0x1(%ebx),%ecx
 1ef:	42                   	inc    %edx
  while(*p && *p == *q)
 1f0:	84 c0                	test   %al,%al
 1f2:	74 14                	je     208 <strcmp+0x38>
    p++, q++;
 1f4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 1f6:	0f b6 0b             	movzbl (%ebx),%ecx
 1f9:	38 c1                	cmp    %al,%cl
 1fb:	74 eb                	je     1e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 1fd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1fe:	29 c8                	sub    %ecx,%eax
}
 200:	5d                   	pop    %ebp
 201:	c3                   	ret    
 202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 208:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 20c:	31 c0                	xor    %eax,%eax
}
 20e:	5b                   	pop    %ebx
 20f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 210:	29 c8                	sub    %ecx,%eax
}
 212:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 213:	0f b6 0b             	movzbl (%ebx),%ecx
 216:	31 c0                	xor    %eax,%eax
 218:	eb e3                	jmp    1fd <strcmp+0x2d>
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	40                   	inc    %eax
 231:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 235:	89 c1                	mov    %eax,%ecx
 237:	75 f7                	jne    230 <strlen+0x10>
    ;
  return n;
}
 239:	5d                   	pop    %ebp
 23a:	89 c8                	mov    %ecx,%eax
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 241:	31 c9                	xor    %ecx,%ecx
}
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	5f                   	pop    %edi
 263:	89 d0                	mov    %edx,%eax
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 10                	jne    291 <strchr+0x21>
 281:	eb 1d                	jmp    2a0 <strchr+0x30>
 283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 287:	90                   	nop
 288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 28c:	40                   	inc    %eax
 28d:	84 d2                	test   %dl,%dl
 28f:	74 0f                	je     2a0 <strchr+0x30>
    if(*s == c)
 291:	38 d1                	cmp    %dl,%cl
 293:	75 f3                	jne    288 <strchr+0x18>
      return (char*)s;
  return 0;
}
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29e:	66 90                	xchg   %ax,%ax
 2a0:	5d                   	pop    %ebp
  return 0;
 2a1:	31 c0                	xor    %eax,%eax
}
 2a3:	c3                   	ret    
 2a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2af:	90                   	nop

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	31 f6                	xor    %esi,%esi
{
 2b7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 2b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2bb:	83 ec 3c             	sub    $0x3c,%esp
 2be:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 2c1:	eb 32                	jmp    2f5 <gets+0x45>
 2c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c7:	90                   	nop
    cc = read(0, &c, 1);
 2c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2cc:	b8 01 00 00 00       	mov    $0x1,%eax
 2d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 2d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2dc:	e8 1a 01 00 00       	call   3fb <read>
    if(cc < 1)
 2e1:	85 c0                	test   %eax,%eax
 2e3:	7e 19                	jle    2fe <gets+0x4e>
      break;
    buf[i++] = c;
 2e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2e9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 2ed:	3c 0a                	cmp    $0xa,%al
 2ef:	74 10                	je     301 <gets+0x51>
 2f1:	3c 0d                	cmp    $0xd,%al
 2f3:	74 0c                	je     301 <gets+0x51>
  for(i=0; i+1 < max; ){
 2f5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2f8:	46                   	inc    %esi
 2f9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2fc:	7c ca                	jl     2c8 <gets+0x18>
 2fe:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 301:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 305:	83 c4 3c             	add    $0x3c,%esp
 308:	89 d8                	mov    %ebx,%eax
 30a:	5b                   	pop    %ebx
 30b:	5e                   	pop    %esi
 30c:	5f                   	pop    %edi
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 311:	31 c0                	xor    %eax,%eax
{
 313:	89 e5                	mov    %esp,%ebp
 315:	83 ec 18             	sub    $0x18,%esp
 318:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 31b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 31e:	89 44 24 04          	mov    %eax,0x4(%esp)
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	89 04 24             	mov    %eax,(%esp)
 328:	e8 f6 00 00 00       	call   423 <open>
  if(fd < 0)
 32d:	85 c0                	test   %eax,%eax
 32f:	78 2f                	js     360 <stat+0x50>
 331:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 333:	8b 45 0c             	mov    0xc(%ebp),%eax
 336:	89 1c 24             	mov    %ebx,(%esp)
 339:	89 44 24 04          	mov    %eax,0x4(%esp)
 33d:	e8 f9 00 00 00       	call   43b <fstat>
  close(fd);
 342:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 345:	89 c6                	mov    %eax,%esi
  close(fd);
 347:	e8 bf 00 00 00       	call   40b <close>
  return r;
}
 34c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 34f:	89 f0                	mov    %esi,%eax
 351:	8b 75 fc             	mov    -0x4(%ebp),%esi
 354:	89 ec                	mov    %ebp,%esp
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
    return -1;
 360:	be ff ff ff ff       	mov    $0xffffffff,%esi
 365:	eb e5                	jmp    34c <stat+0x3c>
 367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36e:	66 90                	xchg   %ax,%ax

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 02             	movsbl (%edx),%eax
 37a:	88 c1                	mov    %al,%cl
 37c:	80 e9 30             	sub    $0x30,%cl
 37f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 382:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 387:	77 1c                	ja     3a5 <atoi+0x35>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 390:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 393:	42                   	inc    %edx
 394:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 398:	0f be 02             	movsbl (%edx),%eax
 39b:	88 c3                	mov    %al,%bl
 39d:	80 eb 30             	sub    $0x30,%bl
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	5b                   	pop    %ebx
 3a6:	89 c8                	mov    %ecx,%eax
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	8b 45 10             	mov    0x10(%ebp),%eax
 3b8:	8b 55 08             	mov    0x8(%ebp),%edx
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 c0                	test   %eax,%eax
 3c0:	7e 13                	jle    3d5 <memmove+0x25>
 3c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3c4:	89 d7                	mov    %edx,%edi
 3c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3db:	b8 01 00 00 00       	mov    $0x1,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <exit>:
SYSCALL(exit)
 3e3:	b8 02 00 00 00       	mov    $0x2,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <wait>:
SYSCALL(wait)
 3eb:	b8 03 00 00 00       	mov    $0x3,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <pipe>:
SYSCALL(pipe)
 3f3:	b8 04 00 00 00       	mov    $0x4,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <read>:
SYSCALL(read)
 3fb:	b8 05 00 00 00       	mov    $0x5,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <write>:
SYSCALL(write)
 403:	b8 10 00 00 00       	mov    $0x10,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <close>:
SYSCALL(close)
 40b:	b8 15 00 00 00       	mov    $0x15,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <kill>:
SYSCALL(kill)
 413:	b8 06 00 00 00       	mov    $0x6,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exec>:
SYSCALL(exec)
 41b:	b8 07 00 00 00       	mov    $0x7,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <open>:
SYSCALL(open)
 423:	b8 0f 00 00 00       	mov    $0xf,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <mknod>:
SYSCALL(mknod)
 42b:	b8 11 00 00 00       	mov    $0x11,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <unlink>:
SYSCALL(unlink)
 433:	b8 12 00 00 00       	mov    $0x12,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <fstat>:
SYSCALL(fstat)
 43b:	b8 08 00 00 00       	mov    $0x8,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <link>:
SYSCALL(link)
 443:	b8 13 00 00 00       	mov    $0x13,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mkdir>:
SYSCALL(mkdir)
 44b:	b8 14 00 00 00       	mov    $0x14,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <chdir>:
SYSCALL(chdir)
 453:	b8 09 00 00 00       	mov    $0x9,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <dup>:
SYSCALL(dup)
 45b:	b8 0a 00 00 00       	mov    $0xa,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getpid>:
SYSCALL(getpid)
 463:	b8 0b 00 00 00       	mov    $0xb,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <sbrk>:
SYSCALL(sbrk)
 46b:	b8 0c 00 00 00       	mov    $0xc,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sleep>:
SYSCALL(sleep)
 473:	b8 0d 00 00 00       	mov    $0xd,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <uptime>:
SYSCALL(uptime)
 47b:	b8 0e 00 00 00       	mov    $0xe,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <getNumFreePages>:
 483:	b8 16 00 00 00       	mov    $0x16,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 cb                	mov    %ecx,%ebx
 498:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 49b:	89 d1                	mov    %edx,%ecx
{
 49d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4a0:	89 d0                	mov    %edx,%eax
 4a2:	c1 e8 1f             	shr    $0x1f,%eax
 4a5:	84 c0                	test   %al,%al
 4a7:	0f 84 93 00 00 00    	je     540 <printint+0xb0>
 4ad:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4b1:	0f 84 89 00 00 00    	je     540 <printint+0xb0>
    x = -xx;
 4b7:	f7 d9                	neg    %ecx
    neg = 1;
 4b9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4be:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4c5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4c8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 4d0:	89 c8                	mov    %ecx,%eax
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4d7:	f7 f3                	div    %ebx
 4d9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4dc:	0f b6 92 70 09 00 00 	movzbl 0x970(%edx),%edx
 4e3:	8d 47 01             	lea    0x1(%edi),%eax
 4e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4e9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 4ed:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 4ef:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4f2:	39 da                	cmp    %ebx,%edx
 4f4:	73 da                	jae    4d0 <printint+0x40>
  if(neg)
 4f6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 4f9:	85 c0                	test   %eax,%eax
 4fb:	74 0a                	je     507 <printint+0x77>
    buf[i++] = '-';
 4fd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 500:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 505:	89 c7                	mov    %eax,%edi
 507:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 50a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 50e:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 510:	0f b6 07             	movzbl (%edi),%eax
 513:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 516:	b8 01 00 00 00       	mov    $0x1,%eax
 51b:	89 44 24 08          	mov    %eax,0x8(%esp)
 51f:	89 74 24 04          	mov    %esi,0x4(%esp)
 523:	8b 45 bc             	mov    -0x44(%ebp),%eax
 526:	89 04 24             	mov    %eax,(%esp)
 529:	e8 d5 fe ff ff       	call   403 <write>
  while(--i >= 0)
 52e:	89 f8                	mov    %edi,%eax
 530:	4f                   	dec    %edi
 531:	39 d8                	cmp    %ebx,%eax
 533:	75 db                	jne    510 <printint+0x80>
}
 535:	83 c4 4c             	add    $0x4c,%esp
 538:	5b                   	pop    %ebx
 539:	5e                   	pop    %esi
 53a:	5f                   	pop    %edi
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret    
 53d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 540:	31 c0                	xor    %eax,%eax
 542:	e9 77 ff ff ff       	jmp    4be <printint+0x2e>
 547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54e:	66 90                	xchg   %ax,%ax

00000550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
 555:	53                   	push   %ebx
 556:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 559:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 55c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 55f:	0f b6 1e             	movzbl (%esi),%ebx
 562:	84 db                	test   %bl,%bl
 564:	74 6f                	je     5d5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 566:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 569:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 56b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 56e:	88 d9                	mov    %bl,%cl
 570:	46                   	inc    %esi
 571:	89 d3                	mov    %edx,%ebx
 573:	eb 2b                	jmp    5a0 <printf+0x50>
 575:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	74 4b                	je     5c8 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 57d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 580:	b8 01 00 00 00       	mov    $0x1,%eax
 585:	89 44 24 08          	mov    %eax,0x8(%esp)
 589:	8d 45 e7             	lea    -0x19(%ebp),%eax
 58c:	89 44 24 04          	mov    %eax,0x4(%esp)
 590:	89 3c 24             	mov    %edi,(%esp)
 593:	e8 6b fe ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 598:	0f b6 0e             	movzbl (%esi),%ecx
 59b:	46                   	inc    %esi
 59c:	84 c9                	test   %cl,%cl
 59e:	74 35                	je     5d5 <printf+0x85>
    if(state == 0){
 5a0:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 5a2:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 5a5:	74 d1                	je     578 <printf+0x28>
      }
    } else if(state == '%'){
 5a7:	83 fb 25             	cmp    $0x25,%ebx
 5aa:	75 ec                	jne    598 <printf+0x48>
      if(c == 'd'){
 5ac:	83 f8 25             	cmp    $0x25,%eax
 5af:	0f 84 53 01 00 00    	je     708 <printf+0x1b8>
 5b5:	83 e8 63             	sub    $0x63,%eax
 5b8:	83 f8 15             	cmp    $0x15,%eax
 5bb:	77 23                	ja     5e0 <printf+0x90>
 5bd:	ff 24 85 18 09 00 00 	jmp    *0x918(,%eax,4)
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 5c8:	0f b6 0e             	movzbl (%esi),%ecx
 5cb:	46                   	inc    %esi
        state = '%';
 5cc:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 5d1:	84 c9                	test   %cl,%cl
 5d3:	75 cb                	jne    5a0 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d5:	83 c4 3c             	add    $0x3c,%esp
 5d8:	5b                   	pop    %ebx
 5d9:	5e                   	pop    %esi
 5da:	5f                   	pop    %edi
 5db:	5d                   	pop    %ebp
 5dc:	c3                   	ret    
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
 5e0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 5e3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 5e6:	b8 01 00 00 00       	mov    $0x1,%eax
 5eb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ef:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 5f3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5f7:	89 3c 24             	mov    %edi,(%esp)
 5fa:	e8 04 fe ff ff       	call   403 <write>
        putc(fd, c);
 5ff:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 603:	ba 01 00 00 00       	mov    $0x1,%edx
 608:	88 4d e7             	mov    %cl,-0x19(%ebp)
 60b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 60f:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 611:	89 54 24 08          	mov    %edx,0x8(%esp)
 615:	89 3c 24             	mov    %edi,(%esp)
 618:	e8 e6 fd ff ff       	call   403 <write>
 61d:	e9 76 ff ff ff       	jmp    598 <printf+0x48>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 628:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 62b:	b9 10 00 00 00       	mov    $0x10,%ecx
 630:	8b 13                	mov    (%ebx),%edx
 632:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 639:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 63c:	89 f8                	mov    %edi,%eax
 63e:	e8 4d fe ff ff       	call   490 <printint>
        ap++;
 643:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 646:	31 db                	xor    %ebx,%ebx
 648:	e9 4b ff ff ff       	jmp    598 <printf+0x48>
 64d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 650:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 653:	8b 08                	mov    (%eax),%ecx
        ap++;
 655:	83 c0 04             	add    $0x4,%eax
 658:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 65b:	85 c9                	test   %ecx,%ecx
 65d:	0f 84 cd 00 00 00    	je     730 <printf+0x1e0>
        while(*s != 0){
 663:	0f b6 01             	movzbl (%ecx),%eax
 666:	84 c0                	test   %al,%al
 668:	0f 84 ce 00 00 00    	je     73c <printf+0x1ec>
 66e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 671:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 674:	89 ce                	mov    %ecx,%esi
 676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 680:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 683:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 688:	46                   	inc    %esi
  write(fd, &c, 1);
 689:	89 44 24 08          	mov    %eax,0x8(%esp)
 68d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 691:	89 3c 24             	mov    %edi,(%esp)
 694:	e8 6a fd ff ff       	call   403 <write>
        while(*s != 0){
 699:	0f b6 06             	movzbl (%esi),%eax
 69c:	84 c0                	test   %al,%al
 69e:	75 e0                	jne    680 <printf+0x130>
      state = 0;
 6a0:	8b 75 d0             	mov    -0x30(%ebp),%esi
 6a3:	31 db                	xor    %ebx,%ebx
 6a5:	e9 ee fe ff ff       	jmp    598 <printf+0x48>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6b0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 6b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b8:	8b 13                	mov    (%ebx),%edx
 6ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6c1:	e9 73 ff ff ff       	jmp    639 <printf+0xe9>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 6d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6d3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 6d8:	8b 10                	mov    (%eax),%edx
 6da:	89 55 d0             	mov    %edx,-0x30(%ebp)
 6dd:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 6e8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 6eb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 6ef:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 6f1:	89 3c 24             	mov    %edi,(%esp)
 6f4:	e8 0a fd ff ff       	call   403 <write>
        ap++;
 6f9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6fd:	e9 96 fe ff ff       	jmp    598 <printf+0x48>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 708:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 70b:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 70e:	b9 01 00 00 00       	mov    $0x1,%ecx
 713:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 717:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 719:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 71d:	89 3c 24             	mov    %edi,(%esp)
 720:	e8 de fc ff ff       	call   403 <write>
 725:	e9 6e fe ff ff       	jmp    598 <printf+0x48>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 730:	b0 28                	mov    $0x28,%al
          s = "(null)";
 732:	b9 0f 09 00 00       	mov    $0x90f,%ecx
 737:	e9 32 ff ff ff       	jmp    66e <printf+0x11e>
      state = 0;
 73c:	31 db                	xor    %ebx,%ebx
 73e:	66 90                	xchg   %ax,%ax
 740:	e9 53 fe ff ff       	jmp    598 <printf+0x48>
 745:	66 90                	xchg   %ax,%ax
 747:	66 90                	xchg   %ax,%ax
 749:	66 90                	xchg   %ax,%ax
 74b:	66 90                	xchg   %ax,%ax
 74d:	66 90                	xchg   %ax,%ax
 74f:	90                   	nop

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 75e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
 770:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 774:	39 ca                	cmp    %ecx,%edx
 776:	73 30                	jae    7a8 <free+0x58>
 778:	39 c1                	cmp    %eax,%ecx
 77a:	72 04                	jb     780 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	39 c2                	cmp    %eax,%edx
 77e:	72 f0                	jb     770 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 786:	39 f8                	cmp    %edi,%eax
 788:	74 26                	je     7b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 78d:	8b 42 04             	mov    0x4(%edx),%eax
 790:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 793:	39 f1                	cmp    %esi,%ecx
 795:	74 32                	je     7c9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 797:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 799:	5b                   	pop    %ebx
  freep = p;
 79a:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 7a0:	5e                   	pop    %esi
 7a1:	5f                   	pop    %edi
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret    
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	39 c1                	cmp    %eax,%ecx
 7aa:	72 d0                	jb     77c <free+0x2c>
 7ac:	eb c2                	jmp    770 <free+0x20>
 7ae:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 7b0:	8b 78 04             	mov    0x4(%eax),%edi
 7b3:	01 fe                	add    %edi,%esi
 7b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b8:	8b 02                	mov    (%edx),%eax
 7ba:	8b 00                	mov    (%eax),%eax
 7bc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bf:	8b 42 04             	mov    0x4(%edx),%eax
 7c2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7c5:	39 f1                	cmp    %esi,%ecx
 7c7:	75 ce                	jne    797 <free+0x47>
  freep = p;
 7c9:	89 15 a0 0b 00 00    	mov    %edx,0xba0
    p->s.size += bp->s.size;
 7cf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7d2:	01 c8                	add    %ecx,%eax
 7d4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7d7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7da:	89 0a                	mov    %ecx,(%edx)
}
 7dc:	5b                   	pop    %ebx
 7dd:	5e                   	pop    %esi
 7de:	5f                   	pop    %edi
 7df:	5d                   	pop    %ebp
 7e0:	c3                   	ret    
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ef:	90                   	nop

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 78 07             	lea    0x7(%eax),%edi
 805:	c1 ef 03             	shr    $0x3,%edi
 808:	47                   	inc    %edi
  if((prevp = freep) == 0){
 809:	85 d2                	test   %edx,%edx
 80b:	0f 84 8f 00 00 00    	je     8a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 811:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 813:	8b 48 04             	mov    0x4(%eax),%ecx
 816:	39 f9                	cmp    %edi,%ecx
 818:	73 5e                	jae    878 <malloc+0x88>
  if(nu < 4096)
 81a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 81f:	39 df                	cmp    %ebx,%edi
 821:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 824:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 82b:	eb 0c                	jmp    839 <malloc+0x49>
 82d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 48 04             	mov    0x4(%eax),%ecx
 835:	39 f9                	cmp    %edi,%ecx
 837:	73 3f                	jae    878 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 839:	39 05 a0 0b 00 00    	cmp    %eax,0xba0
 83f:	89 c2                	mov    %eax,%edx
 841:	75 ed                	jne    830 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 843:	89 34 24             	mov    %esi,(%esp)
 846:	e8 20 fc ff ff       	call   46b <sbrk>
  if(p == (char*)-1)
 84b:	83 f8 ff             	cmp    $0xffffffff,%eax
 84e:	74 18                	je     868 <malloc+0x78>
  hp->s.size = nu;
 850:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 853:	83 c0 08             	add    $0x8,%eax
 856:	89 04 24             	mov    %eax,(%esp)
 859:	e8 f2 fe ff ff       	call   750 <free>
  return freep;
 85e:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 864:	85 d2                	test   %edx,%edx
 866:	75 c8                	jne    830 <malloc+0x40>
        return 0;
  }
}
 868:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 86b:	31 c0                	xor    %eax,%eax
}
 86d:	5b                   	pop    %ebx
 86e:	5e                   	pop    %esi
 86f:	5f                   	pop    %edi
 870:	5d                   	pop    %ebp
 871:	c3                   	ret    
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 878:	39 cf                	cmp    %ecx,%edi
 87a:	74 54                	je     8d0 <malloc+0xe0>
        p->s.size -= nunits;
 87c:	29 f9                	sub    %edi,%ecx
 87e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 881:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 884:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 887:	89 15 a0 0b 00 00    	mov    %edx,0xba0
}
 88d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 890:	83 c0 08             	add    $0x8,%eax
}
 893:	5b                   	pop    %ebx
 894:	5e                   	pop    %esi
 895:	5f                   	pop    %edi
 896:	5d                   	pop    %ebp
 897:	c3                   	ret    
 898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8a0:	b8 a4 0b 00 00       	mov    $0xba4,%eax
 8a5:	ba a4 0b 00 00       	mov    $0xba4,%edx
 8aa:	a3 a0 0b 00 00       	mov    %eax,0xba0
    base.s.size = 0;
 8af:	31 c9                	xor    %ecx,%ecx
 8b1:	b8 a4 0b 00 00       	mov    $0xba4,%eax
    base.s.ptr = freep = prevp = &base;
 8b6:	89 15 a4 0b 00 00    	mov    %edx,0xba4
    base.s.size = 0;
 8bc:	89 0d a8 0b 00 00    	mov    %ecx,0xba8
    if(p->s.size >= nunits){
 8c2:	e9 53 ff ff ff       	jmp    81a <malloc+0x2a>
 8c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ce:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 08                	mov    (%eax),%ecx
 8d2:	89 0a                	mov    %ecx,(%edx)
 8d4:	eb b1                	jmp    887 <malloc+0x97>
