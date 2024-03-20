
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
       f:	90                   	nop
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f b5 00 00 00    	jg     ce <main+0xce>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 04 24 69 15 00 00 	movl   $0x1569,(%esp)
      20:	b8 02 00 00 00       	mov    $0x2,%eax
      25:	89 44 24 04          	mov    %eax,0x4(%esp)
      29:	e8 e5 0f 00 00       	call   1013 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 33                	jmp    67 <main+0x67>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 42 16 00 00 20 	cmpb   $0x20,0x1642
      3f:	0f 84 a7 00 00 00    	je     ec <main+0xec>
      45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 76 0f 00 00       	call   fcb <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 d6 00 00 00    	je     134 <main+0x134>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 76                	je     d8 <main+0xd8>
    wait();
      62:	e8 74 0f 00 00       	call   fdb <wait>
  printf(2, "$ ");
      67:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      6e:	b8 c8 14 00 00       	mov    $0x14c8,%eax
      73:	89 44 24 04          	mov    %eax,0x4(%esp)
      77:	e8 c4 10 00 00       	call   1140 <printf>
  memset(buf, 0, nbuf);
      7c:	31 c9                	xor    %ecx,%ecx
      7e:	ba 64 00 00 00       	mov    $0x64,%edx
      83:	89 54 24 08          	mov    %edx,0x8(%esp)
      87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      8b:	c7 04 24 40 16 00 00 	movl   $0x1640,(%esp)
      92:	e8 a9 0d 00 00       	call   e40 <memset>
  gets(buf, nbuf);
      97:	b8 64 00 00 00       	mov    $0x64,%eax
      9c:	89 44 24 04          	mov    %eax,0x4(%esp)
      a0:	c7 04 24 40 16 00 00 	movl   $0x1640,(%esp)
      a7:	e8 f4 0d 00 00       	call   ea0 <gets>
  if(buf[0] == 0) // EOF
      ac:	0f b6 05 40 16 00 00 	movzbl 0x1640,%eax
      b3:	84 c0                	test   %al,%al
      b5:	74 12                	je     c9 <main+0xc9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      b7:	3c 63                	cmp    $0x63,%al
      b9:	75 95                	jne    50 <main+0x50>
      bb:	80 3d 41 16 00 00 64 	cmpb   $0x64,0x1641
      c2:	75 8c                	jne    50 <main+0x50>
      c4:	e9 6f ff ff ff       	jmp    38 <main+0x38>
  exit();
      c9:	e8 05 0f 00 00       	call   fd3 <exit>
      close(fd);
      ce:	89 04 24             	mov    %eax,(%esp)
      d1:	e8 25 0f 00 00       	call   ffb <close>
      break;
      d6:	eb 8f                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      d8:	c7 04 24 40 16 00 00 	movl   $0x1640,(%esp)
      df:	e8 2c 0c 00 00       	call   d10 <parsecmd>
      e4:	89 04 24             	mov    %eax,(%esp)
      e7:	e8 04 01 00 00       	call   1f0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      ec:	c7 04 24 40 16 00 00 	movl   $0x1640,(%esp)
      f3:	e8 18 0d 00 00       	call   e10 <strlen>
      if(chdir(buf+3) < 0)
      f8:	c7 04 24 43 16 00 00 	movl   $0x1643,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ff:	c6 80 3f 16 00 00 00 	movb   $0x0,0x163f(%eax)
      if(chdir(buf+3) < 0)
     106:	e8 38 0f 00 00       	call   1043 <chdir>
     10b:	85 c0                	test   %eax,%eax
     10d:	0f 89 54 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     113:	c7 44 24 08 43 16 00 	movl   $0x1643,0x8(%esp)
     11a:	00 
     11b:	c7 44 24 04 71 15 00 	movl   $0x1571,0x4(%esp)
     122:	00 
     123:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     12a:	e8 11 10 00 00       	call   1140 <printf>
     12f:	e9 33 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     134:	c7 04 24 cb 14 00 00 	movl   $0x14cb,(%esp)
     13b:	e8 60 00 00 00       	call   1a0 <panic>

00000140 <getcmd>:
{
     140:	55                   	push   %ebp
  printf(2, "$ ");
     141:	b8 c8 14 00 00       	mov    $0x14c8,%eax
{
     146:	89 e5                	mov    %esp,%ebp
     148:	83 ec 18             	sub    $0x18,%esp
     14b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     14e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     151:	89 75 fc             	mov    %esi,-0x4(%ebp)
     154:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     157:	89 44 24 04          	mov    %eax,0x4(%esp)
     15b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     162:	e8 d9 0f 00 00       	call   1140 <printf>
  memset(buf, 0, nbuf);
     167:	31 d2                	xor    %edx,%edx
     169:	89 74 24 08          	mov    %esi,0x8(%esp)
     16d:	89 54 24 04          	mov    %edx,0x4(%esp)
     171:	89 1c 24             	mov    %ebx,(%esp)
     174:	e8 c7 0c 00 00       	call   e40 <memset>
  gets(buf, nbuf);
     179:	89 74 24 04          	mov    %esi,0x4(%esp)
     17d:	89 1c 24             	mov    %ebx,(%esp)
     180:	e8 1b 0d 00 00       	call   ea0 <gets>
}
     185:	8b 75 fc             	mov    -0x4(%ebp),%esi
  if(buf[0] == 0) // EOF
     188:	80 3b 01             	cmpb   $0x1,(%ebx)
}
     18b:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  if(buf[0] == 0) // EOF
     18e:	19 c0                	sbb    %eax,%eax
}
     190:	89 ec                	mov    %ebp,%esp
     192:	5d                   	pop    %ebp
     193:	c3                   	ret    
     194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     19f:	90                   	nop

000001a0 <panic>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     1a6:	8b 45 08             	mov    0x8(%ebp),%eax
     1a9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     1b0:	89 44 24 08          	mov    %eax,0x8(%esp)
     1b4:	b8 65 15 00 00       	mov    $0x1565,%eax
     1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
     1bd:	e8 7e 0f 00 00       	call   1140 <printf>
  exit();
     1c2:	e8 0c 0e 00 00       	call   fd3 <exit>
     1c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1ce:	66 90                	xchg   %ax,%ax

000001d0 <fork1>:
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 18             	sub    $0x18,%esp
  pid = fork();
     1d6:	e8 f0 0d 00 00       	call   fcb <fork>
  if(pid == -1)
     1db:	83 f8 ff             	cmp    $0xffffffff,%eax
     1de:	74 04                	je     1e4 <fork1+0x14>
  return pid;
}
     1e0:	89 ec                	mov    %ebp,%esp
     1e2:	5d                   	pop    %ebp
     1e3:	c3                   	ret    
    panic("fork");
     1e4:	c7 04 24 cb 14 00 00 	movl   $0x14cb,(%esp)
     1eb:	e8 b0 ff ff ff       	call   1a0 <panic>

