#include "DriveMotor.h"

DriveMotor::DriveMotor () {

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

	//attachInterrupt(digitalPinToInterrupt(encoder_b_pin), ReadEncoder, RISING);
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


int64_t DriveMotor::posi = 0;
/*
void DriveMotor::ReadEncoder () {
	int b = digitalRead(DriveMotor::encoder_b_pin);
	if (b > 0) {
		posi++;
	} else {
		posi--;
	}
}*/

void DriveMotor::Loop () {
	int64_t pos;
	//monitor speed
	/*ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
    	pos = posi;
  	}*/
}

float DriveMotor::CalculateFPS (long timeLength, uint32_t frames) {
  return 1000.0 / ((float) timeLength / (float) frames);
}

float DriveMotor::CalculateRPM (long rotationLength) {
  return 60000.0 / (float) (rotationLength);
}
