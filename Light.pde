class Light {

  PImage lightImg;
  final int MAX_LIGHT_W=8000;
  final int MAX_LIGHT_H=4500;
  float w=MAX_LIGHT_W;
  float h=MAX_LIGHT_H;
  float hSpeed=2;
  float wSpeed=3.5;

  Light() {
    lightImg=loadImage("img/light.png");
  }

  void display() {
    imageMode(CENTER);
    image(lightImg, 0, height, w, h);
  }

  void update() {
    if (h<=1800) {
      h=1800;
    } else {
      h-=hSpeed;
    }
    if (w<=3200) {
      w=3200;
    } else {
      w-=wSpeed;
    }
  }
}