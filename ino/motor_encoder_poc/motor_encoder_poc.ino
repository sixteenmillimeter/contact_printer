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

volatile int posi = 0; // specify posi as volatile
const long maxTime = 10000;
const int ppr = 11;
const float ratio = 62.0;
const int maxPulses = (int) round((float) ppr * ratio);
const int speed = 40;
volatile long start = 0;
volatile bool done  = false;
volatile bool stop = false;
volatile int incoming;
volatile float rpm;

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

}

void loop() {
  int pos;
  if (Serial.available() > 0) {
    incoming = Serial.read();
    start = -1;
    posi = 0;
    done = false;
    stop = false;
  }
  // Read the position in an atomic block to avoid a potential
  // misread if the interrupt coincides with this code running
  // see: https://www.arduino.cc/reference/en/language/variables/variable-scope-qualifiers/volatile/
  
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
    pos = posi;
  }

  if (abs(pos) == maxPulses) {
    stop = true;
  }
  if (start == -1) {
    delay(1000);
    analogWrite(MOTORA, speed);
    digitalWrite(MOTORB, LOW);
    start = millis();
  } else if ((stop || millis() - start >= maxTime) && !done) {
    digitalWrite(MOTORA, LOW);
    digitalWrite(MOTORB, LOW);
    Serial.print("Final: ");
    Serial.println(pos);
    Serial.print("Time:  ");
    Serial.println(millis() - start);
    rpm = (float) 60000 / (float) (millis() - start);
    Serial.print("RPM:   ");
    Serial.println(rpm);
    done = true;
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
