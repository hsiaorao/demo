class Player {

  PImage img;
  float x, y, speed;
  float w = 90, h = 90;
  final float PLAYER_INIT_X = 80;
  final float PLAYER_INIT_Y = height - 20 - h;

  int moveDirection = 0;
  //int moveTimer = 0;
  //int moveDuration = 80;
  float currentX;
  boolean stay;

  Player() {  // remember the gender
    //img = loadImage("img/player" + gender + ".png");
    img = girlIdle;
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    speed = 3;
    stay = true;
  }

  void update() {
    if (stay) {
      if (jumpState) {
        currentX = 0;
        img = girlJump;
        moveDirection = UP;
        //moveTimer = moveDuration;
        stay = false;
      } else {
        img = girlIdle;
      }
    }

    image(img, x, y, w, h);
    //x += speed;

    if (!stay) {

      //moveTimer --;
      currentX += 5;
      switch(moveDirection) {

      case UP:
        img = girlJump;
        if (currentX < 180) {
          y -= 5;
        } else {
          y += 5;
          if (y > PLAYER_INIT_Y+1) {
            y = PLAYER_INIT_Y;
            stay = true;
          }
        }
        break;
      }
    }
  }
}