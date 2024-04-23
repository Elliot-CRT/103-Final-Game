class Ewok{
  int x;
  int y;
  int d;
  int speed;
  
  int left;
  int right;
  int top;
  int bottom; 
  
  boolean hit;
  boolean hitPlayer;
  
  Ewok(int startX, int startY, int startD, int startS){
    x= startX;
    y= startY;
    d= startD;
    speed= startS;
    hit= false;
  }
  
  void render(){
    //fill(255);
    //circle(x, y, d);
    image(buddy, x, y);
  }
  void move(){
    x-= speed;
    
    left= x- d/2;
    right= x+ d/2;
    top= y- d/2;
    bottom= y+ d/2;
  }
  
}
