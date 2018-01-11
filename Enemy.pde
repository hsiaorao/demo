class Enemy extends Object {
  boolean isAlive;
  Enemy() {
    super();
    isAlive = true;
  }

  void display() {
    imageMode(CORNER);
  }

  void update() {
  }

  void checkCollision(Player player) {
    if (isAlive && canHit && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      hpX -= 216*0.2;
      isAlive = false;
      //game_over
    }
    if (hpX < 0) {
      hpX = 0;
      player.die();
      dieSound.trigger();
    }
  }
}