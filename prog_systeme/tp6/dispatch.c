#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

typedef struct {
    const char *name;
    FILE *in;
    FILE *out;
} CoProcess;

int main() {
    CoProcess co_processes[] = {
        {"add", NULL, NULL},
        {"sub", NULL, NULL},
        {"mult", NULL, NULL},
        {"div", NULL, NULL},
    };
    int num_co_processes = sizeof(co_processes) / sizeof(CoProcess);

    for (int i = 0; i < num_co_processes; i++) {
        int stdin_pipe[2], stdout_pipe[2];
        if (pipe(stdin_pipe) == -1 || pipe(stdout_pipe) == -1) {
            perror("pipe failed");
            exit(EXIT_FAILURE);
        }

        pid_t pid = fork();
        if (pid == -1) {
            perror("fork failed");
            exit(EXIT_FAILURE);
        } else if (pid == 0) {
            close(stdin_pipe[1]);
            close(stdout_pipe[0]);
            dup2(stdin_pipe[0], STDIN_FILENO);
            dup2(stdout_pipe[1], STDOUT_FILENO);
            close(stdin_pipe[0]);
            close(stdout_pipe[1]);

            char proc_path[256];
            snprintf(proc_path, sizeof(proc_path), "./%s", co_processes[i].name);
            execl(proc_path, co_processes[i].name, (char *)NULL);
            perror("execl failed");
            exit(EXIT_FAILURE);
        } else {
            close(stdin_pipe[0]);
            close(stdout_pipe[1]);
            co_processes[i].in = fdopen(stdin_pipe[1], "w");
            co_processes[i].out = fdopen(stdout_pipe[0], "r");
            if (!co_processes[i].in || !co_processes[i].out) {
                perror("fdopen failed");
                exit(EXIT_FAILURE);
            }
        }
    }

    char line[256];
    while (fgets(line, sizeof(line), stdin)) {
        char op[10];
        int a, b;
        if (sscanf(line, "%9s %d %d", op, &a, &b) != 3) {
            fprintf(stderr, "Invalid command\n");
            continue;
        }

        CoProcess *proc = NULL;
        for (int i = 0; i < num_co_processes; i++) {
            if (strcmp(co_processes[i].name, op) == 0) {
                proc = &co_processes[i];
                break;
            }
        }

        if (!proc) {
            fprintf(stderr, "Unknown operation: %s\n", op);
            continue;
        }

        fprintf(proc->in, "%d %d\n", a, b);
        fflush(proc->in);

        char result_line[256];
        if (fgets(result_line, sizeof(result_line), proc->out)) {
            int result;
            if (sscanf(result_line, "%d", &result) == 1) {
                printf("%d\n", result);
            } else {
                fprintf(stderr, "Invalid result from %s\n", op);
            }
        } else {
            fprintf(stderr, "Failed to read from %s\n", op);
        }
    }

    for (int i = 0; i < num_co_processes; i++) {
        fclose(co_processes[i].in);
        fclose(co_processes[i].out);
    }

    return 0;
}