#include <Adafruit_NeoPixel.h>
#include <ArduinoJson.h>

StaticJsonBuffer<200> jsonBuffer;

/*LIGHT VARIABLES*/
#define NUMPIXELS 1 // Number of Pixies in the strip
#define PIXELPIN  3 // Pin number for SoftwareSerial output;
Adafruit_NeoPixel light = Adafruit_NeoPixel(1, PIXELPIN, NEO_GRB + NEO_KHZ800);

String color = "000,000,000";

volatile int commaR = 0;
volatile int commaG = 0;

String strR = "000";
String strG = "000";
String strB = "000";

volatile int r = 0;
volatile int g = 0;
volatile int b = 0;

/*MOTOR VARIABLES*/
#define PI 3.1415926535897932384626433832795
#define HALF_PI 1.5707963267948966192313216916398
#define TWO_PI 6.283185307179586476925286766559
#define DEG_TO_RAD 0.017453292519943295769236907684886
#define RAD_TO_DEG 57.295779513082320876798154814105

const float RPM = 15.0;
const float RPS = RPM / 60.0;
const float RATIO = 0.5; //Gear ratio
const float THICKNESS = 0.11938; //16mm thickness

volatile int LENGTH = 33000; //mm
String lengthStr = "33000";
volatile float CORE_D = 31.27; //Daylight spool
//2in core
//3in core
//takeup spool?
unsigned long starttime = 0;
unsigned long runtime = 0;
volatile boolean running = false;

//motor pins
const int MOTOR_PIN = 9; //TIP120 -> 2.2k resistor

/*CORE INFO*/
volatile int i = 0;
unsigned long now; //to be compared to stored values every loop

/*COMMANDS*/
volatile char cmd_char = 'z'; //null command default
const char cmd_connect = 'c';
const char cmd_light = 'l';
const char cmd_length = 'f';
const char cmd_start = 's';
const char cmd_stop = 'x';

const int serialDelay = 5;//allows for sending longer strings to arduino in realtime

void setup () {
  Serial.begin(57600);
  Serial.flush();
  Serial.setTimeout(serialDelay);
  pinMode(MOTOR_PIN, OUTPUT);

  light.begin();
  setAll(0, 0, 0);

  delay(2000);
  reportString("msg", "Connected to contact printer");
}

void loop () {
  now = millis();
  readCmd();
  if (running) {
    motor_run();
  }
}

void readCmd () {
  if (Serial.available()) {
    /* read the most recent byte */
    cmd_char = (char)Serial.read();
  }
  if (cmd_char != 'z') {
    cmd(cmd_char);
    cmd_char = 'z';
  }  
}

void cmd (const char val) {
  if (val == cmd_connect) {
    reportString("verify", "contact_printer");
  } else if (val == cmd_light) {
    colorString();
    reportString("light", color);
  } else if (val == cmd_length) {
    setLength();
    reportInt("length", LENGTH);
  } else if (val == cmd_start) {
    running = true;
  } else if (val == cmd_stop) {
    runtime = now - starttime;
    reportInt("stopped", runtime);
    running = false;
    i = 0;  
  }
}

void reportString (String key, String val) {
  JsonObject& jsonObj = jsonBuffer.createObject();
  jsonObj[key] = val;
  jsonObj.printTo(Serial);
  Serial.println(""); 
}

void reportFloat (String key, const float val) {
  JsonObject& jsonObj = jsonBuffer.createObject();
  jsonObj[key] = val;
  jsonObj.printTo(Serial);
  Serial.println("");  
}

void reportInt (String key, const int val) {
  JsonObject& jsonObj = jsonBuffer.createObject();
  jsonObj[key] = val;
  jsonObj.printTo(Serial);
  Serial.println("");  
}

void motor_run () {
  starttime = now;
  runtime = 0;
  Serial.println("Starting motor");
  //analogWrite(MOTOR_PIN, 255 - (i * 2));
  analogWrite(MOTOR_PIN, pwm());
  Serial.print("PWM = ");
  Serial.println(255 - (i * 2));
  Serial.print(i);
  Serial.print("ft = ");
  Serial.print(diameter(12.0 * 25.4 * i));
  Serial.println("mm");

  Serial.print(32.0 + (i * 0.4));
  Serial.print("mm = ");
  Serial.print(length(32.0 + (i * 0.4)) / (12 * 25.4) );
  Serial.println("ft");
  delay(1000);
  i++;
  if (i > 108) {
    runtime = now - starttime;
    reportInt("completed", runtime);
    running = false;
    i = 0;  
  } 
}

int pwm () {
  int val = 255; //full speed

  return val;
}

float diameter (const float len) { //mm
	'use strict';
	return 2 * sqrt( ((len * THICKNESS) / PI) + pow(CORE_D / 2, 2) );
}

float length (const float diam) {
  return (PI * (pow(diam / 2, 2) - pow(CORE_D / 2, 2)) ) / THICKNESS;
  //var len = Math.PI * (Math.pow(d / 2, 2) - Math.pow(D / 2, 2));
  //return len / THICKNESS;
}

void setAll (const int red, const int green, const int blue) {
  for (volatile int x = 0; x < NUMPIXELS; x++) { 
    light.setPixelColor(x, red, green, blue);
  }
  light.show(); 
 }

 void setLength () {
   while (Serial.available() == 0) {             
    //Wait for length string
  }
  lengthStr = Serial.readString();
  LENGTH = lengthStr.toInt(); 
 }

float speed (float diam) {
  return (diam * PI) * RPS;
}

void colorString () {
  while (Serial.available() == 0) {             
    //Wait for color string
  }
  color = Serial.readString();

  commaR = color.indexOf(','); //comma trailing R
  commaG = color.indexOf(',', commaR + 1);

  strR = color.substring(0, commaR);
  strG = color.substring(commaR + 1, commaG);
  strB = color.substring(commaG + 1);

  r = strR.toInt();
  g = strG.toInt();
  b = strB.toInt();

  setAll(r, g, b);
}
