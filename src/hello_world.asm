; hello_world.asm
;
; Author: Florin Google - based on John Hammond YouTube video
; Date: 2026-02-17


section .text:
    mov eax, 0x4        ; use the write syscall


section .data:
    message: db "Hello World", 0xA
    message_length equ $-message