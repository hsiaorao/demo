class Potion extends Object {
  boolean isAlive;

  Potion(float x, float y) {
    super();
    img = loadImage("img/potion1.png") ;
    this.x = x;
    this.y = y;
    this.w = 48;
    this.h = 60;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && canHit && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      //player.flyState = uptoFly;
      //player.isFly = true;
      //objectCanHit = false;
      isAlive = false;
      openBoxSound.trigger();
      //eatPotionSound.trigger();
    }
  }


  void display() {
    if (isAlive) {
      super.display();
    }
  }
}
