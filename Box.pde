class Box extends Object {
  boolean isAlive;
  PImage box, boxOpen;

  Box(float x, float y) {
    super();
    box = loadImage("img/treasure1.png");
    boxOpen = loadImage("img/treasure2.png");
    this.x = x;
    this.y = y;
    this.w = 80;
    this.h = 80;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && canHit && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      player.flyState = uptoFly;
      player.isFly = true;
      objectCanHit = false;
      isAlive = false;
    }
  }

  void display() {
    if (isAlive) {
      img = box;
    } else {
      img = boxOpen;
    }
    super.display();
  }
}