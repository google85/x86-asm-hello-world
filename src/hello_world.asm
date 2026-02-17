; hello_world.asm
;
; Author: Florin Google - based on John Hammond YouTube video
; Date: 2026-02-17

global _start

section .text:

_start:
    mov eax, 0x4            ; use the write syscall
    mov ebx, 1              ; use stdout as the fd
    mov ecx, message        ; use the message as the buffer
    mov edx, message_length ; and supply the length
    int 0x80                ; invoke the syscall
    ; equivalent with:
    ;
    ; #include <unistd.h>
    ; void main() {
    ;     write(1, "Hello World\n", 12);
    ; }

    ; now gracefully exit

    mov eax, 0x1            ; use the exit syscall
    mov ebx, 0              ; return code
    int 0x80                ; invoke the syscall

    ; equivalent with:
    ;
    ; #include <unistd.h>
    ; void main() {
    ;     _exit(0x0);
    ; }

section .data:
    message: db "Hello World", 0xA
    message_length equ $-message