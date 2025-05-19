#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc,char *argv[])
{
    char buffer[256];
    char* env;
    for(int i = 0 ; 1 ; i++)
    {
        snprintf(buffer,sizeof(buffer),"RUN_%d",i);
        if(!(env = getenv(buffer)))
        {
            break;
        }
        switch (fork())
        {
        case 0:
            execvp(env,argv);
            break;
        
        default:
            wait(NULL);
            break;
        }
        
    }
}