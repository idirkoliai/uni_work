#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "../try.h"
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        exit(1);
    }

    char *prog = argv[1];
    char *args[argc];
    for (int i = 1; i < argc; i++)
    {
        args[i - 1] = argv[i];
    }
    args[argc - 1] = NULL;

    switch (try(fork()))
    {
    case 0:
        int fd = try(open("/dev/null", O_WRONLY, 0644));
        printf("%d",fd);
        if (fd == -1)
        {
            perror("open");
            exit(EXIT_FAILURE);
        }
        dup2(fd, STDOUT_FILENO);
        try(close(fd));
        return try(execvp(prog, args));

    default:;
        int wstatus;
        int ret = try(wait(&wstatus));
        if (ret == -1)
            printf("OK\n");
        else
            printf("ERROR\n");
    }
}
