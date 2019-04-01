.intel_syntax noprefix

.text

.global _start
_start:
    #exit(2)
    mov rax, 1 #Syscall #1: exit()
    mov rbx, 2 #Exit status: 2
    int 0x80   #System call
