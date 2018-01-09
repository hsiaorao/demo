class Enemy extends Object {

  Enemy() {
    super();
  }

  void display() {
    imageMode(CORNER);
  }

  void update() {
  }

  void checkCollision(Player player) {
    if (canHit && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      //player.die();
      //game_over
    }
  }
}