000001f0 <runcmd>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	53                   	push   %ebx
     1f4:	83 ec 24             	sub    $0x24,%esp
     1f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1fa:	85 db                	test   %ebx,%ebx
     1fc:	74 52                	je     250 <runcmd+0x60>
  switch(cmd->type){
     1fe:	83 3b 05             	cmpl   $0x5,(%ebx)
     201:	0f 87 fe 00 00 00    	ja     305 <runcmd+0x115>
     207:	8b 03                	mov    (%ebx),%eax
     209:	ff 24 85 80 15 00 00 	jmp    *0x1580(,%eax,4)
    if(ecmd->argv[0] == 0)
     210:	8b 43 04             	mov    0x4(%ebx),%eax
     213:	85 c0                	test   %eax,%eax
     215:	74 39                	je     250 <runcmd+0x60>
    exec(ecmd->argv[0], ecmd->argv);
     217:	89 04 24             	mov    %eax,(%esp)
     21a:	8d 53 04             	lea    0x4(%ebx),%edx
     21d:	89 54 24 04          	mov    %edx,0x4(%esp)
     221:	e8 e5 0d 00 00       	call   100b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     226:	8b 43 04             	mov    0x4(%ebx),%eax
     229:	c7 44 24 04 d7 14 00 	movl   $0x14d7,0x4(%esp)
     230:	00 
     231:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     238:	89 44 24 08          	mov    %eax,0x8(%esp)
     23c:	e8 ff 0e 00 00       	call   1140 <printf>
    break;
     241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     24f:	90                   	nop
      exit();
     250:	e8 7e 0d 00 00       	call   fd3 <exit>
    if(fork1() == 0)
     255:	e8 76 ff ff ff       	call   1d0 <fork1>
     25a:	85 c0                	test   %eax,%eax
     25c:	75 f2                	jne    250 <runcmd+0x60>
     25e:	66 90                	xchg   %ax,%ax
     260:	e9 95 00 00 00       	jmp    2fa <runcmd+0x10a>
    if(pipe(p) < 0)
     265:	8d 45 f0             	lea    -0x10(%ebp),%eax
     268:	89 04 24             	mov    %eax,(%esp)
     26b:	e8 73 0d 00 00       	call   fe3 <pipe>
     270:	85 c0                	test   %eax,%eax
     272:	0f 88 b9 00 00 00    	js     331 <runcmd+0x141>
    if(fork1() == 0){
     278:	e8 53 ff ff ff       	call   1d0 <fork1>
     27d:	85 c0                	test   %eax,%eax
     27f:	90                   	nop
     280:	0f 84 b7 00 00 00    	je     33d <runcmd+0x14d>
    if(fork1() == 0){
     286:	e8 45 ff ff ff       	call   1d0 <fork1>
     28b:	85 c0                	test   %eax,%eax
     28d:	8d 76 00             	lea    0x0(%esi),%esi
     290:	0f 84 df 00 00 00    	je     375 <runcmd+0x185>
    close(p[0]);
     296:	8b 45 f0             	mov    -0x10(%ebp),%eax
     299:	89 04 24             	mov    %eax,(%esp)
     29c:	e8 5a 0d 00 00       	call   ffb <close>
    close(p[1]);
     2a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2a4:	89 04 24             	mov    %eax,(%esp)
     2a7:	e8 4f 0d 00 00       	call   ffb <close>
    wait();
     2ac:	e8 2a 0d 00 00       	call   fdb <wait>
    wait();
     2b1:	e8 25 0d 00 00       	call   fdb <wait>
    break;
     2b6:	eb 98                	jmp    250 <runcmd+0x60>
    if(fork1() == 0)
     2b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2bf:	90                   	nop
     2c0:	e8 0b ff ff ff       	call   1d0 <fork1>
     2c5:	85 c0                	test   %eax,%eax
     2c7:	74 31                	je     2fa <runcmd+0x10a>
    wait();
     2c9:	e8 0d 0d 00 00       	call   fdb <wait>
    runcmd(lcmd->right);
     2ce:	8b 43 08             	mov    0x8(%ebx),%eax
     2d1:	89 04 24             	mov    %eax,(%esp)
     2d4:	e8 17 ff ff ff       	call   1f0 <runcmd>
    close(rcmd->fd);
     2d9:	8b 43 14             	mov    0x14(%ebx),%eax
     2dc:	89 04 24             	mov    %eax,(%esp)
     2df:	e8 17 0d 00 00       	call   ffb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2e4:	8b 43 10             	mov    0x10(%ebx),%eax
     2e7:	89 44 24 04          	mov    %eax,0x4(%esp)
     2eb:	8b 43 08             	mov    0x8(%ebx),%eax
     2ee:	89 04 24             	mov    %eax,(%esp)
     2f1:	e8 1d 0d 00 00       	call   1013 <open>
     2f6:	85 c0                	test   %eax,%eax
     2f8:	78 17                	js     311 <runcmd+0x121>
      runcmd(bcmd->cmd);
     2fa:	8b 43 04             	mov    0x4(%ebx),%eax
     2fd:	89 04 24             	mov    %eax,(%esp)
     300:	e8 eb fe ff ff       	call   1f0 <runcmd>
    panic("runcmd");
     305:	c7 04 24 d0 14 00 00 	movl   $0x14d0,(%esp)
     30c:	e8 8f fe ff ff       	call   1a0 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     311:	8b 43 08             	mov    0x8(%ebx),%eax
     314:	c7 44 24 04 e7 14 00 	movl   $0x14e7,0x4(%esp)
     31b:	00 
     31c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     323:	89 44 24 08          	mov    %eax,0x8(%esp)
     327:	e8 14 0e 00 00       	call   1140 <printf>
     32c:	e9 1f ff ff ff       	jmp    250 <runcmd+0x60>
      panic("pipe");
     331:	c7 04 24 f7 14 00 00 	movl   $0x14f7,(%esp)
     338:	e8 63 fe ff ff       	call   1a0 <panic>
      close(1);
     33d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     344:	e8 b2 0c 00 00       	call   ffb <close>
      dup(p[1]);
     349:	8b 45 f4             	mov    -0xc(%ebp),%eax
     34c:	89 04 24             	mov    %eax,(%esp)
     34f:	e8 f7 0c 00 00       	call   104b <dup>
      close(p[0]);
     354:	8b 45 f0             	mov    -0x10(%ebp),%eax
     357:	89 04 24             	mov    %eax,(%esp)
     35a:	e8 9c 0c 00 00       	call   ffb <close>
      close(p[1]);
     35f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     362:	89 04 24             	mov    %eax,(%esp)
     365:	e8 91 0c 00 00       	call   ffb <close>
      runcmd(pcmd->left);
     36a:	8b 43 04             	mov    0x4(%ebx),%eax
     36d:	89 04 24             	mov    %eax,(%esp)
     370:	e8 7b fe ff ff       	call   1f0 <runcmd>
      close(0);
     375:	31 c0                	xor    %eax,%eax
     377:	89 04 24             	mov    %eax,(%esp)
     37a:	e8 7c 0c 00 00       	call   ffb <close>
      dup(p[0]);
     37f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     382:	89 04 24             	mov    %eax,(%esp)
     385:	e8 c1 0c 00 00       	call   104b <dup>
      close(p[0]);
     38a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     38d:	89 04 24             	mov    %eax,(%esp)
     390:	e8 66 0c 00 00       	call   ffb <close>
      close(p[1]);
     395:	8b 45 f4             	mov    -0xc(%ebp),%eax
     398:	89 04 24             	mov    %eax,(%esp)
     39b:	e8 5b 0c 00 00       	call   ffb <close>
      runcmd(pcmd->right);
     3a0:	8b 43 08             	mov    0x8(%ebx),%eax
     3a3:	89 04 24             	mov    %eax,(%esp)
     3a6:	e8 45 fe ff ff       	call   1f0 <runcmd>
     3ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3af:	90                   	nop

000003b0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	83 ec 18             	sub    $0x18,%esp
     3b6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b9:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3c0:	e8 1b 10 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3c5:	31 d2                	xor    %edx,%edx
     3c7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3cb:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3cd:	b8 54 00 00 00       	mov    $0x54,%eax
     3d2:	89 1c 24             	mov    %ebx,(%esp)
     3d5:	89 44 24 08          	mov    %eax,0x8(%esp)
     3d9:	e8 62 0a 00 00       	call   e40 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3de:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3e0:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3e9:	89 ec                	mov    %ebp,%esp
     3eb:	5d                   	pop    %ebp
     3ec:	c3                   	ret    
     3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 18             	sub    $0x18,%esp
     3f6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f9:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     400:	e8 db 0f 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     405:	31 d2                	xor    %edx,%edx
     407:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     40b:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     40d:	b8 18 00 00 00       	mov    $0x18,%eax
     412:	89 1c 24             	mov    %ebx,(%esp)
     415:	89 44 24 08          	mov    %eax,0x8(%esp)
     419:	e8 22 0a 00 00       	call   e40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     41e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     421:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     427:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     42a:	8b 45 0c             	mov    0xc(%ebp),%eax
     42d:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     430:	8b 45 10             	mov    0x10(%ebp),%eax
     433:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     436:	8b 45 14             	mov    0x14(%ebp),%eax
     439:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     43c:	8b 45 18             	mov    0x18(%ebp),%eax
     43f:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     442:	89 d8                	mov    %ebx,%eax
     444:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     447:	89 ec                	mov    %ebp,%esp
     449:	5d                   	pop    %ebp
     44a:	c3                   	ret    
     44b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     44f:	90                   	nop

00000450 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 18             	sub    $0x18,%esp
     456:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     459:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     460:	e8 7b 0f 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     465:	31 d2                	xor    %edx,%edx
     467:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     46b:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     46d:	b8 0c 00 00 00       	mov    $0xc,%eax
     472:	89 1c 24             	mov    %ebx,(%esp)
     475:	89 44 24 08          	mov    %eax,0x8(%esp)
     479:	e8 c2 09 00 00       	call   e40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     47e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     481:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     487:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     48a:	8b 45 0c             	mov    0xc(%ebp),%eax
     48d:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     490:	89 d8                	mov    %ebx,%eax
     492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     495:	89 ec                	mov    %ebp,%esp
     497:	5d                   	pop    %ebp
     498:	c3                   	ret    
     499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	83 ec 18             	sub    $0x18,%esp
     4a6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a9:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     4b0:	e8 2b 0f 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4b5:	31 d2                	xor    %edx,%edx
     4b7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4bb:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4bd:	b8 0c 00 00 00       	mov    $0xc,%eax
     4c2:	89 1c 24             	mov    %ebx,(%esp)
     4c5:	89 44 24 08          	mov    %eax,0x8(%esp)
     4c9:	e8 72 09 00 00       	call   e40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4ce:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4d1:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4d7:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4da:	8b 45 0c             	mov    0xc(%ebp),%eax
     4dd:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4e0:	89 d8                	mov    %ebx,%eax
     4e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4e5:	89 ec                	mov    %ebp,%esp
     4e7:	5d                   	pop    %ebp
     4e8:	c3                   	ret    
     4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	83 ec 18             	sub    $0x18,%esp
     4f6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f9:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     500:	e8 db 0e 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     505:	31 d2                	xor    %edx,%edx
     507:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     50b:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     50d:	b8 08 00 00 00       	mov    $0x8,%eax
     512:	89 1c 24             	mov    %ebx,(%esp)
     515:	89 44 24 08          	mov    %eax,0x8(%esp)
     519:	e8 22 09 00 00       	call   e40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     51e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     521:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     527:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     52a:	89 d8                	mov    %ebx,%eax
     52c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     52f:	89 ec                	mov    %ebp,%esp
     531:	5d                   	pop    %ebp
     532:	c3                   	ret    
     533:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000540 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     549:	8b 45 08             	mov    0x8(%ebp),%eax
{
     54c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     54f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     552:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     554:	39 df                	cmp    %ebx,%edi
     556:	72 0d                	jb     565 <gettoken+0x25>
     558:	eb 22                	jmp    57c <gettoken+0x3c>
     55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     560:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     561:	39 fb                	cmp    %edi,%ebx
     563:	74 17                	je     57c <gettoken+0x3c>
     565:	0f be 07             	movsbl (%edi),%eax
     568:	c7 04 24 2c 16 00 00 	movl   $0x162c,(%esp)
     56f:	89 44 24 04          	mov    %eax,0x4(%esp)
     573:	e8 e8 08 00 00       	call   e60 <strchr>
     578:	85 c0                	test   %eax,%eax
     57a:	75 e4                	jne    560 <gettoken+0x20>
  if(q)
     57c:	85 f6                	test   %esi,%esi
     57e:	74 02                	je     582 <gettoken+0x42>
    *q = s;
     580:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     582:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     585:	3c 3c                	cmp    $0x3c,%al
     587:	0f 8f d3 00 00 00    	jg     660 <gettoken+0x120>
     58d:	3c 3a                	cmp    $0x3a,%al
     58f:	0f 8f b9 00 00 00    	jg     64e <gettoken+0x10e>
     595:	84 c0                	test   %al,%al
     597:	75 47                	jne    5e0 <gettoken+0xa0>
     599:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     59b:	8b 4d 14             	mov    0x14(%ebp),%ecx
     59e:	85 c9                	test   %ecx,%ecx
     5a0:	74 05                	je     5a7 <gettoken+0x67>
    *eq = s;
     5a2:	8b 45 14             	mov    0x14(%ebp),%eax
     5a5:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     5a7:	39 df                	cmp    %ebx,%edi
     5a9:	72 0a                	jb     5b5 <gettoken+0x75>
     5ab:	eb 1f                	jmp    5cc <gettoken+0x8c>
     5ad:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     5b0:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     5b1:	39 fb                	cmp    %edi,%ebx
     5b3:	74 17                	je     5cc <gettoken+0x8c>
     5b5:	0f be 07             	movsbl (%edi),%eax
     5b8:	c7 04 24 2c 16 00 00 	movl   $0x162c,(%esp)
     5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c3:	e8 98 08 00 00       	call   e60 <strchr>
     5c8:	85 c0                	test   %eax,%eax
     5ca:	75 e4                	jne    5b0 <gettoken+0x70>
  *ps = s;
     5cc:	8b 45 08             	mov    0x8(%ebp),%eax
     5cf:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5d1:	83 c4 1c             	add    $0x1c,%esp
     5d4:	89 f0                	mov    %esi,%eax
     5d6:	5b                   	pop    %ebx
     5d7:	5e                   	pop    %esi
     5d8:	5f                   	pop    %edi
     5d9:	5d                   	pop    %ebp
     5da:	c3                   	ret    
     5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5df:	90                   	nop
  switch(*s){
     5e0:	79 5e                	jns    640 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5e2:	39 df                	cmp    %ebx,%edi
     5e4:	72 36                	jb     61c <gettoken+0xdc>
  if(eq)
     5e6:	8b 55 14             	mov    0x14(%ebp),%edx
     5e9:	85 d2                	test   %edx,%edx
     5eb:	0f 84 ab 00 00 00    	je     69c <gettoken+0x15c>
    *eq = s;
     5f1:	8b 45 14             	mov    0x14(%ebp),%eax
     5f4:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     5f6:	e9 a1 00 00 00       	jmp    69c <gettoken+0x15c>
     5fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5ff:	90                   	nop
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     600:	0f be 07             	movsbl (%edi),%eax
     603:	c7 04 24 24 16 00 00 	movl   $0x1624,(%esp)
     60a:	89 44 24 04          	mov    %eax,0x4(%esp)
     60e:	e8 4d 08 00 00       	call   e60 <strchr>
     613:	85 c0                	test   %eax,%eax
     615:	75 1c                	jne    633 <gettoken+0xf3>
      s++;
     617:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     618:	39 fb                	cmp    %edi,%ebx
     61a:	74 72                	je     68e <gettoken+0x14e>
     61c:	0f be 07             	movsbl (%edi),%eax
     61f:	c7 04 24 2c 16 00 00 	movl   $0x162c,(%esp)
     626:	89 44 24 04          	mov    %eax,0x4(%esp)
     62a:	e8 31 08 00 00       	call   e60 <strchr>
     62f:	85 c0                	test   %eax,%eax
     631:	74 cd                	je     600 <gettoken+0xc0>
    ret = 'a';
     633:	be 61 00 00 00       	mov    $0x61,%esi
     638:	e9 5e ff ff ff       	jmp    59b <gettoken+0x5b>
     63d:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     640:	3c 26                	cmp    $0x26,%al
     642:	74 0a                	je     64e <gettoken+0x10e>
     644:	88 c1                	mov    %al,%cl
     646:	80 e9 28             	sub    $0x28,%cl
     649:	80 f9 01             	cmp    $0x1,%cl
     64c:	77 94                	ja     5e2 <gettoken+0xa2>
  ret = *s;
     64e:	0f be f0             	movsbl %al,%esi
    s++;
     651:	47                   	inc    %edi
    break;
     652:	e9 44 ff ff ff       	jmp    59b <gettoken+0x5b>
     657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     65e:	66 90                	xchg   %ax,%ax
  switch(*s){
     660:	3c 3e                	cmp    $0x3e,%al
     662:	75 14                	jne    678 <gettoken+0x138>
    if(*s == '>'){
     664:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     668:	74 17                	je     681 <gettoken+0x141>
    s++;
     66a:	47                   	inc    %edi
  ret = *s;
     66b:	be 3e 00 00 00       	mov    $0x3e,%esi
     670:	e9 26 ff ff ff       	jmp    59b <gettoken+0x5b>
     675:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     678:	3c 7c                	cmp    $0x7c,%al
     67a:	74 d2                	je     64e <gettoken+0x10e>
     67c:	e9 61 ff ff ff       	jmp    5e2 <gettoken+0xa2>
      s++;
     681:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     684:	be 2b 00 00 00       	mov    $0x2b,%esi
     689:	e9 0d ff ff ff       	jmp    59b <gettoken+0x5b>
  if(eq)
     68e:	8b 45 14             	mov    0x14(%ebp),%eax
     691:	85 c0                	test   %eax,%eax
     693:	74 05                	je     69a <gettoken+0x15a>
    *eq = s;
     695:	8b 45 14             	mov    0x14(%ebp),%eax
     698:	89 18                	mov    %ebx,(%eax)
      s++;
     69a:	89 df                	mov    %ebx,%edi
    ret = 'a';
     69c:	be 61 00 00 00       	mov    $0x61,%esi
     6a1:	e9 26 ff ff ff       	jmp    5cc <gettoken+0x8c>
     6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6ad:	8d 76 00             	lea    0x0(%esi),%esi

000006b0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
     6b6:	83 ec 1c             	sub    $0x1c,%esp
     6b9:	8b 7d 08             	mov    0x8(%ebp),%edi
     6bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     6bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6c1:	39 f3                	cmp    %esi,%ebx
     6c3:	72 10                	jb     6d5 <peek+0x25>
     6c5:	eb 25                	jmp    6ec <peek+0x3c>
     6c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6ce:	66 90                	xchg   %ax,%ax
    s++;
     6d0:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     6d1:	39 de                	cmp    %ebx,%esi
     6d3:	74 17                	je     6ec <peek+0x3c>
     6d5:	0f be 03             	movsbl (%ebx),%eax
     6d8:	c7 04 24 2c 16 00 00 	movl   $0x162c,(%esp)
     6df:	89 44 24 04          	mov    %eax,0x4(%esp)
     6e3:	e8 78 07 00 00       	call   e60 <strchr>
     6e8:	85 c0                	test   %eax,%eax
     6ea:	75 e4                	jne    6d0 <peek+0x20>
  *ps = s;
     6ec:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6ee:	31 c0                	xor    %eax,%eax
     6f0:	0f be 13             	movsbl (%ebx),%edx
     6f3:	84 d2                	test   %dl,%dl
     6f5:	75 09                	jne    700 <peek+0x50>
}
     6f7:	83 c4 1c             	add    $0x1c,%esp
     6fa:	5b                   	pop    %ebx
     6fb:	5e                   	pop    %esi
     6fc:	5f                   	pop    %edi
     6fd:	5d                   	pop    %ebp
     6fe:	c3                   	ret    
     6ff:	90                   	nop
  return *s && strchr(toks, *s);
     700:	89 54 24 04          	mov    %edx,0x4(%esp)
     704:	8b 45 10             	mov    0x10(%ebp),%eax
     707:	89 04 24             	mov    %eax,(%esp)
     70a:	e8 51 07 00 00       	call   e60 <strchr>
     70f:	85 c0                	test   %eax,%eax
     711:	0f 95 c0             	setne  %al
}
     714:	83 c4 1c             	add    $0x1c,%esp
     717:	5b                   	pop    %ebx
  return *s && strchr(toks, *s);
     718:	0f b6 c0             	movzbl %al,%eax
}
     71b:	5e                   	pop    %esi
     71c:	5f                   	pop    %edi
     71d:	5d                   	pop    %ebp
     71e:	c3                   	ret    
     71f:	90                   	nop

00000720 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 3c             	sub    $0x3c,%esp
     729:	8b 75 0c             	mov    0xc(%ebp),%esi
     72c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     72f:	90                   	nop
     730:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     734:	b8 19 15 00 00       	mov    $0x1519,%eax
     739:	89 44 24 08          	mov    %eax,0x8(%esp)
     73d:	89 34 24             	mov    %esi,(%esp)
     740:	e8 6b ff ff ff       	call   6b0 <peek>
     745:	85 c0                	test   %eax,%eax
     747:	0f 84 13 01 00 00    	je     860 <parseredirs+0x140>
    tok = gettoken(ps, es, 0, 0);
     74d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     751:	31 c0                	xor    %eax,%eax
     753:	89 44 24 0c          	mov    %eax,0xc(%esp)
     757:	31 c0                	xor    %eax,%eax
     759:	89 44 24 08          	mov    %eax,0x8(%esp)
     75d:	89 34 24             	mov    %esi,(%esp)
     760:	e8 db fd ff ff       	call   540 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     765:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     769:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     76c:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     76e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     771:	89 44 24 0c          	mov    %eax,0xc(%esp)
     775:	8d 45 e0             	lea    -0x20(%ebp),%eax
     778:	89 44 24 08          	mov    %eax,0x8(%esp)
     77c:	e8 bf fd ff ff       	call   540 <gettoken>
     781:	83 f8 61             	cmp    $0x61,%eax
     784:	0f 85 e1 00 00 00    	jne    86b <parseredirs+0x14b>
      panic("missing file for redirection");
    switch(tok){
     78a:	83 ff 3c             	cmp    $0x3c,%edi
     78d:	74 71                	je     800 <parseredirs+0xe0>
     78f:	83 ff 3e             	cmp    $0x3e,%edi
     792:	74 05                	je     799 <parseredirs+0x79>
     794:	83 ff 2b             	cmp    $0x2b,%edi
     797:	75 97                	jne    730 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     799:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     79c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     79f:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7a2:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7a5:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     7ac:	e8 2f 0c 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7b1:	ba 18 00 00 00       	mov    $0x18,%edx
     7b6:	31 c9                	xor    %ecx,%ecx
     7b8:	89 54 24 08          	mov    %edx,0x8(%esp)
     7bc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     7c0:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     7c3:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7c5:	e8 76 06 00 00       	call   e40 <memset>
  cmd->type = REDIR;
     7ca:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7d0:	8b 45 08             	mov    0x8(%ebp),%eax
     7d3:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7d6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7d9:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7dc:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7df:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->fd = fd;
     7e6:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
  cmd->efile = efile;
     7ed:	89 57 0c             	mov    %edx,0xc(%edi)
      break;
     7f0:	89 7d 08             	mov    %edi,0x8(%ebp)
     7f3:	e9 38 ff ff ff       	jmp    730 <parseredirs+0x10>
     7f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ff:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     800:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     803:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     806:	89 55 d0             	mov    %edx,-0x30(%ebp)
     809:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     80c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     813:	e8 c8 0b 00 00       	call   13e0 <malloc>
     818:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     81a:	b8 18 00 00 00       	mov    $0x18,%eax
     81f:	89 44 24 08          	mov    %eax,0x8(%esp)
     823:	31 c0                	xor    %eax,%eax
     825:	89 44 24 04          	mov    %eax,0x4(%esp)
     829:	89 3c 24             	mov    %edi,(%esp)
     82c:	e8 0f 06 00 00       	call   e40 <memset>
  cmd->cmd = subcmd;
     831:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     834:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->file = file;
     83a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  cmd->mode = mode;
     83d:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->efile = efile;
     844:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->fd = fd;
     847:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  cmd->cmd = subcmd;
     84e:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     851:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     854:	89 57 0c             	mov    %edx,0xc(%edi)
      break;
     857:	89 7d 08             	mov    %edi,0x8(%ebp)
     85a:	e9 d1 fe ff ff       	jmp    730 <parseredirs+0x10>
     85f:	90                   	nop
    }
  }
  return cmd;
}
     860:	8b 45 08             	mov    0x8(%ebp),%eax
     863:	83 c4 3c             	add    $0x3c,%esp
     866:	5b                   	pop    %ebx
     867:	5e                   	pop    %esi
     868:	5f                   	pop    %edi
     869:	5d                   	pop    %ebp
     86a:	c3                   	ret    
      panic("missing file for redirection");
     86b:	c7 04 24 fc 14 00 00 	movl   $0x14fc,(%esp)
     872:	e8 29 f9 ff ff       	call   1a0 <panic>
     877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     87e:	66 90                	xchg   %ax,%ax

00000880 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     880:	55                   	push   %ebp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     881:	b8 1c 15 00 00       	mov    $0x151c,%eax
{
     886:	89 e5                	mov    %esp,%ebp
     888:	57                   	push   %edi
     889:	56                   	push   %esi
     88a:	53                   	push   %ebx
     88b:	83 ec 3c             	sub    $0x3c,%esp
     88e:	8b 75 08             	mov    0x8(%ebp),%esi
     891:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     894:	89 44 24 08          	mov    %eax,0x8(%esp)
     898:	89 34 24             	mov    %esi,(%esp)
     89b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     89f:	e8 0c fe ff ff       	call   6b0 <peek>
     8a4:	85 c0                	test   %eax,%eax
     8a6:	0f 85 cc 00 00 00    	jne    978 <parseexec+0xf8>
  cmd = malloc(sizeof(*cmd));
     8ac:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     8b3:	89 c3                	mov    %eax,%ebx
     8b5:	e8 26 0b 00 00       	call   13e0 <malloc>
     8ba:	89 c2                	mov    %eax,%edx
  memset(cmd, 0, sizeof(*cmd));
     8bc:	b8 54 00 00 00       	mov    $0x54,%eax
     8c1:	89 44 24 08          	mov    %eax,0x8(%esp)
     8c5:	31 c0                	xor    %eax,%eax
     8c7:	89 14 24             	mov    %edx,(%esp)
     8ca:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ce:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     8d1:	e8 6a 05 00 00       	call   e40 <memset>
  cmd->type = EXEC;
     8d6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     8d9:	c7 02 01 00 00 00    	movl   $0x1,(%edx)

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8df:	89 7c 24 08          	mov    %edi,0x8(%esp)
     8e3:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e7:	89 14 24             	mov    %edx,(%esp)
     8ea:	89 55 d0             	mov    %edx,-0x30(%ebp)
     8ed:	e8 2e fe ff ff       	call   720 <parseredirs>
     8f2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8f5:	eb 1f                	jmp    916 <parseexec+0x96>
     8f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8fe:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     900:	89 7c 24 08          	mov    %edi,0x8(%esp)
     904:	89 74 24 04          	mov    %esi,0x4(%esp)
     908:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     90b:	89 04 24             	mov    %eax,(%esp)
     90e:	e8 0d fe ff ff       	call   720 <parseredirs>
     913:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     916:	89 7c 24 04          	mov    %edi,0x4(%esp)
     91a:	b8 33 15 00 00       	mov    $0x1533,%eax
     91f:	89 44 24 08          	mov    %eax,0x8(%esp)
     923:	89 34 24             	mov    %esi,(%esp)
     926:	e8 85 fd ff ff       	call   6b0 <peek>
     92b:	85 c0                	test   %eax,%eax
     92d:	75 61                	jne    990 <parseexec+0x110>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     92f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     933:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     936:	89 44 24 0c          	mov    %eax,0xc(%esp)
     93a:	8d 45 e0             	lea    -0x20(%ebp),%eax
     93d:	89 44 24 08          	mov    %eax,0x8(%esp)
     941:	89 34 24             	mov    %esi,(%esp)
     944:	e8 f7 fb ff ff       	call   540 <gettoken>
     949:	85 c0                	test   %eax,%eax
     94b:	74 43                	je     990 <parseexec+0x110>
    if(tok != 'a')
     94d:	83 f8 61             	cmp    $0x61,%eax
     950:	75 58                	jne    9aa <parseexec+0x12a>
    cmd->argv[argc] = q;
     952:	8b 45 e0             	mov    -0x20(%ebp),%eax
     955:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     958:	89 44 99 04          	mov    %eax,0x4(%ecx,%ebx,4)
    cmd->eargv[argc] = eq;
     95c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95f:	89 44 99 2c          	mov    %eax,0x2c(%ecx,%ebx,4)
    argc++;
     963:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     964:	83 fb 0a             	cmp    $0xa,%ebx
     967:	75 97                	jne    900 <parseexec+0x80>
      panic("too many args");
     969:	c7 04 24 25 15 00 00 	movl   $0x1525,(%esp)
     970:	e8 2b f8 ff ff       	call   1a0 <panic>
     975:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     978:	89 7d 0c             	mov    %edi,0xc(%ebp)
     97b:	89 75 08             	mov    %esi,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     97e:	83 c4 3c             	add    $0x3c,%esp
     981:	5b                   	pop    %ebx
     982:	5e                   	pop    %esi
     983:	5f                   	pop    %edi
     984:	5d                   	pop    %ebp
    return parseblock(ps, es);
     985:	e9 16 02 00 00       	jmp    ba0 <parseblock>
     98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     990:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->argv[argc] = 0;
     993:	31 c0                	xor    %eax,%eax
  cmd->eargv[argc] = 0;
     995:	31 c9                	xor    %ecx,%ecx
  cmd->argv[argc] = 0;
     997:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
}
     99b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  cmd->eargv[argc] = 0;
     99e:	89 4c 9a 2c          	mov    %ecx,0x2c(%edx,%ebx,4)
}
     9a2:	83 c4 3c             	add    $0x3c,%esp
     9a5:	5b                   	pop    %ebx
     9a6:	5e                   	pop    %esi
     9a7:	5f                   	pop    %edi
     9a8:	5d                   	pop    %ebp
     9a9:	c3                   	ret    
      panic("syntax");
     9aa:	c7 04 24 1e 15 00 00 	movl   $0x151e,(%esp)
     9b1:	e8 ea f7 ff ff       	call   1a0 <panic>
     9b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <parsepipe>:
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 28             	sub    $0x28,%esp
     9c6:	89 75 f8             	mov    %esi,-0x8(%ebp)
     9c9:	8b 75 08             	mov    0x8(%ebp),%esi
     9cc:	89 7d fc             	mov    %edi,-0x4(%ebp)
     9cf:	8b 7d 0c             	mov    0xc(%ebp),%edi
     9d2:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  cmd = parseexec(ps, es);
     9d5:	89 34 24             	mov    %esi,(%esp)
     9d8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9dc:	e8 9f fe ff ff       	call   880 <parseexec>
  if(peek(ps, es, "|")){
     9e1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9e5:	89 34 24             	mov    %esi,(%esp)
  cmd = parseexec(ps, es);
     9e8:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     9ea:	b8 38 15 00 00       	mov    $0x1538,%eax
     9ef:	89 44 24 08          	mov    %eax,0x8(%esp)
     9f3:	e8 b8 fc ff ff       	call   6b0 <peek>
     9f8:	85 c0                	test   %eax,%eax
     9fa:	75 14                	jne    a10 <parsepipe+0x50>
}
     9fc:	8b 75 f8             	mov    -0x8(%ebp),%esi
     9ff:	89 d8                	mov    %ebx,%eax
     a01:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     a04:	8b 7d fc             	mov    -0x4(%ebp),%edi
     a07:	89 ec                	mov    %ebp,%esp
     a09:	5d                   	pop    %ebp
     a0a:	c3                   	ret    
     a0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a0f:	90                   	nop
    gettoken(ps, es, 0, 0);
     a10:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a14:	31 d2                	xor    %edx,%edx
     a16:	31 c0                	xor    %eax,%eax
     a18:	89 54 24 08          	mov    %edx,0x8(%esp)
     a1c:	89 34 24             	mov    %esi,(%esp)
     a1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a23:	e8 18 fb ff ff       	call   540 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a28:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a2c:	89 34 24             	mov    %esi,(%esp)
     a2f:	e8 8c ff ff ff       	call   9c0 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     a34:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a3b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     a3d:	e8 9e 09 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a42:	b9 0c 00 00 00       	mov    $0xc,%ecx
     a47:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     a4b:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     a4d:	31 c0                	xor    %eax,%eax
     a4f:	89 34 24             	mov    %esi,(%esp)
     a52:	89 44 24 04          	mov    %eax,0x4(%esp)
     a56:	e8 e5 03 00 00       	call   e40 <memset>
  cmd->left = left;
     a5b:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a5e:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     a60:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     a66:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a68:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a6b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     a6e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     a71:	8b 7d fc             	mov    -0x4(%ebp),%edi
     a74:	89 ec                	mov    %ebp,%esp
     a76:	5d                   	pop    %ebp
     a77:	c3                   	ret    
     a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a7f:	90                   	nop

00000a80 <parseline>:
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	57                   	push   %edi
     a84:	56                   	push   %esi
     a85:	53                   	push   %ebx
     a86:	83 ec 2c             	sub    $0x2c,%esp
     a89:	8b 75 08             	mov    0x8(%ebp),%esi
     a8c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a8f:	89 34 24             	mov    %esi,(%esp)
     a92:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a96:	e8 25 ff ff ff       	call   9c0 <parsepipe>
     a9b:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a9d:	eb 4f                	jmp    aee <parseline+0x6e>
     a9f:	90                   	nop
    gettoken(ps, es, 0, 0);
     aa0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aa4:	31 c0                	xor    %eax,%eax
     aa6:	89 44 24 0c          	mov    %eax,0xc(%esp)
     aaa:	31 c0                	xor    %eax,%eax
     aac:	89 44 24 08          	mov    %eax,0x8(%esp)
     ab0:	89 34 24             	mov    %esi,(%esp)
     ab3:	e8 88 fa ff ff       	call   540 <gettoken>
  cmd = malloc(sizeof(*cmd));
     ab8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     abf:	e8 1c 09 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ac4:	b9 08 00 00 00       	mov    $0x8,%ecx
     ac9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     acd:	89 c2                	mov    %eax,%edx
  memset(cmd, 0, sizeof(*cmd));
     acf:	31 c0                	xor    %eax,%eax
     ad1:	89 14 24             	mov    %edx,(%esp)
     ad4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ad8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     adb:	e8 60 03 00 00       	call   e40 <memset>
  cmd->type = BACK;
     ae0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     ae3:	89 5a 04             	mov    %ebx,0x4(%edx)
     ae6:	89 d3                	mov    %edx,%ebx
  cmd->type = BACK;
     ae8:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  while(peek(ps, es, "&")){
     aee:	89 7c 24 04          	mov    %edi,0x4(%esp)
     af2:	b8 3a 15 00 00       	mov    $0x153a,%eax
     af7:	89 44 24 08          	mov    %eax,0x8(%esp)
     afb:	89 34 24             	mov    %esi,(%esp)
     afe:	e8 ad fb ff ff       	call   6b0 <peek>
     b03:	85 c0                	test   %eax,%eax
     b05:	75 99                	jne    aa0 <parseline+0x20>
  if(peek(ps, es, ";")){
     b07:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b0b:	b8 36 15 00 00       	mov    $0x1536,%eax
     b10:	89 44 24 08          	mov    %eax,0x8(%esp)
     b14:	89 34 24             	mov    %esi,(%esp)
     b17:	e8 94 fb ff ff       	call   6b0 <peek>
     b1c:	85 c0                	test   %eax,%eax
     b1e:	75 10                	jne    b30 <parseline+0xb0>
}
     b20:	83 c4 2c             	add    $0x2c,%esp
     b23:	89 d8                	mov    %ebx,%eax
     b25:	5b                   	pop    %ebx
     b26:	5e                   	pop    %esi
     b27:	5f                   	pop    %edi
     b28:	5d                   	pop    %ebp
     b29:	c3                   	ret    
     b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     b30:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b34:	31 d2                	xor    %edx,%edx
     b36:	31 c0                	xor    %eax,%eax
     b38:	89 54 24 08          	mov    %edx,0x8(%esp)
     b3c:	89 34 24             	mov    %esi,(%esp)
     b3f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b43:	e8 f8 f9 ff ff       	call   540 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     b48:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b4c:	89 34 24             	mov    %esi,(%esp)
     b4f:	e8 2c ff ff ff       	call   a80 <parseline>
  cmd = malloc(sizeof(*cmd));
     b54:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     b5b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     b5d:	e8 7e 08 00 00       	call   13e0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b62:	b9 0c 00 00 00       	mov    $0xc,%ecx
     b67:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     b6b:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     b6d:	31 c0                	xor    %eax,%eax
     b6f:	89 34 24             	mov    %esi,(%esp)
     b72:	89 44 24 04          	mov    %eax,0x4(%esp)
     b76:	e8 c5 02 00 00       	call   e40 <memset>
  cmd->left = left;
     b7b:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     b7e:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     b80:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     b86:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     b88:	89 7e 08             	mov    %edi,0x8(%esi)
}
     b8b:	83 c4 2c             	add    $0x2c,%esp
     b8e:	5b                   	pop    %ebx
     b8f:	5e                   	pop    %esi
     b90:	5f                   	pop    %edi
     b91:	5d                   	pop    %ebp
     b92:	c3                   	ret    
     b93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ba0 <parseblock>:
{
     ba0:	55                   	push   %ebp
  if(!peek(ps, es, "("))
     ba1:	b8 1c 15 00 00       	mov    $0x151c,%eax
{
     ba6:	89 e5                	mov    %esp,%ebp
     ba8:	83 ec 28             	sub    $0x28,%esp
     bab:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     bae:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bb1:	89 75 f8             	mov    %esi,-0x8(%ebp)
     bb4:	8b 75 0c             	mov    0xc(%ebp),%esi
     bb7:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(!peek(ps, es, "("))
     bba:	89 44 24 08          	mov    %eax,0x8(%esp)
     bbe:	89 1c 24             	mov    %ebx,(%esp)
     bc1:	89 74 24 04          	mov    %esi,0x4(%esp)
     bc5:	e8 e6 fa ff ff       	call   6b0 <peek>
     bca:	85 c0                	test   %eax,%eax
     bcc:	74 74                	je     c42 <parseblock+0xa2>
  gettoken(ps, es, 0, 0);
     bce:	89 74 24 04          	mov    %esi,0x4(%esp)
     bd2:	31 c9                	xor    %ecx,%ecx
     bd4:	31 ff                	xor    %edi,%edi
     bd6:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     bda:	89 7c 24 08          	mov    %edi,0x8(%esp)
     bde:	89 1c 24             	mov    %ebx,(%esp)
     be1:	e8 5a f9 ff ff       	call   540 <gettoken>
  cmd = parseline(ps, es);
     be6:	89 74 24 04          	mov    %esi,0x4(%esp)
     bea:	89 1c 24             	mov    %ebx,(%esp)
     bed:	e8 8e fe ff ff       	call   a80 <parseline>
  if(!peek(ps, es, ")"))
     bf2:	89 74 24 04          	mov    %esi,0x4(%esp)
     bf6:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     bf9:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     bfb:	b8 58 15 00 00       	mov    $0x1558,%eax
     c00:	89 44 24 08          	mov    %eax,0x8(%esp)
     c04:	e8 a7 fa ff ff       	call   6b0 <peek>
     c09:	85 c0                	test   %eax,%eax
     c0b:	74 41                	je     c4e <parseblock+0xae>
  gettoken(ps, es, 0, 0);
     c0d:	89 74 24 04          	mov    %esi,0x4(%esp)
     c11:	31 d2                	xor    %edx,%edx
     c13:	31 c0                	xor    %eax,%eax
     c15:	89 54 24 08          	mov    %edx,0x8(%esp)
     c19:	89 1c 24             	mov    %ebx,(%esp)
     c1c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c20:	e8 1b f9 ff ff       	call   540 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     c25:	89 74 24 08          	mov    %esi,0x8(%esp)
     c29:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     c2d:	89 3c 24             	mov    %edi,(%esp)
     c30:	e8 eb fa ff ff       	call   720 <parseredirs>
}
     c35:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c38:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c3b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c3e:	89 ec                	mov    %ebp,%esp
     c40:	5d                   	pop    %ebp
     c41:	c3                   	ret    
    panic("parseblock");
     c42:	c7 04 24 3c 15 00 00 	movl   $0x153c,(%esp)
     c49:	e8 52 f5 ff ff       	call   1a0 <panic>
    panic("syntax - missing )");
     c4e:	c7 04 24 47 15 00 00 	movl   $0x1547,(%esp)
     c55:	e8 46 f5 ff ff       	call   1a0 <panic>
     c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c60 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	83 ec 18             	sub    $0x18,%esp
     c66:	89 5d fc             	mov    %ebx,-0x4(%ebp)
     c69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c6c:	85 db                	test   %ebx,%ebx
     c6e:	0f 84 8c 00 00 00    	je     d00 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     c74:	83 3b 05             	cmpl   $0x5,(%ebx)
     c77:	77 25                	ja     c9e <nulterminate+0x3e>
     c79:	8b 03                	mov    (%ebx),%eax
     c7b:	ff 24 85 98 15 00 00 	jmp    *0x1598(,%eax,4)
     c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     c88:	8b 43 04             	mov    0x4(%ebx),%eax
     c8b:	89 04 24             	mov    %eax,(%esp)
     c8e:	e8 cd ff ff ff       	call   c60 <nulterminate>
    nulterminate(lcmd->right);
     c93:	8b 43 08             	mov    0x8(%ebx),%eax
     c96:	89 04 24             	mov    %eax,(%esp)
     c99:	e8 c2 ff ff ff       	call   c60 <nulterminate>
    return 0;
     c9e:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     ca0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ca3:	89 ec                	mov    %ebp,%esp
     ca5:	5d                   	pop    %ebp
     ca6:	c3                   	ret    
     ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cae:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     cb0:	8b 43 04             	mov    0x4(%ebx),%eax
     cb3:	89 04 24             	mov    %eax,(%esp)
     cb6:	e8 a5 ff ff ff       	call   c60 <nulterminate>
    break;
     cbb:	eb e1                	jmp    c9e <nulterminate+0x3e>
     cbd:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     cc0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     cc3:	8d 43 08             	lea    0x8(%ebx),%eax
     cc6:	85 c9                	test   %ecx,%ecx
     cc8:	74 d4                	je     c9e <nulterminate+0x3e>
     cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     cd0:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     cd3:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     cd6:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     cd9:	8b 50 fc             	mov    -0x4(%eax),%edx
     cdc:	85 d2                	test   %edx,%edx
     cde:	75 f0                	jne    cd0 <nulterminate+0x70>
     ce0:	eb bc                	jmp    c9e <nulterminate+0x3e>
     ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    nulterminate(rcmd->cmd);
     ce8:	8b 43 04             	mov    0x4(%ebx),%eax
     ceb:	89 04 24             	mov    %eax,(%esp)
     cee:	e8 6d ff ff ff       	call   c60 <nulterminate>
    *rcmd->efile = 0;
     cf3:	8b 43 0c             	mov    0xc(%ebx),%eax
     cf6:	c6 00 00             	movb   $0x0,(%eax)
    break;
     cf9:	eb a3                	jmp    c9e <nulterminate+0x3e>
     cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cff:	90                   	nop
    return 0;
     d00:	31 c0                	xor    %eax,%eax
     d02:	eb 9c                	jmp    ca0 <nulterminate+0x40>
     d04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d0f:	90                   	nop

00000d10 <parsecmd>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	53                   	push   %ebx
     d15:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     d18:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d1b:	89 1c 24             	mov    %ebx,(%esp)
     d1e:	e8 ed 00 00 00       	call   e10 <strlen>
     d23:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     d25:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     d29:	8d 45 08             	lea    0x8(%ebp),%eax
     d2c:	89 04 24             	mov    %eax,(%esp)
     d2f:	e8 4c fd ff ff       	call   a80 <parseline>
  peek(&s, es, "");
     d34:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     d38:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     d3a:	b8 e6 14 00 00       	mov    $0x14e6,%eax
     d3f:	89 44 24 08          	mov    %eax,0x8(%esp)
     d43:	8d 45 08             	lea    0x8(%ebp),%eax
     d46:	89 04 24             	mov    %eax,(%esp)
     d49:	e8 62 f9 ff ff       	call   6b0 <peek>
  if(s != es){
     d4e:	8b 45 08             	mov    0x8(%ebp),%eax
     d51:	39 d8                	cmp    %ebx,%eax
     d53:	75 11                	jne    d66 <parsecmd+0x56>
  nulterminate(cmd);
     d55:	89 34 24             	mov    %esi,(%esp)
     d58:	e8 03 ff ff ff       	call   c60 <nulterminate>
}
     d5d:	83 c4 10             	add    $0x10,%esp
     d60:	89 f0                	mov    %esi,%eax
     d62:	5b                   	pop    %ebx
     d63:	5e                   	pop    %esi
     d64:	5d                   	pop    %ebp
     d65:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     d66:	89 44 24 08          	mov    %eax,0x8(%esp)
     d6a:	c7 44 24 04 5a 15 00 	movl   $0x155a,0x4(%esp)
     d71:	00 
     d72:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     d79:	e8 c2 03 00 00       	call   1140 <printf>
    panic("syntax");
     d7e:	c7 04 24 1e 15 00 00 	movl   $0x151e,(%esp)
     d85:	e8 16 f4 ff ff       	call   1a0 <panic>
     d8a:	66 90                	xchg   %ax,%ax
     d8c:	66 90                	xchg   %ax,%ax
     d8e:	66 90                	xchg   %ax,%ax

00000d90 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d91:	31 c0                	xor    %eax,%eax
{
     d93:	89 e5                	mov    %esp,%ebp
     d95:	53                   	push   %ebx
     d96:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     da0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     da4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     da7:	40                   	inc    %eax
     da8:	84 d2                	test   %dl,%dl
     daa:	75 f4                	jne    da0 <strcpy+0x10>
    ;
  return os;
}
     dac:	5b                   	pop    %ebx
     dad:	89 c8                	mov    %ecx,%eax
     daf:	5d                   	pop    %ebp
     db0:	c3                   	ret    
     db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dbf:	90                   	nop

00000dc0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	53                   	push   %ebx
     dc4:	8b 55 08             	mov    0x8(%ebp),%edx
     dc7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     dca:	0f b6 02             	movzbl (%edx),%eax
     dcd:	84 c0                	test   %al,%al
     dcf:	75 15                	jne    de6 <strcmp+0x26>
     dd1:	eb 30                	jmp    e03 <strcmp+0x43>
     dd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dd7:	90                   	nop
     dd8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     ddc:	8d 4b 01             	lea    0x1(%ebx),%ecx
     ddf:	42                   	inc    %edx
  while(*p && *p == *q)
     de0:	84 c0                	test   %al,%al
     de2:	74 14                	je     df8 <strcmp+0x38>
    p++, q++;
     de4:	89 cb                	mov    %ecx,%ebx
  while(*p && *p == *q)
     de6:	0f b6 0b             	movzbl (%ebx),%ecx
     de9:	38 c1                	cmp    %al,%cl
     deb:	74 eb                	je     dd8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
     ded:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     dee:	29 c8                	sub    %ecx,%eax
}
     df0:	5d                   	pop    %ebp
     df1:	c3                   	ret    
     df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     df8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
     dfc:	31 c0                	xor    %eax,%eax
}
     dfe:	5b                   	pop    %ebx
     dff:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
     e00:	29 c8                	sub    %ecx,%eax
}
     e02:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
     e03:	0f b6 0b             	movzbl (%ebx),%ecx
     e06:	31 c0                	xor    %eax,%eax
     e08:	eb e3                	jmp    ded <strcmp+0x2d>
     e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e10 <strlen>:

