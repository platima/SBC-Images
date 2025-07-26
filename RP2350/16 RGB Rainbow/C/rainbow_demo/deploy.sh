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
