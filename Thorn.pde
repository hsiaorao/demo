class Thorn extends Enemy {
  PImage img;  

  Thorn(float x, float y) {
    super();
    img = loadImage("img/thorn.png") ;
    this.x = x;
    this.y = y;
    this.w = 80;
    this.h = 80;
  }
  void display() {
    super.display();
    image(img, x, y, w, h);
  }
}