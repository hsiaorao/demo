class Light {

  Light() {
  }

  float w=8000;
  float h=4500;
  float hSpeed=2;
  float wSpeed=2;

  void display() {
    imageMode(CENTER);
    image(lightImg, 0, height, w, h);
  }

  void update() {
    w-=wSpeed;
    h-=hSpeed;
    if (h<=900) hSpeed=0;
    if (w<=1600) wSpeed=0;
  }
}