#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "../try.h"

int main()
{
    char buff[1024];
    int i = 0;
    char *env_value;

    snprintf(buff, sizeof(buff), "RUN_%d", i);
    while ((env_value = getenv(buff)) != NULL)
    {
        strcpy(buff, env_value);
        // printf("%s\n", buff);
        i++;
        int n;
        switch (n = fork())
        {
        case 0:
        {
            printf("Child %d = %s\n", i,buff);
            char *args[] = {buff, NULL};
            char *env[] = {NULL};
            execve(buff, args, env);
            break;
        }
        default:
        {
            int wstatus;
            try(wait(&wstatus));
            if (!WIFEXITED(wstatus))
            {
                perror("Error");
            }
            snprintf(buff, sizeof(buff), "RUN_%d", i);
            break;
        }
        }
    }
    return 0;
}