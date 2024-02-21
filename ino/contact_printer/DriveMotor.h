#ifndef DRIVE_MOTOR
#define DRIVE_MOTOR

#include <Arduino.h>

class DriveMotor {           

	private:

	//defaults are for EPS32 dev board
	static const uint8_t enable_pin = 26;
	static const uint8_t forward_pin = 27; //Clockwise
	static const uint8_t backward_pin = 14; //Counter-clockwise
	static const uint8_t encoder_a_pin = 33;
	static const uint8_t encoder_b_pin = 25;

	const uint32_t pwm_frequency = 5000;
	const uint8_t pwm_channel = 0;
	const uint8_t pwm_resolution = 10;
	const uint16_t pwm_maximum = 1024; //8 = 255, 10 = 1024, 16 = 65535

	const uint8_t ppr = 11;
	const float ratio = 187.0 / 3.0;
	const uint32_t pulses_per_rotation = (int) round((float) ppr * ratio);
	const uint8_t frames_per_rotation = 18;
	const float pulses_per_frame = (float) pulses_per_rotation / (float) frames_per_rotation;

	volatile uint32_t pwm_duty_cycle = 0;

	static int32_t pulses;

	//state
	volatile long timer = 0;
	volatile long start_time = 0;
	volatile int32_t start_rotation = 0;
	volatile int32_t start_frame = 0;

	//measure
	volatile float rpm = 0.0;
	volatile float rpm_max = -1.0;
	volatile float rpm_min = 100000.0;
	volatile float rpm_avg = -1.0;
	volatile int32_t rotations = 0;
	volatile int32_t last_rotation = 0;

	volatile float fps = 0.0;
	volatile float fps_max = -1.0;
	volatile float fps_min = 100000.0;
	volatile float fps_avg = -1.0;
	volatile int32_t frames = 0;
	volatile int32_t last_frame = 0;

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

	float CalculateFPS (long time_length, uint32_t frames);
	float CalculateRPM (long time_length, uint32_t rotations);

	protected: 

	static void ReadEncoder();

};

#endif