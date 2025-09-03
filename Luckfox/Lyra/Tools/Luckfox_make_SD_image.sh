#!/bin/bash

# SD Card Image Creator for RK3506 with Auto-Expanding RootFS
# 
# This script creates a GPT-partitioned SD card image with:
# - Partition 1: U-Boot (4MB at sector 8192)  
# - Partition 2: Kernel (12MB at sector 16384)
# - Partition 3: RootFS (original size + 4GB, auto-expanded)
#
# The rootfs filesystem is automatically expanded to fill the partition,
# so users get a ready-to-use image with extra space available.
#
# Compatible with Linux and macOS
# Part of: https://github.com/platima/SBC-Images
#
# Prerequisites:
#   Linux: sudo apt install gdisk e2fsprogs
#   macOS: brew install gptfdisk e2fsprogs

## NOTE
## The below is configured for the Luckfox Lyra Zero W
## You can check the `device/rockchip/.chips/rk3506/parameter-*` file specific to your board to adjust it though

# Configuration
OUTPUT_IMG="$1"
SECTOR_SIZE=512
EXTRA_GB=4  # Extra space to add to rootfs partition

# Source files
UBOOT_IMG="u-boot/uboot.img"
KERNEL_IMG="kernel-6.1/zboot.img"
ROOTFS_IMG="ubuntu/output/images/rootfs.ext4"

# Partition configuration (sectors)
P1_START=8192    # 4MB offset
P1_SIZE=8192     # 4MB = 4*1024*1024/512 sectors
P2_START=16384   # Directly after P1
P2_SIZE=24576    # 12MB = 12*1024*1024/512 sectors  
P3_START=65536   # Start at 32MB offset

# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: sudo $0 <output_filename.img>"
    echo "Example: sudo $0 rk3506-sdcard.img"
    echo ""
    echo "Note: This script requires root privileges for filesystem expansion"
    echo ""
    echo "Prerequisites:"
    echo "  Linux: sudo apt install gdisk e2fsprogs" 
    echo "  macOS: brew install gptfdisk e2fsprogs"
    exit 1
fi

# Check for root privileges (required for losetup and filesystem operations)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script requires root privileges for filesystem expansion."
    echo "Please run with sudo:"
    echo "  sudo $0 $1"
    echo ""
    echo "Root privileges are needed for:"
    echo "  - Creating loopback devices (losetup)"
    echo "  - Running filesystem checks (e2fsck)"
    echo "  - Resizing filesystems (resize2fs)"
    exit 1
fi

# Detect OS and set appropriate commands
OS_TYPE=$(uname -s)
case "$OS_TYPE" in
    Darwin)
        echo "Detected macOS"
        STAT_SIZE_CMD="stat -f%z"
        ;;
    Linux)
        echo "Detected Linux"
        STAT_SIZE_CMD="stat -c%s"
        ;;
    *)
        echo "Warning: Unsupported OS ($OS_TYPE), assuming Linux commands"
        STAT_SIZE_CMD="stat -c%s"
        ;;
esac

# Check for required tools
for tool in sgdisk resize2fs e2fsck; do
    if ! command -v $tool &> /dev/null; then
        echo "Error: $tool not found. Please install it:"
        case "$OS_TYPE" in
            Darwin)
                echo "  brew install gptfdisk e2fsprogs"
                ;;
            Linux)
                echo "  sudo apt install gdisk e2fsprogs    # Debian/Ubuntu"
                echo "  sudo yum install gdisk e2fsprogs    # RHEL/CentOS"
                echo "  sudo pacman -S gptfdisk e2fsprogs   # Arch Linux"
                ;;
            *)
                echo "  Install gptfdisk/gdisk and e2fsprogs packages for your distribution"
                ;;
        esac
        exit 1
    fi
done

