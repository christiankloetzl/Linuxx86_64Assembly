section .data
    InfoText db "Text from the stack: "
    InfoTextLen equ $ - InfoText
section .bss
    StackPointer: resb 8
section .text
    global _start

_start:
    ;Reserve 100 bytes on the stack
    ;and save the address in StackPointer
    sub rsp, 4
    mov rdi, StackPointer
    mov [rdi], rsp

    ;Fill the array
    .fillArray:
    mov rcx, 99
    mov rdi, [StackPointer]

    ; Set the position of array to "A" (65)
    .start:
    mov byte [rdi], 65
    inc rdi
    dec rcx
    cmp rcx, 0
    jne .start

    ;Add a new line at the end
    .end:
    mov byte [rdi], 10

    ;Print the prompt
    ;write(1, InfoText, InfoTextLen)
    mov rax, 1             ;Syscall #1: write()
    mov rdi, 1             ;File descriptor #1 (stdout)
    mov rsi, InfoText      ;Message
    mov rdx, InfoTextLen   ;Length of message
    syscall                ;System call

    ;Print the Array
    ;write(1, StackPointer, 100)
    mov rax, 1               ;Syscall #1: write()
    mov rdi, 1               ;File descriptor #1 (stdout)
    mov rsi, [StackPointer]  ;Point to the stack; message
    mov rdx, 100             ;Length of array
    syscall

    ;Destroy the array
    add rsp, 100

    ;exit(0)
    mov rax, 60 ;Syscall #60: exit()
    mov rdi, 0  ;Exit status: 0 (EXIT_SUCCESS)
    syscall     ;System call
