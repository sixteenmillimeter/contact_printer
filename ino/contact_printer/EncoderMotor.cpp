#include "EncoderMotor.h"

EncoderMotor::EncoderMotor () {

};

EncoderMotor::EncoderMotor (uint8_t e_pin, uint8_t f_pin, uint8_t b_pin, uint8_t ea_pin, uint8_t eb_pin) {
	enable_pin = e_pin;
	forward_pin = f_pin;
	backward_pin = b_pin;
	encoder_a_pin = ea_pin;
	encoder_b_pin = eb_pin;
};

void EncoderMotor::Setup () {
	pinMode(enable_pin, OUTPUT);
	pinMode(forward_pin, OUTPUT);
	pinMode(backward_pin, OUTPUT);

	ledcSetup(pwm_channel, pwm_frequency, pwm_resolution);
	ledcAttachPin(enable_pin, pwm_channel);
	ledcWrite(pwm_channel, pwm_duty_cycle);
}
