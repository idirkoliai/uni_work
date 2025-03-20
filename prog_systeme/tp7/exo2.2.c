#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <signal.h>
#include "../try.h"
volatile sig_atomic_t flag = 0;
void bytes_per_second(int signum)
{
    flag = 1;
    alarm(1);
}
int main(int argc, char *argv[])
{
    char buffer[1024];
    ssize_t read_count,count = 0;
    struct sigaction sa;
    sa.sa_handler = bytes_per_second;
    sa.sa_flags = 0;
    sigemptyset(&sa.sa_mask);
    try(sigaction(SIGALRM, &sa, NULL));
    alarm(1);
    while (1)
    {
        read_count = read(STDIN_FILENO, buffer, sizeof(buffer));
        if (read_count > 0)
            count += read_count;
        else
            continue;
        if (flag)
        {
            printf("%ld B/s\n", count);
            count = 0;
            flag = 0;
            fflush(stdout);
        } 
    }
    return 0;
}