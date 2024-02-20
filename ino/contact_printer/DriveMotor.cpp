#include "DriveMotor.h"

DriveMotor::DriveMotor () {

};

DriveMotor::DriveMotor (uint8_t e_pin, uint8_t f_pin, uint8_t b_pin, uint8_t ea_pin, uint8_t eb_pin) {
	enable_pin = e_pin;
	forward_pin = f_pin;
	backward_pin = b_pin;
	encoder_a_pin = ea_pin;
	encoder_b_pin = eb_pin;
};

void DriveMotor::Setup () {
	pinMode(enable_pin, OUTPUT);
	pinMode(forward_pin, OUTPUT);
	pinMode(backward_pin, OUTPUT);

	pinMode(encoder_a_pin, INPUT);
  	pinMode(encoder_b_pin, INPUT);

	ledcSetup(pwm_channel, pwm_frequency, pwm_resolution);
	Serial.print("Attaching pin ");
	Serial.print(enable_pin);
	Serial.print(" to ledc channel ");
	Serial.print(pwm_channel);
	Serial.println(" for drive");
	ledcAttachPin(enable_pin, pwm_channel);
	ledcWrite(pwm_channel, pwm_duty_cycle);

	digitalWrite(forward_pin, LOW);
	digitalWrite(backward_pin, LOW);
}

void DriveMotor::Start() {
	ledcWrite(pwm_channel, pwm_duty_cycle);
	digitalWrite(forward_pin, HIGH);
	digitalWrite(backward_pin, LOW);
}

void DriveMotor::Stop() {;
	digitalWrite(forward_pin, LOW);
	digitalWrite(backward_pin, LOW);
	ledcWrite(pwm_channel, 0);
}

void DriveMotor::SetSpeed(float speed) {
	pwm_duty_cycle = floor(pwm_maximum * speed);
	Serial.print("Set drive motor PWM = ");
	Serial.println(pwm_duty_cycle);
}

void DriveMotor::Loop () {
	//monitor speed
}
