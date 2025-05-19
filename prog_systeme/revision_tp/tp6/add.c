#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    setbuf(stdout, NULL); 
    char buf[BUFSIZ];
    while (fgets(buf, sizeof(buf), stdin))
    {
        long a, b;
        char junk; 
        if (sscanf(buf, "%ld%ld %c", &a, &b, &junk) == 2)
        {
            printf("%ld\n", a + b);
        }
        else
        {
            printf("%s: Syntax error\n", argv[0]);
        }
    }
}