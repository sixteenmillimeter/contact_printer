#ifndef CONTACT_PRINTER
#define CONTACT_PRINTER

#include <Arduino.h>
#include "DriveMotor.h"
#include "Lamp.h"

class ContactPrinter {           

	private:

	//use default drive motor pins
	DriveMotor drive_motor;
	Lamp lamp;

	const uint16_t serial_delay = 5;
	const uint16_t baud = 115200;

	const uint8_t takeup_picture_pin_enable = 23;
	const uint8_t takeup_picture_pin_cw = 22;
	const uint8_t takeup_picture_pin_ccw = 21;

	const uint8_t takeup_stock_pin_enable = 19;
	const uint8_t takeup_stock_pin_cw = 18;
	const uint8_t takeup_stock_pin_ccw = 5;

	const uint8_t start_button_pin = 34;

	const uint32_t pwm_frequency = 30000;
	const uint8_t takeup_picture_pwm_channel = 1;
	const uint8_t takeup_stock_pwm_channel = 2;
	const uint8_t pwm_resolution = 8;

	volatile long timer = 0;

	volatile float drive_speed = 1.0;  //calculated rpm
	volatile float takeup_speed = 1.0; //estimated rpm

	volatile uint16_t takeup_pwm_duty_cycle = 0;
	volatile uint16_t takeup_ramp_steps = 0;  //# of steps
	volatile uint16_t takeup_ramp_step = 0;   //length of step (ms)
	volatile boolean takeup_ramp_dir = true;  //true = up, false = down

	volatile uint16_t takeup_ramp_time = 500; //default ramp time (ms)
	volatile long takeup_ramp_start = 0;      //time to start ramping
	volatile long takeup_ramp_current_step = 0;
	volatile long takeup_ramp_next_step_start = 0;

	volatile boolean takeup_ramping = false;

	volatile bool takeup_picture_cw = false;
	volatile bool takeup_picture_ccw = true;

	volatile bool takeup_stock_cw = true;
	volatile bool takeup_stock_ccw = true;

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
	void RampTakeupLoop();

	void ButtonLoop();

	bool IsRunning ();
};

#endif
