#!/bin/bash

name="$1"
nasm -f elf64 -o bin/"$name".o "$name".asm && ld -o bin/"$name" bin/"$name".o && ./bin/"$name"