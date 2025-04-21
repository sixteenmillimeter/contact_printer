#include "PIDMotorController.h"

PIDMotorController::PIDMotorController(double kp, double ki, double kd, uint32_t sampleTimeMs)
    : m_kp(kp), m_ki(ki), m_kd(kd),
      m_targetRPM(0.0), m_lastError(0.0), m_integralSum(0.0),
      m_sampleTimeMs(sampleTimeMs), m_firstUpdate(true) {
}

void PIDMotorController::setTargetRPM(double targetRPM) {
    m_targetRPM = targetRPM;
}

double PIDMotorController::getTargetRPM() const {
    return m_targetRPM;
}

uint16_t PIDMotorController::update(double currentRPM) {
    unsigned long currentTime = millis();
    
    if (m_firstUpdate) {
        m_firstUpdate = false;
        m_lastTime = currentTime;
        m_lastError = m_targetRPM - currentRPM;
        return 0;
    }
    
    unsigned long deltaTime = currentTime - m_lastTime;
    
    if (deltaTime >= m_sampleTimeMs) {
        double error = m_targetRPM - currentRPM;
        double pTerm = m_kp * error;
        m_integralSum += error * deltaTime / 1000.0;
        double iTerm = m_ki * m_integralSum;
        double dTerm = 0.0;
        if (deltaTime > 0) {
            double derivativeError = (error - m_lastError) / (deltaTime / 1000.0);
            dTerm = m_kd * derivativeError;
        }
        
        double output = pTerm + iTerm + dTerm;
        m_lastError = error;
        m_lastTime = currentTime;
        int16_t pwmValue = static_cast<int16_t>(output);
        
        return constrain(pwmValue, MIN_PWM, MAX_PWM);
    }
    
    // If not enough time has passed, return the last calculated value
    // Here we approximate by using the last error
    double pTerm = m_kp * m_lastError;
    double iTerm = m_ki * m_integralSum;
    double output = pTerm + iTerm;
    
    return constrain(static_cast<int16_t>(output), MIN_PWM, MAX_PWM);
}

void PIDMotorController::setTunings(double kp, double ki, double kd) {
    if (kp < 0 || ki < 0 || kd < 0) {
        return;
    }
    
    m_kp = kp;
    m_ki = ki;
    m_kd = kd;
}

void PIDMotorController::setSampleTime(uint32_t sampleTimeMs) {
    if (sampleTimeMs > 0) {
        m_sampleTimeMs = sampleTimeMs;
    }
}

void PIDMotorController::reset() {
    m_integralSum = 0.0;
    m_lastError = 0.0;
    m_firstUpdate = true;
}