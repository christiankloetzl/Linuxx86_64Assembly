;System constants
SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60
STDOUT equ 1
STDIN equ 0
EXIT_SUCCESS equ 0

section .data
    Prompt db "Input (16 bytes): "
    PromptLen equ $ - Prompt

section .bss
    InputLength equ 16
    InputBufferSize equ InputLength + 1
    InputBuffer: resb InputBufferSize

section .text
    global _start

_start:
    ;Write the prompt
    ;write(STDOUT, Prompt, PromptLen)
    mov rax, SYS_WRITE   ;Syscall #1: write()
    mov rdi, STDOUT      ;File descriptor #1 (stdout)
    mov rsi, Prompt      ;Prompt text
    mov rdx, PromptLen   ;Length of the prompt text
    syscall              ;System call

    ;Read the input from stdin
    ;read(STDIN, InputBuffer, InputBufferSize)
    mov rax, SYS_READ        ;Syscall #0: read()
    mov rdi, STDIN           ;File descriptor #0 (stdin)
    mov rsi, InputBuffer     ;Input buffer
    mov rdx, InputLength     ;Amount of characters to read
    syscall                  ;System call

    ;Write the input to stdout
    ;write(STDOUT, InputBuffer, InputBufferSize)
    mov rax, SYS_WRITE       ;Syscall #1: write()
    mov rdi, STDOUT          ;File descriptor #1 (stdout)
    mov rsi, InputBuffer     ;Output text
    mov rdx, InputBufferSize ;Length of the Output text
    syscall                  ;System call

    ;Exit with status 0
    ;exit(EXIT_SUCCESS)
    mov rax, SYS_EXIT     ;Syscall #60: exit()
    mov rdi, EXIT_SUCCESS ;Exit status: 0 (EXIT_SUCCESS)
    syscall               ;System call
