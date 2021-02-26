int RedPin = 7;
int GreenPin = 6;
int BluePin = 5;

int TriRedPin =8;
int TriGreenPin =9;
int TriBluePin =10;

int btnBlue = 11;
int btnGreen = 12;
int btnRed = 13;


bool Rpast = false;
bool Bpast = false;
bool Gpast = false;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(btnRed, INPUT);
  pinMode(btnBlue, INPUT);
  pinMode(btnGreen, INPUT);
  
  pinMode(RedPin, OUTPUT);
  pinMode(BluePin, OUTPUT);
  pinMode(GreenPin, OUTPUT);
  pinMode(TriRedPin, OUTPUT);
  pinMode(TriGreenPin, OUTPUT);
  pinMode(TriBluePin, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  

  bool Rcurr = btnPress(btnRed);
  bool Bcurr = btnPress(btnBlue);
  bool Gcurr = btnPress(btnGreen);

  if(Rcurr && !Rpast)
  {
    int Red = digitalRead(TriRedPin);
    digitalWrite(TriRedPin, !Red);
    digitalWrite(RedPin, !Red);
  }
  if(Gcurr && !Gpast)
  {
    int Green = digitalRead(TriGreenPin);
    digitalWrite(TriGreenPin, !Green);
    digitalWrite(GreenPin, !Green);
  }
  if(Bcurr && !Bpast)
  {
    int Blue = digitalRead(TriBluePin);
    digitalWrite(TriBluePin, !Blue);
    digitalWrite(BluePin, !Blue);
  }
  Rpast = Rcurr;
  Gpast = Gcurr;
  Bpast = Bcurr;
}

bool btnPress(int pin)
{
  for(int i = 0; i< 1000; i++)
  {
    bool toggle = digitalRead(pin);
    if(toggle)
    {
      return false;
    }
  }
  return true;
}
