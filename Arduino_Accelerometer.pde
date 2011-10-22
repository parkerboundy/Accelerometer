// these constants won't change:
const int xPin = 2;		// X output of the accelerometer
const int yPin = 3;		// Y output of the accelerometer

void setup() {
  // initialize serial communications:
  Serial.begin(9600);
  
  // initialize the pins connected to the accelerometer
  pinMode(xPin, INPUT);
  pinMode(yPin, INPUT);
}

void loop() {
  // variables to read the pulse widths
  int pulseX, pulseY;
  
  // variables to contain the resulting accelerations
  int accelerationX, accelerationY;
  
  // read the pulses from the accelerometer
  pulseX = pulseIn(xPin,HIGH);  
  pulseY = pulseIn(yPin,HIGH);

  // map the pulse to a value between 0-500, to be used in Processing
  accelerationX = map(pulseX, 3700, 6350, 0, 500);
  accelerationY = map(pulseY, 3700, 6350, 0, 500);
  
  // send the accelerometer to Processing through serial connection
  Serial.print(accelerationX);
  Serial.print(",");
  Serial.print(accelerationY);
  Serial.print('\n');
  
  // delay the loop so we're sending a manageable amount of data
  delay(100);
}
