#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <fcntl.h>
#include "try.h"

int main(int argc, char *argv[])
{
    size_t count_r, count_w;
    char buffer[256];
    if (argc <= 1)
    {
        while ((count_r = try(read(STDIN_FILENO, buffer, 1))))
        {
            size_t index = 0;
            while (index < count_r)
            {
                count_w = try(write(STDOUT_FILENO, buffer + index, 1));
                index++;
            }
        }
    }
    else if (argc >= 2 && !strcmp(argv[1], "-"))
    {
        while ((count_r = try(read(STDIN_FILENO, buffer, sizeof(buffer)))))
        {
            size_t index = 0;
            while (index < count_r)
            {
                count_w = try(write(STDOUT_FILENO, buffer + index, 1));
                index += count_w;
            }
        }

        for (int i = 2; i < argc; i++)
        {
            int fd = open(argv[i], O_RDONLY);
            if (fd == -1)
                continue;
            while ((count_r = try(read(fd, buffer, sizeof(buffer)))))
            {
                size_t index = 0;
                while (index < count_r)
                {
                    count_w = try(write(STDOUT_FILENO, buffer + index, 1));
                    index += count_w;
                }
            }
            close(fd);
        }
    }
    else
    {
        for (int i = 1; i < argc; i++)
        {
            int fd = open(argv[i], O_RDONLY);
            if (fd == -1)
                continue;
            while ((count_r = try(read(fd, buffer, 1))))
            {
                size_t index = 0;
                while (index < count_r)
                {
                    count_w = try(write(STDOUT_FILENO, buffer + index, 1));
                    index++;
                }
            }
            close(fd);
        }
    }
}