.text
    .global _start

_start:
    #write(1, helloWorld, helloWorldLen)
    movq $1, %rax             #Syscall #1: write()
    movq $1, %rdi             #File descriptor #1 (stdout)
    movq $helloWorld, %rsi    #Message
    movq $13, %rdx            #Length of message
    syscall                   #System call

    #exit(0)
    movq $60, %rax #Syscall #60: exit()
    movq $0, %rdi  #Exit status: 0 (EXIT_SUCCESS)
    syscall        #System call

.data
    helloWorld: .ascii "Hello World!\n"
