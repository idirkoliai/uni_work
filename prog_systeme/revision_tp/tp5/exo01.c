#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#
int main()
{
    int fd = open("exo01.txt", O_CREAT | O_WRONLY, 0644);
    if (fd == -1)
    {
        perror("open");
        exit(1);
    }    
    dup2(fd,STDOUT_FILENO);
    close(fd);
    execlp("ls","ls","-l","-a","test.txt",NULL);
    return 0;

}