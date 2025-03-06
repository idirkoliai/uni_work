#include <stdlib.h>
#include "../try.h"
#include <unistd.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdbool.h>
#include <string.h>
#define BUF_SIZE 1024

void parse_cmd_line(int argc, char *argv[], bool *nflag, bool *stdinflag)
{
    int opt;
    while ((opt = getopt(argc, argv, "n")) != -1)
    {
        switch (opt)
        {
        case 'n':
            {*nflag = true; if (argc == 2) *stdinflag = true;}
        default:
            continue;
        }
    }
    for (int i = optind; i < argc; i++)
    {
        if(!strcmp("-",argv[i]))
        {
            *stdinflag = true;
            return ;
        }
    }
}

void line_indexing(char buffer[1024],int *index,bool stdinflag)
{
    char* next_line = strchr(buffer,'\n');
    while(next_line != NULL)
    {
        *next_line = '\0';
        printf("%s%d %s\n",stdinflag?"    ": "",*index,buffer);
        *index += 1;
        buffer = next_line+1;
        next_line = strchr(buffer,'\n');
    }
    if(buffer[0] != '\0')
    {
        printf("%s%d %s",stdinflag?"    ": "",*index,buffer);
    }
}

int main(int argc, char *argv[])
{
    bool stdinflag , nflag;
    stdinflag = nflag = false;
    parse_cmd_line(argc,argv,&nflag,&stdinflag);
    char buf[BUF_SIZE];
    ssize_t lenread;
    int index = 1;
    bool new_line = true;
    if(stdinflag || argc < 2)
    {
        while ((lenread = try(read(STDIN_FILENO, buf, BUF_SIZE))) > 0) {
            if(nflag)
            {
                line_indexing(buf,&index,stdinflag);
            }
            else
            {
                try(write(STDOUT_FILENO, buf, lenread));
            }
        }
    }
    else
    {
        for(int i = 1; i < argc; i++) {
            if(strcmp("-",argv[i]) && strcmp("-n",argv[i]))
            {
                int f =  try(open(argv[i],O_RDONLY));
                while ((lenread = try(read(f, buf, BUF_SIZE))) > 0) {
                    buf[lenread] = '\0';
                    if(nflag)
                    {
                        line_indexing(buf,&index,stdinflag);
                    }
                    else
                    {
                        try(write(STDOUT_FILENO, buf, lenread));
                    }
                }
                try(close(f));
            }
        }
    }
}