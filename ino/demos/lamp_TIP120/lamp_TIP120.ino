/**  ______________
 *   |            |
 *   |            |
 *   |   TIP120   |
 *   |            |
 *   |            |
 *   --------------
 *   ||    ||    ||
 *   ||    ||    ||
 *   ||    ||    ||
 *   ||    ||    ||
 *  2.2K
 *   |
 *   |      
 *  \/
 * 8 pin
 **/


int signalPin = 8;

void setup () {
	pinMode(signalPin, OUTPUT);
}

void loop () {
	digitalWrite(signalPin, HIGH);
	delay(1000);
	digitalWrite(signalPin, LOW);
	delay(2000);
}