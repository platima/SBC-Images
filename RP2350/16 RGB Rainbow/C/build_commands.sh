#!/bin/bash

# Raspberry Pi Pico 2 Rainbow Demo - Build Script
# This script builds the project for both ARM and RISC-V architectures

# Prerequisites:
# 1. Install Pico SDK:
#    cd ~
#    git clone https://github.com/raspberrypi/pico-sdk.git --branch master
#    cd pico-sdk
#    git submodule update --init
#    export PICO_SDK_PATH=~/pico-sdk
#
# 2. Install build tools:
#    sudo apt update
#    sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential

echo "Building Raspberry Pi Pico 2 Rainbow Demo"
echo "=========================================="

# Set Pico SDK path (adjust as needed)
export PICO_SDK_PATH=~/pico-sdk
export PICO_TOOLCHAIN_PATH=~/pico-sdk-tools/build/riscv-install/bin/

# Create project directory structure
PROJECT_NAME="rainbow_demo"
mkdir -p ${PROJECT_NAME}
cd ${PROJECT_NAME}

# Files should be placed here:
# - main.c (from C Rainbow artifact)
# - ws2812.pio (from PIO artifact) 
# - CMakeLists.txt (from CMake artifact)

echo "Building for ARM Cortex-M33..."
echo "=============================="

# Build ARM version
mkdir -p build_arm
cd build_arm

# Configure for ARM
cmake .. -DPICO_PLATFORM=rp2350-arm-s

# Build
make -j$(nproc)

echo "ARM build complete: rainbow_demo.uf2"
ls -la rainbow_demo.uf2

cd ..

echo ""
echo "Building for RISC-V..."
echo "======================"

# Build RISC-V version  
mkdir -p build_riscv
cd build_riscv

# Configure for RISC-V
cmake .. -DPICO_PLATFORM=rp2350-riscv

# Build
make -j$(nproc)

echo "RISC-V build complete: rainbow_demo.uf2"
ls -la rainbow_demo.uf2

cd ..

echo ""
echo "Build Summary:"
echo "=============="
echo "ARM build:    build_arm/rainbow_demo.uf2"
echo "RISC-V build: build_riscv/rainbow_demo.uf2"
echo ""
echo "To flash:"
echo "1. Hold BOOTSEL button while plugging in Pico 2"
echo "2. Copy the appropriate .uf2 file to the $MOUNTNAME drive"
echo "3. The Pico will reboot and run your rainbow demo"
echo ""
echo "ARM version: Normal rainbow direction"
echo "RISC-V version: Reversed rainbow direction"

# Optional: Create a simple deployment script
cat > deploy.sh << 'EOF'
#!/bin/bash
echo "Raspberry Pi Pico 2 Deployment"
echo "Choose version to deploy:"
echo "1) ARM version (normal direction)"
echo "2) RISC-V version (reversed direction)"
read -p "Enter choice (1 or 2): " choice

MOUNTNAME=RP2350

case $choice in
    1)
        if [ -f "build_arm/rainbow_demo.uf2" ]; then
            echo "Waiting for Pico 2 in BOOTSEL mode..."
            while [ ! -d "/media/$USER/$MOUNTNAME" ]; do
                sleep 1
            done
            cp build_arm/rainbow_demo.uf2 /media/$USER/$MOUNTNAME/
            echo "ARM version deployed!"
        else
            echo "ARM build not found. Run build first."
        fi
        ;;
    2)
        if [ -f "build_riscv/rainbow_demo.uf2" ]; then
            echo "Waiting for Pico 2 in BOOTSEL mode..."
            while [ ! -d "/media/$USER/$MOUNTNAME" ]; do
                sleep 1
            done
            cp build_riscv/rainbow_demo.uf2 /media/$USER/$MOUNTNAME/
            echo "RISC-V version deployed!"
        else
            echo "RISC-V build not found. Run build first."
        fi
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
EOF

chmod +x deploy.sh
echo "Created deploy.sh for easy flashing"
