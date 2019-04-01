.intel_syntax noprefix

.text

.global _start
_start:
    #exit(2)
    mov rax, 60 #Syscall #60: exit()
    mov rdi, 2  #Exit status: 2
    syscall     #System call
