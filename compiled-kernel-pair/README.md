# Linux Kernel Pair: vmlinux + Image

This directory contains a pair of compiled Linux kernel files for ARM64 architecture.

## Files

1. **`vmlinux`** (160MB) - Complete kernel ELF executable
   - Architecture: ARM AArch64
   - Contains debug symbols and relocation information
   - Useful for debugging and analysis
   - File type: ELF 64-bit LSB pie executable, ARM aarch64

2. **`Image`** (48MB) - Bootable kernel image
   - Architecture: ARM AArch64
   - Boot executable for ARM64 systems
   - Generated from vmlinux using: `objcopy -O binary -R .note -R .note.gnu.build-id -R .comment -S vmlinux Image`
   - File type: Linux kernel ARM64 boot executable Image, little-endian, 4K pages

## Relationship

- **vmlinux** → **Image**: The Image file is a binary extraction of the vmlinux ELF file, stripped of debug sections and converted to a flat binary format suitable for booting.

## Usage

- **For booting**: Use `Image` file
- **For debugging**: Use `vmlinux` file with gdb
- **For analysis**: Both files can be used together with System.map (not included here)

## Compilation Details

- Kernel version: 6.18.18
- Architecture: ARM64 (AArch64)
- Compilation date: 2026-03-18
- Configuration: Default with minimal changes

## Generation Command

```bash
# Generate Image from vmlinux
aarch64-linux-gnu-objcopy -O binary -R .note -R .note.gnu.build-id -R .comment -S vmlinux Image
```

