; nasm -f elf64 -o bin/fizzbuzz.o fizzbuzz.asm && ld -o bin/fizzbuzz bin/fizzbuzz.o && ./bin/fizzbuzz

global _start

section .text

print_fizz:
  mov rax, 1      
  mov rdi, 1       
  mov rsi, fizz    
  mov rdx, fizzlen 
  syscall          
  ret

print_buzz:
  mov rax, 1        
  mov rdi, 1        
  mov rsi, buzz     
  mov rdx, buzzlen  
  syscall           
  ret

print_newline:
  mov rax, 1        
  mov rdi, 1        
  mov rsi, newline  
  mov rdx, newlinelen
  syscall           
  ret

print_number: ; prints number in r12 register
  mov r14, r12
  mov r15, 0
  number_loop:
  
  ; r14%10 -> rdx
  ; r14/10 -> rax
  mov rax, r14  
  mov rbx, 10
  mov rdx, 0
  div rbx

  ; r14 = rax
  mov r14, rax 

  push rdx
  inc r15 ; i++

  cmp rax, 0
  jz print_loop
  jmp number_loop

  print_loop:
  pop rdx
  mov r13, rdx
  add r13, '0'
  mov [number+0], r13 ; numberBuffer[0] = r13

  mov rax, 1  ; write     
  mov rdi, 1  ; standard out
  mov rsi, number
  mov rdx, number_len
  syscall

  ; if (r15 != 0) goto print_loop
  ; else return
  dec r15 ; i--
  cmp r15, 0
  jz return 
  jmp print_loop

  return:
  ret

remainder3:
  mov rax, r12
  mov rbx, 3
  mov rdx, 0
  div rbx
  ret

remainder5:
  mov rax, r12
  mov rbx, 5
  mov rdx, 0
  div rbx
  ret


_start:
  mov r12, 1
my_loop:
  ; use div to get remainder of dividing r12 by 3 and 5 and use jumps to do the logic accordingly
  call remainder3

  cmp rdx, 0
  jz fizz_section

  call remainder5

  cmp rdx, 0
  jz buzz_section

  call print_number
  jmp next

  fizz_section:
  call print_fizz

  call remainder5
  cmp rdx, 0
  jz buzz_section

  jmp next

  buzz_section:
  call print_buzz
  jmp next

  next:
  call print_newline
  inc r12
  cmp r12, 100
  jb my_loop

  exit:
  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

section .data
  fizz: db "fizz" ; string
  fizzlen: equ $ - fizz ; length of string
  buzz: db "buzz" ; string
  buzzlen: equ $ - buzz ; length of string
  newline: db 10 ; string
  newlinelen: equ $ - newline ; length of string
  number: db "0", 10 ; string
  number_len: equ $-number ; length of string