#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include <fcntl.h>
#include "../tp1/try.h"
#include <ctype.h>

static struct dispatch
{
    char *name;
    int input;
    int output;

} proc[] = {
    {"add", -1, -1},
    {"sub", -1, -1},
    {"mult", -1, -1},
    {"div", -1, -1},
    {NULL, -1, -1}};

static void start_process(void)
{

    for (int i = 0; proc[i].name; i++)
    {
        int pipe_in[2];
        int pipe_out[2];
        try(pipe(pipe_in));
        try(pipe(pipe_out));
        switch (fork())
        {
        case 0:
            try(dup2(pipe_in[0], STDIN_FILENO));
            try(dup2(pipe_out[1], STDOUT_FILENO));
            try(close(pipe_in[0]));
            try(close(pipe_in[1]));
            try(close(pipe_out[0]));
            try(close(pipe_out[1]));
            execl(proc[i].name, proc[i].name, NULL);
            perror("execlp");
            exit(EXIT_FAILURE);
        default:
            try(close(pipe_in[0]));
            try(close(pipe_out[1]));
            proc[i].input = pipe_in[1];
            proc[i].output = pipe_out[0];
            break;
        }
    }
}

static void dispatch(void)
{
    char line[256];
    int a, b;
    int result;
    char op[10];
    char buffer[256];
    while (1)
    {
        if (fgets(line, sizeof(line), stdin))
        {
            if (sscanf(line, "%s %d %d", op, &a, &b) == 3)
            {
                for (int i = 0; proc[i].name; i++)
                {
                    if (strcmp(op, proc[i].name) == 0)
                    {
                        snprintf(buffer, sizeof(buffer), "%d %d\n", a, b);
                        try(write(proc[i].input, buffer, sizeof(buffer)));
                        char res_buffer[256];
                        ssize_t n = try(read(proc[i].output, res_buffer, sizeof(res_buffer) - 1));
                        res_buffer[n] = '\0';
                        result = atoi(res_buffer);
                        printf("%s: %d\n", op, result);
                        break;
                    }
                }
            }
            else
            {
                fprintf(stderr, "Invalid input format\n");
            }
        }
    }
}

int main()
{
    start_process();
    dispatch();
    return 0;
}