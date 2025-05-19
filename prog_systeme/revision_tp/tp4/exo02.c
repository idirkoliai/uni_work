#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
int main(int argc, int argv)
{
    pid_t pid = getpid();
    printf("mon PID est %d", pid);

    char buffer[256];
    snprintf(buffer, sizeof(buffer), "mon PID est %d", pid);
    write(STDOUT_FILENO, buffer, strlen(buffer));

    switch (fork())
    {
    case 0:;
        snprintf(buffer, sizeof(buffer), "je suis l'enfant mon PID est %d", pid);
        printf("%s", buffer);
        snprintf(buffer, sizeof(buffer), "I'm the child my PID is %d", pid);
        write(STDOUT_FILENO, buffer, strlen(buffer));
        break;
    
    default:
        
        wait(NULL);
        snprintf(buffer, sizeof(buffer), "je suis le pére mon PID est %d", pid);
        printf("%s", buffer);
        snprintf(buffer, sizeof(buffer), "I'm the parent my PID is %d", pid);
        write(STDOUT_FILENO, buffer, strlen(buffer));
        break;
    }
    puts("\n");
    return 0;
}