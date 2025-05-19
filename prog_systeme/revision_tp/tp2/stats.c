#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <fcntl.h>
#include "try.h"
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <time.h>

int main(int argc, char *argv[])
{
    struct stat sb;
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <pathname>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if (lstat(argv[1], &sb) == -1)
    {
        perror("lstat");
        exit(EXIT_FAILURE);
    }

    if (S_ISLNK(sb.st_mode))
    {
        printf("l   ");
        off_t size = sb.st_size + 1;
        char link[size];
        readlink(argv[1], link, size);
        link[size - 1] = '\0';
        lstat(link, &sb);
        printf("%s -> %s ", argv[1], link);
    }
    else
    {
        printf("%s ", argv[1]);
        switch (sb.st_mode & S_IFMT)
        {
        case S_IFDIR:
            printf("d ");
            break;
        case S_IFREG:
            printf("f ");
            break;
        default:
            printf("? ");
            break;
        }
    }

    char *date = ctime(&sb.st_mtime);
    date[strlen(date) - 1] = '\0';
    printf("%s %d\n", date, sb.st_ino);
}