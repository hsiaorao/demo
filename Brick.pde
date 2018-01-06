class Brick extends Enemy {
  PImage img;
  int number;
  int different;
  int w1, w2, w3;


  Brick(float x, float y) {
    super();
    number =floor(random(1, 3));
    img = loadImage("img/stone1.png") ;
    this.x = x;
    this.y = y;
    w1 = 60*number;
    w2 = 60*number;
    w3 = 60*number;
    h = 32*number;
  }

  void display() {
    for (int i=0; i<number; i++) {  
      if (number==1) {
        image(img, x, y-60*(number-1), w1, h);
        image(img, x+w1, y-60*(number-1), w2, h);
        image(img, x+w1+w2, y-60*(number-1), w3, h);
      } else {
        image(img, x, y-32*(number-1), w1, h);
      }
    }
  }
}