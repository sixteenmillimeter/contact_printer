#ifndef DRIVE_MOTOR
#define DRIVE_MOTOR

#include <Arduino.h>

class DriveMotor {           

	private:

	//defaults are for EPS32 dev board
	volatile uint8_t enable_pin = 13;
	volatile uint8_t forward_pin = 12;
	volatile uint8_t backward_pin = 14;
	volatile uint8_t encoder_a_pin = 27;
	volatile uint8_t encoder_b_pin = 26;

	volatile uint8_t pwm_duty_cycle = 0;

	const uint32_t pwm_frequency = 30000;
	const uint8_t pwm_channel = 0;
	const uint8_t pwm_resolution = 8;

	const uint8_t ppr = 11;
	const float ratio = 187.0 / 3.0;
	const uint32_t maxPulses = (int) round((float) ppr * ratio);
	const uint8_t speed = 255;
	const uint8_t framesPerRotation = 18;

	public:

	DriveMotor();
	DriveMotor(uint8_t e_pin, uint8_t f_pin, uint8_t b_pin, uint8_t ea_pin, uint8_t eb_pin);
	void Setup();
	void Loop();
	void Start();
	void Stop();
	void SetSpeed();

};

#endif