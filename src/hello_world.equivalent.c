#include <unistd.h>

void main() {
    write(1, "Hello World\n", 12);
    _exit(0x0);
}