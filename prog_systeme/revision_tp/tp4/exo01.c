#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
    write(STDOUT_FILENO, "bonjour\n", 8);
    fork();
    write(STDOUT_FILENO, "Au revoir\n", 8);
}