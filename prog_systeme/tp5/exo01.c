#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "../try.h"

int main()
{
    int fd = try(open("exo01.txt", O_CREAT | O_WRONLY, 0644));
    if (fd == -1)
    {
        perror("open");
        exit(1);
    }
    try(dup2(fd,STDOUT_FILENO));
    try(close(fd));
    try(execlp("ls", "ls", "-l", NULL));
    perror("execlp");
    exit(1);
    return 0;

}