#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include <fcntl.h>
#include "../tp1/try.h"
#include <ctype.h>

char *to_uppercase(char *str)
{
    char *p = str;
    while (*p)
    {
        *p = toupper(*p);
        p++;
    }
    return str;
}

int main()
{
    int p[2];
    try(pipe(p));
    char buffer[256];
    size_t count_r, count_w;
    size_t total = 0;
    switch (fork())
    {
    case 0:
        try(dup2(p[0], STDIN_FILENO));
        try(close(p[0]));
        try(close(p[1]));
        while (total < 10 && (count_r = try(read(STDIN_FILENO, buffer, sizeof(buffer)))) > 0)
        {

            size_t index = 0;
            while (index < count_r && total < 10)
            {
                size_t to_write = (count_r - index < 10 - total) ? (count_r - index) : (10 - total);
                count_w = try(write(STDOUT_FILENO, buffer + index, to_write));
                total += count_w;
                index += count_w;
            }
        }
        try(close(STDIN_FILENO));
        exit(EXIT_SUCCESS);

    default:
        try(dup2(p[1], STDOUT_FILENO));
        try(close(p[0]));
        try(close(p[1]));
        while ((count_r = try(read(STDIN_FILENO, buffer, sizeof(buffer)))))
        {
            size_t index = 0;
            while (index < count_r)
            {
                count_w = try(write(STDOUT_FILENO, buffer + index, count_r - index));
                index += count_w;
            }
        }
        break;
    }
    return 0;
}
