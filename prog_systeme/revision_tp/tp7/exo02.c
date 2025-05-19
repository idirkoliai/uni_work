#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>
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
    struct winsize ws;
    try(ioctl(STDIN_FILENO, TIOCGWINSZ, &ws));
    struct sigaction act;
    act.sa_handler = handler;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    try(sigaction(SIGWINCH,&act,NULL));
    while (1)
    {
        pause();
        if (flag)
        {
            char buffer[256];
            snprintf(buffer,sizeof(buffer),"window size: %d x %d\n", ws.ws_row,ws.ws_col);
            write(STDOUT_FILENO,buffer,strlen(buffer));
            try(ioctl(STDIN_FILENO, TIOCGWINSZ, &ws));
        }
    }
}