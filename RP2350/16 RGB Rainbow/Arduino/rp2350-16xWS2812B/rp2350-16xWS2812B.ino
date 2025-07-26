#include <FastLED.h>

#define LED_PIN     28      // GP28 (pin 34)
#define NUM_LEDS    16
#define LED_TYPE    WS2812B
#define COLOR_ORDER GRB

CRGB leds[NUM_LEDS];

uint8_t hue = 0;
uint32_t lastUpdate = 0;
uint16_t baseDelay = 100;  // Starting delay in ms
uint16_t currentDelay = baseDelay;
uint32_t startTime = 0;

void setup() {
  Serial.begin(115200);
  
  // Initialize FastLED
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  FastLED.setBrightness(64);  // 50% brightness
  
  startTime = millis();
  lastUpdate = startTime;
  
  Serial.println("Pico 2 Rainbow Demo - Arduino/FastLED");
  Serial.println("Rainbow will accelerate over time...");
}

void loop() {
  uint32_t currentTime = millis();
  
  if (currentTime - lastUpdate >= currentDelay) {
    // Update rainbow
    for (int i = 0; i < NUM_LEDS; i++) {
      // Calculate hue for each LED with 360/16 = 22.5 degree spacing
      uint8_t ledHue = hue + (i * 255 / NUM_LEDS);
      leds[i] = CHSV(ledHue, 255, 255);
    }
    
    FastLED.show();
    hue += 2;  // Increment hue for rotation
    
    // Calculate acceleration - reduce delay over time
    uint32_t elapsed = currentTime - startTime;
    float acceleration = 1.0 - (elapsed / 30000.0);  // Over 30 seconds
    if (acceleration < 0.1) acceleration = 0.1;  // Minimum 10% of original speed
    
    currentDelay = (uint16_t)(baseDelay * acceleration);
    lastUpdate = currentTime;
    
    // Debug output every 2 seconds
    static uint32_t lastDebug = 0;
    if (currentTime - lastDebug > 2000) {
      Serial.print("Speed: ");
      Serial.print(currentDelay);
      Serial.println("ms delay");
      lastDebug = currentTime;
    }
  }
}