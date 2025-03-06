#include <sys/types.h>
#include <sys/stat.h>
#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/sysmacros.h>
#include <unistd.h>
#include "../try.h"
#include <dirent.h>
#include <string.h>
#include <stdbool.h>
#include <getopt.h>

#define RESET_COLOR "\033[0m"
#define BLUE "\033[34m"  // Directory
#define GREEN "\033[32m" // Regular file
#define CYAN "\033[36m"  // Symbolic link
#define RED "\033[31m"   // Errors/Warnings

void print_file_info(const char *filename)
{
    struct stat st;
    try(lstat(filename, &st), -1);

    char *color = RESET_COLOR;

    if (S_ISLNK(st.st_mode))
    {
        color = CYAN;
        int size = st.st_size + 1;
        char link[size];
        try(readlink(filename, link, size), -1);
        link[size - 1] = '\0';
        printf("%s%s%s -> %s\n", color, filename, RESET_COLOR, link);
        try(lstat(link, &st), -1);
    }
    else if (S_ISDIR(st.st_mode))
    {
        color = BLUE;
    }
    else if (S_ISREG(st.st_mode))
    {
        color = GREEN;
    }

    printf("%sFile: %s%s\n    ", color, filename, RESET_COLOR);

    switch (st.st_mode & S_IFMT)
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
    printf("Inode: %ld  ", st.st_ino);
    printf("size: %ld  ", st.st_size);
    printf("last modification: %ld\n", st.st_mtime);
}

char *get_full_path(const char *dirname, const char *filename)
{
    char *full_path = malloc(strlen(dirname) + strlen(filename) + 2);
    if (full_path == NULL)
    {
        perror("malloc");
        exit(EXIT_FAILURE);
    }
    sprintf(full_path, "%s/%s", dirname, filename);
    return full_path;
}

void list_directory(const char *dirname)
{
    DIR *dir;
    struct dirent *entry;
    dir = opendir(dirname);
    if (dir == NULL)
    {
        print_file_info(dirname);
        return;
    }
    while ((entry = readdir(dir)) != NULL)
    {
        char *full_path = get_full_path(dirname, entry->d_name);
        print_file_info(full_path);
        free(full_path);
    }
    try(closedir(dir), -1);
}

void list_directory_recursive(const char *dirname)
{
    DIR *dir;
    struct dirent *entry;
    dir = opendir(dirname);
    if (dir == NULL)
    {
        print_file_info(dirname);
        return;
    }
    while ((entry = readdir(dir)) != NULL)
    {
        char *full_path = get_full_path(dirname, entry->d_name);
        if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") && strcmp(entry->d_name, ".."))
        {
            list_directory_recursive(full_path);
        }
        else
        {
            print_file_info(full_path);
        }
        free(full_path);
    }
    try(closedir(dir), -1);
}

void parse_cmd_line(int argc, char *argv[], bool *Rflag, bool *current_dir_flag)
{
    int c;
    while ((c = getopt(argc, argv, "R")) != -1)
    {
        switch (c)
        {
        case 'R':
            *Rflag = true;
            if (argc == 2)
                *current_dir_flag = true;
            break;
        default:
            printf(RED "Usage: %s [-R] [directory]\n" RESET_COLOR, argv[0]);
            exit(EXIT_FAILURE);
        }
    }
}

int main(int argc, char *argv[])
{
    bool Rflag, current_dir_flag;
    Rflag = current_dir_flag = false;
    parse_cmd_line(argc, argv, &Rflag, &current_dir_flag);

    if (argc < 2)
    {
        list_directory(".");
    }
    else if (current_dir_flag)
    {
        Rflag ? list_directory_recursive(".") : list_directory(".");
    }
    else
    {
        for (int i = optind; i < argc; i++)
        {
            if (Rflag)
            {
                list_directory_recursive(argv[i]);
            }
            else
            {
                list_directory(argv[i]);
            }
        }
    }
}
