
//globals
import processing.sound.*;
// constant variables
int PX;
int PY;
int PS;
int EwokX;
PImage Player;
Player STORM;
SoundFile blaster;
SoundFile hitEwok;
SoundFile song1;
SoundFile song2;
SoundFile song3;
Button songButton1;
Button songButton2;
Button songButton3;
Button Easy;
Button Medium;
Button Hard;

// changing variables
// either with time or level
float startTime;
float interval;
int minTime;
int maxTime;
int endTime;
int level;
int counter;
int winNumber;
// Lists
ArrayList<Bullet> BulList;
ArrayList<Ewok> EwokList;
// states
int state= 0;
// animations and images
PImage[] jumping = new PImage[2];
Animation jumpingTrooper;
PImage buddy;
PImage Info;
PImage Lev1;
PImage Lev2;
PImage Lev3;
PImage Home;
PImage WIN;
void setup(){
  rectMode(CENTER);
  imageMode(CENTER);
  size(800, 800);
  PX= width/ 4;
  PY= height* 3/ 4;
  PS= 50;
  EwokX= width+ width/ 4;
  counter= 0;
  STORM= new Player(PX, PY, PS, color(255));
  BulList = new ArrayList<Bullet>();
  EwokList = new ArrayList<Ewok>();
  blaster= new SoundFile(this, "blaster.wav");
  hitEwok= new SoundFile(this, "hit-ewok.wav");
  song1= new SoundFile(this, "song.wav");
  song2= new SoundFile(this, "song2.wav");  
  song3= new SoundFile(this, "song3.wav");  
  songButton1= new Button(width* 3/ 4, height/ 4, 100, color(255, 0, 0));
  songButton2= new Button(width* 3/ 4, height/ 2, 100, color(0, 255, 0));
  songButton3= new Button(width* 3/ 4, height* 3/ 4, 100, color(0, 0, 255));
  Easy= new Button(width/ 4, height/ 4, 100, color(255, 0, 0));
  Medium= new Button(width/ 4, height/ 2, 100, color(0, 255, 0));
  Hard= new Button(width/ 4, height* 3/ 4, 100, color(0, 0, 255));
  for (int i=0; i < jumping.length; i++) {
    jumping[i] = loadImage("jumping"+i+".png");
  }
  jumpingTrooper= new Animation(jumping, .5, 1);
  buddy= loadImage("Ewok.png");
  Info= loadImage("InfoEndor.jpeg");
  Lev1= loadImage("EasyEndor.jpeg");
  Lev2= loadImage("NightEndor.jpeg");
  Lev3= loadImage("ScaryEwoks.jpeg");
  Home= loadImage("HomeEndor.jpeg");
  WIN= loadImage("winScreen.jpeg");
  Lev1.resize(width, height);
  Lev2.resize(width, height);
  Lev3.resize(width, height);
  Home.resize(width, height);
  Info.resize(width, height);
  WIN.resize(width, height);
}

