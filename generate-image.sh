#!/bin/bash
# Script to generate Image from vmlinux once compilation completes

set -e

echo "Checking for vmlinux..."
if [ -f vmlinux ]; then
    echo "vmlinux found! Generating Image..."
    
    # Generate Image
    aarch64-linux-gnu-objcopy -O binary -R .note -R .note.gnu.build-id -R .comment -S vmlinux Image
    
    # Check file
    echo "Image generated:"
    ls -lh Image
    file Image
    
    # Copy to no-kaslr-kernel directory
    mkdir -p no-kaslr-kernel
    cp vmlinux Image no-kaslr-kernel/ 2>/dev/null || true
    
    echo "Files ready in no-kaslr-kernel/"
else
    echo "vmlinux not found yet. Waiting..."
    exit 1
fi
