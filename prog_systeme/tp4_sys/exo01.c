#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main()
{
    printf("Bonjour\n");
    fork();  // Crée un processus fils s'exécute à partir de la ligne suivante
    printf("Au revoir\n");
}