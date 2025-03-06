#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "../try.h"
#define MAX 20

typedef struct {
    pid_t pid;
    int numero;
} enfant_t;

int main()
{
    enfant_t enfants[MAX];
    for (int i = 0; i < MAX; i++)
    {
        pid_t n = fork();
        if (n < 0) {
            perror("Erreur lors du fork");
            exit(EXIT_FAILURE);
        }
        if (n == 0) {
            char buffer[100];
            snprintf(buffer, sizeof(buffer),
                     "je suis le processus %d, mon pid est %d et le pid de mon père est %d\n",
                     i + 1, getpid(), getppid());
            write(STDOUT_FILENO, buffer, strlen(buffer));
            return 0;
        } else {
            enfants[i].pid = n;
            enfants[i].numero = i + 1;
        }
    }
    int wstatus;
    pid_t terminated;
    while ((terminated = wait(&wstatus)) > 0) {
        int num = -1;
        for (int i = 0; i < MAX; i++) {
            if (enfants[i].pid == terminated) {
                num = enfants[i].numero;
                break;
            }
        }
        char msg[150];
        int len = snprintf(msg, sizeof(msg),
                           "le processus numéro %d de PID %d vient de terminer\n",
                           num, terminated);
        write(STDOUT_FILENO, msg, len);
    }
    return 0;
}
