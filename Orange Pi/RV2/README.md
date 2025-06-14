# Linux Fastboot Commands for Orange Pi RV2 EMMC Flashing

Note: these don't actually seem to work - it appears as a DFU device, but I would imagine you need to 'kick' it into fastboot mode, and I do not know how.

## Prerequisites
```bash
# Install fastboot if not already available
sudo apt install fastboot  # Ubuntu/Debian
# or
sudo dnf install android-tools  # Fedora/RHEL
```

## Step 1: Initial Boot Setup
```bash
# Check device is detected
fastboot devices

# Stage FSBL (First Stage Boot Loader) - 181 KB
fastboot stage factory/FSBL.bin

# Continue boot process to initialize hardware
fastboot continue

# Flash U-Boot bootloader - 1920 KB  
fastboot flash u-boot u-boot.itb

# Continue boot to activate U-Boot
fastboot continue
```

## Step 2: Partition Table Setup
```bash
# Flash GPT partition table - 2 KB
fastboot flash gpt gpt.img
```

## Step 3: Flash Boot Components
```bash
# Flash bootinfo partition - 512 bytes
fastboot flash bootinfo factory/bootinfo_sd.bin

# Flash FSBL to permanent storage - 256K
fastboot flash fsbl factory/FSBL.bin

# Flash environment variables - 64K
fastboot flash env env.bin

# Flash OpenSBI firmware - 384K
fastboot flash opensbi fw_dynamic.itb

# Flash U-Boot to permanent storage - 2M
fastboot flash uboot u-boot.itb
```

## Step 4: Flash System Images
```bash
# Flash boot image - 256M
fastboot flash boot boot.img

# Flash ramdisk - 8M
fastboot flash ramdisk ramdisk.img

# Skip misc partition (empty in this case)
# fastboot flash misc misc.img  # Skip if no misc.img file

# Flash updater partition - 64M
fastboot flash updater updater.img

# Flash system production partition - 64M
fastboot flash sys_prod sys_prod.img

# Flash chip production partition - 64M
fastboot flash chip_prod chip_prod.img

# Flash main system partition - 2048M (will be sent in chunks)
fastboot flash system system.img

# Flash vendor partition - 512M
fastboot flash vendor vendor.img

# Flash userdata partition
fastboot flash userdata userdata.img
```

## Step 5: Reboot
```bash
# Reboot the device to complete flashing
fastboot reboot
```

## Complete Script
```bash
#!/bin/bash
set -e

echo "Starting Orange Pi RV2 EMMC flashing process..."

# Check device
echo "Checking for fastboot device..."
fastboot devices

# Initial boot setup
echo "Staging FSBL..."
fastboot stage factory/FSBL.bin
echo "Continuing boot..."
fastboot continue

echo "Flashing U-Boot..."
fastboot flash u-boot u-boot.itb
fastboot continue

# Flash partition table
echo "Flashing GPT partition table..."
fastboot flash gpt gpt.img

# Flash boot components
echo "Flashing boot components..."
fastboot flash bootinfo factory/bootinfo_sd.bin
fastboot flash fsbl factory/FSBL.bin
fastboot flash env env.bin
fastboot flash opensbi fw_dynamic.itb
fastboot flash uboot u-boot.itb

# Flash system images
echo "Flashing system images..."
fastboot flash boot boot.img
fastboot flash ramdisk ramdisk.img

# Skip misc if no file exists
if [ -f "misc.img" ]; then
    fastboot flash misc misc.img
else
    echo "Skipping misc partition (no image file)"
fi

fastboot flash updater updater.img
fastboot flash sys_prod sys_prod.img
fastboot flash chip_prod chip_prod.img

echo "Flashing system partition (this will take a while)..."
fastboot flash system system.img

echo "Flashing vendor partition..."
fastboot flash vendor vendor.img

echo "Flashing userdata partition..."
fastboot flash userdata userdata.img

echo "Rebooting device..."
fastboot reboot

echo "Flashing complete!"
```

## Key Observations from the Log

1. **Two-stage boot process**: First stages FSBL, continues boot, then flashes U-Boot
2. **Sparse image handling**: Large images like `system.img` are automatically split into chunks
3. **Error on misc partition**: The tool skipped the misc partition due to permission/file issues
4. **Total process time**: About 2 minutes for the complete flash

## File Structure Expected
Your extracted zip should contain:
```
factory/
├── FSBL.bin
└── bootinfo_sd.bin
gpt.img
env.bin
fw_dynamic.itb
u-boot.itb
boot.img
ramdisk.img
updater.img
sys_prod.img
chip_prod.img
system.img
vendor.img
userdata.img
```
