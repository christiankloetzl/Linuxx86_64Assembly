section .data
    HelloWorld db "Hello World", 10 ;10: Newline
    HelloWorldLen equ $ - HelloWorld

section .text
    global _start

_start:
    ;write(1, helloWorld, helloWorldLen)
    mov rax, 1             ;Syscall #1: write()
    mov rdi, 1             ;File descriptor #1 (stdout)
    mov rsi, HelloWorld    ;Message
    mov rdx, HelloWorldLen ;Length of message
    syscall                ;System call

    ;exit(0)
    mov rax, 60 ;Syscall #60: exit()
    mov rdi, 0  ;Exit status: 0 (EXIT_SUCCESS)
    syscall     ;System call
