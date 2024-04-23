class Player{
  int x;
  int y;
  int size;
  color c;
  int JumpS;
  
  boolean isJumping;
  boolean isFalling;
  
  int maxHeight; 
  int floor;
  
  int left;
  int right;
  int top;
  int bottom;
  
  boolean isDead;
  
  Player(int startx, int starty, int D, color startC){
    x= startx;
    y= starty;
    size= D;
    c= startC;
    JumpS= 10;
    isJumping= false;
    isFalling= false;
    maxHeight= starty - JumpS*12;
    floor= starty;
    isDead= false;
  }
  void render(){
    //fill(c);
    //rect(x, y, size, size);
    //image(loadImage("stormtrooper.png"), x, y);
    jumpingTrooper.display(x,y);
  }
  
  void move(){
    if(isJumping == true){
      y-= JumpS;
    }
    if(isFalling == true){
      y+= JumpS;
    }   
    left= x- size/2;
    right= x+ size/2;
    top= y- size/2;
    bottom= y+ size/2;
  }
  
  void topJump(){
    if(y <= maxHeight){
      isJumping= false;
      isFalling= true;
    }
  }
  void land(){
    if(y >= floor){
      isJumping= false;
      isFalling= false;
    }
  }
  void gotHit(Ewok anEwok){
    if(top <= anEwok.bottom &&
       bottom >= anEwok.top &&
       left <= anEwok.right &&
       right >= anEwok.left){
         anEwok.hitPlayer= true;
       }
  }
}
