import machine
import neopixel
import time
import math

# Configuration
LED_PIN = 28        # GP28 (pin 34)
NUM_LEDS = 16
BASE_DELAY = 0.1    # Starting delay in seconds

# Initialize NeoPixel strip
pin = machine.Pin(LED_PIN)
np = neopixel.NeoPixel(pin, NUM_LEDS)

def hsv_to_rgb(h, s, v):
    """Convert HSV to RGB values (0-255 range)"""
    h = h / 360.0
    s = s / 100.0
    v = v / 100.0
    
    i = int(h * 6.0)
    f = (h * 6.0) - i
    p = v * (1.0 - s)
    q = v * (1.0 - s * f)
    t = v * (1.0 - s * (1.0 - f))
    
    i = i % 6
    
    if i == 0:
        r, g, b = v, t, p
    elif i == 1:
        r, g, b = q, v, p
    elif i == 2:
        r, g, b = p, v, t
    elif i == 3:
        r, g, b = p, q, v
    elif i == 4:
        r, g, b = t, p, v
    elif i == 5:
        r, g, b = v, p, q
    
    return int(r * 64), int(g * 64), int(b * 64)

def main():
    print("Pico 2 Rainbow Demo - MicroPython")
    print("Rainbow will accelerate over time...")
    
    hue_offset = 0
    start_time = time.ticks_ms()
    last_update = start_time
    last_debug = start_time
    
    while True:
        current_time = time.ticks_ms()
        
        # Calculate current delay based on elapsed time
        elapsed = time.ticks_diff(current_time, start_time) / 1000.0  # Convert to seconds
        acceleration = 1.0 - (elapsed / 30.0)  # Over 30 seconds
        if acceleration < 0.1:
            acceleration = 0.1  # Minimum 10% of original speed
        
        current_delay = BASE_DELAY * acceleration
        
        if time.ticks_diff(current_time, last_update) >= int(current_delay * 1000):
            # Update rainbow
            for i in range(NUM_LEDS):
                # Calculate hue for each LED with even spacing around color wheel
                hue = (hue_offset + (i * 360 // NUM_LEDS)) % 360
                r, g, b = hsv_to_rgb(hue, 100, 100)  # Full saturation and brightness
                np[i] = (r, g, b)
            
            np.write()
            hue_offset = (hue_offset + 8) % 360  # Rotate rainbow
            last_update = current_time
        
        # Debug output every 2 seconds
        if time.ticks_diff(current_time, last_debug) > 2000:
            print(f"Speed: {current_delay:.3f}s delay")
            last_debug = current_time
        
        time.sleep_ms(10)  # Small delay to prevent excessive CPU usage

if __name__ == "__main__":
    main()