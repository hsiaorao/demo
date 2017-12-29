class MummyCat extends Enemy {
  PImage img;
  float ySpeed = 4;

  MummyCat(float x, float y) {
    super();
    img = loadImage("img/mummyCat.png") ;
    this.x = x;
    this.y = y;
    this.w = 80;
    this.h = 80;
  }

  void display() {
    image(img, x, y, w, h);
  }
  
  void move(float speed) {
    super.move(speed);
    y += ySpeed;  
    if (y>=height-160) {    
      y=height-160;
    }
  }
  void update() {
    //x += speed;
    //if (x >= width) x = -w;
  }
}