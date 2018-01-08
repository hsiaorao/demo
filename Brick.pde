class Brick extends Enemy {
  int number;

  Brick(float x, float y) {
    super();
    this.number = floor(random(0, 3));
    img = loadImage("img/stone1.png") ;
    this.x = x;
    this.y = y;
    this.w = 60 + 60*number;
    this.h = 60;
    println(number);
  }

  void display() {
    switch(number) {

    case 0:
      image(img, x, y, 60, 60);
      break;

    case 1:
      image(img, x, y, 60, 60);
      image(img, x+60, y, 60, 60);
      break;

    case 2:
      image(img, x, y, 60, 60);
      image(img, x+60, y, 60, 60);
      image(img, x+120, y, 60, 60);
      break;
    }
  }
}
