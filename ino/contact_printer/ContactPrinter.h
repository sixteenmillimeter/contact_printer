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

	/* PINS */
	const uint8_t takeup_pin_enable = 21;
	const uint8_t takeup_pin_dir_a = 22;
	const uint8_t takeup_pin_dir_b = 23;

	const uint8_t start_button_pin = 15;

	/* MOTOR PWM */
	const uint32_t pwm_frequency = 5000;
	const uint8_t takeup_pwm_channel = 1;
	const uint8_t pwm_resolution = 8;
	const uint16_t pwm_maximum = 255; //8 = 255, 10 = 1024, 16 = 65535

	/* BUTTONS */
	const uint16_t button_delay = 500;

	/* MEMORY */

	volatile long timer = 0;
	volatile long start_time = 0;
	volatile long run_time = 0;

	volatile float drive_speed = 1.0;  //CHANGE
	volatile float takeup_speed = 1.0; //percentage of max PWM

	volatile uint16_t takeup_pwm_duty_cycle = 0;
	volatile uint16_t takeup_ramp_steps = 0;  //# of steps
	volatile uint16_t takeup_ramp_step = 0;   //length of step (ms)
	volatile boolean takeup_ramp_dir = true;  //true = up, false = down
	volatile uint16_t takeup_ramp_time = 500; //default ramp time (ms)
	volatile long takeup_ramp_start = 0;      //time to start ramping
	volatile long takeup_ramp_current_step = 0;
	volatile long takeup_ramp_next_step_start = 0;
	volatile boolean takeup_ramping = false;

	volatile uint8_t load = 2; //0 = no load, 1 = single thread, 2 = dual thread

	volatile bool takeup_dir = true;
	volatile bool initialized = false;
	volatile bool running = false;


	public:

	ContactPrinter();

	void Setup();
	void Loop();
	void Start();
	void Stop();
	void SetSpeedTakeup(float speed); //percent
	void SetupDrive();
	void SetupTakeup();
	void SetDirectionTakeup(bool dir);

	void StartTakeup();
	void StopTakeup();
	void EnableTakeup();

	void RampTakeup(uint16_t start, uint16_t end, uint16_t time);
	void RampTakeupLoop();

	void ButtonLoop();

	bool IsRunning ();

};

#endif
