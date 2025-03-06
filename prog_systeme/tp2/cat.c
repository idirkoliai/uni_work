#include <stdlib.h>
#include "../try.h"
#include <unistd.h>
#include <fcntl.h>
#define BUF_SIZE 1024
int main(int argc, char *argv[]) {
    char buf[BUF_SIZE];
    ssize_t lenread;
    if(argc >= 2)
    {
        for(int i = 1; i < argc; i++) {
            int f =  try(open(argv[i],O_RDONLY));
            while ((lenread = try(read(f, buf, BUF_SIZE))) > 0) {
                try(write(STDOUT_FILENO, buf, lenread));
            }
            try(close(f));
        }
    }
    else
    {
        while ((lenread = try(read(STDIN_FILENO, buf, BUF_SIZE))) > 0) {
            try(write(STDOUT_FILENO, buf, lenread));
        }
    }
}