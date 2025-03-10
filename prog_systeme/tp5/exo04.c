#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <string.h>

#define BUFFER_SIZE 1024

void sigchld_handler(int signum)
{
    (void)signum;
    wait(NULL);
    exit(EXIT_SUCCESS);
}

int main()
{
    int fd[2];
    pid_t pid;
    char buffer[BUFFER_SIZE];

    if (pipe(fd) == -1)
    {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    signal(SIGCHLD, sigchld_handler);

    pid = fork();

    switch (pid)
    {
    case -1:
        perror("fork");
        exit(EXIT_FAILURE);

    case 0:
        close(fd[1]);
        ssize_t n = read(fd[0], buffer, 10);
        if (n > 0)
        {
            write(STDOUT_FILENO, buffer, n);
        }
        close(fd[0]);
        exit(EXIT_SUCCESS);

    default:
        close(fd[0]);
        ssize_t bytes_read = read(STDIN_FILENO, buffer, BUFFER_SIZE);
        if (bytes_read > 0)
        {
            write(fd[1], buffer, bytes_read);
        }
        close(fd[1]);
        pause();
    }

    return 0;
}
