#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <string.h>
#include "../try.h"
/*int main(int argc, char **argv)
{
    if (argc != 3)
    {
        fprintf(stderr, "Wrong usage\n");
        exit(EXIT_FAILURE);
    }
    int p[2];
    try(pipe(p));
    switch (try(fork()))
    {
    case 0: 
        try(dup2(p[1], STDOUT_FILENO));
        try(close(p[0]));
        try(close(p[1]));
        try(execlp(argv[1], (char *)NULL));
    default: 
        try(dup2(p[0], STDIN_FILENO));
        try(close(p[0]));
        try(close(p[1]));
        try(execlp(argv[2], (char *)NULL));
    }
}*/

void execute_pipeline(int cmd_count, char *cmds[]) {
    int pipes[cmd_count - 1][2];

    for (int i = 0; i < cmd_count - 1; i++) {
        if (pipe(pipes[i]) == -1) {
            perror("pipe");
            exit(EXIT_FAILURE);
        }
    }

    for (int i = 0; i < cmd_count; i++) {
        pid_t pid = fork();

        switch (pid) {
            case -1:
                perror("fork");
                exit(EXIT_FAILURE);

            case 0:  
                if (i > 0) {
                    dup2(pipes[i - 1][0], STDIN_FILENO);
                }
                if (i < cmd_count - 1) {
                    dup2(pipes[i][1], STDOUT_FILENO);
                }

                for (int j = 0; j < cmd_count - 1; j++) {
                    close(pipes[j][0]);
                    close(pipes[j][1]);
                }

                execlp(cmds[i], cmds[i], NULL);
                perror("execlp");
                exit(EXIT_FAILURE);

            default: 
                break;
        }
    }

    for (int i = 0; i < cmd_count - 1; i++) {
        close(pipes[i][0]);
        close(pipes[i][1]);
    }

    int status;
    wait(&status);
    exit(WEXITSTATUS(status));
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <cmd1> <cmd2> [<cmd3> ... <cmdN>]\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    execute_pipeline(argc - 1, &argv[1]);
}