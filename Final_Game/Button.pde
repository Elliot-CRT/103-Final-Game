class Button{
  int x;
  int y;
  int d;
  color c;
  
  Button(int startX, int startY, int startD, color startC){
    d= startD;
    y= startY;
    x= startX;
    c= startC;
  }
  
  void render(){
    fill(c);
    rect(x, y, d, d, 10);
  }
  
  
  boolean isBetween(int num, int min, int max) {
  if (num > min &&
    num < max) {
    return true;
  } else {
    return false;
  }
}
boolean isInButton() {
  int left= x- d/ 2;
  int up= y- d/2;
  int right= x+ d/ 2;
  int down= y+ d/ 2;
  
  if (isBetween(mouseX, left, right) &&
    isBetween(mouseY, up, down) &&
    mousePressed) {
    return true;
  } else {
    return false;
  }
}
 public boolean isPressed(){
  if (isInButton() == true){
    return true;
  }
  else{
    return false;
  }
 }
}
