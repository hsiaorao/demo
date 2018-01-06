class MummyCat extends Enemy {
  PImage img;
  float ySpeed = 4;

  MummyCat(float x, float y) {
    super();
    img = loadImage("img/mummyCat.png") ;
    this.x = x;
    this.y = y;
    this.w = 76;
    this.h = 60;
  }

  void display() {
    super.display();
    image(img, x, y, w, h);
  }

  void move(float speed) {
    super.move(speed);
    if (dist(x, y, player.x, player.y) < 525) {
      y += ySpeed;
    }
    if (y>=height-140) {    
      y=height-140;
    }
  }
}