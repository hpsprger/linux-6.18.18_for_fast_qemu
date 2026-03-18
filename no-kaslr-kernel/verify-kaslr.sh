#!/bin/bash
# Verification script for No-KASLR kernel

echo "=== No-KASLR Kernel Verification ==="
echo

# Check configuration
echo "1. Checking kernel configuration..."
if grep -q "CONFIG_RANDOMIZE_BASE=n" ../.config 2>/dev/null; then
    echo "   ✅ CONFIG_RANDOMIZE_BASE=n (KASLR disabled)"
else
    echo "   ❌ CONFIG_RANDOMIZE_BASE not set to 'n'"
    echo "   Found: $(grep CONFIG_RANDOMIZE_BASE ../.config 2>/dev/null || echo 'Not found')"
fi

# Check vmlinux file
echo
echo "2. Checking vmlinux file..."
if [ -f vmlinux ]; then
    echo "   ✅ vmlinux exists ($(ls -lh vmlinux | awk '{print $5}'))"
    file vmlinux | grep -q "ARM aarch64" && echo "   ✅ ARM aarch64 architecture"
else
    echo "   ❌ vmlinux not found"
fi

# Check Image file
echo
echo "3. Checking Image file..."
if [ -f Image ]; then
    echo "   ✅ Image exists ($(ls -lh Image | awk '{print $5}'))"
    file Image | grep -q "ARM64 boot executable" && echo "   ✅ ARM64 boot executable"
else
    echo "   ❌ Image not found"
fi

# Summary
echo
echo "=== Summary ==="
if [ -f vmlinux ] && [ -f Image ] && grep -q "CONFIG_RANDOMIZE_BASE=n" ../.config 2>/dev/null; then
    echo "✅ All checks passed! No-KASLR kernel is ready."
    echo
    echo "To use:"
    echo "1. Boot with 'Image' file"
    echo "2. Debug with 'vmlinux' file"
    echo "3. Verify at runtime: dmesg | grep -i kaslr"
else
    echo "⚠️  Some checks failed. Review above messages."
    exit 1
fi
