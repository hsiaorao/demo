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
    //int number=floor(random(0,3));
    //image(img, x+x*number, y, w, h);
    image(img, x, y, w, h);
  }
}