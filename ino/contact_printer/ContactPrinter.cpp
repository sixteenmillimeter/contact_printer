#include "ContactPrinter.h" 

ContactPrinter::ContactPrinter () {

}

void ContactPrinter::Setup () {

	pinMode(takeup_pin_dir_a, OUTPUT);
	pinMode(takeup_pin_dir_b, OUTPUT);

	pinMode(start_button_pin, INPUT_PULLUP);

	drive_motor.Setup();
	lamp.Setup();

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

	SetupTakeup();
	SetupDrive();
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
	lamp.Off();
	drive_motor.Stop();
	StopTakeup();
	run_time = timer;
	running = false;
} 

void ContactPrinter::SetDirectionTakeup(bool dir) {
	takeup_dir = dir;
}

void ContactPrinter::SetSpeedTakeup(float speed) {
	takeup_speed = speed;
	takeup_pwm_duty_cycle = floor(speed * pwm_maximum);
	Serial.print("Set takeup motors PWM = ");
	Serial.print(takeup_pwm_duty_cycle);
	Serial.print(" / ");
	Serial.println(pwm_maximum);
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

void ContactPrinter::SetupTakeup () {
	SetDirectionTakeup(true);
	SetSpeedTakeup(0.9);
}

void ContactPrinter::SetupDrive() {
	//drive_motor.SetSpeed(speed);
	//drive_motor.SetPWM(247);
	drive_motor.SetLoad(load);
	drive_motor.SetFPS(18.0);

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
	int32_t frame;
	timer = millis();
	if (initialized) {
		ButtonLoop();
		if (running) {
			drive_motor.Loop();
			frame = drive_motor.GetFrames();
			if (!lamp.IsOn() && frame >= start_after) {
				lamp.On();
			}
			/*if (frame >= 1000) {
				Stop();
			}*/
		}
	} else if (timer >= start_time + 100) {
		initialized = true;
	}
}
