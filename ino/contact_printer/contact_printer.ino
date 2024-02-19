#include "ContactPrinter.h";

 #define VERSION "0.2.0"

/**
 * 
 * 
 * Target Board: ESP32 Dev Kit
 * 
 * Pins
 * 
 * 23 Takeup Picture Enable - set duty rate
 * 22 Takeup Picture Clockwise
 * 21 Takeup Picture Counter Clockwise
 * 
 * 19 Takeup Stock Enable - set duty rate
 * 18 Takeup Stock Clockwise
 *  5 Takeup Stock Counter Clockwise
 * 
 * 13 Drive Enable
 * 12 Drive Forward (Clockwise)
 * 14 Drive Backward (Counter Clockwise)
 * 27 Drive Encoder A
 * 26 Drive Encoder B
 * 
 * 15 Start Button
 * 
 * 33 Lamp
 * 
 **/

ContactPrinter contact_printer;

void setup () {
	Serial.begin(115200);
	contact_printer.Setup();
	Serial.print("contact_printer v");
	Serial.println(VERSION);
}
void loop () {
	contact_printer.Loop();
}