
const int buttonPin0 = 0;// Enter
const int buttonPin1 = 1;// Esc  

//These are the directions of the controller:
const int buttonPin3 = 3; //down
const int buttonPin4 = 4; //left
const int buttonPin5 = 5; //right
const int buttonPin6 = 6; //up

//These are the button of the actions in the game:
const int buttonPin8 = 8; 
const int buttonPin9 = 9; 
const int buttonPin10 = 10; 
const int buttonPin11 = 11; 

int led = 13;

void setup() {
     Serial.begin(9600);
     pinMode(led, OUTPUT);  
  
     pinMode(buttonPin0, INPUT);  
     pinMode(buttonPin1, INPUT);  
     
     pinMode(buttonPin3, INPUT);  
     pinMode(buttonPin4, INPUT);  
     pinMode(buttonPin5, INPUT);  
     pinMode(buttonPin6, INPUT);  
     
     pinMode(buttonPin8, INPUT);  
     pinMode(buttonPin9, INPUT);  
     pinMode(buttonPin10, INPUT);  
     pinMode(buttonPin11, INPUT);  
        
}

void loop() {   
      //The button 0 writes 2 instead of 0, all the other buttons write the expected number in the serial port.
      if(digitalRead(buttonPin0)==LOW){
         digitalWrite(led, HIGH);
         while(digitalRead(buttonPin0)==LOW){}
         Serial.write(2);
         //Serial.println("Enter");
      }
      else if(digitalRead(buttonPin1)==LOW){
         digitalWrite(led, HIGH);
         while(digitalRead(buttonPin1)==LOW){}
         Serial.write(1);
         //Serial.println("Esc");
      }
      else if(digitalRead(buttonPin3)==LOW){
         //if (val=='2')while(digitalRead(buttonPin3)==LOW){}
         digitalWrite(led, HIGH);
         Serial.write(3);
         //Serial.println("down");
      }
      else if(digitalRead(buttonPin4)==LOW){
         //if (val=='2')while(digitalRead(buttonPin4)==LOW){}
         digitalWrite(led, HIGH);
         Serial.write(4);
         //Serial.println("left");
      }
      else if(digitalRead(buttonPin5)==LOW){
         //if (val=='2')while(digitalRead(buttonPin5)==LOW){}
         digitalWrite(led, HIGH);
         Serial.write(5);
         //Serial.println("right");
      }
      else if(digitalRead(buttonPin6)==LOW){
         //if (val=='2')while(digitalRead(buttonPin6)==LOW){}
         digitalWrite(led, HIGH);
         Serial.write(6);
         //Serial.println("up");
      }
      else if(digitalRead(buttonPin8)==LOW){
         digitalWrite(led, HIGH);
         while(digitalRead(buttonPin8)==LOW){}
         Serial.write(8);
         //Serial.println("8");
      }
      else if(digitalRead(buttonPin9)==LOW){
         digitalWrite(led, HIGH);   
         while(digitalRead(buttonPin9)==LOW){}
         Serial.write(9);
         //Serial.println("9");
      }
      else if(digitalRead(buttonPin10)==LOW){
         digitalWrite(led, HIGH);
         while(digitalRead(buttonPin10)==LOW){}
         Serial.write(10);
         //Serial.println("10");
      }
      else if(digitalRead(buttonPin11)==LOW){
         digitalWrite(led, HIGH);  
         while(digitalRead(buttonPin11)==LOW){}
         Serial.write(11);
         //Serial.println("11");
      }
      else{
         digitalWrite(led, LOW);
         Serial.write(99);
         Serial.println("99");
         //Serial.println("no button pressed");
      }
      delay(100);
}

