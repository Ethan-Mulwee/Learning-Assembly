; nasm -f elf64 -o bin/input.o input.asm && ld -o bin/input bin/input.o && ./bin/input

section .data
  buffer: db 0

section .bss
  resb 256

global _start

section .text

_start:
  mov rax, 0        ; read
  mov rdi, 0        ; stdin;
  lea rsi, buffer   ; address of buffer [buffer]
  mov rdx, 256      
  syscall     

  mov rax, 1 ; write
  mov rdi, 1 ; stdout
  mov rsi, buffer
  mov rdx, 256
  syscall

  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );



