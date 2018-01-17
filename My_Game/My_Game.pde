import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

int prev_state;
int state = 0;
//There are diferent States:
//state == 0; Part where the player chose the game he wants to play;
//state == 1; Game 1 - Almost Pong;
//state == 2; Game 2 - Snake;
//state == 99; Game Paused or Menu2(Restart or Go Back to Main Menu);
//state == -1; Menu3 (Sure you wanna leave the game?)

//General Variables:
int R1=0,G1=0,B1=255;
int R2=0,G2=0,B2=255;
int i=0,j=0;
PImage img,img2;
///////////////////////////////////
//Variables of the game AlmostPong:
float ballX=random(950)+25;
float ballY=700;

float speedX=10;
float speedY=-10;

float pos=300;
float lenght=400;
float inc=25;
float rad =50;
int score1=0;
//////////////////////////////////
//Variables of the game Tube:
int tubeX=200;
int tubeY=(int)random(625)+100;
float speedTX=40, speedTY=10;
float speedB1=1,speedB2=2,speedB3=3;
float prev_speed;
int bx1=60,by1=190;
int bx2=60,by2=390;
int bx3=60,by3=590;
int b1=0,b2=0,b3=0;
int capt=0;
int score2=0,miss=0;
//////////////////////////////////

void setup() {
  size(1000,800);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println(Serial.list());
  img = loadImage("img1_almost_pong.jpg");
  img2 = loadImage("img2_tube.jpg");
}

