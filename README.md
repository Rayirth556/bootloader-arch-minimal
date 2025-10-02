# Tiny x86 Bootloader

A minimal x86 bootloader written in assembly, demonstrating BIOS interrupts, real-mode memory management, and kernel loading.

## Overview

A simple bootloader that:  

- Displays a message on the screen.  
- Loads a kernel image from disk into memory.  
- Transfers control to the loaded kernel.  

The bootloader fits within a single 512-byte sector, following the Master Boot Record (MBR) format.

## Prerequisites

- Bochs x86 emulator  
- NASM assembler  
- Optional: GRUB or similar for additional boot management  

## Building the Bootloader

1. Assemble the bootloader:  

```bash
nasm -f bin -o boot.bin boot.asm
```

2. Create a bootable image:  

```bash
dd if=boot.bin of=boot.img bs=512 seek=4
```

3. Copy the kernel image to the correct location on the bootable image.

## Running the Bootloader

Test with Bochs:  

```bash
bochs -f bochsrc.txt
```

Ensure `bochsrc.txt` points to your bootable image as the disk drive.
