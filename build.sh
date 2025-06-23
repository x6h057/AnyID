#!/bin/bash

echo "==[ AnyID Multi-Platform Build Script ]=="

# Set output directory
BUILD_DIR="builds"

# Check if build directory exists
if [ ! -d "$BUILD_DIR" ]; then
    echo "[*] Creating build directory: $BUILD_DIR"
    mkdir "$BUILD_DIR"
else
    echo "[*] Build directory exists: $BUILD_DIR"
fi

echo

echo "=== Windows Builds ==="
echo "[*] Building for Windows 32-bit..."
GOOS=windows GOARCH=386 go build -o $BUILD_DIR/AnyID-Windows32.exe AnyID-Windows.go && \
echo "[✓] Windows 32-bit build successful." || echo "[✗] Windows 32-bit build failed."

echo
echo "[*] Building for Windows 64-bit..."
GOOS=windows GOARCH=amd64 go build -o $BUILD_DIR/AnyID-Windows64.exe AnyID-Windows.go && \
echo "[✓] Windows 64-bit build successful." || echo "[✗] Windows 64-bit build failed."

echo

echo "=== Linux Builds ==="
echo "[*] Building for Linux 32-bit..."
GOOS=linux GOARCH=386 go build -o $BUILD_DIR/AnyID-Linux32 AnyID-Linux.go && \
echo "[✓] Linux 32-bit build successful." || echo "[✗] Linux 32-bit build failed."

echo
echo "[*] Building for Linux 64-bit..."
GOOS=linux GOARCH=amd64 go build -o $BUILD_DIR/AnyID-Linux64 AnyID-Linux.go && \
echo "[✓] Linux 64-bit build successful." || echo "[✗] Linux 64-bit build failed."

echo
echo "==[ Build Process Complete ]=="

echo
ls -lh "$BUILD_DIR"
