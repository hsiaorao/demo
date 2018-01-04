class Light {

  Light() {
  }

  float w=8000;
  float h=4500;
  float hSpeed=2;
  float wSpeed=3.5;

  void display() {
    imageMode(CENTER);
    image(lightImg, 0, height, w, h);
  }

  void update() {
    if (h<=900) {
      h=900;
    } else {
      h-=hSpeed;
    }
    if (w<=1600) {
      w=1600;
    } else {
      w-=wSpeed;
    }
  }
}