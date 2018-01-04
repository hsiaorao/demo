class Torch extends Object {
  boolean isAlive;

  Torch(float x, float y) {
    super();
    img = loadImage("img/torch.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 90;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && canHit && isHit(x, y, w, h, player.x, player.y, player.w, player.h)) {
      //add the light
      light.w+=1000;
      light.h+=1000;
      isAlive = false;
    }
  }

  void display() {
    if (isAlive) {
      super.display();
    }
  }
}