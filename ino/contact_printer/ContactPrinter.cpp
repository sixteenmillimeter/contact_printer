#include "ContactPrinter.h" 

ContactPrinter::ContactPrinter () {
	SetSpeedDrive(drive_speed);
	SetSpeedTakeup(takeup_speed);
}

void ContactPrinter::Setup () {

	pinMode(takeup_pin_dir_a, OUTPUT);
	pinMode(takeup_pin_dir_b, OUTPUT);

	pinMode(start_button_pin, INPUT_PULLUP);

	drive_motor.Setup();

	ledcSetup(takeup_pwm_channel, pwm_frequency, pwm_resolution);
	Serial.print("Attaching pin ");
	Serial.print(takeup_pin_enable);
	Serial.print(" to ledc channel ");
	Serial.print(takeup_pwm_channel);
	Serial.println(" for takeup");
	ledcAttachPin(takeup_pin_enable, takeup_pwm_channel);
	ledcWrite(takeup_pwm_channel, takeup_pwm_duty_cycle);

	digitalWrite(takeup_pin_dir_a, LOW);
	digitalWrite(takeup_pin_dir_b, LOW);

	SetDirectionTakeup(true);
	SetSpeedTakeup(0.9);
	SetSpeedDrive(0.8);
	start_time = millis();
}

void ContactPrinter::Start () {
	Serial.println("Start()");
	drive_motor.Start();
	StartTakeup();
	run_time = timer;
	running = true;
}

void ContactPrinter::Stop () {
	Serial.println("Stop()");
	drive_motor.Stop();
	StopTakeup();
	run_time = timer;
	running = false;
} 

void ContactPrinter::SetSpeedTakeup(float speed) {
	takeup_speed = speed;
	takeup_pwm_duty_cycle = floor(speed * pwm_maximum);
	Serial.print("Set takeup motors PWM = ");
	Serial.println(takeup_pwm_duty_cycle);
}

void ContactPrinter::StartTakeup () {
	ledcWrite(takeup_pwm_channel, takeup_pwm_duty_cycle);
	if (takeup_dir) {
		digitalWrite(takeup_pin_dir_a, LOW);
		digitalWrite(takeup_pin_dir_b, HIGH);
	} else {
		digitalWrite(takeup_pin_dir_a, HIGH);
		digitalWrite(takeup_pin_dir_b, LOW);
	}
}

void ContactPrinter::StopTakeup() {
	digitalWrite(takeup_pin_dir_a, LOW);
	digitalWrite(takeup_pin_dir_b, LOW);
	ledcWrite(takeup_pwm_channel, 0);
}

void ContactPrinter::SetSpeedDrive(float speed) {
	drive_motor.SetSpeed(speed);
}

void ContactPrinter::SetDirectionTakeup(bool dir) {
	takeup_dir = dir;
}

//linear
void ContactPrinter::RampTakeup(uint16_t start_pwm, uint16_t end_pwm, uint16_t time) {
	takeup_ramp_steps = abs(start_pwm - end_pwm);
	takeup_ramp_step = round(time / takeup_ramp_steps);
	takeup_pwm_duty_cycle  = start_pwm;
	takeup_ramp_dir = end_pwm < start_pwm;
	takeup_ramp_current_step = 0;
	takeup_ramping = true;

	for (uint16_t i = 0; i < takeup_ramp_steps; i++) {
		if (takeup_pwm_duty_cycle <= 0 || takeup_pwm_duty_cycle >= pwm_maximum) {
			break;
		}
		ledcWrite(takeup_pwm_channel, takeup_pwm_duty_cycle);
		delay(takeup_ramp_step);
		if (takeup_ramp_dir) {
			takeup_pwm_duty_cycle++;
		} else {
			takeup_pwm_duty_cycle--;
		}
	}
	takeup_ramping = false;
}


void ContactPrinter::ButtonLoop () {
	if (!running && timer >= run_time + button_delay && digitalRead(start_button_pin) == LOW) {
		Start();
	} else if (running && timer >= run_time + button_delay && digitalRead(start_button_pin) == LOW) {
		Stop();
	}
}

bool ContactPrinter::IsRunning () {
	return running;
}

void ContactPrinter::Loop () {
	timer = millis();
	if (initialized) {
		ButtonLoop();
		if (running) {
			drive_motor.Loop();
		}
	} else if (timer >= start_time + 100) {
		initialized = true;
	}
}

