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

	attachInterrupt(digitalPinToInterrupt(encoder_b_pin), ReadEncoder, RISING);
}

void DriveMotor::Start() {
	pulses = 0;
	fps = 0.0;
	fps_max = -1.0;
	fps_min = 100000.0;
	fps_avg = -1.0;
	rpm = 0.0;
	rpm_max = -1.0;
	rpm_min = 100000.0;
	rpm_avg = -1.0;
	start_frame = frames;
	start_rotation = rotations;
	start_time = millis();
	ledcWrite(pwm_channel, pwm_duty_cycle);
	digitalWrite(forward_pin, HIGH);
	digitalWrite(backward_pin, LOW);
}

void DriveMotor::Stop() {;
	digitalWrite(forward_pin, LOW);
	digitalWrite(backward_pin, LOW);
	ledcWrite(pwm_channel, 0);
	Report();
}

void DriveMotor::SetLoad(uint8_t loadInt) {
	load = loadInt;
}

void DriveMotor::SetSpeed(float speed) {
	pwm_duty_cycle = floor(pwm_maximum * speed);
	Serial.print("Set drive motor PWM = ");
	Serial.print(pwm_duty_cycle);
	Serial.print(" / ");
	Serial.println(pwm_maximum);
}

void DriveMotor::SetPWM(uint32_t pwm) {
	pwm_duty_cycle = pwm;
	Serial.print("Set drive motor PWM = ");
	Serial.print(pwm_duty_cycle);
	Serial.print(" / ");
	Serial.println(pwm_maximum);
}

void DriveMotor::SetFPS(float fps) {
	target_fps = fps;
	Serial.print("FPS = ");
	Serial.println(fps);
	SetPWM(EstimatePWMFromFPS(fps));
}

int32_t DriveMotor::pulses = 0;

void DriveMotor::ReadEncoder () {
	int b = digitalRead(encoder_b_pin);
	if (b > 0) {
		pulses++;
	} else {
		pulses--;
	}
}

void DriveMotor::Loop () {
	timer = millis();
	//monitor speed
	frames = (int32_t) floor((float) pulses / pulses_per_frame);
	if (frames != last_frame) {
		last_frame = frames;
		fps = CalculateFPS(timer - start_time, frames - start_frame);
		if (fps < fps_min) { fps_min = fps; }
		if (fps > fps_max) { fps_max = fps; }
		if (fps_avg < 0.0) {
			fps_avg = fps;
		} else {
			fps_avg = (fps_avg + fps) / 2.0;
		}
		Serial.print("Frame: ");
		Serial.println(frames);
	}
	rotations = (int32_t) floor((float) pulses / (float) pulses_per_rotation);
  	if (rotations != last_rotation) {
    	last_rotation = rotations;
    	//correction
    	frames = rotations * frames_per_rotation;
    	rpm = CalculateRPM(timer - start_time, rotations - start_rotation);
    	if (rpm < rpm_min) { rpm_min = rpm; }
    	if (rpm > rpm_max) { rpm_max = rpm; }
    	if (rpm_avg < 0.0) {
			rpm_avg = rpm;
		} else {
			rpm_avg = (rpm_avg + rpm) / 2.0;
		}
		Serial.print("Rotation: ");
		Serial.println(rotations);
	}
}


void DriveMotor::Report () {
	fps = CalculateFPS(timer - start_time, frames - start_frame);
	rpm = CalculateRPM(timer - start_time, rotations - start_rotation);
	Serial.print("RPM      ");
	Serial.println(rpm);
	Serial.print("RPM avg: ");
	Serial.println(rpm_avg);
	Serial.print("RPM min: ");
	Serial.println(rpm_min);
	Serial.print("RPM max: ");
	Serial.println(rpm_max);

	Serial.print("FPS      ");
	Serial.println(fps);
	Serial.print("FPS avg: ");
	Serial.println(fps_avg);
	Serial.print("FPS min: ");
	Serial.println(fps_min);
	Serial.print("FPS max: ");
	Serial.println(fps_max);
}

/* Helper methods */

float DriveMotor::CalculateFPS (long time_length, uint32_t frames) {
	return 1000.0 / ((float) time_length / (float) frames);
}

float DriveMotor::CalculateRPM (long time_length, uint32_t rotations) {
	return 60000.0 / ((float) time_length / (float) rotations);
}

int32_t DriveMotor::GetFrames () {
	return frames;
}

int32_t DriveMotor::GetRotations () {
	return rotations;
}

float DriveMotor::FloatMap (float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

uint16_t DriveMotor::EstimatePWMFromFPS (float fps) {
	float min, max;
	float max_pwm = pwm_range[0];
	float min_pwm = pwm_range[1];
	switch (load) {
		case 0 :
			max = load_none[0];
			min = load_none[1];
			break;
		case 1 :
			max = load_one[0];
			min = load_one[1];
			break;
		case 2 :
			max = load_two[0];
			min = load_two[1];
			break;
	}
	return (uint16_t) floor(FloatMap(fps, min, max, (float) min_pwm, (float) max_pwm));
}
