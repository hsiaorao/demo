class Player {

  PImage img;
  float x, y;
  float w = 65, h = 90;
  float jumpSpeed = 13;
  final float PLAYER_INIT_X = 80;
  final float PLAYER_INIT_Y = height - 80 - h;
  float t;
  final float a = 50;

  int moveDirection = 0;
  float currentX;
  boolean stay;
  boolean isFly;
  int flyState;
  int flyTimer;
  int walkTimer;

  Player() {  // remember the gender
    //img = loadImage("img/player" + gender + ".png");
    img = girlIdle;
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    stay = true;
    isFly = false;
    walkTimer = 15;
  }



  void fly() {
    img = girlFly;
    w = 110;
    h = 110;
    if (isFly) {
      player.stay = false;
      switch(flyState) {

      case uptoFly:
        if (y > a*sin(t)+100) {
          y -= 8;
        } else {
          flyTimer = 200;
          flyState = flying;
        }
        break;

      case flying:
        cameraSpeed = 15;
        flyTimer--;
        t += 0.14;
        y = a*sin(t)+100;
        if (flyTimer <= 0) {
          flyState = downtoRun;
        }
        break;

      case downtoRun:
        cameraSpeed = 7;
        if (y < PLAYER_INIT_Y) {
          y += 6;
        } else {
          y = PLAYER_INIT_Y;
          objectCanHit = true;
          isFly = false;
          stay = true;
          w = 65;
          h = 90;
        }
        break;
      }
    }
  }

  void update() {
    if (stay) {
      if (jumpState) {
        currentX = 0;
        img = girlJump;
        moveDirection = UP;
        //moveTimer = moveDuration;
        stay = false;
        y = PLAYER_INIT_Y;
       // h = 90;
      } else if (slipState) {
        img = girlSlip;
        y = PLAYER_INIT_Y + 25;
        w = 78;
        h = 64;
        jumpState = false;
      } else {
        walkTimer--;
        if (walkTimer >= 7) {
          img = girlIdle;
        }
        //else if (walkTimer >= 15) {
        //  img = girlWalk1;
        //} else if (walkTimer >= 8) {
        //  img = girlWalk2;
        //}
        else {
          img = girlWalk3;
        }
        if (walkTimer <= 0) {
          walkTimer = 15;
        }
        y = PLAYER_INIT_Y;
        w = 65;
        h = 90;
      }
    }

    image(img, x, y, w, h);

    if (!stay && !isFly) {
      //moveTimer --;
      currentX += 5;
      switch(moveDirection) {

      case UP:
        img = girlJump;
        y -= jumpSpeed;
        jumpSpeed -= 0.6;
        if (y > PLAYER_INIT_Y+1) {
          y = PLAYER_INIT_Y;
          jumpSpeed = 13;
          stay = true;
        }
        break;
      }
    }
  }
}