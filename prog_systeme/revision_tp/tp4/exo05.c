#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
    char buffer[256];
    for (int i = 1; i <= 20; i++)
    {
        switch (fork())
        {
        case 0:
            snprintf(buffer, sizeof(buffer), "process %d my pid is %d et mon parent est %d\n", i, getpid(),getppid());
            write(STDOUT_FILENO, buffer, strlen(buffer));
            return 0;
        default:
            int w_status;
            pid_t pid = wait(&w_status);
            printf("process %d terminated\n",pid);
            break;
        }
    }
    //while(1) pause();
    return 0;
}