class Mummy extends Enemy {
  PImage img1, img2;
  float speed = 2;
  float timer;  

  Mummy(float x, float y) {
    super();
    img1 = loadImage("img/mummy1.png") ;
    img2 = loadImage("img/mummy2.png") ;
    this.x = x;
    this.y = y;
    this.w = 50;
    this.h = 100;
    timer = 30;
  }

  void display() {
    super.display();
    timer--;
    if (timer >= 15) {
      image(img1, x, y, w, h);
    } else {
      image(img2, x, y, w, h);
    }
    if (timer <= 0) {
      timer = 30;
    }
  }
}