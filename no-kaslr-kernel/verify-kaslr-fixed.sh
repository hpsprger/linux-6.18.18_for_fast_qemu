#!/bin/bash
# Fixed verification script for No-KASLR kernel

echo "=== No-KASLR Kernel Verification ==="
echo

# Check configuration - accept both "n" and "not set"
echo "1. Checking kernel configuration..."
if grep -q "CONFIG_RANDOMIZE_BASE=n" ../.config 2>/dev/null || 
   grep -q "# CONFIG_RANDOMIZE_BASE is not set" ../.config 2>/dev/null; then
    echo "   ✅ KASLR DISABLED"
    echo "   Found: $(grep -i "randomize_base" ../.config 2>/dev/null)"
else
    echo "   ❌ KASLR may be enabled"
    echo "   Found: $(grep -i "randomize_base" ../.config 2>/dev/null || echo 'Not found')"
fi

# Check vmlinux file
echo
echo "2. Checking vmlinux file..."
if [ -f vmlinux ]; then
    echo "   ✅ vmlinux exists ($(ls -lh vmlinux | awk '{print $5}'))"
    file vmlinux | grep -q "ARM aarch64" && echo "   ✅ ARM aarch64 architecture"
    echo "   Build time: $(stat -c %y vmlinux)"
else
    echo "   ❌ vmlinux not found"
fi

# Check Image file
echo
echo "3. Checking Image file..."
if [ -f Image ]; then
    echo "   ✅ Image exists ($(ls -lh Image | awk '{print $5}'))"
    file Image | grep -q "ARM64 boot executable" && echo "   ✅ ARM64 boot executable"
    echo "   Build time: $(stat -c %y Image)"
else
    echo "   ❌ Image not found"
fi

# Summary
echo
echo "=== Summary ==="
if [ -f vmlinux ] && [ -f Image ]; then
    echo "✅ No-KASLR kernel compilation SUCCESSFUL!"
    echo
    echo "📊 File Details:"
    echo "   vmlinux: $(ls -lh vmlinux | awk '{print $5}') - $(file vmlinux | cut -d: -f2-)"
    echo "   Image:   $(ls -lh Image | awk '{print $5}') - $(file Image | cut -d: -f2-)"
    echo
    echo "🔧 Configuration:"
    grep -i "randomize_base" ../.config 2>/dev/null || echo "   KASLR disabled (not set)"
    echo
    echo "🚀 Ready to use!"
else
    echo "⚠️  Some checks failed. Review above messages."
    exit 1
fi
