
_grep:     file format elf32-i386


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
   9:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
{
  10:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(argc <= 1){
  13:	7e 78                	jle    8d <main+0x8d>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
  15:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  pattern = argv[1];
  19:	8b 7a 04             	mov    0x4(%edx),%edi
  if(argc <= 2){
  1c:	0f 84 84 00 00 00    	je     a6 <main+0xa6>
  22:	8d 72 08             	lea    0x8(%edx),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  25:	bb 02 00 00 00       	mov    $0x2,%ebx
  2a:	eb 29                	jmp    55 <main+0x55>
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  30:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 2; i < argc; i++){
  34:	43                   	inc    %ebx
  35:	83 c6 04             	add    $0x4,%esi
    grep(pattern, fd);
  38:	89 3c 24             	mov    %edi,(%esp)
  3b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  3f:	e8 9c 01 00 00       	call   1e0 <grep>
    close(fd);
  44:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  48:	89 04 24             	mov    %eax,(%esp)
  4b:	e8 ab 05 00 00       	call   5fb <close>
  for(i = 2; i < argc; i++){
  50:	39 5d 08             	cmp    %ebx,0x8(%ebp)
  53:	7e 33                	jle    88 <main+0x88>
    if((fd = open(argv[i], 0)) < 0){
  55:	31 c0                	xor    %eax,%eax
  57:	89 44 24 04          	mov    %eax,0x4(%esp)
  5b:	8b 06                	mov    (%esi),%eax
  5d:	89 04 24             	mov    %eax,(%esp)
  60:	e8 ae 05 00 00       	call   613 <open>
  65:	85 c0                	test   %eax,%eax
  67:	79 c7                	jns    30 <main+0x30>
      printf(1, "grep: cannot open %s\n", argv[i]);
  69:	8b 06                	mov    (%esi),%eax
  6b:	c7 44 24 04 e8 0a 00 	movl   $0xae8,0x4(%esp)
  72:	00 
  73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7a:	89 44 24 08          	mov    %eax,0x8(%esp)
  7e:	e8 bd 06 00 00       	call   740 <printf>
      exit();
  83:	e8 4b 05 00 00       	call   5d3 <exit>
  }
  exit();
  88:	e8 46 05 00 00       	call   5d3 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  8d:	c7 44 24 04 c8 0a 00 	movl   $0xac8,0x4(%esp)
  94:	00 
  95:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  9c:	e8 9f 06 00 00       	call   740 <printf>
    exit();
  a1:	e8 2d 05 00 00       	call   5d3 <exit>
    grep(pattern, 0);
  a6:	89 3c 24             	mov    %edi,(%esp)
  a9:	31 d2                	xor    %edx,%edx
  ab:	89 54 24 04          	mov    %edx,0x4(%esp)
  af:	e8 2c 01 00 00       	call   1e0 <grep>
    exit();
  b4:	e8 1a 05 00 00       	call   5d3 <exit>
  b9:	66 90                	xchg   %ax,%ax
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  cf:	0f b6 16             	movzbl (%esi),%edx
  d2:	84 d2                	test   %dl,%dl
  d4:	0f 84 96 00 00 00    	je     170 <matchhere+0xb0>
    return 1;
  if(re[1] == '*')
  da:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  de:	3c 2a                	cmp    $0x2a,%al
  e0:	74 2f                	je     111 <matchhere+0x51>
  e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
  f0:	80 fa 24             	cmp    $0x24,%dl
    return *text == '\0';
  f3:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
  f6:	74 50                	je     148 <matchhere+0x88>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  f8:	84 c9                	test   %cl,%cl
  fa:	74 68                	je     164 <matchhere+0xa4>
  fc:	80 fa 2e             	cmp    $0x2e,%dl
  ff:	75 5f                	jne    160 <matchhere+0xa0>
    return matchhere(re+1, text+1);
 101:	43                   	inc    %ebx
 102:	46                   	inc    %esi
  if(re[0] == '\0')
 103:	84 c0                	test   %al,%al
 105:	74 69                	je     170 <matchhere+0xb0>
 107:	88 c2                	mov    %al,%dl
  if(re[1] == '*')
 109:	0f b6 46 01          	movzbl 0x1(%esi),%eax
 10d:	3c 2a                	cmp    $0x2a,%al
 10f:	75 df                	jne    f0 <matchhere+0x30>
    return matchstar(re[0], re+2, text);
 111:	83 c6 02             	add    $0x2,%esi
 114:	0f be fa             	movsbl %dl,%edi
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
 117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11e:	66 90                	xchg   %ax,%ax
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 120:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 124:	89 34 24             	mov    %esi,(%esp)
 127:	e8 94 ff ff ff       	call   c0 <matchhere>
 12c:	85 c0                	test   %eax,%eax
 12e:	75 40                	jne    170 <matchhere+0xb0>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 130:	0f be 0b             	movsbl (%ebx),%ecx
 133:	84 c9                	test   %cl,%cl
 135:	74 3e                	je     175 <matchhere+0xb5>
 137:	43                   	inc    %ebx
 138:	39 f9                	cmp    %edi,%ecx
 13a:	74 e4                	je     120 <matchhere+0x60>
 13c:	83 ff 2e             	cmp    $0x2e,%edi
 13f:	74 df                	je     120 <matchhere+0x60>
 141:	eb 32                	jmp    175 <matchhere+0xb5>
 143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 147:	90                   	nop
  if(re[0] == '$' && re[1] == '\0')
 148:	84 c0                	test   %al,%al
 14a:	74 31                	je     17d <matchhere+0xbd>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14c:	84 c9                	test   %cl,%cl
 14e:	66 90                	xchg   %ax,%ax
 150:	74 12                	je     164 <matchhere+0xa4>
 152:	80 f9 24             	cmp    $0x24,%cl
 155:	75 0d                	jne    164 <matchhere+0xa4>
    return matchhere(re+1, text+1);
 157:	43                   	inc    %ebx
 158:	46                   	inc    %esi
  if(re[0] == '\0')
 159:	88 c2                	mov    %al,%dl
 15b:	eb ac                	jmp    109 <matchhere+0x49>
 15d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 160:	38 d1                	cmp    %dl,%cl
 162:	74 9d                	je     101 <matchhere+0x41>
}
 164:	83 c4 1c             	add    $0x1c,%esp
  return 0;
 167:	31 c0                	xor    %eax,%eax
}
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5f                   	pop    %edi
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
 16e:	66 90                	xchg   %ax,%ax
    return 1;
 170:	b8 01 00 00 00       	mov    $0x1,%eax
}
 175:	83 c4 1c             	add    $0x1c,%esp
 178:	5b                   	pop    %ebx
 179:	5e                   	pop    %esi
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    
    return *text == '\0';
 17d:	31 c0                	xor    %eax,%eax
 17f:	84 c9                	test   %cl,%cl
 181:	0f 94 c0             	sete   %al
 184:	eb ef                	jmp    175 <matchhere+0xb5>
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <match>:
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
 195:	83 ec 10             	sub    $0x10,%esp
 198:	8b 5d 08             	mov    0x8(%ebp),%ebx
 19b:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 19e:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1a1:	75 0c                	jne    1af <match+0x1f>
 1a3:	eb 2b                	jmp    1d0 <match+0x40>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1a8:	46                   	inc    %esi
 1a9:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1ad:	74 15                	je     1c4 <match+0x34>
    if(matchhere(re, text))
 1af:	89 74 24 04          	mov    %esi,0x4(%esp)
 1b3:	89 1c 24             	mov    %ebx,(%esp)
 1b6:	e8 05 ff ff ff       	call   c0 <matchhere>
 1bb:	85 c0                	test   %eax,%eax
 1bd:	74 e9                	je     1a8 <match+0x18>
      return 1;
 1bf:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1c4:	83 c4 10             	add    $0x10,%esp
 1c7:	5b                   	pop    %ebx
 1c8:	5e                   	pop    %esi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop
    return matchhere(re+1, text);
 1d0:	43                   	inc    %ebx
 1d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	5b                   	pop    %ebx
 1d8:	5e                   	pop    %esi
 1d9:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1da:	e9 e1 fe ff ff       	jmp    c0 <matchhere>
 1df:	90                   	nop

000001e0 <grep>:
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
  m = 0;
 1e4:	31 ff                	xor    %edi,%edi
{
 1e6:	56                   	push   %esi
 1e7:	53                   	push   %ebx
 1e8:	83 ec 2c             	sub    $0x2c,%esp
 1eb:	89 7d e0             	mov    %edi,-0x20(%ebp)
 1ee:	8b 75 08             	mov    0x8(%ebp),%esi
    return matchhere(re+1, text);
 1f1:	8d 46 01             	lea    0x1(%esi),%eax
 1f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 200:	8b 55 e0             	mov    -0x20(%ebp),%edx
 203:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 208:	29 d0                	sub    %edx,%eax
 20a:	89 44 24 08          	mov    %eax,0x8(%esp)
 20e:	8d 82 80 0b 00 00    	lea    0xb80(%edx),%eax
 214:	89 44 24 04          	mov    %eax,0x4(%esp)
 218:	8b 45 0c             	mov    0xc(%ebp),%eax
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 c8 03 00 00       	call   5eb <read>
 223:	85 c0                	test   %eax,%eax
 225:	0f 8e fa 00 00 00    	jle    325 <grep+0x145>
    m += n;
 22b:	01 45 e0             	add    %eax,-0x20(%ebp)
 22e:	bb 80 0b 00 00       	mov    $0xb80,%ebx
 233:	8b 55 e0             	mov    -0x20(%ebp),%edx
    buf[m] = '\0';
 236:	c6 82 80 0b 00 00 00 	movb   $0x0,0xb80(%edx)
    while((q = strchr(p, '\n')) != 0){
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	89 1c 24             	mov    %ebx,(%esp)
 243:	ba 0a 00 00 00       	mov    $0xa,%edx
 248:	89 54 24 04          	mov    %edx,0x4(%esp)
 24c:	e8 0f 02 00 00       	call   460 <strchr>
 251:	85 c0                	test   %eax,%eax
 253:	89 c1                	mov    %eax,%ecx
 255:	0f 84 85 00 00 00    	je     2e0 <grep+0x100>
      *q = 0;
 25b:	c6 01 00             	movb   $0x0,(%ecx)
  if(re[0] == '^')
 25e:	80 3e 5e             	cmpb   $0x5e,(%esi)
 261:	74 55                	je     2b8 <grep+0xd8>
 263:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
 266:	89 cf                	mov    %ecx,%edi
 268:	eb 0d                	jmp    277 <grep+0x97>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 270:	43                   	inc    %ebx
 271:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 275:	74 39                	je     2b0 <grep+0xd0>
    if(matchhere(re, text))
 277:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 27b:	89 34 24             	mov    %esi,(%esp)
 27e:	e8 3d fe ff ff       	call   c0 <matchhere>
 283:	85 c0                	test   %eax,%eax
 285:	74 e9                	je     270 <grep+0x90>
        write(1, p, q+1 - p);
 287:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
 28a:	89 f9                	mov    %edi,%ecx
 28c:	8d 7f 01             	lea    0x1(%edi),%edi
        *q = '\n';
 28f:	c6 01 0a             	movb   $0xa,(%ecx)
        write(1, p, q+1 - p);
 292:	89 f8                	mov    %edi,%eax
 294:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 298:	29 d8                	sub    %ebx,%eax
 29a:	89 fb                	mov    %edi,%ebx
 29c:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a7:	e8 47 03 00 00       	call   5f3 <write>
 2ac:	eb 92                	jmp    240 <grep+0x60>
 2ae:	66 90                	xchg   %ax,%ax
 2b0:	8d 5f 01             	lea    0x1(%edi),%ebx
      p = q+1;
 2b3:	eb 8b                	jmp    240 <grep+0x60>
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
 2b8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    return matchhere(re+1, text);
 2bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
 2c2:	89 04 24             	mov    %eax,(%esp)
 2c5:	e8 f6 fd ff ff       	call   c0 <matchhere>
        write(1, p, q+1 - p);
 2ca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 2cd:	8d 79 01             	lea    0x1(%ecx),%edi
      if(match(pattern, p)){
 2d0:	85 c0                	test   %eax,%eax
 2d2:	75 bb                	jne    28f <grep+0xaf>
        write(1, p, q+1 - p);
 2d4:	89 fb                	mov    %edi,%ebx
 2d6:	e9 65 ff ff ff       	jmp    240 <grep+0x60>
 2db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2df:	90                   	nop
    if(p == buf)
 2e0:	81 fb 80 0b 00 00    	cmp    $0xb80,%ebx
 2e6:	74 31                	je     319 <grep+0x139>
    if(m > 0){
 2e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2eb:	85 c0                	test   %eax,%eax
 2ed:	0f 8e 0d ff ff ff    	jle    200 <grep+0x20>
      m -= p - buf;
 2f3:	89 d8                	mov    %ebx,%eax
 2f5:	2d 80 0b 00 00       	sub    $0xb80,%eax
 2fa:	29 45 e0             	sub    %eax,-0x20(%ebp)
 2fd:	8b 7d e0             	mov    -0x20(%ebp),%edi
      memmove(buf, p, m);
 300:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 304:	c7 04 24 80 0b 00 00 	movl   $0xb80,(%esp)
 30b:	89 7c 24 08          	mov    %edi,0x8(%esp)
 30f:	e8 8c 02 00 00       	call   5a0 <memmove>
 314:	e9 e7 fe ff ff       	jmp    200 <grep+0x20>
      m = 0;
 319:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 320:	e9 db fe ff ff       	jmp    200 <grep+0x20>
}
 325:	83 c4 2c             	add    $0x2c,%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi

00000330 <matchstar>:
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 1c             	sub    $0x1c,%esp
 339:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33c:	8b 75 0c             	mov    0xc(%ebp),%esi
 33f:	8b 7d 10             	mov    0x10(%ebp),%edi
 342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 350:	89 7c 24 04          	mov    %edi,0x4(%esp)
 354:	89 34 24             	mov    %esi,(%esp)
 357:	e8 64 fd ff ff       	call   c0 <matchhere>
 35c:	85 c0                	test   %eax,%eax
 35e:	75 20                	jne    380 <matchstar+0x50>
  }while(*text!='\0' && (*text++==c || c=='.'));
 360:	0f be 17             	movsbl (%edi),%edx
 363:	84 d2                	test   %dl,%dl
 365:	74 0a                	je     371 <matchstar+0x41>
 367:	47                   	inc    %edi
 368:	39 da                	cmp    %ebx,%edx
 36a:	74 e4                	je     350 <matchstar+0x20>
 36c:	83 fb 2e             	cmp    $0x2e,%ebx
 36f:	74 df                	je     350 <matchstar+0x20>
}
 371:	83 c4 1c             	add    $0x1c,%esp
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5f                   	pop    %edi
 377:	5d                   	pop    %ebp
 378:	c3                   	ret    
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 380:	83 c4 1c             	add    $0x1c,%esp
      return 1;
 383:	b8 01 00 00 00       	mov    $0x1,%eax
}
 388:	5b                   	pop    %ebx
 389:	5e                   	pop    %esi
 38a:	5f                   	pop    %edi
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	66 90                	xchg   %ax,%ax
 38f:	90                   	nop

00000390 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 390:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 391:	31 c0                	xor    %eax,%eax
{
 393:	89 e5                	mov    %esp,%ebp
 395:	53                   	push   %ebx
 396:	8b 4d 08             	mov    0x8(%ebp),%ecx
 399:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 3a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3a7:	40                   	inc    %eax
 3a8:	84 d2                	test   %dl,%dl
 3aa:	75 f4                	jne    3a0 <strcpy+0x10>
    ;
  return os;
}
 3ac:	5b                   	pop    %ebx
 3ad:	89 c8                	mov    %ecx,%eax
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3bf:	90                   	nop

000003c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 55 08             	mov    0x8(%ebp),%edx
 3c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3ca:	0f b6 02             	movzbl (%edx),%eax
 3cd:	84 c0                	test   %al,%al
 3cf:	75 15                	jne    3e6 <strcmp+0x26>
 3d1:	eb 30                	jmp    403 <strcmp+0x43>
 3d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d7:	90                   	nop
 3d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3dc:	8d 4b 01             	lea    0x1(%ebx),%ecx
 3df:	42                   	inc    %edx
  while(*p && *p == *q)
 3e0:	84 c0                	test   %al,%al
 3e2:	74 14                	je     3f8 <strcmp+0x38>
    p++, q++;
 3e4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
 3e6:	0f b6 0b             	movzbl (%ebx),%ecx
 3e9:	38 c1                	cmp    %al,%cl
 3eb:	74 eb                	je     3d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 3ed:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3ee:	29 c8                	sub    %ecx,%eax
}
 3f0:	5d                   	pop    %ebp
 3f1:	c3                   	ret    
 3f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 3f8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 3fc:	31 c0                	xor    %eax,%eax
}
 3fe:	5b                   	pop    %ebx
 3ff:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 400:	29 c8                	sub    %ecx,%eax
}
 402:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 403:	0f b6 0b             	movzbl (%ebx),%ecx
 406:	31 c0                	xor    %eax,%eax
 408:	eb e3                	jmp    3ed <strcmp+0x2d>
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <strlen>:

