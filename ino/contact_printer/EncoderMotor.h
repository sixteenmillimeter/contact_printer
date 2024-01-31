#ifndef ENCODER_MOTOR
#define ENCODER_MOTOR

#include <Arduino.h>

class EncoderMotor {           

	private:
		uint8_t enable_pin;
		uint8_t forward_pin;
		uint8_t backward_pin;
		uint8_t pwm_duty_speed = 255;
		uint32_t pwm_frequency = 30000;

	public:

	EncoderMotor();

};

#endif