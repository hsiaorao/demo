class Background {
  PImage bg;
  float x, y, speed;
  int bgRandom;
  final float LIMIT_X = -800;
  final float RESET = 2400;

  Background(float x, float y) {
    bgRandom = floor(random(0,4));
    bg =loadImage("img/bg" + str(bgRandom) + ".png");
    this.x = x;
    this.y = y;
  }

  void move(float speed) {
    this.speed = speed;
    x -= speed;
    if (x <= LIMIT_X) {
      x = this.x + RESET;
    }
  }

  void display() {
    image(bg, x, y);
  }
}