uint
strlen(const char *s)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 416:	80 3a 00             	cmpb   $0x0,(%edx)
 419:	74 15                	je     430 <strlen+0x20>
 41b:	31 c0                	xor    %eax,%eax
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	40                   	inc    %eax
 421:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 425:	89 c1                	mov    %eax,%ecx
 427:	75 f7                	jne    420 <strlen+0x10>
    ;
  return n;
}
 429:	5d                   	pop    %ebp
 42a:	89 c8                	mov    %ecx,%eax
 42c:	c3                   	ret    
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 431:	31 c9                	xor    %ecx,%ecx
}
 433:	89 c8                	mov    %ecx,%eax
 435:	c3                   	ret    
 436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi

00000440 <memset>:

void*
memset(void *dst, int c, uint n)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 447:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44a:	8b 45 0c             	mov    0xc(%ebp),%eax
 44d:	89 d7                	mov    %edx,%edi
 44f:	fc                   	cld    
 450:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 452:	5f                   	pop    %edi
 453:	89 d0                	mov    %edx,%eax
 455:	5d                   	pop    %ebp
 456:	c3                   	ret    
 457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45e:	66 90                	xchg   %ax,%ax

00000460 <strchr>:

char*
strchr(const char *s, char c)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 45 08             	mov    0x8(%ebp),%eax
 466:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 46a:	0f b6 10             	movzbl (%eax),%edx
 46d:	84 d2                	test   %dl,%dl
 46f:	75 10                	jne    481 <strchr+0x21>
 471:	eb 1d                	jmp    490 <strchr+0x30>
 473:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 477:	90                   	nop
 478:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 47c:	40                   	inc    %eax
 47d:	84 d2                	test   %dl,%dl
 47f:	74 0f                	je     490 <strchr+0x30>
    if(*s == c)
 481:	38 d1                	cmp    %dl,%cl
 483:	75 f3                	jne    478 <strchr+0x18>
      return (char*)s;
  return 0;
}
 485:	5d                   	pop    %ebp
 486:	c3                   	ret    
 487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48e:	66 90                	xchg   %ax,%ax
 490:	5d                   	pop    %ebp
  return 0;
 491:	31 c0                	xor    %eax,%eax
}
 493:	c3                   	ret    
 494:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop

