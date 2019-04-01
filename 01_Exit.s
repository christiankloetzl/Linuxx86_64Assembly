.text

.global _start
_start:
    #exit(2)
    movq $60, %rax #Syscall #60: exit()
    movq $2, %rdi  #Exit status: 2
    syscall        #System call
