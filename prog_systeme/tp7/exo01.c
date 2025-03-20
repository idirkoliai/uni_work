#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <signal.h>
#include "../try.h"

struct winsize ws;

void handler(int sig)
{
    try(ioctl(STDIN_FILENO, TIOCGWINSZ, &ws));
}

int main(int argc, char *argv[])
{
    //try(signal(SIGWINCH, handler), SIG_ERR);
    struct sigaction act;
    act.sa_handler = handler;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    try(sigaction(SIGWINCH, &act, NULL));
    handler(SIGWINCH);
    while (1)
    {
        printf("Window size: %d x %d\n", ws.ws_row, ws.ws_col);
        pause();
    }
    return 0;
}
