#ifndef PID_MOTOR_CONTROLLER_H
#define PID_MOTOR_CONTROLLER_H

#include <Arduino.h>
#include <stdint.h>

class PIDMotorController {
public:
    /**
     * Constructor for PID Motor Controller
     * 
     * @param kp Proportional gain coefficient
     * @param ki Integral gain coefficient
     * @param kd Derivative gain coefficient
     * @param sampleTimeMs Time between PID calculations in milliseconds
     */
    PIDMotorController(double kp = 1.0, double ki = 0.1, double kd = 0.01, uint32_t sampleTimeMs = 20);

    /**
     * Sets the desired motor speed
     * 
     * @param targetRPM Desired motor speed in RPM
     */
    void setTargetRPM(double targetRPM);

    /**
     * Gets the current target RPM
     * 
     * @return Current target RPM
     */
    double getTargetRPM() const;

    /**
     * Updates the PID controller with current encoder reading
     * 
     * @param currentRPM Current motor speed in RPM from encoder
     * @return PWM value for motor (0-255)
     */
    uint16_t update(double currentRPM);

    /**
     * Set PID controller parameters
     * 
     * @param kp Proportional gain coefficient
     * @param ki Integral gain coefficient
     * @param kd Derivative gain coefficient
     */
    void setTunings(double kp, double ki, double kd);

    /**
     * Set sample time for PID calculations
     * 
     * @param sampleTimeMs Time between PID calculations in milliseconds
     */
    void setSampleTime(uint32_t sampleTimeMs);

    /**
     * Reset the PID controller (clear accumulated error)
     */
    void reset();

private:
    // PID const
    double m_kp;           // Proportional gain
    double m_ki;           // Integral gain
    double m_kd;           // Derivative gain
    
    // PID var
    double m_targetRPM;    // Desired RPM
    double m_lastError;    // Last error value
    double m_integralSum;  // Sum of all errors (integral)
    
    // Timing
    uint32_t m_sampleTimeMs;  // Time between updates in milliseconds
    unsigned long m_lastTime;  // Last time update was called in milliseconds
    
    // Output limits
    const uint16_t MIN_PWM = 0;
    const uint16_t MAX_PWM = 255;
    
    bool m_firstUpdate;
};

#endif