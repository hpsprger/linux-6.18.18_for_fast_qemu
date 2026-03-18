# Linux Kernel Pair: vmlinux + Image

This directory contains a pair of compiled Linux kernel files for ARM64 architecture.

## Files

### Core Pair
1. **`Image`** (48MB) - Bootable kernel image
   - Architecture: ARM AArch64
   - Boot executable for ARM64 systems
   - Generated from vmlinux using: `objcopy -O binary -R .note -R .note.gnu.build-id -R .comment -S vmlinux Image`
   - File type: Linux kernel ARM64 boot executable Image, little-endian, 4K pages

### vmlinux (Compressed Versions)
Due to GitHub file size limits, vmlinux is provided in compressed formats:

2. **`vmlinux.gz`** (58MB) - gzip compressed vmlinux
   - Complete kernel ELF executable compressed with gzip -9
   - Original size: 160MB

3. **`vmlinux.xz`** (19MB) - xz compressed vmlinux  
   - Complete kernel ELF executable compressed with xz -9
   - Smallest compressed version

## Relationship

- **vmlinux** → **Image**: The Image file is a binary extraction of the vmlinux ELF file, stripped of debug sections and converted to a flat binary format suitable for booting.

## Usage

- **For booting**: Use `Image` file directly
- **For debugging**: Extract `vmlinux.gz` or `vmlinux.xz` and use with gdb
- **For analysis**: Both files can be used together

## Extraction Commands

```bash
# Extract vmlinux from gzip
gzip -d vmlinux.gz

# Extract vmlinux from xz
xz -d vmlinux.xz
```

## Compilation Details

- Kernel version: 6.18.18
- Architecture: ARM64 (AArch64)
- Compilation date: 2026-03-18
- Configuration: Default with minimal changes

## Generation Commands

```bash
# Generate Image from vmlinux
aarch64-linux-gnu-objcopy -O binary -R .note -R .note.gnu.build-id -R .comment -S vmlinux Image

# Compress vmlinux
gzip -9 -k vmlinux    # Creates vmlinux.gz
xz -9 -k vmlinux      # Creates vmlinux.xz
```

