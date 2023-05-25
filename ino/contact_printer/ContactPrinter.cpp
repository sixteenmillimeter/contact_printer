#include "ContactPrinter.h" 

ContactPrinter::ContactPrinter () {
	SetDriveSpeed(drive_speed);
	SetSpeedTakeup(takeup_speed);
}

void ContactPrinter::Setup () {
	pinMode(drive_pin, OUTPUT);
	pinMode(takeup_picture_pin, OUTPUT);
	pinMode(takeup_stock_pin, OUTPUT);

	digitalWrite(drive_pin, LOW);
	digitalWrite(takeup_picture_pin, LOW);
	digitalWrite(takeup_stock_pin, LOW);
}

void ContactPrinter::Start () {
	RampTakeup(0, takeup_pwm, takeup_ramp_time);
	delay(100);
	analogWrite(drive_pin, drive_pwm);
}

void ContactPrinter::Stop () {
	analogWrite(drive_pin, 0);
	analogWrite(takeup_stock_pin, 0);
	analogWrite(takeup_picture_pin, 0);
} 

void ContactPrinter::SetSpeedTakeup(float speed) {
	takeup_speed = speed;
	takeup_pwm = round(speed * 255);
}

void ContactPrinter::SetSpeedDrive(float speed) {
	drive_speed = speed;
	drive_pwm = round(speed * 255);
}

void ContactPrinter::SetDirectionStock(bool clockwise) {

}

void ContactPrinter::SetDirectionPicture(bool clockwise) {

}

void ContactPrinter::RampTakeup(uint16_t start, uint16_t end, uint16_t time) {
	uint16_t steps = abs(start - end);
	uint16_t step = round(time / steps);
	uint16_t pwm = start;
	bool dir = end < start;
	for (uint16_t i = 0; i < steps; i++) {
		if (pwm <= 0 || pwm >= 256) {
			break;
		}
		analogWrite(takeup_stock_pin, pwm);
		analogWrite(takeup_picture_pin, pwm);
		delay(step);
		if (dir) {
			pwm++;
		} else {
			pwm--;
		}
	}
}

bool ContactPrinter::IsRunning () {
	return running;
}