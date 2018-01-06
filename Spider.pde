class Spider extends Enemy {

  PImage img;
  float ySpeed = 3;

  Spider(float x, float y) {
    super();
    img = loadImage("img/spider.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 43;
  }

  void move(float speed) {
    super.move(speed);
    //detect the distance
    if (dist(x, y, player.x, player.y) < 200) {
      y += ySpeed;
      if (y >=340 || y <= 50) {
        ySpeed *= -1;
      }
    }
  }

  void display() {
    super.display();
    line(x+w/2, 0, x+w/2, y+h/2);
    image(img, x, y, w, h);
  }
}