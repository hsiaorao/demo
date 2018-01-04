class Brick extends Enemy {
  PImage img;

  Brick(float x, float y) {
    super();
    img = loadImage("img/stone1.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 60;
  }

  void display() {
    super.display();
    image(img, x, y, w, h);
  }
}