// main.c
#include <stdio.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "hardware/clocks.h"
#include "ws2812.pio.h"

#define LED_PIN 28
#define NUM_LEDS 16
#define BASE_DELAY_MS 100
#define BRIGHTNESS 64  // 0-255, where 255 is full brightness, 128 is 50%

// Check if we're compiling for RISC-V
#ifdef __riscv
#define REVERSE_DIRECTION 1
#else
#define REVERSE_DIRECTION 0
#endif

static inline uint32_t urgb_u32(uint8_t r, uint8_t g, uint8_t b) {
    return ((uint32_t)(r) << 8) | ((uint32_t)(g) << 16) | (uint32_t)(b);
}

void hsv_to_rgb(int h, uint8_t brightness, uint8_t *r, uint8_t *g, uint8_t *b) {
    // Simplified HSV to RGB conversion using integer math
    // h is 0-359, s and v are fixed at maximum, brightness is 0-255
    
    h = h % 360;
    int sector = h / 60;
    int offset = h % 60;
    
    uint8_t p = 0;
    uint8_t q = 255 - (255 * offset / 60);
    uint8_t t = 255 * offset / 60;
    
    uint8_t temp_r, temp_g, temp_b;
    
    switch (sector) {
        case 0: temp_r = 255; temp_g = t;   temp_b = p;   break;
        case 1: temp_r = q;   temp_g = 255; temp_b = p;   break;
        case 2: temp_r = p;   temp_g = 255; temp_b = t;   break;
        case 3: temp_r = p;   temp_g = q;   temp_b = 255; break;
        case 4: temp_r = t;   temp_g = p;   temp_b = 255; break;
        case 5: temp_r = 255; temp_g = p;   temp_b = q;   break;
        default: temp_r = 0; temp_g = 0; temp_b = 0; break;
    }
    
    // Apply brightness scaling
    *r = (temp_r * brightness) / 255;
    *g = (temp_g * brightness) / 255;
    *b = (temp_b * brightness) / 255;
}

int main() {
    stdio_init_all();
    
    // Setup PIO for WS2812
    PIO pio = pio0;
    int sm = 0;
    uint offset = pio_add_program(pio, &ws2812_program);
    
    ws2812_program_init(pio, sm, offset, LED_PIN, 800000, false);
    
    printf("Pico 2 Rainbow Demo - C/PIO\n");
    #if REVERSE_DIRECTION
    printf("RISC-V build - Rainbow direction reversed\n");
    #else
    printf("ARM build - Normal rainbow direction\n");
    #endif
    printf("Rainbow will accelerate over time...\n");
    
    int hue_offset = 0;
    uint32_t start_time = to_ms_since_boot(get_absolute_time());
    uint32_t last_update = start_time;
    uint32_t last_debug = start_time;
    
    while (true) {
        uint32_t current_time = to_ms_since_boot(get_absolute_time());
        
        // Calculate acceleration using integer math
        uint32_t elapsed_ms = current_time - start_time;
        uint32_t current_delay = BASE_DELAY_MS;
        
        // Reduce delay over 30 seconds (30000ms)
        if (elapsed_ms < 30000) {
            // Scale from BASE_DELAY_MS down to BASE_DELAY_MS/10
            current_delay = BASE_DELAY_MS - (BASE_DELAY_MS * 9 * elapsed_ms) / (10 * 30000);
            if (current_delay < BASE_DELAY_MS / 10) {
                current_delay = BASE_DELAY_MS / 10;
            }
        } else {
            current_delay = BASE_DELAY_MS / 10;  // Maximum speed
        }
        
        if (current_time - last_update >= current_delay) {
            // Update rainbow
            for (int i = 0; i < NUM_LEDS; i++) {
                int led_index = i;
                
                #if REVERSE_DIRECTION
                // Reverse direction for RISC-V
                led_index = NUM_LEDS - 1 - i;
                #endif
                
                // Calculate hue for each LED (0-359 degrees)
                int hue = (hue_offset + (led_index * 360 / NUM_LEDS)) % 360;
                uint8_t r, g, b;
                hsv_to_rgb(hue, BRIGHTNESS, &r, &g, &b);
                
                // Send to PIO
                pio_sm_put_blocking(pio, sm, urgb_u32(r, g, b) << 8u);
            }
            
            hue_offset = (hue_offset + 8) % 360;  // Rotate rainbow
            last_update = current_time;
        }
        
        // Debug output every 2 seconds
        if (current_time - last_debug > 2000) {
            printf("Speed: %lums delay\n", current_delay);
            last_debug = current_time;
        }
        
        sleep_ms(10);  // Small delay
    }
    
    return 0;
}
