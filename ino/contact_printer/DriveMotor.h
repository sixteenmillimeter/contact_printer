#ifndef DRIVE_MOTOR
#define DRIVE_MOTOR

#include <Arduino.h>

class DriveMotor {           

	private:

	//defaults are for EPS32 dev board
	volatile uint8_t enable_pin = 26;
	volatile uint8_t forward_pin = 27; //Clockwise
	volatile uint8_t backward_pin = 14; //Counter-clockwise
	volatile uint8_t encoder_a_pin = 33;
	volatile uint8_t encoder_b_pin = 25;

	volatile uint8_t pwm_duty_cycle = 0;

	const uint32_t pwm_frequency = 5000;
	const uint8_t pwm_channel = 0;
	const uint8_t pwm_resolution = 8;
	const uint16_t pwm_maximum = 255; //8 = 255, 16 = 65535

	const uint8_t ppr = 11;
	const float ratio = 187.0 / 3.0;
	const uint32_t maxPulses = (int) round((float) ppr * ratio);
	const uint8_t framesPerRotation = 18;

	volatile float target_fps = 0.0;
	volatile float target_rpm = 0.0;

	public:

	DriveMotor();
	DriveMotor(uint8_t e_pin, uint8_t f_pin, uint8_t b_pin, uint8_t ea_pin, uint8_t eb_pin);
	void Setup();
	void Loop();
	void Start();
	void Stop();
	void SetSpeed(float speed);

	static void ReadEncoder();

};

#endif