#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "../try.h"
#include <sys/types.h>
#include <sys/wait.h>
#include <ctype.h>
#define BUFF_SIZE 1024
void toUpperCase(char *buffer)
{
    for (int i = 0; buffer[i] != '\0'; i++)
    {
        buffer[i] = toupper(buffer[i]);
    }
}
int main()
{
    int p[2];
    char buffer[1024];
    try(pipe(p));
    ssize_t bytesRead;
    switch (try(fork()))
    {
    case 0:
        try(close(p[0]));
        while ((bytesRead = try(read(STDIN_FILENO, buffer, BUFF_SIZE - 1))) > 0)
        {
            buffer[bytesRead] = '\0';
            toUpperCase(buffer);
            try(write(p[1], buffer, bytesRead));
        }
        break;
    default:
        try(close(p[1]));
        while ((bytesRead = try(read(p[0], buffer, BUFF_SIZE - 1))) > 0)
        {
            buffer[bytesRead] = '\0';
            try(write(STDOUT_FILENO, buffer, bytesRead));
        }
        break;
    }
}