#include "ContactPrinter.h";

/**
 * 
 * 
 * Target Board: ESP32 Dev Kit
 * 
 * Pins
 * 
 *  7 Takeup Picture Enable
 *  8 Takeup Picture Clockwise
 *  9 Takeup Picture Counter Clockwise
 * 
 * 12 Takeup Stock Enable - set duty speed
 * 10 Takeup Stock Clockwise
 * 11 Takeup Stock Counter Clockwise
 * 
 * 13 Drive Enable
 * 12 Drive Forward (Clockwise)
 * 14 Drive Backward (Counter Clockwise)
 * 27 Drive Encoder A
 * 26 Drive Encoder B
 * 
 **/

ContactPrinter contact_printer;

void setup () {
	contact_printer.Setup();
}
void loop () {
	contact_printer.Loop();
}