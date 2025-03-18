#include <Encoder.h>
#include <ESP32Servo.h>

static const int servoPin = 13;



const int servo_pin = 13;

// Changed the servo pin for physical pin D13

Servo servo1;

const int in_pin_1 = 6;
const int in_pin_2 = 5;
const int enc_a = 3;
const int enc_b = 2;

//Adding constant angles that the servo should be set to

const int open_angle = 0;
const int closed_angle = 0;

Encoder enc(enc_a, enc_b);

int S0_zero = 0;
int S1_compress = 1;
int S2_lock = 2;
int S3_decompress = 3;
int S4_unlock = 4;
int state = 0;
int rep = 0;

int des = 0;
double pos = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(500);

  pinMode(in_pin_1, OUTPUT);
  pinMode(in_pin_2, OUTPUT);
  servo1.attach(servo_pin);
}

void loop() {
  // put your main code here, to run repeatedly:
  pos = enc.read()*360/(379.17*12);
  Serial.print("State: ");
  Serial.print(state);
  Serial.print(" pos: ");
  Serial.print(pos);
  Serial.print(" des: ");
  Serial.println(des);
  // analogWrite(servo_pin,1000);
  // delay(1500);
  // // analogWrite(servo_pin,100);
  // // delay(1500);

  
  if (state == S0_zero){
    des = 0;
    if (pos >= 0.98 * des && pos <= 1.02 * des){
      state = S1_compress;
      servo1.write(open_angle);
    }
    go();
  } else if (state == S1_compress){
    des = 720;
    if (pos >= 0.95 * des && pos <= 1.05 * des){
      state = S2_lock;
    }
    go();
  } else if (state == S2_lock){
    // add servo lock part
    Serial.println("locking");
    servo1.write(closed_angle);
    delay(1000);
    state = S3_decompress;
  } else if (state == S3_decompress){
    des = 10;
    if (pos >= 0.95 * des && pos <= 1.05 * des){
      state = S4_unlock;
    }
    go();
  } else if (state == S4_unlock){
    // add servo unlock part
    Serial.println("unlocking");
    analogWrite(servo_pin,1000);
    delay(1000);
    Serial.println("Cycle done");
    state = 5;
  } else if (state == 5){
    stop();
  }

  
  
  delay(10);
}

void reverse(){
  digitalWrite(in_pin_1, HIGH); // Apply PWM to in1
  digitalWrite(in_pin_2, LOW); 
}

void forward(){
  digitalWrite(in_pin_1, LOW); // Apply PWM to in1
  digitalWrite(in_pin_2, HIGH); 
}

void stop(){
  digitalWrite(in_pin_1, LOW); // Apply PWM to in1
  digitalWrite(in_pin_2, LOW); 
}
void go(){
  if ((pos - des) >= 0){
    reverse();
  }
  else if ((pos - des) < 0){
    forward();
  }
  else{
    stop();
  }
}