000004a0 <gets>:

char*
gets(char *buf, int max)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a5:	31 f6                	xor    %esi,%esi
{
 4a7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 4a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 4ab:	83 ec 3c             	sub    $0x3c,%esp
 4ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 4b1:	eb 32                	jmp    4e5 <gets+0x45>
 4b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b7:	90                   	nop
    cc = read(0, &c, 1);
 4b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4bc:	b8 01 00 00 00       	mov    $0x1,%eax
 4c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4cc:	e8 1a 01 00 00       	call   5eb <read>
    if(cc < 1)
 4d1:	85 c0                	test   %eax,%eax
 4d3:	7e 19                	jle    4ee <gets+0x4e>
      break;
    buf[i++] = c;
 4d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4d9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 4dd:	3c 0a                	cmp    $0xa,%al
 4df:	74 10                	je     4f1 <gets+0x51>
 4e1:	3c 0d                	cmp    $0xd,%al
 4e3:	74 0c                	je     4f1 <gets+0x51>
  for(i=0; i+1 < max; ){
 4e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4e8:	46                   	inc    %esi
 4e9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4ec:	7c ca                	jl     4b8 <gets+0x18>
 4ee:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 4f1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 4f5:	83 c4 3c             	add    $0x3c,%esp
 4f8:	89 d8                	mov    %ebx,%eax
 4fa:	5b                   	pop    %ebx
 4fb:	5e                   	pop    %esi
 4fc:	5f                   	pop    %edi
 4fd:	5d                   	pop    %ebp
 4fe:	c3                   	ret    
 4ff:	90                   	nop

00000500 <stat>:

int
stat(const char *n, struct stat *st)
{
 500:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 501:	31 c0                	xor    %eax,%eax
{
 503:	89 e5                	mov    %esp,%ebp
 505:	83 ec 18             	sub    $0x18,%esp
 508:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 50b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 50e:	89 44 24 04          	mov    %eax,0x4(%esp)
 512:	8b 45 08             	mov    0x8(%ebp),%eax
 515:	89 04 24             	mov    %eax,(%esp)
 518:	e8 f6 00 00 00       	call   613 <open>
  if(fd < 0)
 51d:	85 c0                	test   %eax,%eax
 51f:	78 2f                	js     550 <stat+0x50>
 521:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 523:	8b 45 0c             	mov    0xc(%ebp),%eax
 526:	89 1c 24             	mov    %ebx,(%esp)
 529:	89 44 24 04          	mov    %eax,0x4(%esp)
 52d:	e8 f9 00 00 00       	call   62b <fstat>
  close(fd);
 532:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 535:	89 c6                	mov    %eax,%esi
  close(fd);
 537:	e8 bf 00 00 00       	call   5fb <close>
  return r;
}
 53c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 53f:	89 f0                	mov    %esi,%eax
 541:	8b 75 fc             	mov    -0x4(%ebp),%esi
 544:	89 ec                	mov    %ebp,%esp
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
    return -1;
 550:	be ff ff ff ff       	mov    $0xffffffff,%esi
 555:	eb e5                	jmp    53c <stat+0x3c>
 557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55e:	66 90                	xchg   %ax,%ax

00000560 <atoi>:

int
atoi(const char *s)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 567:	0f be 02             	movsbl (%edx),%eax
 56a:	88 c1                	mov    %al,%cl
 56c:	80 e9 30             	sub    $0x30,%cl
 56f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 572:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 577:	77 1c                	ja     595 <atoi+0x35>
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 580:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 583:	42                   	inc    %edx
 584:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 588:	0f be 02             	movsbl (%edx),%eax
 58b:	88 c3                	mov    %al,%bl
 58d:	80 eb 30             	sub    $0x30,%bl
 590:	80 fb 09             	cmp    $0x9,%bl
 593:	76 eb                	jbe    580 <atoi+0x20>
  return n;
}
 595:	5b                   	pop    %ebx
 596:	89 c8                	mov    %ecx,%eax
 598:	5d                   	pop    %ebp
 599:	c3                   	ret    
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	8b 45 10             	mov    0x10(%ebp),%eax
 5a8:	8b 55 08             	mov    0x8(%ebp),%edx
 5ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5ae:	85 c0                	test   %eax,%eax
 5b0:	7e 13                	jle    5c5 <memmove+0x25>
 5b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 5b4:	89 d7                	mov    %edx,%edi
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5c1:	39 f8                	cmp    %edi,%eax
 5c3:	75 fb                	jne    5c0 <memmove+0x20>
  return vdst;
}
 5c5:	5e                   	pop    %esi
 5c6:	89 d0                	mov    %edx,%eax
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    

000005cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5cb:	b8 01 00 00 00       	mov    $0x1,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <exit>:
SYSCALL(exit)
 5d3:	b8 02 00 00 00       	mov    $0x2,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <wait>:
SYSCALL(wait)
 5db:	b8 03 00 00 00       	mov    $0x3,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <pipe>:
SYSCALL(pipe)
 5e3:	b8 04 00 00 00       	mov    $0x4,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <read>:
SYSCALL(read)
 5eb:	b8 05 00 00 00       	mov    $0x5,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <write>:
SYSCALL(write)
 5f3:	b8 10 00 00 00       	mov    $0x10,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <close>:
SYSCALL(close)
 5fb:	b8 15 00 00 00       	mov    $0x15,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <kill>:
SYSCALL(kill)
 603:	b8 06 00 00 00       	mov    $0x6,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <exec>:
SYSCALL(exec)
 60b:	b8 07 00 00 00       	mov    $0x7,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <open>:
SYSCALL(open)
 613:	b8 0f 00 00 00       	mov    $0xf,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <mknod>:
SYSCALL(mknod)
 61b:	b8 11 00 00 00       	mov    $0x11,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <unlink>:
SYSCALL(unlink)
 623:	b8 12 00 00 00       	mov    $0x12,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <fstat>:
SYSCALL(fstat)
 62b:	b8 08 00 00 00       	mov    $0x8,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <link>:
SYSCALL(link)
 633:	b8 13 00 00 00       	mov    $0x13,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <mkdir>:
SYSCALL(mkdir)
 63b:	b8 14 00 00 00       	mov    $0x14,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <chdir>:
SYSCALL(chdir)
 643:	b8 09 00 00 00       	mov    $0x9,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <dup>:
SYSCALL(dup)
 64b:	b8 0a 00 00 00       	mov    $0xa,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <getpid>:
SYSCALL(getpid)
 653:	b8 0b 00 00 00       	mov    $0xb,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <sbrk>:
SYSCALL(sbrk)
 65b:	b8 0c 00 00 00       	mov    $0xc,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <sleep>:
SYSCALL(sleep)
 663:	b8 0d 00 00 00       	mov    $0xd,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <uptime>:
SYSCALL(uptime)
 66b:	b8 0e 00 00 00       	mov    $0xe,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <getNumFreePages>:
 673:	b8 16 00 00 00       	mov    $0x16,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	89 cb                	mov    %ecx,%ebx
 688:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 68b:	89 d1                	mov    %edx,%ecx
{
 68d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 690:	89 d0                	mov    %edx,%eax
 692:	c1 e8 1f             	shr    $0x1f,%eax
 695:	84 c0                	test   %al,%al
 697:	0f 84 93 00 00 00    	je     730 <printint+0xb0>
 69d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6a1:	0f 84 89 00 00 00    	je     730 <printint+0xb0>
    x = -xx;
 6a7:	f7 d9                	neg    %ecx
    neg = 1;
 6a9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 6ae:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6b5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6b8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 6c0:	89 c8                	mov    %ecx,%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 6c7:	f7 f3                	div    %ebx
 6c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6cc:	0f b6 92 60 0b 00 00 	movzbl 0xb60(%edx),%edx
 6d3:	8d 47 01             	lea    0x1(%edi),%eax
 6d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 6d9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 6dd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 6df:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 6e2:	39 da                	cmp    %ebx,%edx
 6e4:	73 da                	jae    6c0 <printint+0x40>
  if(neg)
 6e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 6e9:	85 c0                	test   %eax,%eax
 6eb:	74 0a                	je     6f7 <printint+0x77>
    buf[i++] = '-';
 6ed:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6f0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 6f5:	89 c7                	mov    %eax,%edi
 6f7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 6fa:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 6fe:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
 700:	0f b6 07             	movzbl (%edi),%eax
 703:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 706:	b8 01 00 00 00       	mov    $0x1,%eax
 70b:	89 44 24 08          	mov    %eax,0x8(%esp)
 70f:	89 74 24 04          	mov    %esi,0x4(%esp)
 713:	8b 45 bc             	mov    -0x44(%ebp),%eax
 716:	89 04 24             	mov    %eax,(%esp)
 719:	e8 d5 fe ff ff       	call   5f3 <write>
  while(--i >= 0)
 71e:	89 f8                	mov    %edi,%eax
 720:	4f                   	dec    %edi
 721:	39 d8                	cmp    %ebx,%eax
 723:	75 db                	jne    700 <printint+0x80>
}
 725:	83 c4 4c             	add    $0x4c,%esp
 728:	5b                   	pop    %ebx
 729:	5e                   	pop    %esi
 72a:	5f                   	pop    %edi
 72b:	5d                   	pop    %ebp
 72c:	c3                   	ret    
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 730:	31 c0                	xor    %eax,%eax
 732:	e9 77 ff ff ff       	jmp    6ae <printint+0x2e>
 737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73e:	66 90                	xchg   %ax,%ax

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 74c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 1e             	movzbl (%esi),%ebx
 752:	84 db                	test   %bl,%bl
 754:	74 6f                	je     7c5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
 756:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
 759:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 75b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
 75e:	88 d9                	mov    %bl,%cl
 760:	46                   	inc    %esi
 761:	89 d3                	mov    %edx,%ebx
 763:	eb 2b                	jmp    790 <printf+0x50>
 765:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 768:	83 f8 25             	cmp    $0x25,%eax
 76b:	74 4b                	je     7b8 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
 76d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 770:	b8 01 00 00 00       	mov    $0x1,%eax
 775:	89 44 24 08          	mov    %eax,0x8(%esp)
 779:	8d 45 e7             	lea    -0x19(%ebp),%eax
 77c:	89 44 24 04          	mov    %eax,0x4(%esp)
 780:	89 3c 24             	mov    %edi,(%esp)
 783:	e8 6b fe ff ff       	call   5f3 <write>
  for(i = 0; fmt[i]; i++){
 788:	0f b6 0e             	movzbl (%esi),%ecx
 78b:	46                   	inc    %esi
 78c:	84 c9                	test   %cl,%cl
 78e:	74 35                	je     7c5 <printf+0x85>
    if(state == 0){
 790:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
 792:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
 795:	74 d1                	je     768 <printf+0x28>
      }
    } else if(state == '%'){
 797:	83 fb 25             	cmp    $0x25,%ebx
 79a:	75 ec                	jne    788 <printf+0x48>
      if(c == 'd'){
 79c:	83 f8 25             	cmp    $0x25,%eax
 79f:	0f 84 53 01 00 00    	je     8f8 <printf+0x1b8>
 7a5:	83 e8 63             	sub    $0x63,%eax
 7a8:	83 f8 15             	cmp    $0x15,%eax
 7ab:	77 23                	ja     7d0 <printf+0x90>
 7ad:	ff 24 85 08 0b 00 00 	jmp    *0xb08(,%eax,4)
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7b8:	0f b6 0e             	movzbl (%esi),%ecx
 7bb:	46                   	inc    %esi
        state = '%';
 7bc:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
 7c1:	84 c9                	test   %cl,%cl
 7c3:	75 cb                	jne    790 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7c5:	83 c4 3c             	add    $0x3c,%esp
 7c8:	5b                   	pop    %ebx
 7c9:	5e                   	pop    %esi
 7ca:	5f                   	pop    %edi
 7cb:	5d                   	pop    %ebp
 7cc:	c3                   	ret    
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
 7d0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
 7d3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 7d6:	b8 01 00 00 00       	mov    $0x1,%eax
 7db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7df:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 7e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 7e7:	89 3c 24             	mov    %edi,(%esp)
 7ea:	e8 04 fe ff ff       	call   5f3 <write>
        putc(fd, c);
 7ef:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
 7f3:	ba 01 00 00 00       	mov    $0x1,%edx
 7f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
 7fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 7ff:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 801:	89 54 24 08          	mov    %edx,0x8(%esp)
 805:	89 3c 24             	mov    %edi,(%esp)
 808:	e8 e6 fd ff ff       	call   5f3 <write>
 80d:	e9 76 ff ff ff       	jmp    788 <printf+0x48>
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 818:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 81b:	b9 10 00 00 00       	mov    $0x10,%ecx
 820:	8b 13                	mov    (%ebx),%edx
 822:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 829:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 82c:	89 f8                	mov    %edi,%eax
 82e:	e8 4d fe ff ff       	call   680 <printint>
        ap++;
 833:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
 836:	31 db                	xor    %ebx,%ebx
 838:	e9 4b ff ff ff       	jmp    788 <printf+0x48>
 83d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 840:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 843:	8b 08                	mov    (%eax),%ecx
        ap++;
 845:	83 c0 04             	add    $0x4,%eax
 848:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 84b:	85 c9                	test   %ecx,%ecx
 84d:	0f 84 cd 00 00 00    	je     920 <printf+0x1e0>
        while(*s != 0){
 853:	0f b6 01             	movzbl (%ecx),%eax
 856:	84 c0                	test   %al,%al
 858:	0f 84 ce 00 00 00    	je     92c <printf+0x1ec>
 85e:	89 75 d0             	mov    %esi,-0x30(%ebp)
 861:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 864:	89 ce                	mov    %ecx,%esi
 866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
 870:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 873:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 878:	46                   	inc    %esi
  write(fd, &c, 1);
 879:	89 44 24 08          	mov    %eax,0x8(%esp)
 87d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 881:	89 3c 24             	mov    %edi,(%esp)
 884:	e8 6a fd ff ff       	call   5f3 <write>
        while(*s != 0){
 889:	0f b6 06             	movzbl (%esi),%eax
 88c:	84 c0                	test   %al,%al
 88e:	75 e0                	jne    870 <printf+0x130>
      state = 0;
 890:	8b 75 d0             	mov    -0x30(%ebp),%esi
 893:	31 db                	xor    %ebx,%ebx
 895:	e9 ee fe ff ff       	jmp    788 <printf+0x48>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 8a0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 8a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8a8:	8b 13                	mov    (%ebx),%edx
 8aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8b1:	e9 73 ff ff ff       	jmp    829 <printf+0xe9>
 8b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
 8c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 8c3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
 8c8:	8b 10                	mov    (%eax),%edx
 8ca:	89 55 d0             	mov    %edx,-0x30(%ebp)
 8cd:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 8d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8d4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 8d8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 8db:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 8df:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 8e1:	89 3c 24             	mov    %edi,(%esp)
 8e4:	e8 0a fd ff ff       	call   5f3 <write>
        ap++;
 8e9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8ed:	e9 96 fe ff ff       	jmp    788 <printf+0x48>
 8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 8f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 8fb:	8d 5d e7             	lea    -0x19(%ebp),%ebx
 8fe:	b9 01 00 00 00       	mov    $0x1,%ecx
 903:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
 907:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
 909:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 90d:	89 3c 24             	mov    %edi,(%esp)
 910:	e8 de fc ff ff       	call   5f3 <write>
 915:	e9 6e fe ff ff       	jmp    788 <printf+0x48>
 91a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 920:	b0 28                	mov    $0x28,%al
          s = "(null)";
 922:	b9 fe 0a 00 00       	mov    $0xafe,%ecx
 927:	e9 32 ff ff ff       	jmp    85e <printf+0x11e>
      state = 0;
 92c:	31 db                	xor    %ebx,%ebx
 92e:	66 90                	xchg   %ax,%ax
 930:	e9 53 fe ff ff       	jmp    788 <printf+0x48>
 935:	66 90                	xchg   %ax,%ax
 937:	66 90                	xchg   %ax,%ax
 939:	66 90                	xchg   %ax,%ax
 93b:	66 90                	xchg   %ax,%ax
 93d:	66 90                	xchg   %ax,%ax
 93f:	90                   	nop

00000940 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 940:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 941:	a1 80 0f 00 00       	mov    0xf80,%eax
{
 946:	89 e5                	mov    %esp,%ebp
 948:	57                   	push   %edi
 949:	56                   	push   %esi
 94a:	53                   	push   %ebx
 94b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 94e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 95f:	90                   	nop
 960:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 962:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	39 ca                	cmp    %ecx,%edx
 966:	73 30                	jae    998 <free+0x58>
 968:	39 c1                	cmp    %eax,%ecx
 96a:	72 04                	jb     970 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96c:	39 c2                	cmp    %eax,%edx
 96e:	72 f0                	jb     960 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 970:	8b 73 fc             	mov    -0x4(%ebx),%esi
 973:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 976:	39 f8                	cmp    %edi,%eax
 978:	74 26                	je     9a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 97a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 97d:	8b 42 04             	mov    0x4(%edx),%eax
 980:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 983:	39 f1                	cmp    %esi,%ecx
 985:	74 32                	je     9b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 987:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 989:	5b                   	pop    %ebx
  freep = p;
 98a:	89 15 80 0f 00 00    	mov    %edx,0xf80
}
 990:	5e                   	pop    %esi
 991:	5f                   	pop    %edi
 992:	5d                   	pop    %ebp
 993:	c3                   	ret    
 994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 998:	39 c1                	cmp    %eax,%ecx
 99a:	72 d0                	jb     96c <free+0x2c>
 99c:	eb c2                	jmp    960 <free+0x20>
 99e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
 9a0:	8b 78 04             	mov    0x4(%eax),%edi
 9a3:	01 fe                	add    %edi,%esi
 9a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a8:	8b 02                	mov    (%edx),%eax
 9aa:	8b 00                	mov    (%eax),%eax
 9ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 9af:	8b 42 04             	mov    0x4(%edx),%eax
 9b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9b5:	39 f1                	cmp    %esi,%ecx
 9b7:	75 ce                	jne    987 <free+0x47>
  freep = p;
 9b9:	89 15 80 0f 00 00    	mov    %edx,0xf80
    p->s.size += bp->s.size;
 9bf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 9c2:	01 c8                	add    %ecx,%eax
 9c4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 9c7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9ca:	89 0a                	mov    %ecx,(%edx)
}
 9cc:	5b                   	pop    %ebx
 9cd:	5e                   	pop    %esi
 9ce:	5f                   	pop    %edi
 9cf:	5d                   	pop    %ebp
 9d0:	c3                   	ret    
 9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9df:	90                   	nop

000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ec:	8b 15 80 0f 00 00    	mov    0xf80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8d 78 07             	lea    0x7(%eax),%edi
 9f5:	c1 ef 03             	shr    $0x3,%edi
 9f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9f9:	85 d2                	test   %edx,%edx
 9fb:	0f 84 8f 00 00 00    	je     a90 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a01:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a03:	8b 48 04             	mov    0x4(%eax),%ecx
 a06:	39 f9                	cmp    %edi,%ecx
 a08:	73 5e                	jae    a68 <malloc+0x88>
  if(nu < 4096)
 a0a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a0f:	39 df                	cmp    %ebx,%edi
 a11:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a14:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a1b:	eb 0c                	jmp    a29 <malloc+0x49>
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a22:	8b 48 04             	mov    0x4(%eax),%ecx
 a25:	39 f9                	cmp    %edi,%ecx
 a27:	73 3f                	jae    a68 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a29:	39 05 80 0f 00 00    	cmp    %eax,0xf80
 a2f:	89 c2                	mov    %eax,%edx
 a31:	75 ed                	jne    a20 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a33:	89 34 24             	mov    %esi,(%esp)
 a36:	e8 20 fc ff ff       	call   65b <sbrk>
  if(p == (char*)-1)
 a3b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a3e:	74 18                	je     a58 <malloc+0x78>
  hp->s.size = nu;
 a40:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a43:	83 c0 08             	add    $0x8,%eax
 a46:	89 04 24             	mov    %eax,(%esp)
 a49:	e8 f2 fe ff ff       	call   940 <free>
  return freep;
 a4e:	8b 15 80 0f 00 00    	mov    0xf80,%edx
      if((p = morecore(nunits)) == 0)
 a54:	85 d2                	test   %edx,%edx
 a56:	75 c8                	jne    a20 <malloc+0x40>
        return 0;
  }
}
 a58:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 a5b:	31 c0                	xor    %eax,%eax
}
 a5d:	5b                   	pop    %ebx
 a5e:	5e                   	pop    %esi
 a5f:	5f                   	pop    %edi
 a60:	5d                   	pop    %ebp
 a61:	c3                   	ret    
 a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a68:	39 cf                	cmp    %ecx,%edi
 a6a:	74 54                	je     ac0 <malloc+0xe0>
        p->s.size -= nunits;
 a6c:	29 f9                	sub    %edi,%ecx
 a6e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a71:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a74:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a77:	89 15 80 0f 00 00    	mov    %edx,0xf80
}
 a7d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a80:	83 c0 08             	add    $0x8,%eax
}
 a83:	5b                   	pop    %ebx
 a84:	5e                   	pop    %esi
 a85:	5f                   	pop    %edi
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
 a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a8f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 a90:	b8 84 0f 00 00       	mov    $0xf84,%eax
 a95:	ba 84 0f 00 00       	mov    $0xf84,%edx
 a9a:	a3 80 0f 00 00       	mov    %eax,0xf80
    base.s.size = 0;
 a9f:	31 c9                	xor    %ecx,%ecx
 aa1:	b8 84 0f 00 00       	mov    $0xf84,%eax
    base.s.ptr = freep = prevp = &base;
 aa6:	89 15 84 0f 00 00    	mov    %edx,0xf84
    base.s.size = 0;
 aac:	89 0d 88 0f 00 00    	mov    %ecx,0xf88
    if(p->s.size >= nunits){
 ab2:	e9 53 ff ff ff       	jmp    a0a <malloc+0x2a>
 ab7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 abe:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 08                	mov    (%eax),%ecx
 ac2:	89 0a                	mov    %ecx,(%edx)
 ac4:	eb b1                	jmp    a77 <malloc+0x97>
