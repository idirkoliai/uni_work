#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include "../include/joblist.h"
#include "../include/try.h"
#include <fcntl.h>
#include <unistd.h>
#include <readline/readline.h>
#include <readline/history.h>

int lastExitCode = 0;
int lastSignal = 0;

static char *readCmdLine(void)
{
  char *user = getenv("USER");
  char host[256];
  char cwd[1024];

  if (gethostname(host, sizeof(host)) == -1)
  {
    perror("gethostname");
    strcpy(host, "unknown");
  }

  if (getcwd(cwd, sizeof(cwd)) == NULL)
  {
    perror("getcwd");
    strcpy(cwd, "unknown");
  }

  // Codes ANSI pour les couleurs
  const char *GREEN = "\033[0;32m";
  const char *CYAN = "\033[0;36m";
  const char *YELLOW = "\033[0;33m";
  const char *WHITE = "\033[0;37m";
  const char *RESET = "\033[0m";

  // Prompt avec couleurs
  fprintf(stderr, "%s%s%s@%s%s%s:%s%s%s%s$ ",
          GREEN, user ? user : "unknown", RESET,
          CYAN, host, RESET,
          YELLOW, cwd, RESET,
          WHITE);
  char *result = NULL;
  size_t len = 0;
#ifndef READLINE
  if (getline(&result, &len, stdin) == -1)
  {
    fprintf(stderr, "\n");
    free(result);
    result = NULL;
  }
#else
  result = readline("");
  if (result && *result)
  {
    add_history(result);
    // Remove trailing newline
  }
  rl_outstream = stdin;

#endif
  // Remove trailing newline
  len = strlen(result);
  if (len > 0 && result[len - 1] == '\n')
  {
    result[len - 1] = '\0';
  }
  return result;
}

int builtinCD(int argc, char **argv)
{
  if (argc != 2)
  {
    char *home = getenv("HOME");
    if (chdir(home) == -1)
    {
      printf("path %s not found\n", home);
      lastExitCode = 1;
      return 1;
    }
  }
  else
  {
    if (chdir(argv[1]) == -1)
    {
      printf("path %s not found\n", argv[1]);
      lastExitCode = 1;
      return 1;
    }
  }
  lastExitCode = 0;
  return 0;
}

int builtinExit(int argc, char **argv)
{
  if (argc > 2)
  {
    printf("exit: too many arguments\n");
    lastExitCode = 1;
    return 1;
  }
  if (argc == 2)
  {
    int exitCode = atoi(argv[1]);
    exit(exitCode);
  }

  if (lastSignal != 0)
  {
    exit(lastSignal + 128);
  }
  exit(lastExitCode);
}

static void redirections(Proc *proc, int pipefd[2], int prev_fd)
{
  if (proc->redin)
  {
    int fd = try(open(proc->redin, O_RDONLY));
    dup2(fd, STDIN_FILENO);
    close(fd);
    close(prev_fd);
    close(pipefd[0]);
  }
  else if (prev_fd != -1)
  {
    dup2(prev_fd, STDIN_FILENO);
    close(prev_fd);
    close(pipefd[0]);
  }

  if (proc->redout)
  {
    int fd;
    if (proc->append)
      fd = try(open(proc->redout, O_WRONLY | O_CREAT | O_APPEND, 0644));
    else
      fd = try(open(proc->redout, O_WRONLY | O_CREAT | O_TRUNC, 0644));
    dup2(fd, STDOUT_FILENO);
    close(fd);
    close(pipefd[1]);
  }
  else if (proc->next)
  {
    try(dup2(pipefd[1], STDOUT_FILENO));
    try(close(pipefd[1]));
  }
}

void execJob(Job *job)
{
  Proc *proc = job->pipeline->head;
  int prev_fd = -1; // previous read-end of the pipe
  int pipefd[2];
  int status;

  for (; proc; proc = proc->next)
  {

    try(pipe(pipefd));

    switch (try(fork()))
    {
    case 0:
      redirections(proc, pipefd, prev_fd);
      execvp(proc->args->array[0], proc->args->array);
      perror("execvp");
      exit(EXIT_FAILURE);

    default:
      if (prev_fd != -1)
        close(prev_fd);
      if (proc->next)
      {
        close(pipefd[1]);
        prev_fd = pipefd[0];
      }
      if (!job->bg)
      {
        waitpid(-1, &status, 0);
        if (WIFEXITED(status))
        {
          lastExitCode = WEXITSTATUS(status);
          lastSignal = 0;
        }
        else if (WIFSIGNALED(status))
        {
          lastSignal = WTERMSIG(status);
          lastExitCode = 0;
        }
      }
    }
  }
}

int main(void)
{

  while (true)
  {
    char *line = readCmdLine();
    if (!line)
    {
      break;
    }
    Job *job = newJobFromCmdLine(line);
    if (job)
    {
      if (strcmp(job->pipeline->head->args->array[0], "exit") == 0)
      {
        builtinExit(job->pipeline->head->args->size, job->pipeline->head->args->array);
      }
      else if (strcmp(job->pipeline->head->args->array[0], "cd") == 0)
      {
        builtinCD(job->pipeline->head->args->size, job->pipeline->head->args->array);
      }
      else
      {
        execJob(job);
      }
      delJob(job);
    }
  }
  exit(EXIT_SUCCESS);
}
