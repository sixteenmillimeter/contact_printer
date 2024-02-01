#ifndef CONTACT_PRINTER
#define CONTACT_PRINTER

#include <Arduino.h>
#include "EncoderMotor.h"

class ContactPrinter {           

	private:

	EncoderMotor drive_motor;

	const uint16_t serial_delay = 5;
	const uint16_t baud = 57600;

	const uint8_t takeup_picture_pin_cw = 8;
	const uint8_t takeup_picture_pin_ccw = 9;
	const uint8_t takeup_stock_pin_cw = 10;
	const uint8_t takeup_stock_pin_ccw = 11;

	volatile float drive_speed = 1.0; //calculated rpm
	volatile float takeup_speed = 1.0; //estimated rpm

	volatile uint16_t drive_pwm;
	volatile uint16_t takeup_pwm;

	volatile bool takeup_picture_cw = false;
	volatile bool takeup_picture_ccw = true;

	volatile bool takeup_stock_cw = true;
	volatile bool takeup_stock_ccw = true;

	volatile uint16_t takeup_ramp_time = 500;

	volatile bool running = false;

	public:

	ContactPrinter();

	void Setup();
	void Loop();
	void Start();
	void Stop();
	void SetSpeedTakeup(float speed);
	void SetSpeedDrive(float speed);
	void SetDirectionStock(bool clockwise);
	void SetDirectionPicture(bool clockwise);

	void RampTakeup(uint16_t start, uint16_t end, uint16_t time);

	bool IsRunning ();
};

#endif
