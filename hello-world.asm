; nasm -f elf64 -o bin/hello-world.o hello-world.asm && ld -o bin/hello-world bin/hello-world.o && ./bin/hello-world

global _start

section .text

_start:
  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  mov rsi, msg      ;   "Hello, world!\n",
  mov rdx, msglen   ;   sizeof("Hello, world!\n")
  syscall           ; );

  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

section .rodata
  msg: db "Hello, world!", 10 ; string
  msglen: equ $ - msg ; length of string


