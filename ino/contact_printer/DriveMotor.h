#ifndef DRIVE_MOTOR
#define DRIVE_MOTOR

#include <Arduino.h>

class DriveMotor {           

	private:

	//defaults are for EPS32 dev board
	const uint8_t enable_pin = 26;
	const uint8_t forward_pin = 27; //Clockwise
	const uint8_t backward_pin = 14; //Counter-clockwise
	const uint8_t encoder_a_pin = 33;
	const uint8_t encoder_b_pin = 25;

	const uint32_t pwm_frequency = 5000;
	const uint8_t pwm_channel = 0;
	const uint8_t pwm_resolution = 8;
	const uint16_t pwm_maximum = 255; //8 = 255, 16 = 65535

	const uint8_t ppr = 11;
	const float ratio = 187.0 / 3.0;
	const uint32_t maxPulses = (int) round((float) ppr * ratio);
	const uint8_t framesPerRotation = 18;

	volatile uint8_t pwm_duty_cycle = 0;

	static int64_t posi;

	//measured
	volatile float rpm = 0.0;
	volatile float fps = 0.0;

	//target
	volatile float target_fps = 0.0;
	volatile float target_rpm = 0.0;

	public:

	DriveMotor();
	void Setup();
	void Loop();
	void Start();
	void Stop();
	void SetSpeed(float speed);

	float CalculateFPS (long timeLength, uint32_t frames);
	float CalculateRPM (long rotationLength);

	protected: 

	static void ReadEncoder();

};

#endif