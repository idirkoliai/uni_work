#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include "try.h"

typedef struct
{
    bool s_flag;
    bool S_flag;
    char *S_arg;
    bool n_flag;
} Flags;

Flags fill_flags(int argc, char *argv[])
{
    int opt;
    Flags flags = {0};
    //flags.n_flag = false;
    //flags.s_flag = false;
    //flags.S_flag = false;
    while ((opt = getopt(argc, argv, "snS:")) != -1)
    {
        switch (opt)
        {
        case 'n':
            flags.n_flag = true;
            break;
        case 's':
            if (flags.S_flag)
                break;
            flags.s_flag = true;
            break;
        case 'S':
            if (flags.s_flag)
                break;
            flags.S_flag = true;
            flags.S_arg = optarg;
            break;
        default:
            break;
        }
    }
    return flags;
}

int main(int argc, char *argv[])
{
    Flags flags = fill_flags(argc, argv);
    for (int i = optind; i < argc; i++)
    {
        try(write(STDOUT_FILENO, argv[i], strlen(argv[i])));
        if (flags.S_flag && i < argc - 1)
            try(write(STDOUT_FILENO, flags.S_arg, strlen(flags.S_arg)));
        else if (!flags.s_flag)
        {
            write(STDOUT_FILENO, " ", 1);
        }
    }
    if (!flags.n_flag)
        try(write(STDOUT_FILENO, "\n", 1));
}