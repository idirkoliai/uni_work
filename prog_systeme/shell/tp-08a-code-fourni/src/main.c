#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include "../include/joblist.h"
#include "../include/try.h"

#define PROMPT "$ "

static char *readCmdLine(void)
{
  fprintf(stderr, "%s", PROMPT);
  char *result = NULL;
  size_t len = 0;
  if (getline(&result, &len, stdin) == -1)
  {
    fprintf(stderr, "\n");
    free(result);
    result = NULL;
  }
  else
  {
    len = strlen(result);
    if (len > 0 && result[len - 1] == '\n')
    {
      result[len - 1] = '\0';
    }
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
      return 1;
    }
  }
  else
  {
    if (chdir(argv[1]) == -1)
    {
      printf("path %s not found\n", argv[1]);
      return 1;
    }
  }
  return 0;
}

int builtinExit(int argc, char **argv)
{
  if (argc > 2)
  {
    printf("exit: too many arguments\n");
    return 1;
  }
  if (argc == 2)
  {
    int status = atoi(argv[1]);
    exit(status);
  }
  exit(EXIT_SUCCESS);
}

int main(void)
{
  int status = 0;
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
      // TODO: Do something more useful with the job!
      // printJob(job);
      // delJob(job);
      if (strcmp(job->pipeline->head->args->array[0], "exit") == 0)
      {
        builtinExit(job->pipeline->head->args->size, job->pipeline->head->args->array);
      }
      else
      if (strcmp(job->pipeline->head->args->array[0], "cd") == 0)
      {
        builtinCD(job->pipeline->head->args->size, job->pipeline->head->args->array);
      }
      else
      {
        switch (try(fork()))
        {
        case 0:
          try(execvp(job->pipeline->head->args->array[0], job->pipeline->head->args->array));
          break;
        default:
          if (!job->bg)
          {
            try(waitpid(-1, &status, 0));
          }
        }
      }
      delJob(job);
    }
    }
  exit(EXIT_SUCCESS);
}
