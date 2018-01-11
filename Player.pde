class Player {
  PImage img, girlW1, girlW2, girlJ, girlS;
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
  boolean isFly, isInvincible, isAfterFly, isDie;
  int flyState;
  int flyTimer;
  int walkTimer;
  int InTimer;
  int dieTimer;

  Player() {
    img = girlWalk1;
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    stay = true;
    isFly = false;
    isDie = false;
    walkTimer = 15;
    girlW1 = girlWalk1;
    girlW2 = girlWalk2;
    girlJ = girlJump;
    girlS = girlSlip;
  }

  void die() {
    cameraSpeed = 0;
    this.stay = false;
    this.isDie = true;
    img = ghost;
    w=70;
    //dieTimer=120; 
    dieTimer--;
    if (dieTimer > 0) {
      y-=2;
    }
  }

  void Invincible() {
    //if (isAfterFly) {
    //  InTimer = 30;
    //} else if (isInvincible) {
    //  InTimer = 50;
    //}

    InTimer--;

    if (InTimer < 0) {
      girlW1 = girlWalk1;
      girlW2 = girlWalk2;
      girlJ = girlJump;
      girlS = girlSlip;
      objectCanHit = true;
      isAfterFly = false;
      isInvincible = false;
    } else {
      objectCanHit = false;
      girlW1 = girlWalk1Inv;
      girlW2 = girlWalk2Inv;
      girlJ = girlJumpInv;
      girlS = girlSlipInv;
    }
  }

  void fly() {
    img = girlFlyInv;
    w = 130;
    h = 130;
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
          //objectCanHit = true;
          isFly = false;
          stay = true;
          isAfterFly = true;
          InTimer = 100;
          w = 65;
        //  h = 90;
        }
        break;
      }
    }
  }

  void update() {
    if (stay) {
      if (jumpState) {
        currentX = 0;
        img = girlJ;
        moveDirection = UP;
        //moveTimer = moveDuration;
        stay = false;
        y = PLAYER_INIT_Y;
        // h = 90;
      } else if (slipState) {
        img = girlS;
        y = PLAYER_INIT_Y + 35;
        w = 81;
        h = 55;
        jumpState = false;
      } else {
        walkTimer--;
        if (walkTimer >= 7) {
          img = girlW1;
        } else {
          img = girlW2;
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

    if (!stay && !isFly && !isDie) {
      //moveTimer --;
      currentX += 5;
      switch(moveDirection) {

      case UP:
        img = girlJ;
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