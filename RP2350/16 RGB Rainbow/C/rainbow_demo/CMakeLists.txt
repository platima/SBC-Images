cmake_minimum_required(VERSION 3.13)

# Set board type for Pico 2
set(PICO_BOARD pico2)

# Include the Pico SDK
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(rainbow_demo C CXX ASM)

# Set C standard
set(CMAKE_C_STANDARD 11)

# Initialize the Pico SDK
pico_sdk_init()

# Add executable
add_executable(rainbow_demo
    main.c
)

# Generate PIO header
pico_generate_pio_header(rainbow_demo ${CMAKE_CURRENT_LIST_DIR}/ws2812.pio)

# Link libraries
target_link_libraries(rainbow_demo
    pico_stdlib
    hardware_pio
    hardware_clocks
)

# Enable USB output, disable UART output
pico_enable_stdio_usb(rainbow_demo 1)
pico_enable_stdio_uart(rainbow_demo 0)

# Create map/bin/hex/uf2 files
pico_add_extra_outputs(rainbow_demo)
