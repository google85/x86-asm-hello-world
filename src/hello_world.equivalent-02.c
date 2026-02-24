#include <sys/syscall.h>
#include <unistd.h>

void _start() {  // _start instead of main, since we have no CRT
    /*
    syscall(SYS_write, 1, "Hello World\n", 12);
    syscall(SYS_exit, 0);
    */

    // write(1, "Hello World\n", 12)
    asm volatile (
        "mov $1, %%rax\n"   // SYS_write
        "mov $1, %%rdi\n"   // fd = stdout
        "lea msg(%%rip), %%rsi\n"
        "mov $12, %%rdx\n"  // length
        "syscall\n"
        "mov $60, %%rax\n"  // SYS_exit
        "xor %%rdi, %%rdi\n"
        "syscall\n"
        "msg: .ascii \"Hello World\\n\""
        ::: "rax", "rdi", "rsi", "rdx"
    );
}