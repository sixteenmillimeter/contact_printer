#include "ContactPrinter.h";

 #define VERSION "0"

/**
 * 
 * 
 * Target Board: ESP32 Dev Kit
 * 
 * Pins
 * 
 * 21 Takeup Picture Enable - set duty rate
 * 22 Takeup Direction A - Stock Clockwise, Picture Counter Clockwise
 * 23 Takeup Direction B  - Stoc k Counter Clockwise, Picture Clockwise
 * 
 * 26 Drive Enable
 * 27 Drive Forward (Clockwise)
 * 14 Drive Backward (Counter Clockwise)
 * 33 Drive Encoder A
 * 25 Drive Encoder B
 * 
 * 15 Start Button
 * 
 * 32 Lamp
 * 
 **/

ContactPrinter contact_printer;

void setup () {
	Serial.begin(115200);
	Serial.print("contact_printer v");
	Serial.println(VERSION);
	contact_printer.Setup();
}
void loop () {
	contact_printer.Loop();
}
