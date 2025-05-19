#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // Désactiver la bufferisation sur stdin et stdout
    //setvbuf(stdin, NULL, _IONBF, 0);
    //setvbuf(stdout, NULL, _IONBF, 0);

    int c;
    while ((c = fgetc(stdin)) != EOF) {
        fputc(c, stdout);
    }

    return 0;
}
