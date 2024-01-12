/***
 * 
 *  100RPM 12VDC Worm Gear Motor w/ encoder
 *  SKU - JGY-370
 *  DC12V100RPM - SKU-GS00127-05
 * 
 *  Gear ratio: 40:1
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

void setup() {
  Serial.begin(9600);
  pinMode(ENCA, INPUT);
  pinMode(ENCB, INPUT);
  attachInterrupt(digitalPinToInterrupt(ENCA), readEncoder,RISING);
}

void loop() {
  // Read the position in an atomic block to avoid a potential
  // misread if the interrupt coincides with this code running
  // see: https://www.arduino.cc/reference/en/language/variables/variable-scope-qualifiers/volatile/
  int pos = 0; 
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
    pos = posi;
  }

  Serial.println(pos);
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
