#include "Lamp.h"

Lamp::Lamp () {
	//
}

void Lamp::Setup() {
	pinMode(lamp_pin_a, OUTPUT);
	digitalWrite(lamp_pin_a, LOW);
	Serial.print("Simple white LED lamp on pin: ");
	Serial.println(lamp_pin_a);
} 

void Lamp::On () {
	digitalWrite(lamp_pin_a, HIGH);
	on = true;
}

void Lamp::Off () {
	digitalWrite(lamp_pin_a, LOW);
	on = false;
}

boolean Lamp::IsOn () {
	return on;
}