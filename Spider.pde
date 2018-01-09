class Spider extends Enemy {

  PImage img;
  float ySpeed = 3;

  Spider(float x, float y) {
    super();
    img = loadImage("img/spider.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 60;
  }

  void move(float speed) {
    super.move(speed);
    //detect the distance
    if (dist(x, y, player.x, player.y) < 220) {
      y += ySpeed;
      if (y >=300 || y <= 50) {
        ySpeed *= -1;
      }
    }
  }
  
  void playsound(){
     if(y == height-300+ySpeed){
         spiderSound.trigger();
     }
  }

  void display() {
    super.display();
    line(x+w/2, 0, x+w/2, y+h/2);
    image(img, x, y, w, h);
  }
}
