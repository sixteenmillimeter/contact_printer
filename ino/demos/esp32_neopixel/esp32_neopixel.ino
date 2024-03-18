
#include <Adafruit_NeoPixel.h>

#define PIN 15
#define NUM 1

int r = 255;
int g = 255;
int b = 255;

//neopixel jewel 7 = NEO_GRBW + NEO_KHZ800
//neopixel strips = NEO_GRB + NEO_KHZ800
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUM, PIN, NEO_GRBW + NEO_KHZ800);

void setup() {
	Serial.begin(115200);
	pixels.begin();
	pixels.setBrightness(55);
	for ( int i = 0; i < NUM; i++ ) {
       pixels.setPixelColor(i, 0, 0, 0);
    }
	pixels.show();
}

void loop () {
   for ( int i = 0; i < NUM; i++ ) {
       pixels.setPixelColor(i, r, g, b);
   }
   pixels.show();
   delay(300);
}