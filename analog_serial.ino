
// These constants won't change. They're used to give names to the pins used:
const int analogInPin1 = A0;  // Analog input pin that the 1st potentiometer is attached to
const int analogInPin2 = A1;  // Analog input pin that the 2nd potentiometer is attached to

int sensorValue_1 = 0;        // value read from the 1st pot
int sensorValue_2 = 0;        // value read from the 1st pot

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(115200);
}

void loop() {
  // read the analog in value:
  sensorValue_1 = analogRead(analogInPin1);
  sensorValue_2 = analogRead(analogInPin2);
  // map it to the range of the analog out:
 

  // print the results to the Serial Monitor:
  Serial.print(sensorValue_1);
  Serial.print(":");
  Serial.print(sensorValue_2);
  Serial.println(":");

  // wait 2 milliseconds before the next loop for the analog-to-digital
  // converter to settle after the last reading:
  delay(2);
}
