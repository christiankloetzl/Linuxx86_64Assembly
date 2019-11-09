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
    ReadBytes: resb 1
    DummyCharacter: resb 1

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

    ;Check if the last character is a new line
    mov [ReadBytes], rax	; ReadBytes = rax (return value of read(); Number of read bytes)
    mov rsi, InputBuffer	; Point to InputBuffer
    add rsi, rax		; Point to the last character
    sub rsi, 1
    cmp byte [rsi], 10	        ; Check if the last character is 10 (line feed)
    je .end

    ;Clear the input buffer
    .ClearInputBuffer:
    .readCharacter:
    ;Read the input from stdin
    ;read(STDIN, DummyCharacter, 1)
    mov rax, SYS_READ        ;Syscall #0: read()
    mov rdi, STDIN           ;File descriptor #0 (stdin)
    mov rsi, DummyCharacter  ;Input buffer
    mov rdx, 1		     ;Amount of characters to read
    syscall                  ;System call

    ;Check if rax ist EOF (0)
    cmp rax, 0
    je .addNewLine

    ;Check if the read character is 10 (line feed)
    mov rax, [DummyCharacter]
    cmp rax, 10		     ;Check if a new line is read in
    jne .readCharacter       ;If no, jump back to .readCharacter

    ; Add a new line at the end of InputBuffer
    .addNewLine:
    mov rsi, InputBuffer
    add rsi, InputLength
    mov byte [rsi], 10
    .end:

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
