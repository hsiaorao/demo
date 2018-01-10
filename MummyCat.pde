class MummyCat extends Enemy {
  PImage mummyCat1, mummyCat2;
  float ySpeed=4;
  float timer;

  MummyCat(float x, float y) {
    super();
    mummyCat1 = loadImage("img/mummyCat1.png") ;
    mummyCat2 = loadImage("img/mummyCat2.png") ;    
    this.x = x;
    this.y = y;
    this.w = 76;
    this.h = 60;
    timer=30;
  }

  void display() {
    super.display();
    timer--;
    if (timer >= 15) {
      img = mummyCat1;
    } else {
      img = mummyCat2;
      w=70;
    }
    if (timer <= 0) {
      timer = 30;
    }
    image(img, x, y, w, h);
  }

  void move(float speed) {
    super.move(speed);
    if (dist(x, y, player.x, player.y) < 525) {
      y += ySpeed;
      ySpeed+=0.3;
    }
    if (y>height-140) {    
      y=height-140;
    }  
  }

  void playsound() {
    if (y == -80 + ySpeed*10) {
      meowSound.trigger();
    }
  }
}