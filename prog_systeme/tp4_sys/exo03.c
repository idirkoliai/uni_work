#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "../try.h"

int main()
{
    int n;
    switch ((n = try(fork())))
    {
    case 0:
    {
        int m;
        switch (m = try(fork()))
        {
        case 0:
        {
            char *args[] = {"/bin/ls", "-l" ,"..", NULL};
            char *env[] = {NULL};
            try(execve("/bin/ls", args, env));
        }
        default:
        {
            int wstatus;
            pid_t pid = try(wait(&wstatus));
            if (WIFEXITED(wstatus))
            {
                char *args[] = {"/bin/ps", NULL};
                char *env[] = {NULL};
                try(execve("/bin/ps", args, env));
            }
        }
        }
    }
    default:
    {
        int wstatus;
        pid_t pid = try(wait(&wstatus));
        if (WIFEXITED(wstatus))
        {
            char *args[] = {"/usr/bin/free", NULL};
            char *env[] = {NULL};
            try(execve("/usr/bin/free", args, env));
        }
    }
    }
    return 0;
}