uint
strlen(const char *s)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     e16:	80 3a 00             	cmpb   $0x0,(%edx)
     e19:	74 15                	je     e30 <strlen+0x20>
     e1b:	31 c0                	xor    %eax,%eax
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
     e20:	40                   	inc    %eax
     e21:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     e25:	89 c1                	mov    %eax,%ecx
     e27:	75 f7                	jne    e20 <strlen+0x10>
    ;
  return n;
}
     e29:	5d                   	pop    %ebp
     e2a:	89 c8                	mov    %ecx,%eax
     e2c:	c3                   	ret    
     e2d:	8d 76 00             	lea    0x0(%esi),%esi
     e30:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
     e31:	31 c9                	xor    %ecx,%ecx
}
     e33:	89 c8                	mov    %ecx,%eax
     e35:	c3                   	ret    
     e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e3d:	8d 76 00             	lea    0x0(%esi),%esi

00000e40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e47:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e4d:	89 d7                	mov    %edx,%edi
     e4f:	fc                   	cld    
     e50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     e52:	5f                   	pop    %edi
     e53:	89 d0                	mov    %edx,%eax
     e55:	5d                   	pop    %ebp
     e56:	c3                   	ret    
     e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e5e:	66 90                	xchg   %ax,%ax

00000e60 <strchr>:

