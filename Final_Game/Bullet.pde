class Bullet{
  int x;
  int y;
  int w;
  int h;
  int bulletS;
  
  boolean isGone;
  
  int left;
  int right;
  int top;
  int bottom;
  
  Bullet(int startX, int startY){
    x= startX;
    y= startY;
    w= 10;
    h= 5;
    bulletS= 15;
    isGone= false;
  }
  
  void render(){
    fill(color (0, 255, 0));
    rect(x, y, w, h);
  }
  
  void move(){
    x += bulletS;
    
    left= x+ w/2;
    right= x- w/2;
    top= y- h/2;
    bottom= y+ h/2;
  }
  
  void checkBullet(){
    if(x > width){
      isGone= true;
    }
  }
  void hitEwok(Ewok anEwok){
    if(top <= anEwok.bottom &&
       bottom >= anEwok.top &&
       left <= anEwok.right &&
       right >= anEwok.left){
         isGone= true;
         anEwok.hit= true;
         println("hit");
       }
  }
}
