#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "../try.h"

int main()
{
    char buffer[50];
    int pid = getpid();
    snprintf(buffer, sizeof(buffer), "mon PID est %d", pid);
    printf("%s", buffer);
    try(write(STDOUT_FILENO, buffer, strlen(buffer)));

    int n;
    switch (n = try(fork()))
    {
    case 0:
        pid = getpid();
        snprintf(buffer, sizeof(buffer), "Je suis l'enfant, mon PID est %d", pid);
        printf("%s", buffer);
        snprintf(buffer, sizeof(buffer), "I am the child, my PID is %d", pid);
        try(write(STDOUT_FILENO, buffer, strlen(buffer)));
        break;
    
    default: ;
        int ppid = getpid();
        snprintf(buffer, sizeof(buffer), "Je suis le parent, mon PID est %d", pid);
        printf("%s", buffer);
        snprintf(buffer, sizeof(buffer), "I am the parent, my PID is %d", pid);
        try(write(STDOUT_FILENO, buffer, strlen(buffer)));
        break;
    }
    puts("\n");
    return 0;
}