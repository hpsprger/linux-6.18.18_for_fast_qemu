# No-KASLR Linux Kernel

This directory contains a Linux kernel compiled with KASLR (Kernel Address Space Layout Randomization) disabled.

## Configuration Changes

The following configuration options have been modified:

1. **CONFIG_RANDOMIZE_BASE=n** - Disables kernel base address randomization
2. **Other randomization options attempted to be disabled**

## Files

When compilation completes, this directory will contain:

1. **vmlinux** - Complete kernel ELF executable (KASLR disabled)
2. **Image** - Bootable kernel image generated from vmlinux
3. **Configuration files** showing the changes made

## Purpose

Disabling KASLR provides:
- Deterministic kernel memory layout
- Easier debugging and development
- Consistent performance testing
- Simplified security research

## Security Warning

**WARNING**: Disabling KASLR reduces kernel security by making addresses predictable.
Use only in controlled environments for development and testing.

## Verification

To verify KASLR is disabled:
```bash
# Kernel should NOT have 'nokaslr' in command line (it's disabled by default)
# Check kernel messages
dmesg | grep -i kaslr
```

## Build Information
- Kernel version: 6.18.18
- Architecture: ARM64 (AArch64)
- KASLR status: DISABLED
- Build date: $(date)
