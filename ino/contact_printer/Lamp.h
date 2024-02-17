#ifndef LAMP
#define LAMP

#include <Arduino.h>

class Lamp {
	private:
	volatile boolean on = false;
	volatile uint8_t lamp_pin_a = 33;

	public:
	Lamp();
	void Setup();
	void Loop();
};

#endif