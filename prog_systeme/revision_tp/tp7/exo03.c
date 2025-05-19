#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include "../tp1/try.h"
#include <string.h>
volatile sig_atomic_t flag;

void handler(int sig)
{
    flag = 1;
}

int main()
{
    struct sigaction act;
    act.sa_handler = handler;
    sigemptyset(&act.sa_mask);
    act.sa_flags = SA_RESTART;
    sigaction(SIGALRM, &act, NULL);
    ssize_t total= 0, r;
    char buffer_r[1024];
    alarm(1);
    while (1)
    {
        r = try(read(STDIN_FILENO, buffer_r, sizeof(buffer_r)));
        if (r > 0)
            total += r;
        else
            continue;
        if (flag)
        {
            char buffer[256];
            snprintf(buffer, sizeof(buffer), "%d B/s\n", total);
            write(STDOUT_FILENO, buffer, strlen(buffer));
            total = 0;
            flag = 0;
            alarm(1);
        }
    }
}