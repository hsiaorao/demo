class Thorn extends Enemy {
  PImage img;  

  Thorn(float x, float y) {
    super();
    img = loadImage("img/stone2.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 60;
  }
   void display() {
    image(img, x, y, w, h);
  }
}