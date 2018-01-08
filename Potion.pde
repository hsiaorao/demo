class Potion extends Object {
  boolean isAlive;

  Potion(float x, float y) {
    super();
    img = loadImage("img/potion.png") ;
    this.x = x;
    this.y = y;
    this.w = 48;
    this.h = 60;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && !player.isFly && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      player.isInvincible = true;
      player.InTimer = 200;
      //objectCanHit = false;
      isAlive = false;
    }
  }


  void display() {
    if (isAlive) {
      super.display();
    }
  }
}
