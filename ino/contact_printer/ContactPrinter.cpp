#include "ContactPrinter.h" 

ContactPrinter::ContactPrinter () {
	SetSpeedDrive(drive_speed);
	SetSpeedTakeup(takeup_speed);
}

void ContactPrinter::Setup () {
	pinMode(takeup_picture_pin_cw, OUTPUT);
	pinMode(takeup_picture_pin_ccw, OUTPUT);
	pinMode(takeup_stock_pin_cw, OUTPUT);
	pinMode(takeup_stock_pin_ccw, OUTPUT);

	drive_motor.Setup();

	ledcSetup(takeup_picture_pwm_channel, pwm_frequency, pwm_resolution);
	ledcSetup(takeup_stock_pwm_channel, pwm_frequency, pwm_resolution);

	ledcAttachPin(takeup_picture_pin_enable, takeup_picture_pwm_channel);
	ledcAttachPin(takeup_stock_pin_enable, takeup_stock_pwm_channel);

	ledcWrite(takeup_picture_pwm_channel, takeup_pwm_duty_cycle);
	ledcWrite(takeup_stock_pwm_channel, takeup_pwm_duty_cycle);

	digitalWrite(takeup_picture_pin_cw, LOW);
	digitalWrite(takeup_picture_pin_ccw, LOW);
	digitalWrite(takeup_stock_pin_cw, LOW);
	digitalWrite(takeup_stock_pin_ccw, LOW);
}

void ContactPrinter::Start () {
	RampTakeup(0, takeup_pwm_duty_cycle, takeup_ramp_time);
	delay(100);
	drive_motor.Start();
}

void ContactPrinter::Stop () {
	drive_motor.Start();
	delay(100);
	RampTakeup( takeup_pwm_duty_cycle, 0, takeup_ramp_time);
	digitalWrite(takeup_picture_pin_cw, LOW);
	digitalWrite(takeup_picture_pin_ccw, LOW);
	digitalWrite(takeup_stock_pin_cw, LOW);
	digitalWrite(takeup_stock_pin_ccw, LOW);
} 

void ContactPrinter::SetSpeedTakeup(float speed) {
	takeup_speed = speed;
	takeup_pwm_duty_cycle = floor(speed * 255);
}

void ContactPrinter::SetSpeedDrive(float speed) {
	//drive_motor.SetSpeed();
}

void ContactPrinter::SetDirectionStock(bool clockwise) {
	takeup_stock_cw = clockwise;
}

void ContactPrinter::SetDirectionPicture(bool clockwise) {
	takeup_picture_cw = clockwise;
}

//linear
void ContactPrinter::RampTakeup(uint16_t start, uint16_t end, uint16_t time) {
	takeup_ramp_steps = abs(start - end);
	takeup_ramp_step = round(time / takeup_ramp_steps);
	takeup_pwm_duty_cycle  = start;
	takeup_ramp_dir = end < start;

	if (takeup_picture_cw) {
		digitalWrite(takeup_picture_pin_cw, HIGH);
		digitalWrite(takeup_picture_pin_ccw, LOW);
	} else {
		digitalWrite(takeup_picture_pin_cw, LOW);
		digitalWrite(takeup_picture_pin_ccw, HIGH);
	}
	if (takeup_stock_cw) {
		digitalWrite(takeup_stock_pin_cw, HIGH);
		digitalWrite(takeup_stock_pin_ccw, LOW);
	} else {
		digitalWrite(takeup_stock_pin_cw, LOW);
		digitalWrite(takeup_stock_pin_ccw, HIGH);
	}
	takeup_ramping = true;

	for (uint16_t i = 0; i < takeup_ramp_steps; i++) {
		if (takeup_pwm_duty_cycle <= 0 || takeup_pwm_duty_cycle >= 255) {
			takeup_ramping = false;
			break;
		}
		ledcWrite(takeup_picture_pwm_channel, takeup_pwm_duty_cycle);
		ledcWrite(takeup_stock_pwm_channel, takeup_pwm_duty_cycle);
		delay(takeup_ramp_step);
		if (takeup_ramp_dir) {
			takeup_pwm_duty_cycle++;
		} else {
			takeup_pwm_duty_cycle--;
		}
	}
	takeup_ramping = false;
}

bool ContactPrinter::IsRunning () {
	return running;
}

void ContactPrinter::Loop () {
	timer = millis();
	drive_motor.Loop();
}