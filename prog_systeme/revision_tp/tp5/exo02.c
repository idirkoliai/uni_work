#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include <fcntl.h>
#include "../tp1/try.h"

int main(int argc, char *argv[])
{
    int w_status, fd;

    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s command [args...]\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    char *args[argc]; // argc - 1 args + NULL
    for (int i = 1; i < argc; i++)
    {
        args[i - 1] = argv[i];
    }
    args[argc - 1] = NULL;

    switch (fork())
    {
    case 0:
        fd = try(open("/dev/null", O_WRONLY));
        try(dup2(fd, STDOUT_FILENO));
        try(execvp(args[0], args));
        exit(EXIT_FAILURE); // only if exec fails
    default:
        wait(&w_status);
        if (!WEXITSTATUS(w_status))
            write(STDOUT_FILENO, "OK\n", 3);
        else
            write(STDOUT_FILENO, "ERROR\n", 6);
        break;
    }

    return 0;
}
