class Bat extends Enemy {

  PImage img1, img2;
  float timer;
  int number;
  float t;
  final float a=50; 

  Bat(float x, float y) {
    super();
    img1 = loadImage("img/bat1.png") ;
    img2 = loadImage("img/bat2.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 60;
    this.number=floor(random(2, 3));
    timer = 30;
  }

  void move(float speed) {
    super.move(speed);
    t += 0.05;
  }

  void display() {
    super.display();
    timer--;
    if (timer >= 15) {
      image(img2, x, y+90, w, h);
      y=a*sin(t);
    } else {
      image(img1, x, y+90, w, h);
      y=a*sin(t);
    }
    if (timer <= 0) {
      timer = 30;
    }
  }
}