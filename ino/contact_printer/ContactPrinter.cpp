#include "ContactPrinter.h" 

ContactPrinter::ContactPrinter () {
	SetDriveSpeed(drive_speed);
	SetSpeedTakeup(takeup_speed);
}

void ContactPrinter::Setup () {
	pinMode(drive_pin, OUTPUT);
	pinMode(takeup_picture_pin_cw, OUTPUT);
	pinMode(takeup_picture_pin_ccw, OUTPUT);
	pinMode(takeup_stock_pin_cw, OUTPUT);
	pinMode(takeup_stock_pin_ccw, OUTPUT);

	digitalWrite(drive_pin, LOW);
	digitalWrite(takeup_picture_pin_cw, LOW);
	digitalWrite(takeup_picture_pin_ccw, LOW);
	digitalWrite(takeup_stock_pin_cw, LOW);
	digitalWrite(takeup_stock_pin_ccw, LOW);
}

void ContactPrinter::Start () {
	RampTakeup(0, takeup_pwm, takeup_ramp_time);
	delay(100);
	analogWrite(drive_pin, drive_pwm);
}

void ContactPrinter::Stop () {
	analogWrite(drive_pin, 0);
	delay(100);
	RampTakeup(takeup_pwm, 0, takeup_ramp_time);

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
	takeup_stock_cw = clockwise;
}

void ContactPrinter::SetDirectionPicture(bool clockwise) {
	takeup_picture_cw = clockwise;
}

//linear
void ContactPrinter::RampTakeup(uint16_t start, uint16_t end, uint16_t time) {
	uint16_t steps = abs(start - end);
	uint16_t step = round(time / steps);
	uint16_t pwm = start;
	uint8_t takeup_picture_pin;
	uint8_t takeup_stock_pin;
	bool dir = end < start;

	if (takeup_picture_cw) {
		takeup_picture_pin = takeup_picture_pin_cw;
		analogWrite(takeup_picture_pin_ccw, 0);
	} else {
		takeup_picture_pin = takeup_picture_pin_ccw;
		analogWrite(takeup_picture_pin_cw, 0);
	}
	if (takeup_stock_cw) {
		takeup_stock_pin = takeup_stock_pin_cw;
		analogWrite(takeup_stock_pin_ccw, 0);
	} else {
		takeup_stock_pin = takeup_stock_pin_cw;
		analogWrite(takeup_stock_pin_cw, 0);
	}

	for (uint16_t i = 0; i < steps; i++) {
		if (pwm <= 0 || pwm >= 256) {
			break;
		}
		analogWrite(takeup_picture_pin, pwm);
		analogWrite(takeup_stock_pin, pwm);
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