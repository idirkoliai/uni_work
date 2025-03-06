#include <sys/types.h>
#include <sys/stat.h>
#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include "../try.h"

void print_file_info(const char *filename)
{
    struct stat st;
    
    try(lstat(filename, &st), -1);

    if (S_ISLNK(st.st_mode))
    {
        int size = st.st_size + 1;
        char link[size];
        try(readlink(filename, link, size), -1);
        link[size - 1] = '\0';
        printf("%s points to %s\n", filename, link);
        try(lstat(link, &st), -1);
        printf("File: %s stats\n", link);
    }
    else
    {
        printf("File: %s stats\n", filename);
    }

    switch (st.st_mode & S_IFMT)
    {
    case S_IFDIR: printf("d "); break;
    case S_IFREG: printf("f "); break;
    default: printf("? "); break;
    }
    printf("Inode: %ld  ", st.st_ino);
    printf("size: %ld  ", st.st_size);
    printf("last modification: %ld\n", st.st_mtime);
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    print_file_info(argv[1]);
    return EXIT_SUCCESS;
}