char*
strchr(const char *s, char c)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	8b 45 08             	mov    0x8(%ebp),%eax
     e66:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     e6a:	0f b6 10             	movzbl (%eax),%edx
     e6d:	84 d2                	test   %dl,%dl
     e6f:	75 10                	jne    e81 <strchr+0x21>
     e71:	eb 1d                	jmp    e90 <strchr+0x30>
     e73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e77:	90                   	nop
     e78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     e7c:	40                   	inc    %eax
     e7d:	84 d2                	test   %dl,%dl
     e7f:	74 0f                	je     e90 <strchr+0x30>
    if(*s == c)
     e81:	38 d1                	cmp    %dl,%cl
     e83:	75 f3                	jne    e78 <strchr+0x18>
      return (char*)s;
  return 0;
}
     e85:	5d                   	pop    %ebp
     e86:	c3                   	ret    
     e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e8e:	66 90                	xchg   %ax,%ax
     e90:	5d                   	pop    %ebp
  return 0;
     e91:	31 c0                	xor    %eax,%eax
}
     e93:	c3                   	ret    
     e94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e9f:	90                   	nop

00000ea0 <gets>:

char*
gets(char *buf, int max)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ea5:	31 f6                	xor    %esi,%esi
{
     ea7:	53                   	push   %ebx
    cc = read(0, &c, 1);
     ea8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     eab:	83 ec 3c             	sub    $0x3c,%esp
     eae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
     eb1:	eb 32                	jmp    ee5 <gets+0x45>
     eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     eb7:	90                   	nop
    cc = read(0, &c, 1);
     eb8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ebc:	b8 01 00 00 00       	mov    $0x1,%eax
     ec1:	89 44 24 08          	mov    %eax,0x8(%esp)
     ec5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ecc:	e8 1a 01 00 00       	call   feb <read>
    if(cc < 1)
     ed1:	85 c0                	test   %eax,%eax
     ed3:	7e 19                	jle    eee <gets+0x4e>
      break;
    buf[i++] = c;
     ed5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ed9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
     edd:	3c 0a                	cmp    $0xa,%al
     edf:	74 10                	je     ef1 <gets+0x51>
     ee1:	3c 0d                	cmp    $0xd,%al
     ee3:	74 0c                	je     ef1 <gets+0x51>
  for(i=0; i+1 < max; ){
     ee5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     ee8:	46                   	inc    %esi
     ee9:	3b 75 0c             	cmp    0xc(%ebp),%esi
     eec:	7c ca                	jl     eb8 <gets+0x18>
     eee:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
     ef1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
     ef5:	83 c4 3c             	add    $0x3c,%esp
     ef8:	89 d8                	mov    %ebx,%eax
     efa:	5b                   	pop    %ebx
     efb:	5e                   	pop    %esi
     efc:	5f                   	pop    %edi
     efd:	5d                   	pop    %ebp
     efe:	c3                   	ret    
     eff:	90                   	nop

00000f00 <stat>:

int
stat(const char *n, struct stat *st)
{
     f00:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f01:	31 c0                	xor    %eax,%eax
{
     f03:	89 e5                	mov    %esp,%ebp
     f05:	83 ec 18             	sub    $0x18,%esp
     f08:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     f0b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     f0e:	89 44 24 04          	mov    %eax,0x4(%esp)
     f12:	8b 45 08             	mov    0x8(%ebp),%eax
     f15:	89 04 24             	mov    %eax,(%esp)
     f18:	e8 f6 00 00 00       	call   1013 <open>
  if(fd < 0)
     f1d:	85 c0                	test   %eax,%eax
     f1f:	78 2f                	js     f50 <stat+0x50>
     f21:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     f23:	8b 45 0c             	mov    0xc(%ebp),%eax
     f26:	89 1c 24             	mov    %ebx,(%esp)
     f29:	89 44 24 04          	mov    %eax,0x4(%esp)
     f2d:	e8 f9 00 00 00       	call   102b <fstat>
  close(fd);
     f32:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     f35:	89 c6                	mov    %eax,%esi
  close(fd);
     f37:	e8 bf 00 00 00       	call   ffb <close>
  return r;
}
     f3c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     f3f:	89 f0                	mov    %esi,%eax
     f41:	8b 75 fc             	mov    -0x4(%ebp),%esi
     f44:	89 ec                	mov    %ebp,%esp
     f46:	5d                   	pop    %ebp
     f47:	c3                   	ret    
     f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f4f:	90                   	nop
    return -1;
     f50:	be ff ff ff ff       	mov    $0xffffffff,%esi
     f55:	eb e5                	jmp    f3c <stat+0x3c>
     f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f5e:	66 90                	xchg   %ax,%ax

00000f60 <atoi>:

int
atoi(const char *s)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	53                   	push   %ebx
     f64:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f67:	0f be 02             	movsbl (%edx),%eax
     f6a:	88 c1                	mov    %al,%cl
     f6c:	80 e9 30             	sub    $0x30,%cl
     f6f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     f72:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     f77:	77 1c                	ja     f95 <atoi+0x35>
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     f80:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     f83:	42                   	inc    %edx
     f84:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     f88:	0f be 02             	movsbl (%edx),%eax
     f8b:	88 c3                	mov    %al,%bl
     f8d:	80 eb 30             	sub    $0x30,%bl
     f90:	80 fb 09             	cmp    $0x9,%bl
     f93:	76 eb                	jbe    f80 <atoi+0x20>
  return n;
}
     f95:	5b                   	pop    %ebx
     f96:	89 c8                	mov    %ecx,%eax
     f98:	5d                   	pop    %ebp
     f99:	c3                   	ret    
     f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fa0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
     fa5:	8b 45 10             	mov    0x10(%ebp),%eax
     fa8:	8b 55 08             	mov    0x8(%ebp),%edx
     fab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     fae:	85 c0                	test   %eax,%eax
     fb0:	7e 13                	jle    fc5 <memmove+0x25>
     fb2:	01 d0                	add    %edx,%eax
  dst = vdst;
     fb4:	89 d7                	mov    %edx,%edi
     fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     fc0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     fc1:	39 f8                	cmp    %edi,%eax
     fc3:	75 fb                	jne    fc0 <memmove+0x20>
  return vdst;
}
     fc5:	5e                   	pop    %esi
     fc6:	89 d0                	mov    %edx,%eax
     fc8:	5f                   	pop    %edi
     fc9:	5d                   	pop    %ebp
     fca:	c3                   	ret    

00000fcb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     fcb:	b8 01 00 00 00       	mov    $0x1,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret    

00000fd3 <exit>:
SYSCALL(exit)
     fd3:	b8 02 00 00 00       	mov    $0x2,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret    

00000fdb <wait>:
SYSCALL(wait)
     fdb:	b8 03 00 00 00       	mov    $0x3,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret    

00000fe3 <pipe>:
SYSCALL(pipe)
     fe3:	b8 04 00 00 00       	mov    $0x4,%eax
     fe8:	cd 40                	int    $0x40
     fea:	c3                   	ret    

00000feb <read>:
SYSCALL(read)
     feb:	b8 05 00 00 00       	mov    $0x5,%eax
     ff0:	cd 40                	int    $0x40
     ff2:	c3                   	ret    

00000ff3 <write>:
SYSCALL(write)
     ff3:	b8 10 00 00 00       	mov    $0x10,%eax
     ff8:	cd 40                	int    $0x40
     ffa:	c3                   	ret    

00000ffb <close>:
SYSCALL(close)
     ffb:	b8 15 00 00 00       	mov    $0x15,%eax
    1000:	cd 40                	int    $0x40
    1002:	c3                   	ret    

00001003 <kill>:
SYSCALL(kill)
    1003:	b8 06 00 00 00       	mov    $0x6,%eax
    1008:	cd 40                	int    $0x40
    100a:	c3                   	ret    

0000100b <exec>:
SYSCALL(exec)
    100b:	b8 07 00 00 00       	mov    $0x7,%eax
    1010:	cd 40                	int    $0x40
    1012:	c3                   	ret    

00001013 <open>:
SYSCALL(open)
    1013:	b8 0f 00 00 00       	mov    $0xf,%eax
    1018:	cd 40                	int    $0x40
    101a:	c3                   	ret    

0000101b <mknod>:
SYSCALL(mknod)
    101b:	b8 11 00 00 00       	mov    $0x11,%eax
    1020:	cd 40                	int    $0x40
    1022:	c3                   	ret    

00001023 <unlink>:
SYSCALL(unlink)
    1023:	b8 12 00 00 00       	mov    $0x12,%eax
    1028:	cd 40                	int    $0x40
    102a:	c3                   	ret    

0000102b <fstat>:
SYSCALL(fstat)
    102b:	b8 08 00 00 00       	mov    $0x8,%eax
    1030:	cd 40                	int    $0x40
    1032:	c3                   	ret    

00001033 <link>:
SYSCALL(link)
    1033:	b8 13 00 00 00       	mov    $0x13,%eax
    1038:	cd 40                	int    $0x40
    103a:	c3                   	ret    

0000103b <mkdir>:
SYSCALL(mkdir)
    103b:	b8 14 00 00 00       	mov    $0x14,%eax
    1040:	cd 40                	int    $0x40
    1042:	c3                   	ret    

00001043 <chdir>:
SYSCALL(chdir)
    1043:	b8 09 00 00 00       	mov    $0x9,%eax
    1048:	cd 40                	int    $0x40
    104a:	c3                   	ret    

0000104b <dup>:
SYSCALL(dup)
    104b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1050:	cd 40                	int    $0x40
    1052:	c3                   	ret    

00001053 <getpid>:
SYSCALL(getpid)
    1053:	b8 0b 00 00 00       	mov    $0xb,%eax
    1058:	cd 40                	int    $0x40
    105a:	c3                   	ret    

0000105b <sbrk>:
SYSCALL(sbrk)
    105b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1060:	cd 40                	int    $0x40
    1062:	c3                   	ret    

00001063 <sleep>:
SYSCALL(sleep)
    1063:	b8 0d 00 00 00       	mov    $0xd,%eax
    1068:	cd 40                	int    $0x40
    106a:	c3                   	ret    

0000106b <uptime>:
SYSCALL(uptime)
    106b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1070:	cd 40                	int    $0x40
    1072:	c3                   	ret    

00001073 <getNumFreePages>:
    1073:	b8 16 00 00 00       	mov    $0x16,%eax
    1078:	cd 40                	int    $0x40
    107a:	c3                   	ret    
    107b:	66 90                	xchg   %ax,%ax
    107d:	66 90                	xchg   %ax,%ax
    107f:	90                   	nop

00001080 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	56                   	push   %esi
    1085:	53                   	push   %ebx
    1086:	89 cb                	mov    %ecx,%ebx
    1088:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    108b:	89 d1                	mov    %edx,%ecx
{
    108d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
    1090:	89 d0                	mov    %edx,%eax
    1092:	c1 e8 1f             	shr    $0x1f,%eax
    1095:	84 c0                	test   %al,%al
    1097:	0f 84 93 00 00 00    	je     1130 <printint+0xb0>
    109d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    10a1:	0f 84 89 00 00 00    	je     1130 <printint+0xb0>
    x = -xx;
    10a7:	f7 d9                	neg    %ecx
    neg = 1;
    10a9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    10ae:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    10b5:	8d 75 d7             	lea    -0x29(%ebp),%esi
    10b8:	89 45 b8             	mov    %eax,-0x48(%ebp)
    10bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
    10c0:	89 c8                	mov    %ecx,%eax
    10c2:	31 d2                	xor    %edx,%edx
    10c4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
    10c7:	f7 f3                	div    %ebx
    10c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    10cc:	0f b6 92 10 16 00 00 	movzbl 0x1610(%edx),%edx
    10d3:	8d 47 01             	lea    0x1(%edi),%eax
    10d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    10d9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
    10dd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
    10df:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    10e2:	39 da                	cmp    %ebx,%edx
    10e4:	73 da                	jae    10c0 <printint+0x40>
  if(neg)
    10e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
    10e9:	85 c0                	test   %eax,%eax
    10eb:	74 0a                	je     10f7 <printint+0x77>
    buf[i++] = '-';
    10ed:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    10f0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
    10f5:	89 c7                	mov    %eax,%edi
    10f7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    10fa:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
    10fe:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    putc(fd, buf[i]);
    1100:	0f b6 07             	movzbl (%edi),%eax
    1103:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
    1106:	b8 01 00 00 00       	mov    $0x1,%eax
    110b:	89 44 24 08          	mov    %eax,0x8(%esp)
    110f:	89 74 24 04          	mov    %esi,0x4(%esp)
    1113:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1116:	89 04 24             	mov    %eax,(%esp)
    1119:	e8 d5 fe ff ff       	call   ff3 <write>
  while(--i >= 0)
    111e:	89 f8                	mov    %edi,%eax
    1120:	4f                   	dec    %edi
    1121:	39 d8                	cmp    %ebx,%eax
    1123:	75 db                	jne    1100 <printint+0x80>
}
    1125:	83 c4 4c             	add    $0x4c,%esp
    1128:	5b                   	pop    %ebx
    1129:	5e                   	pop    %esi
    112a:	5f                   	pop    %edi
    112b:	5d                   	pop    %ebp
    112c:	c3                   	ret    
    112d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1130:	31 c0                	xor    %eax,%eax
    1132:	e9 77 ff ff ff       	jmp    10ae <printint+0x2e>
    1137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113e:	66 90                	xchg   %ax,%ax

00001140 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	57                   	push   %edi
    1144:	56                   	push   %esi
    1145:	53                   	push   %ebx
    1146:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1149:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    114c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    114f:	0f b6 1e             	movzbl (%esi),%ebx
    1152:	84 db                	test   %bl,%bl
    1154:	74 6f                	je     11c5 <printf+0x85>
  ap = (uint*)(void*)&fmt + 1;
    1156:	8d 45 10             	lea    0x10(%ebp),%eax
  state = 0;
    1159:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    115b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  write(fd, &c, 1);
    115e:	88 d9                	mov    %bl,%cl
    1160:	46                   	inc    %esi
    1161:	89 d3                	mov    %edx,%ebx
    1163:	eb 2b                	jmp    1190 <printf+0x50>
    1165:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1168:	83 f8 25             	cmp    $0x25,%eax
    116b:	74 4b                	je     11b8 <printf+0x78>
        state = '%';
      } else {
        putc(fd, c);
    116d:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
    1170:	b8 01 00 00 00       	mov    $0x1,%eax
    1175:	89 44 24 08          	mov    %eax,0x8(%esp)
    1179:	8d 45 e7             	lea    -0x19(%ebp),%eax
    117c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1180:	89 3c 24             	mov    %edi,(%esp)
    1183:	e8 6b fe ff ff       	call   ff3 <write>
  for(i = 0; fmt[i]; i++){
    1188:	0f b6 0e             	movzbl (%esi),%ecx
    118b:	46                   	inc    %esi
    118c:	84 c9                	test   %cl,%cl
    118e:	74 35                	je     11c5 <printf+0x85>
    if(state == 0){
    1190:	85 db                	test   %ebx,%ebx
    c = fmt[i] & 0xff;
    1192:	0f b6 c1             	movzbl %cl,%eax
    if(state == 0){
    1195:	74 d1                	je     1168 <printf+0x28>
      }
    } else if(state == '%'){
    1197:	83 fb 25             	cmp    $0x25,%ebx
    119a:	75 ec                	jne    1188 <printf+0x48>
      if(c == 'd'){
    119c:	83 f8 25             	cmp    $0x25,%eax
    119f:	0f 84 53 01 00 00    	je     12f8 <printf+0x1b8>
    11a5:	83 e8 63             	sub    $0x63,%eax
    11a8:	83 f8 15             	cmp    $0x15,%eax
    11ab:	77 23                	ja     11d0 <printf+0x90>
    11ad:	ff 24 85 b8 15 00 00 	jmp    *0x15b8(,%eax,4)
    11b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    11b8:	0f b6 0e             	movzbl (%esi),%ecx
    11bb:	46                   	inc    %esi
        state = '%';
    11bc:	bb 25 00 00 00       	mov    $0x25,%ebx
  for(i = 0; fmt[i]; i++){
    11c1:	84 c9                	test   %cl,%cl
    11c3:	75 cb                	jne    1190 <printf+0x50>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    11c5:	83 c4 3c             	add    $0x3c,%esp
    11c8:	5b                   	pop    %ebx
    11c9:	5e                   	pop    %esi
    11ca:	5f                   	pop    %edi
    11cb:	5d                   	pop    %ebp
    11cc:	c3                   	ret    
    11cd:	8d 76 00             	lea    0x0(%esi),%esi
    11d0:	88 4d d0             	mov    %cl,-0x30(%ebp)
  write(fd, &c, 1);
    11d3:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    11d6:	b8 01 00 00 00       	mov    $0x1,%eax
    11db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    11df:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    11e3:	89 44 24 08          	mov    %eax,0x8(%esp)
    11e7:	89 3c 24             	mov    %edi,(%esp)
    11ea:	e8 04 fe ff ff       	call   ff3 <write>
        putc(fd, c);
    11ef:	0f b6 4d d0          	movzbl -0x30(%ebp),%ecx
  write(fd, &c, 1);
    11f3:	ba 01 00 00 00       	mov    $0x1,%edx
    11f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
    11fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
    11ff:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
    1201:	89 54 24 08          	mov    %edx,0x8(%esp)
    1205:	89 3c 24             	mov    %edi,(%esp)
    1208:	e8 e6 fd ff ff       	call   ff3 <write>
    120d:	e9 76 ff ff ff       	jmp    1188 <printf+0x48>
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1218:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    121b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1220:	8b 13                	mov    (%ebx),%edx
    1222:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
    1229:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    122c:	89 f8                	mov    %edi,%eax
    122e:	e8 4d fe ff ff       	call   1080 <printint>
        ap++;
    1233:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      state = 0;
    1236:	31 db                	xor    %ebx,%ebx
    1238:	e9 4b ff ff ff       	jmp    1188 <printf+0x48>
    123d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1240:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1243:	8b 08                	mov    (%eax),%ecx
        ap++;
    1245:	83 c0 04             	add    $0x4,%eax
    1248:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    124b:	85 c9                	test   %ecx,%ecx
    124d:	0f 84 cd 00 00 00    	je     1320 <printf+0x1e0>
        while(*s != 0){
    1253:	0f b6 01             	movzbl (%ecx),%eax
    1256:	84 c0                	test   %al,%al
    1258:	0f 84 ce 00 00 00    	je     132c <printf+0x1ec>
    125e:	89 75 d0             	mov    %esi,-0x30(%ebp)
    1261:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    1264:	89 ce                	mov    %ecx,%esi
    1266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    126d:	8d 76 00             	lea    0x0(%esi),%esi
          putc(fd, *s);
    1270:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1273:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    1278:	46                   	inc    %esi
  write(fd, &c, 1);
    1279:	89 44 24 08          	mov    %eax,0x8(%esp)
    127d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1281:	89 3c 24             	mov    %edi,(%esp)
    1284:	e8 6a fd ff ff       	call   ff3 <write>
        while(*s != 0){
    1289:	0f b6 06             	movzbl (%esi),%eax
    128c:	84 c0                	test   %al,%al
    128e:	75 e0                	jne    1270 <printf+0x130>
      state = 0;
    1290:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1293:	31 db                	xor    %ebx,%ebx
    1295:	e9 ee fe ff ff       	jmp    1188 <printf+0x48>
    129a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    12a0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    12a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    12a8:	8b 13                	mov    (%ebx),%edx
    12aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12b1:	e9 73 ff ff ff       	jmp    1229 <printf+0xe9>
    12b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, *ap);
    12c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
    12c3:	bb 01 00 00 00       	mov    $0x1,%ebx
        putc(fd, *ap);
    12c8:	8b 10                	mov    (%eax),%edx
    12ca:	89 55 d0             	mov    %edx,-0x30(%ebp)
    12cd:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    12d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    12d4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    12d8:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    12db:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
    12df:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
    12e1:	89 3c 24             	mov    %edi,(%esp)
    12e4:	e8 0a fd ff ff       	call   ff3 <write>
        ap++;
    12e9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    12ed:	e9 96 fe ff ff       	jmp    1188 <printf+0x48>
    12f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    12f8:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
    12fb:	8d 5d e7             	lea    -0x19(%ebp),%ebx
    12fe:	b9 01 00 00 00       	mov    $0x1,%ecx
    1303:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      state = 0;
    1307:	31 db                	xor    %ebx,%ebx
  write(fd, &c, 1);
    1309:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    130d:	89 3c 24             	mov    %edi,(%esp)
    1310:	e8 de fc ff ff       	call   ff3 <write>
    1315:	e9 6e fe ff ff       	jmp    1188 <printf+0x48>
    131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1320:	b0 28                	mov    $0x28,%al
          s = "(null)";
    1322:	b9 b0 15 00 00       	mov    $0x15b0,%ecx
    1327:	e9 32 ff ff ff       	jmp    125e <printf+0x11e>
      state = 0;
    132c:	31 db                	xor    %ebx,%ebx
    132e:	66 90                	xchg   %ax,%ax
    1330:	e9 53 fe ff ff       	jmp    1188 <printf+0x48>
    1335:	66 90                	xchg   %ax,%ax
    1337:	66 90                	xchg   %ax,%ax
    1339:	66 90                	xchg   %ax,%ax
    133b:	66 90                	xchg   %ax,%ax
    133d:	66 90                	xchg   %ax,%ax
    133f:	90                   	nop

00001340 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1340:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1341:	a1 a4 16 00 00       	mov    0x16a4,%eax
{
    1346:	89 e5                	mov    %esp,%ebp
    1348:	57                   	push   %edi
    1349:	56                   	push   %esi
    134a:	53                   	push   %ebx
    134b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    134e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135f:	90                   	nop
    1360:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1362:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1364:	39 ca                	cmp    %ecx,%edx
    1366:	73 30                	jae    1398 <free+0x58>
    1368:	39 c1                	cmp    %eax,%ecx
    136a:	72 04                	jb     1370 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    136c:	39 c2                	cmp    %eax,%edx
    136e:	72 f0                	jb     1360 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1370:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1373:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1376:	39 f8                	cmp    %edi,%eax
    1378:	74 26                	je     13a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    137a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    137d:	8b 42 04             	mov    0x4(%edx),%eax
    1380:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1383:	39 f1                	cmp    %esi,%ecx
    1385:	74 32                	je     13b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1387:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1389:	5b                   	pop    %ebx
  freep = p;
    138a:	89 15 a4 16 00 00    	mov    %edx,0x16a4
}
    1390:	5e                   	pop    %esi
    1391:	5f                   	pop    %edi
    1392:	5d                   	pop    %ebp
    1393:	c3                   	ret    
    1394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1398:	39 c1                	cmp    %eax,%ecx
    139a:	72 d0                	jb     136c <free+0x2c>
    139c:	eb c2                	jmp    1360 <free+0x20>
    139e:	66 90                	xchg   %ax,%ax
    bp->s.size += p->s.ptr->s.size;
    13a0:	8b 78 04             	mov    0x4(%eax),%edi
    13a3:	01 fe                	add    %edi,%esi
    13a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    13a8:	8b 02                	mov    (%edx),%eax
    13aa:	8b 00                	mov    (%eax),%eax
    13ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    13af:	8b 42 04             	mov    0x4(%edx),%eax
    13b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    13b5:	39 f1                	cmp    %esi,%ecx
    13b7:	75 ce                	jne    1387 <free+0x47>
  freep = p;
    13b9:	89 15 a4 16 00 00    	mov    %edx,0x16a4
    p->s.size += bp->s.size;
    13bf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    13c2:	01 c8                	add    %ecx,%eax
    13c4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    13c7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    13ca:	89 0a                	mov    %ecx,(%edx)
}
    13cc:	5b                   	pop    %ebx
    13cd:	5e                   	pop    %esi
    13ce:	5f                   	pop    %edi
    13cf:	5d                   	pop    %ebp
    13d0:	c3                   	ret    
    13d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13df:	90                   	nop

000013e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	57                   	push   %edi
    13e4:	56                   	push   %esi
    13e5:	53                   	push   %ebx
    13e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    13ec:	8b 15 a4 16 00 00    	mov    0x16a4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13f2:	8d 78 07             	lea    0x7(%eax),%edi
    13f5:	c1 ef 03             	shr    $0x3,%edi
    13f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
    13f9:	85 d2                	test   %edx,%edx
    13fb:	0f 84 8f 00 00 00    	je     1490 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1401:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1403:	8b 48 04             	mov    0x4(%eax),%ecx
    1406:	39 f9                	cmp    %edi,%ecx
    1408:	73 5e                	jae    1468 <malloc+0x88>
  if(nu < 4096)
    140a:	bb 00 10 00 00       	mov    $0x1000,%ebx
    140f:	39 df                	cmp    %ebx,%edi
    1411:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1414:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    141b:	eb 0c                	jmp    1429 <malloc+0x49>
    141d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1420:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1422:	8b 48 04             	mov    0x4(%eax),%ecx
    1425:	39 f9                	cmp    %edi,%ecx
    1427:	73 3f                	jae    1468 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1429:	39 05 a4 16 00 00    	cmp    %eax,0x16a4
    142f:	89 c2                	mov    %eax,%edx
    1431:	75 ed                	jne    1420 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1433:	89 34 24             	mov    %esi,(%esp)
    1436:	e8 20 fc ff ff       	call   105b <sbrk>
  if(p == (char*)-1)
    143b:	83 f8 ff             	cmp    $0xffffffff,%eax
    143e:	74 18                	je     1458 <malloc+0x78>
  hp->s.size = nu;
    1440:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1443:	83 c0 08             	add    $0x8,%eax
    1446:	89 04 24             	mov    %eax,(%esp)
    1449:	e8 f2 fe ff ff       	call   1340 <free>
  return freep;
    144e:	8b 15 a4 16 00 00    	mov    0x16a4,%edx
      if((p = morecore(nunits)) == 0)
    1454:	85 d2                	test   %edx,%edx
    1456:	75 c8                	jne    1420 <malloc+0x40>
        return 0;
  }
}
    1458:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    145b:	31 c0                	xor    %eax,%eax
}
    145d:	5b                   	pop    %ebx
    145e:	5e                   	pop    %esi
    145f:	5f                   	pop    %edi
    1460:	5d                   	pop    %ebp
    1461:	c3                   	ret    
    1462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1468:	39 cf                	cmp    %ecx,%edi
    146a:	74 54                	je     14c0 <malloc+0xe0>
        p->s.size -= nunits;
    146c:	29 f9                	sub    %edi,%ecx
    146e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1471:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1474:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1477:	89 15 a4 16 00 00    	mov    %edx,0x16a4
}
    147d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1480:	83 c0 08             	add    $0x8,%eax
}
    1483:	5b                   	pop    %ebx
    1484:	5e                   	pop    %esi
    1485:	5f                   	pop    %edi
    1486:	5d                   	pop    %ebp
    1487:	c3                   	ret    
    1488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    148f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1490:	b8 a8 16 00 00       	mov    $0x16a8,%eax
    1495:	ba a8 16 00 00       	mov    $0x16a8,%edx
    149a:	a3 a4 16 00 00       	mov    %eax,0x16a4
    base.s.size = 0;
    149f:	31 c9                	xor    %ecx,%ecx
    14a1:	b8 a8 16 00 00       	mov    $0x16a8,%eax
    base.s.ptr = freep = prevp = &base;
    14a6:	89 15 a8 16 00 00    	mov    %edx,0x16a8
    base.s.size = 0;
    14ac:	89 0d ac 16 00 00    	mov    %ecx,0x16ac
    if(p->s.size >= nunits){
    14b2:	e9 53 ff ff ff       	jmp    140a <malloc+0x2a>
    14b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14be:	66 90                	xchg   %ax,%ax
        prevp->s.ptr = p->s.ptr;
    14c0:	8b 08                	mov    (%eax),%ecx
    14c2:	89 0a                	mov    %ecx,(%edx)
    14c4:	eb b1                	jmp    1477 <malloc+0x97>