void draw(){
  background(42);
  switch(state){
    case 0:
    startScreen();
      if(song1.isPlaying() == false &&
         songButton1.isPressed() == true){
    song1.play(); 
    song2.stop();
    song3.stop();
  }
  if(song2.isPlaying() == false &&
         songButton2.isPressed() == true){
    song1.stop(); 
    song2.play();
    song3.stop();
  }
  if(song3.isPlaying() == false &&
         songButton3.isPressed() == true){
    song1.stop(); 
    song2.stop();
    song3.play();
  }
  if(Easy.isPressed() == true){
    state= 1;
    minTime= 2000;
    maxTime= 4000;
    interval= random (minTime, maxTime);
    level= 1;
    winNumber= 10;
  }
  if(Medium.isPressed() == true){
    state= 1;
    minTime= 1000;
    maxTime= 2000;
    interval= random (minTime, maxTime);
    level= 2;
    winNumber= 25;
  }
  if(Hard.isPressed() == true){
    state= 1;
    minTime= 0;
    maxTime= 500;
    interval= random (minTime, maxTime);
    level= 3;
    winNumber= 50;
  }
    break;
    
    case 1:
    if(level == 1){
    image(Lev1, width/2, height/2);
    }
    if(level == 2){
     image(Lev2, width/2, height/2);
    }
    if(level == 3){
     image(Lev3, width/2, height/2);
    }
  STORM.render();
  STORM.move();
  STORM.topJump();
  STORM.land();
  for(Ewok anEwok : EwokList){
     STORM.gotHit(anEwok);
    }
    for(int I = EwokList.size() -1; I>= 0; I=I-1){
    Ewok anEwok = EwokList.get(I);
    if(anEwok.hitPlayer == true){
    state= 2;
    }
 } 
  endTime= millis();
  if (endTime- startTime >interval){
    EwokList.add(new Ewok(EwokX, PY, 40, 10));
    startTime= millis();
    interval= random (minTime, maxTime);
  }
  for(Ewok anEwok : EwokList){
     anEwok.render();
     anEwok.move();
  }
  for(int I = EwokList.size() -1; I>= 0; I=I-1){
    Ewok anEwok = EwokList.get(I);
    if(anEwok.hit == true){
    EwokList.remove(anEwok);
    hitEwok.play();
    counter+= 1;
    }
 } 
  for (Bullet Bill : BulList){
    Bill.render();
    Bill.move();
    Bill.checkBullet();
    for(Ewok anEwok : EwokList){
      Bill.hitEwok(anEwok);
    }
  }
  for(int I = BulList.size() -1; I>= 0; I=I-1){
    Bullet Bill = BulList.get(I);
    if(Bill.isGone == true){
    BulList.remove(Bill);
    }
  } 
  fill(255);
  textSize(44);
  text(counter, width/ 2, height/ 8);
  if(counter >= winNumber){
    state= 3;
  }
    break;
    
    case 2:
    endScreen();
    break;
    
    case 3:
    winScreen();
    break;
    
    case 4:
    infoScreen();
    break;
  }
}

void keyPressed(){
  if (key == 'w' && 
  STORM.isJumping == false &&
  STORM.isFalling == false){
    STORM.isJumping= true;
    jumpingTrooper.isAnimating= true;
    jumpingTrooper.display(PX, PY);
  }
  if (key == ' '){
    BulList.add(new Bullet(STORM.x, STORM.y));
    blaster.play();
  }
  if (key == ENTER ||
      key == RETURN){
      state= 0;
      startTime= millis();
  }
  if (key == 'r' ||
      key == 'R'){
        BulList.clear();
        EwokList.clear();
        for(Ewok anEwok : EwokList){
     anEwok.hitPlayer= false;
    }
        if (level == 1){
        state= 1;
        minTime= 2000;
        maxTime= 4000;
        interval= random (minTime, maxTime);
        }
        if (level == 2){
        state= 1;
        minTime= 1000;
        maxTime= 2000;
        interval= random (minTime, maxTime);
        }
        if (level == 3){
        state= 1;
        minTime= 0;
        maxTime= 500;
        interval= random (minTime, maxTime);
        }
      }
  if(key == 'b' ||
     key == 'B'){
      EwokList.clear();
     }
  if(key == 'i' ||
  key == 'I'){
    state= 4;
  }
}

void startScreen(){
  image(Home, width/2, height/2);
  songButton1.render();
  songButton2.render();
  songButton3.render();
  Easy.render();
  Medium.render();
  Hard.render();
  textAlign(CENTER);
  fill(0);
  textSize(15);
  text("somewhere only", width* 3/ 4, height/ 4);
  text("we know", width* 3/ 4, height/ 4+ 10);
  text("kickapoo", width* 3/ 4, height/ 2);
  text("Big Iron", width* 3/ 4, height* 3/ 4);  
  text("Easy", width/ 4, height/ 4);
  text("Medium", width/ 4, height/ 2);
  text("Hard", width/ 4, height* 3/ 4);
  fill(color(#DB07CD));
  textSize(30);
  text("Press i for info", width/2, height/ 5);
}

void endScreen(){
  background(42);
  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER);
  text("You Died!", width/2, height/ 4);
  text("Press R To Try Again", width/2, height* 3/ 4);
}

void winScreen(){
  image(WIN, width/2, height/2);
  textSize(44);
  fill(0, 255, 0);
  text("You win!", width/2, height/ 2);
  text("Press enter to try another level", width/2, height/ 4);
}

void infoScreen(){
  image(Info, width/2, height/2);
  fill(color(#DB07CD));
  textSize(44);
  text("press enter to return to the home screen", width/2, height/ 4- 50);
  text("avoid getting hit by the ewoks to win", width/2, height/ 4);
  text("press w to jump", width/2, height/ 2);
  text("press space to shoot", width/2, height* 3/ 4);
  text("press b to drop a bomb and clear the screen", width/2, height* 3/ 4+ 50);
}