# Verify all source files exist and get sizes
echo "Checking source files..."
for file in "$UBOOT_IMG" "$KERNEL_IMG" "$ROOTFS_IMG"; do
    if [ ! -f "$file" ]; then
        echo "Error: Source file not found: $file"
        exit 1
    fi
    file_size=$($STAT_SIZE_CMD "$file" 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "Error: Cannot get size of $file"
        exit 1
    fi
    echo "  ✓ $file ($file_size bytes)"
done

# Calculate rootfs size in sectors with extra space
echo "Calculating rootfs partition size..."
ROOTFS_BYTES=$($STAT_SIZE_CMD "$ROOTFS_IMG" 2>/dev/null)
if [ $? -ne 0 ] || [ "$ROOTFS_BYTES" -eq 0 ]; then
    echo "Error: Cannot determine rootfs size or file is empty"
    exit 1
fi

# Add extra space to rootfs partition
EXTRA_SECTORS=$(( EXTRA_GB * 1024 * 1024 * 1024 / SECTOR_SIZE ))  # Extra GB in sectors
P3_SIZE=$(( (ROOTFS_BYTES + SECTOR_SIZE - 1) / SECTOR_SIZE + EXTRA_SECTORS ))  # Round up + extra space

echo "RootFS original size: $ROOTFS_BYTES bytes"
echo "Extra space added: ${EXTRA_GB}GB ($EXTRA_SECTORS sectors)"
echo "Total rootfs partition: $P3_SIZE sectors"

# Sanity check: rootfs should be at least 1MB
if [ "$ROOTFS_BYTES" -lt 1048576 ]; then
    echo "Warning: RootFS seems very small ($ROOTFS_BYTES bytes). Are you sure this is correct?"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Calculate total image size (add some padding)
TOTAL_SECTORS=$(( P3_START + P3_SIZE + 1024 ))  # 512KB padding
IMAGE_SIZE=$(( TOTAL_SECTORS * SECTOR_SIZE ))

echo "Creating SD card image: $OUTPUT_IMG"
echo "Partition 1: sectors $P1_START-$(($P1_START + $P1_SIZE - 1)) (4MB, U-Boot)"
echo "Partition 2: sectors $P2_START-$(($P2_START + $P2_SIZE - 1)) (12MB, Kernel)" 
echo "Partition 3: sectors $P3_START-$(($P3_START + $P3_SIZE - 1)) ($(( (P3_SIZE * SECTOR_SIZE) / 1024 / 1024))MB, RootFS)"
echo "Total sectors: $TOTAL_SECTORS"
echo "Total image size: $IMAGE_SIZE bytes ($(($IMAGE_SIZE / 1024 / 1024))MB)"

# Step 1: Create empty image file (use seek to avoid truncation issues)
echo "Creating empty image file..."
dd if=/dev/zero of="$OUTPUT_IMG" bs=$SECTOR_SIZE count=0 seek=$TOTAL_SECTORS status=none
echo "Created $(ls -lh "$OUTPUT_IMG" | awk '{print $5}') image file"

# Step 2: Create GPT partition table
echo "Creating GPT partition table..."
sgdisk -Z "$OUTPUT_IMG"  # Zap any existing partition table
sgdisk -o "$OUTPUT_IMG"  # Create new GPT table

# Step 3: Create partitions
echo "Creating partitions..."
# Partition 1: U-Boot
sgdisk -n 1:$P1_START:$(($P1_START + $P1_SIZE - 1)) \
       -t 1:8300 \
       -c 1:"uboot" \
       "$OUTPUT_IMG"

# Partition 2: Kernel/Boot  
sgdisk -n 2:$P2_START:$(($P2_START + $P2_SIZE - 1)) \
       -t 2:8300 \
       -c 2:"boot" \
       "$OUTPUT_IMG"

# Partition 3: RootFS
sgdisk -n 3:$P3_START:$(($P3_START + $P3_SIZE - 1)) \
       -t 3:8300 \
       -c 3:"rootfs" \
       "$OUTPUT_IMG"

# Set rootfs UUID if specified
sgdisk -u 3:614e0000-0000-4b53-8000-1d28000054a9 "$OUTPUT_IMG"

# Step 4: Write partition data
echo "Writing partition data..."

# Write U-Boot
echo "Writing U-Boot to partition 1..."
if [ ! -f "$UBOOT_IMG" ]; then
    echo "Error: U-Boot image not found during write: $UBOOT_IMG"
    exit 1
fi
dd if="$UBOOT_IMG" of="$OUTPUT_IMG" \
   bs=$SECTOR_SIZE seek=$P1_START conv=notrunc status=progress

# Write Kernel
echo "Writing kernel to partition 2..."  
if [ ! -f "$KERNEL_IMG" ]; then
    echo "Error: Kernel image not found during write: $KERNEL_IMG"
    exit 1
fi
dd if="$KERNEL_IMG" of="$OUTPUT_IMG" \
   bs=$SECTOR_SIZE seek=$P2_START conv=notrunc status=progress

# Write RootFS
echo "Writing rootfs to partition 3..."
if [ ! -f "$ROOTFS_IMG" ]; then
    echo "Error: RootFS image not found during write: $ROOTFS_IMG"
    exit 1
fi
dd if="$ROOTFS_IMG" of="$OUTPUT_IMG" \
   bs=$SECTOR_SIZE seek=$P3_START conv=notrunc status=progress

# Step 5: Expand the rootfs filesystem to fill the partition
echo "Expanding rootfs filesystem to fill partition..."
PARTITION_OFFSET=$(( P3_START * SECTOR_SIZE ))

# Use loopback device to access the partition
echo "Setting up loopback device for rootfs partition..."
LOOP_DEVICE=$(losetup --show -f -o $PARTITION_OFFSET "$OUTPUT_IMG")
if [ $? -ne 0 ] || [ -z "$LOOP_DEVICE" ]; then
    echo "Error: Failed to create loopback device"
    exit 1
fi

echo "Loopback device created: $LOOP_DEVICE"

# Check filesystem before resize
echo "Checking filesystem before resize..."
e2fsck -f "$LOOP_DEVICE" || {
    echo "Error: Filesystem check failed"
    losetup -d "$LOOP_DEVICE"
    exit 1
}

# Resize filesystem to fill the partition
echo "Resizing filesystem to fill ${EXTRA_GB}GB larger partition..."
resize2fs "$LOOP_DEVICE" || {
    echo "Error: Filesystem resize failed"
    losetup -d "$LOOP_DEVICE"
    exit 1
}

# Verify the resize worked
echo "Verifying filesystem after resize..."
e2fsck -f "$LOOP_DEVICE" || {
    echo "Warning: Filesystem check after resize reported issues"
}

# Clean up loopback device
echo "Cleaning up loopback device..."
losetup -d "$LOOP_DEVICE"

# Step 6: Verify partition table and image
echo "Verifying partition table..."
sgdisk -p "$OUTPUT_IMG"

echo "Verifying image size..."
ACTUAL_SIZE=$($STAT_SIZE_CMD "$OUTPUT_IMG")
echo "Expected: $IMAGE_SIZE bytes, Actual: $ACTUAL_SIZE bytes"
if [ "$ACTUAL_SIZE" -ne "$IMAGE_SIZE" ]; then
    echo "Warning: Image size mismatch!"
fi

# Step 7: Generate SHA256 checksum
echo "Generating SHA256 checksum..."
SHA256_FILE="${OUTPUT_IMG}.sha256"
sha256sum "$OUTPUT_IMG" > "$SHA256_FILE"
echo "SHA256 checksum saved to: $SHA256_FILE"

echo ""
echo "=========================================="
echo "SD card image created successfully: $OUTPUT_IMG"
echo "Image size: $(ls -lh "$OUTPUT_IMG" | awk '{print $5}')"
echo "RootFS has been expanded with ${EXTRA_GB}GB of additional space"
echo "SHA256: $(cat "$SHA256_FILE")"
echo ""
echo "You can write it to an SD card using:"
echo "  sudo dd if=$OUTPUT_IMG of=/dev/sdX bs=4M status=progress sync"
echo "  (Replace /dev/sdX with your actual SD card device)"
echo ""
echo "Users will have the extra space available immediately after boot!"
echo "=========================================="