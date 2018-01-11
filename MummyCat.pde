class MummyCat extends Enemy {
  PImage cat1, cat2;
  float ySpeed = 10;
  float timer;

  MummyCat(float x, float y) {
    super();
    cat1 = loadImage("img/mummyCat1.png") ;
    cat2 = loadImage("img/mummyCat2.png");
    this.x = x;
    this.y = y;
    this.w = 80;
    this.h = 80;
    timer=20;
  }

  void display() {
    super.display();
        timer--;
    if (timer >= 10) {
      img = cat1;
    } else {
      img = cat2;
    }
    if (timer <= 0) {
      timer = 20;
    }
    image(img, x, y, w, h);
  }

  void move(float speed) {
    super.move(speed);
    if (dist(x, y, player.x, player.y) < height+700) {
      y += ySpeed;
    if (y>=height-160) {    
      y=height-160;
      }
    }
  }
  
    void playsound(){
     if(y == -540 + ySpeed*60){
         meowSound.trigger();
     }
  }
  
}
