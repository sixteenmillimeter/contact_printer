
#include <Adafruit_NeoPixel.h>

#define PIN 15
#define NUM 6

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUM, PIN, NEO_GRB + NEO_KHZ800);

void setup() {
	Serial.begin(115200);
	pixels.begin();
	pixels.setBrightness(255);
	pixels.fill(0xFF0000);
	pixels.show();
}

void loop () {

}