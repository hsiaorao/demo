class Object {

  PImage img;
  float x, y, w, h;
  float xSpeed;
  boolean canHit;
  boolean isTorch;
  final float LIMIT_X = -360;
  final float RESET_X = 800+360*2;



  Object() {
    canHit = true;
    isTorch= false;
  }

  void move(float speed) {
    this.xSpeed = speed;
    x -= xSpeed;
  }

  void checkCollision(Player player) {
  }

  void display() {
    image(img, x, y, w, h);
  }

  void update() {
  }

  boolean reset() {
    if (x <= LIMIT_X) {
      return true;
    } else {
      return false;
    }
  }
}