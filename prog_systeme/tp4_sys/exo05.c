#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "../try.h"
#define MAX 20

int main()
{
    int n;
    for (int i = 0; i < 20; i++)
    {
        n = fork();
        switch (n)
        {
        case 0:
            ; char buffer[100];
            snprintf(buffer, sizeof(buffer), "je suis le processus %d mon pid est %d et le pid de mon père est %d\n", i+1, getpid(), getppid());
            write(STDOUT_FILENO, buffer, strlen(buffer));
            _exit(0);
            break;
        default:;
            int wstatus;
            try(wait(&wstatus));
            if (!WIFEXITED(wstatus))
            {
                perror("Error");
            }
            break;
        }
    }
    return 0;
}