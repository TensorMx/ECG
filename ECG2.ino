int val;
void setup(){

Serial.begin(14400);
}

void loop(){

val=analogRead(A0);

Serial.println(val);

delay(20);

}

