#ifndef LAMP
#define LAMP

#include <Arduino.h>

class Lamp {
	private:
	const uint8_t lamp_pin_a = 32;
	volatile boolean on = false;

	public:
	Lamp();
	void Setup();
	void Loop();
	void On();
	void Off();
	boolean IsOn();

};

#endif