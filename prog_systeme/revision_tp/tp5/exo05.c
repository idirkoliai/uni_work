#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include <fcntl.h>
#include "../tp1/try.h"
#include <ctype.h>
#include <stdbool.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
        exit(EXIT_FAILURE);
    int p[2];
    int prev_pipe_read;
    int last_pid;

    for (int i = 0; i < argc; i++)
    {
        bool firstCmd = (i == 0);
        bool lastCmd = (i == argc - 1);
        if (!lastCmd)
            try(pipe(p));
        switch ((last_pid = try(fork())))
        {
        case 0:
            if (!firstCmd)
            {
                try(dup2(prev_pipe_read, STDIN_FILENO));
                try(close(prev_pipe_read));
            }
            if (!lastCmd)
            {
                try(dup2(p[1], STDOUT_FILENO));
                try(close(p[1]));
                try(close(p[0]));
            }
            execlp(argv[i], argv[i], (char *)NULL);
            break;

        default:
            if (!firstCmd)
                try(close(prev_pipe_read));
            if (!lastCmd)
            {
                try(close(p[1]));
                prev_pipe_read = p[0];
            }
            break;
        }
    }
    int wstatus;
    try(waitpid(last_pid, &wstatus, 0));
    WEXITSTATUS(wstatus) ? exit(EXIT_FAILURE) : exit(EXIT_SUCCESS);
}