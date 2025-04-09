#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include "../include/joblist.h"
#include "../include/try.h"
#include <fcntl.h>  
#define PROMPT "$ "

int lastExitCode = 0;
int lastSignal = 0;

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

void handleChildProcess(Job *job)
{
    if (job->pipeline->head->redin)
    {
        int in = try(open(job->pipeline->head->redin, O_RDONLY));
        try(dup2(in, STDIN_FILENO));
        try(close(in));
    }
    if (job->pipeline->head->redout)
    {
        int out;
        if (job->pipeline->head->append)
        {
            out = try(open(job->pipeline->head->redout, O_WRONLY | O_CREAT | O_APPEND, 0644));
        }
        else
        {
            out = try(open(job->pipeline->head->redout, O_WRONLY | O_CREAT | O_TRUNC, 0644));
        }
        try(dup2(out, STDOUT_FILENO));
        try(close(out));
    }
    try(execvp(job->pipeline->head->args->array[0], job->pipeline->head->args->array));
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
        switch (try(fork()))
        {
        case 0:
          handleChildProcess(job);
          break;
        default:
          if (!job->bg)
          {
            try(waitpid(-1, &status, 0));
          }
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
      delJob(job);
    }
  }
  exit(EXIT_SUCCESS);
}
