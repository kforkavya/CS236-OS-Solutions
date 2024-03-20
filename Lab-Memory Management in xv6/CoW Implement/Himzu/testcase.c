#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void)
{
  int n = getNumFreePages();
  printf(1, "parent %d Number of free pages: %d\n",getpid(), n);
  char *t = sbrk(4096);
  for (int i=0; i<4096; i++) {
    t[i] = 'a';
  }
  if (fork() == 0)
  {
    printf(1, "child %d Number of free pages: %d\n", getpid(),getNumFreePages());
    printf(1, "Child process,%d\n", t[1]);
    printf(1, "Number of free pages: %d\n", getNumFreePages());
    t[1] = 'b';
    printf(1, "Child process,%d\n", t[1]);
    printf(1, "Number of free pages: %d\n", getNumFreePages());
  }
  else
  {
    wait();
    printf(1, "Parent process, %d\n", t[1]);
    printf(1, "Number of free pages: %d\n", getNumFreePages());
  }
  exit();
}