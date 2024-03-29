/***
 * 
 *  100RPM 12VDC Worm Gear Motor w/ encoder
 *  SKU - JGY-370
 *  DC12V100RPM - SKU-GS00127-05
 * 
 *  Gear ratio: 40:1(?) 60:1(?)
 *  11 PPR Encoder - (!)
 * 
 *  Red——Motor power + (exchange can control rotating and reversing)
 *  Black——Coding power- negative (3.3-5V) polarity cannot be wrong
 *  Yellow——Signal feedback
 *  Green——Signal feedback
 *  Blue——Coding power + positive(3.3-5V)polarity cannot be wrong
 *  White——Motor power - (exchange can control rotating and
 *
 ***/



#include <util/atomic.h> // For the ATOMIC_BLOCK macro

#define ENCA 2 // YELLOW
#define ENCB 3 // WHITE
#define MOTORA 10
#define MOTORB 11

volatile int32_t posi = 0; // specify posi as volatile
const long maxTime = 100000;
const int32_t maxRotations = 10;
const int ppr = 11;
const float ratio = 187.0 / 3.0;
const int maxPulses = (int) round((float) ppr * ratio);
const int speed = 255;
const int framesPerRotation = 18;
const float pulsesPerFrame = (float) maxPulses / (float) framesPerRotation;
volatile long start = 0;
volatile long total;
volatile bool done  = false;
volatile bool stop = false;
volatile int32_t incoming;
volatile float rpm;
volatile float fps;
volatile float fpsMax = -1.0;
volatile float fpsMin = 100000.0;
volatile int32_t rotations = 0;
volatile int32_t lastRotationPosition = 0;
volatile int32_t lastFramePosition = 0;
volatile int32_t frames = 0;

float calculateFPS (long timeLength, int frames) {
  return 1000.0 / ((float) timeLength / (float) frames);
}
float calculateRPM (long rotationLength) {
  return 60000.0 / (float) (rotationLength);
}

void setup() {
  Serial.begin(57600);
  Serial.flush();
  pinMode(ENCA, INPUT);
  pinMode(ENCB, INPUT);
  pinMode(MOTORA, OUTPUT);
  pinMode(MOTORB, OUTPUT);
  
  attachInterrupt(digitalPinToInterrupt(ENCA), readEncoder,RISING);

  Serial.println("Connected");
  Serial.print("PPR:    ");
  Serial.println(ppr);
  Serial.print("Ratio:  ");
  Serial.println(ratio);
  Serial.print("Pulses: ");
  Serial.println(maxPulses);
  Serial.print("Frames per Rotation: ");
  Serial.println(framesPerRotation);
  Serial.print("Pulses per Frame: ");
  Serial.println(pulsesPerFrame);
}

void loop() {
  int32_t pos;
  // Read the position in an atomic block to avoid a potential
  // misread if the interrupt coincides with this code running
  // see: https://www.arduino.cc/reference/en/language/variables/variable-scope-qualifiers/volatile/
  
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
    pos = posi;
  }

  rotations = (int) floor((float) pos / (float) maxPulses);
  if (rotations != lastRotationPosition) {
    lastRotationPosition = rotations;
    frames = rotations * framesPerRotation;
    Serial.print("Rotations:  ");
    Serial.print(rotations);
    Serial.print(" = ");
    Serial.println(millis() - start);
  }
  frames = (int) floor((float) pos / pulsesPerFrame);
  if (frames != lastFramePosition) {
    lastFramePosition = frames;
    total = millis() - start;
    fps = calculateFPS(total, frames);
    if (fps < 10000.0 && fps > fpsMax) {
      fpsMax = fps;
    }
    if (fps < fpsMin) {
      fpsMin = fps;
    }
    //Serial.print("Frames:    ");
    //Serial.print(frames);
    //Serial.print(" = ");
    //Serial.println(total);
    //Serial.println(fps);
    //Serial.print("@");
    //Serial.println(pos);
  }

  if (abs(pos) >= maxPulses * maxRotations) {
    stop = true;
  }
  if (start == -1) {
    delay(1000);
    analogWrite(MOTORA, speed);
    digitalWrite(MOTORB, LOW);
    start = millis();
    rotations = 0;
  } else if (stop && !done) {
    digitalWrite(MOTORA, LOW);
    digitalWrite(MOTORB, LOW);
    //Serial.print("Final:  ");
    //Serial.println(pos);
    Serial.print("Time:   ");
    total = millis() - start;
    Serial.println(total);
    rpm = calculateRPM(total) * (float) (rotations + 1);
    fps = calculateFPS(total, frames);
    Serial.print("RPM:    ");
    Serial.println(rpm);
    Serial.print("FPS:    ");
    Serial.println(fps);
    Serial.print("     Min: ");
    Serial.println(fpsMin);
    Serial.print("     Max: ");
    Serial.println(fpsMax);
    Serial.print("Rotations: ");
    Serial.println(rotations);
    Serial.print("Frames: ");
    Serial.println(frames);
    done = true;
  }
  if (Serial.available() > 0) {
    incoming = Serial.read();
    start = -1;
    posi = 0;
    done = false;
    stop = false;
  }
}

void readEncoder(){
  int b = digitalRead(ENCB);
  if(b > 0){
    posi++;
  }
  else{
    posi--;
  }
}