void draw(){    
    if(state==0){
      menu();
    }
    else if(state==1){
      almost_pong();
    }
    else if(state==2){
      tube();
    }
    else if (state==99 || state==-1){
      menu();
    }
} 
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//These are the subroutines that can be used by all the games:
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void menu(){
    if (state==0){
      background(0,0,0);
    }
    fill(255,255,255);
    if(state==0){
      rect(100,100,800,600);
    }
    else if(state==99 || state==-1){
      rect(200,200,600,500);
    }
    
    fill(R1,G1,B1);
    rect(300,500,150,100);
    fill(R2,G2,B2);
    rect(550,500,150,100);
    
    textSize(20);
    fill(0,0,255);
    if(state==0){
      image(img, 100,100);
      image(img2, 500,94,400,305);
      text("CHOOSE THE GAME YOU WANT TO PLAY:",300,450);
    }
    else if (state==99){
      fill(255,0,0);
      textSize(25);
      text("GAME OVER!!!",422,340);
      textSize(19);
      if(prev_state==1)text("YOUR SCORE: " + score1,435,370);
      else if(prev_state==2)text("YOUR SCORE: " + score2,435,370);
      textSize(20);
      fill(0,0,255);
      text("WHAT TO DO NOW ?",410,450);
    }
     else if (state==-1){
      text("WHAT NOW ?",440,450);
    }
    
    textSize(19);
    fill(255,0,0); 
    if(state==0){
      text("ALMOST PONG",306,550);
    }
    else if (state==99){
      text("RESTART",335,553);
    }
    else if (state==-1){
      text("LEAVE",345,550);
    }
    
    textSize(19);
    fill(255,0,0);
    if(state==0){
      text("TUBE",600,550);
    }
    else if (state==99){
      text("BACK TO",585,545);
      text("MAIN MENU",572,565);
    }
    else if (state==-1){
      text("STAY",600,550);
    }
    
    menu_choose();
           
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void menu_choose(){
  
  if ( myPort.available() > 0) {  // If data is available,
      val = myPort.read();  // read it and store it in val 
   }
      
  if (val==4){
    R1=255;G1=255;B1=51;
    R2=0;G2=0;B2=255;
  
  }
  else if(val==5){
    R1=0;G1=0;B1=255;
    R2=255;G2=255;B2=51;
  }
  else if(val==2){
    val=99;
    if(B1==51){
      if(state==0){
        state =1;
      }
      else if (state ==99){
        restart();
        state = prev_state;
      }
      else if (state ==-1){
        state=0;
        R1=0;G1=0;B1=255;
        R2=0;G2=0;B2=255;
        menu();
      } 
    }
    else if(B2==51){
      if(state==0){
        state =2;
      }
      else if (state ==99){
        restart();
        state = 0;
        R1=0;G1=0;B1=255;
        R2=0;G2=0;B2=255;
      }
      else if (state ==-1){
        state = prev_state;
        R1=0;G1=0;B1=255;
        R2=0;G2=0;B2=255;
      }
    }
  }
  
  if(state!=0 && state!=99 && state!=-1){
      R1=0;G1=0;B1=255;
      R2=0;G2=0;B2=255;
  }
  
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void pause(){
  state = 99;
  while (state == 99){
    if ( myPort.available() > 0) {  // If data is available,
      val = myPort.read();         // read it and store it in val
      if (val == 2){
        val=99;
        state = prev_state;
      }
    }
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////// 
void restart(){
    //Reseting variables of Almost Pong:
    ballX=random(950)+25;
    ballY=700;
    speedX=10;
    speedY=-10;
    pos=300;
    lenght=400;
    inc=25;
    rad =50;
    score1=0;
    
    tubeX=200;
    tubeY=(int)random(625)+100;
    speedTX=40;speedTY=10;
    speedB1=1;speedB2=2;speedB3=3;
    bx1=60;by1=190;
    bx2=60;by2=390;
    bx3=60;by3=590;
    b1=0;b2=0;b3=0;
    capt=0;score2=0;miss=0;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//Game 1: Almost Pong.
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void almost_pong(){
  play1();
  draw_bar();
  draw_ball();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void play1(){
    if ( myPort.available() > 0) {  // If data is available,
      val = myPort.read();         // read it and store it in val
    }
    
    if (val == 1){
        prev_state = state;
        state=-1;
    }
    else if (val == 2){
        prev_state = state;
        pause();
    }
    else if (val == 4) {
        pos = pos - inc;
    }
    else if (val == 5){
        pos = pos + inc;
    }
  

    if(pos<0){
        pos = 0;
    }
    else if (pos>width-lenght){
        pos = width-lenght;
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw_bar(){
    background(100,200,50);
    fill(200,100,50);
    ellipse(ballX,ballY,rad,rad);
    fill(50,100,200);
    rect(pos,height-20,lenght,20);
    textSize(19);
    fill(0);
    text("Score: " + score1,10,20);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw_ball(){
  if(ballY<height+rad){
        if(ballY<(height-rad)){
            if (ballX<=0){
              speedX =-speedX;
              if((ballX+speedX)<=0){
                ballX=1;
              }
            }
            else if(ballX>=width){
              speedX =-speedX;
              if((ballX+speedX)>=width){
                ballX=width-1;
              }
              
            }           
            if(ballY<0){
                speedY =-speedY;
            }
        }
        else if (ballY>=(height-rad)){
          
          if (ballX<(pos-(rad/3)) || ballX>(pos+lenght+(rad/3))){
              
          }
          else if(speedY>0) {
              
              inc = inc*1.01;
              speedY = speedY*1.05;
              speedY =-speedY;
              lenght = lenght - 5;
              pos = pos + 2.5;
              rad = rad *0.99; 
              score1++;
              
              
              if (((ballX>=pos-(rad/3) && ballX<=pos-(rad/5))||(ballX>=pos+lenght+(rad/5) && ballX<=pos+lenght+(rad/3))) && ballY<(height-(rad/2))){
                    speedX =-speedX;                   
              }
              else if (((ballX>=pos-(rad/3) && ballX<=pos-(rad/5))||(ballX>=pos+lenght+(rad/5)) && ballX<=pos+lenght+(rad/3)) && ballY>=(height-(rad/2))){
                  speedX =-speedX;  
                  speedY =-speedY;                  
              }
              
          }
        }
        ballX+=speedX;
        ballY+=speedY;
  }
  else{
       prev_state = 1;
       state=99;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Game 2: Tube
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void tube(){
  play2();
  block();
  draw_tube(); 
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void play2(){
  if(miss<20){
     if ( myPort.available() > 0) {  // If data is available,
        val = myPort.read();         // read it and store it in val
     }
     
     if (val == 1){
          prev_state = state;
          state=-1;
      }
      else if (val == 2){
          prev_state = state;
          pause();
      }
      else if (val==3){
         tubeY +=speedTY;
         
      }
      else if (val==4) {
         tubeX += -speedTX; 
      }
      else if (val==5) {
         tubeX +=speedTX;
      }
      else if (val==6){
         tubeY += -speedTY;
      }
      
      else if(val==8){
         if(capt!=0){
          shoot_block();
         } 
      }
      else if(val==9){
        if(capt==0){
          if(tubeY>=120 && tubeY<=220 && ((tubeX-bx1)<=300)&&((tubeX-bx3)>=-50)){
            capt=1;
          }
          else if(tubeY>=320 && tubeY<=420 && ((tubeX-bx2)<=300)&&((tubeX-bx3)>=-50)){
            capt=2;
          }
          else if(tubeY>=520 && tubeY<=620 && ((tubeX-bx3)<=300) &&((tubeX-bx3)>=-50)){
            capt=3;
          }
        }
      }
      
      
      if (tubeX<110 && capt==0){
          tubeX = 110;
      }
      else if(tubeX<200 && capt!=0){
          tubeX = 200;
      }
  
      if (tubeX>810){
          tubeX = 810;
      }
      if (tubeY<40){
          tubeY = 40;
      }
      if (tubeY>700){
          tubeY = 700;
      }
      
      if(b1<4 && b1>0 && capt!=1){
        bx1+=speedB1;
      }
      if(b2<4 && b2>0 && capt!=2){
        bx2+=speedB2;
      }
      if(b3<4 && b3>0 && capt!=3){
        bx3+=speedB3;
      }
      if(capt!=0){
          catch_block();
      }
      
      if(bx1>920){
        if((b1==1 && by1>=125 &&by1<=275)||(b1==2 && by1>=325 && by1<=475)||(b1==3 && by1>=525 && by1<=675)){
          score2++;
        }
        else{
          miss++;
        }
        
        b1=0;
        bx1=60;by1=190;
        if(speedB1==speedTX){
          speedB1=prev_speed;
          speedB1=speedB1*1.3;
        }
      }
      if(bx2>920){
        if((b2==1 && by2>=125 && by2<=275)||(b2==2 && by2>=325 && by2<=475)||(b2==3 && by2>=525 && by2<=675)){
          score2++;
        }
        else{
          miss++;
        }
        
        b2=0;
        bx2=60;by2=390;
        if(speedB2==speedTX){
          speedB2=prev_speed;
          speedB2=speedB2*1.2;
        }
      }
      if(bx3>920){
        if((b3==1 && by3>=125 && by3<=275)||(b3==2 && by3>=325 && by3<=475)||(b3==3 && by3>=525 && by3<=675)){
          score2++;
        }
        else{
          miss++;
        }
        
        b3=0;
        bx3=60;by3=590;
        if(speedB3==speedTX){
          speedB3=prev_speed;
          speedB3=speedB3*1.1;
        }
      }
  }
  else{
     prev_state = 2;
     state=99;
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void block(){
  if (b1==0){
    b1 = (int)random(6)+1;
    if(b1>3)b1=0;
  }
  if (b2==0){
    b2 = (int)random(6)+1;
    if(b2>3)b2=0;
  }
  if (b3==0){
    b3 = (int)random(6)+1;
    if(b3>3)b3=0;
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void  draw_tube(){
    fill(255,255,255);
    rect(0,0,1000,800);
    fill(0);
    rect(0,15,1000,5);
    rect(0,780,1000,5);
    rect(95,0,5,800);
    rect(900,0,5,800);
    rect(0,0,1000,15);
    rect(0,785,1000,15);
    
    rect(0,150,50,100);
    rect(50,125,10,150);
    rect(0,350,50,100);
    rect(50,325,10,150);
    rect(0,550,50,100);
    rect(50,525,10,150);
    
    if(tubeY>=132.5 && tubeY<=207.5)fill(128,0,0);
    else fill(255,0,0);
    rect(950,150,50,100);
    rect(940,125,10,150);
    if(tubeY>=332.5 && tubeY<=407.5)fill(0,128,0);
    else fill(0,255,0);
    rect(950,350,50,100);
    rect(940,325,10,150);
    if(tubeY>=532.5 && tubeY<=607.5)fill(0,0,128);
    else fill(0,0,255);
    rect(950,550,50,100);
    rect(940,525,10,150);
    
    fill(64,64,64);
    rect(tubeX-10,tubeY-20,10,100);
    rect(tubeX-30,tubeY-20,40,10);
    rect(tubeX-30,tubeY+70,40,10);
    rect(tubeX-20,tubeY-10,50,10);
    rect(tubeX-20,tubeY+60,50,10);
    rect(tubeX,tubeY,40,60);
    rect(tubeX+40,tubeY+10,30,40);
    rect(tubeX+70,tubeY+17.5,20,25);
   
    if(b1<4 && b1>0){
      if(b1==1){
        fill(255,0,0);
      }
      else if(b1==2){
        fill(0,255,0);
      }
      else if(b1==3){
        fill(0,0,255);
      }
      rect(bx1,by1,20,20);
    }
    
    if(b2<4 && b2>0){
      if(b2==1){
        fill(255,0,0);
      }
      else if(b2==2){
        fill(0,255,0);
      }
      else if(b2==3){
        fill(0,0,255);
      }
      rect(bx2,by2,20,20);
    }
    
    if(b3<4 && b3>0){
      if(b3==1){
        fill(255,0,0);
      }
      else if(b3==2){
        fill(0,255,0);
      }
      else if(b3==3){
        fill(0,0,255);
      }
      rect(bx3,by3,20,20);
    }
    textSize(19);
    fill(0);
    text("Score: " + score2,5,40);
    text("Miss: " + miss,5,60);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void catch_block(){
  if(capt==1){
     by1=tubeY+20;
     bx1=tubeX-100;
  }
  else if(capt==2){
     by2=tubeY+20;
     bx2=tubeX-100;
  }
  else if(capt==3){
     by3=tubeY+20;
     bx3=tubeX-100;
  }
}
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void shoot_block(){
    if(capt==1){
      prev_speed=speedB1;
      speedB1=speedTX;
  }
  else if(capt==2){
     prev_speed=speedB2;
     speedB2=speedTX;
  }
  else if(capt==3){
     prev_speed=speedB3;
     speedB3=speedTX;
  }
  capt=0;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
