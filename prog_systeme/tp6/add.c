#include <stdio.h>
#include <stdlib.h>

int main() {
    char line[256];
    while (1) {
        if (fgets(line, sizeof(line), stdin)) {
            int a, b;
            if (sscanf(line, "%d %d", &a, &b) == 2) {
                int result = a + b;
                printf("%d\n", result);
                fflush(stdout);
            }
        }
    }
    return 0;
}