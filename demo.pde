PImage girlIdle, girlJump, girlFly, girlSlip, girlWalk1, girlWalk2, ghost;
PImage girlJumpInv, girlFlyInv, girlSlipInv, girlWalk1Inv, girlWalk2Inv;
PImage gameStart, gameStartH, gameOver, gameOverH, hp;
int cameraSpeed, moveDistance=0;
String depthString;
String score;
int delayTimer=120, hpX;
Player player;
Light light;
Background[] bg = new Background[3]; 
Object[] object = new Object[6];
PFont papyrus;
boolean objectCanHit = true;
boolean jumpState = false;
boolean slipState = false;
boolean backState = false;
final int uptoFly = 0, flying = 1, downtoRun = 2;
final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
final int DelayObject = 50*15;
final float divideObject = 2.5;
int gameState = 0;
int mummyCount=0;
int objectRandom;
int highscore=0;

import ddf.minim.*;
Minim minim;
AudioPlayer playingSong, openingSong;
AudioSample eatPotionSound, openBoxSound, dieSound, flySound, meowSound, mummySound, spiderSound;

void setup() {
  size(800, 450, P3D);

  //load Image
  ghost= loadImage("img/ghost.png");
  girlIdle = loadImage("img/girlIdle.png");
  girlJump = loadImage("img/girlJump.png"); 
  girlFly = loadImage("img/girlFly.png");
  girlSlip = loadImage("img/girlSlip.png");
  girlWalk1 = loadImage("img/girlWalk1.png");  
  girlWalk2 = loadImage("img/girlWalk2.png");  
  girlJumpInv = loadImage("img/girlJumpInv.png"); 
  girlFlyInv = loadImage("img/girlFlyInv.png");
  girlSlipInv = loadImage("img/girlSlipInv.png");
  girlWalk1Inv = loadImage("img/girlWalk1Inv.png");  
  girlWalk2Inv = loadImage("img/girlWalk2Inv.png");    
  gameStart = loadImage("img/gameStart0.png");
  gameStartH = loadImage("img/gameStart1.png");
  gameOver= loadImage("img/gameOver0.png");
  gameOverH= loadImage("img/gameOver1.png");
  hp= loadImage("img/hp.png");

  //load sound
  minim=new Minim(this);
  playingSong = minim.loadFile("sound/Pyramids.wav");
  openingSong = minim.loadFile("sound/mystery.wav");
  openBoxSound = minim.loadSample("sound/magic.wav");
  dieSound = minim.loadSample("sound/gameover.wav", 128);
  flySound = minim.loadSample("sound/fly.wav");
  meowSound = minim.loadSample("sound/meow.wav");
  mummySound = minim.loadSample("sound/mummy.wav");
  spiderSound = minim.loadSample("sound/spider.wav");
  openingSong.play();
  openingSong.loop();

  //load font
  papyrus = createFont("font/papyrus.ttf", 45, true);
  textFont(papyrus);
  
  objectRandom = floor(random(0, 9));
  initGame();
}

void initGame() {

  cameraSpeed = 7;
  moveDistance =0;
  delayTimer=120;
  hpX=216;

  //initialize player
  player = new Player();

  //initialize background
  for (int i=0; i<bg.length; i++) {
    bg[i] = new Background(i*800, 0);
  }

  //initialize object
  for (int i=0; i<object.length; i++) {
    objectRandom = (objectRandom +floor(random(1, 9)))%9;
    switch(objectRandom) {      
      //item      
    case 0:
      object[i] = new Torch(360 + i*360*divideObject + DelayObject, height-360);
      object[i].isTorch = true;
      break;        
    case 1:
      object[i] = new Potion(360 + i*360*divideObject + DelayObject, height-330);
      break;

      //enemy in the air      
    case 2:
      object[i] = new Spider(360 + i*360*divideObject + DelayObject, height-300);
      break;     
    case 3:
      object[i] = new Bat(360 + i*360*divideObject + DelayObject, height-random(240, 360));
      break;

      //enemy on the ground            
    case 4:
      object[i] = new Thorn(360 + i*360*divideObject + DelayObject, height-110);
      break;     
    case 5:
      object[i] = new Brick(360 + i*360*divideObject + DelayObject, height-140);
      break;
    case 6:
      object[i] = new MummyCat(360 + i*360*divideObject + DelayObject, height-140);
      break;    
    case 7:
      if(mummyCount==0) {
        object[i] = new Mummy(360 + i*360*divideObject + DelayObject, height-160);
        mummyCount=1;
      }
      else
        i--;
      break;
    case 8:
      object[i] = new Box(360 + i*360*divideObject + DelayObject, height-160);
      break;
    }
  }

  //initialize light
  light= new Light();
}

void draw() {
  switch (gameState) {

  case GAME_START: // Start Screen
    image(gameStart, 0, 0);
    if (mouseX > 320  && mouseX < 480 && mouseY > 350  && mouseY < 410) {
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
        openingSong.pause();
        playingSong.play();
        playingSong.loop();
      } else {
        image(gameStartH, 0, 0);
      }
    }
    break;

  case GAME_RUN:
    moveDistance += cameraSpeed;

    //Background
    for (int i=0; i<bg.length; i++) {
      bg[i].move(cameraSpeed);
      bg[i].display();
    }

    //hp
    noStroke();
    fill(255, 0, 0);
    rect(16, 17, hpX, 21);
    image(hp, 10, 10, 229, 35); 

    objectCanHit(objectCanHit);

    //Object
    for (int i=0; i<object.length; i++) {
      object[i].move(cameraSpeed);
      object[i].display();
      object[i].update();   
      object[i].checkCollision(player);
      object[i].playsound();
      if (object[i].reset()) {
        if (object[i].isMummy())
          mummyCount=0;
        object[i] = renew();
      }
    }

    //player
    player.update();

    //light  
    light.update();
    light.display(); //add from light  

    //let the torch show up
    for (int i=0; i<object.length; i++) {
      if (object[i].isTorch) {
        object[i].display();
      }
    }

    // m Count UI
    depthString = "hi:" + highscore + "   " +(moveDistance/50) + " m ";
    score=(moveDistance/50)+" m ";
    textSize(45);
    textAlign(RIGHT, TOP);
    textFont(papyrus);
    fill(0, 120);
    text(depthString, width-13, 3);
    fill(#ffcc00);
    text(depthString, width-10, 0);

    if (player.isDie == true) {
      delayTimer--;
      if (delayTimer==119) {
        playingSong.pause();
      }
      if (delayTimer == 0) {
        gameState = GAME_OVER;
        openingSong.play();
        openingSong.loop();
      }
    }
    break;

  case GAME_OVER:
    imageMode(CORNER); 
    image(gameOver, 0, 0);
    if(highscore < moveDistance/50)
      highscore=moveDistance/50;
    if (mouseX > 325  && mouseX < 480 && mouseY > 360  && mouseY < 430) {
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
        initGame();
        openingSong.pause();
        playingSong.play();
        playingSong.loop();
      } else {
        image(gameOverH, 0, 0);
      }
    }  

    textAlign(CENTER, CENTER);
    textSize(65);
    textFont(papyrus);
    fill(0, 120);
    text("Score : "+ score, 403, 293);
    fill(#ffcc00);
    text("Score : "+ score, 400, 290);
    break;
  }
}

void objectCanHit(boolean objectCanHit) {
  if (player.isFly) {
    player.fly();
  }
  if (player.isAfterFly || player.isInvincible) {
    player.Invincible();
  }
  if (objectCanHit) {
    for (int i=0; i<object.length; i++) {
      object[i].canHit = true;
    }
  } else if (!objectCanHit) {
    for (int i=0; i<object.length; i++) {
      object[i].canHit = false;
    }
  }
}

Object renew() {
  Object object;
  int objectRandom = floor(random(0, 9));
  if(objectRandom==7 && mummyCount==1)
    objectRandom = (objectRandom + floor(random(1, 9)))%9;
  switch(objectRandom) {
    //item    
  case 0:
    object = new Torch(800+360*2*divideObject, height-360);
    object.isTorch = true;
    return object;
  case 1:
    object = new Potion(800+360*2*divideObject, height-330);
    return object;

    //enemy in the air  
  case 2:
    object = new Spider(800+360*2*divideObject, height-300);
    return object;
  case 3:
    object = new Bat( 800+360*2*divideObject, height-random(240, 360));
    return object;

    //enemy on the ground      
  case 4:
    object = new Thorn( 800+360*2*divideObject, height-110);
    return object;
  case 5:
    object = new Brick( 800+360*2*divideObject, height-140);
    return object;    
  case 6:
    object = new MummyCat( 800+360*2*divideObject, -540);
    return object;    
  case 7:
    object = new Mummy( 800+360*2*divideObject, height-160);
    return object;
  case 8:
    object = new Box(800+360*2*divideObject, height-160);
    return object;
  }
  return null;
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return  ax + aw > bx &&    // a right edge past b left
    ax < bx + bw &&    // a left edge past b right
    ay + ah > by &&    // a top edge past b bottom
    ay < by + bh;
}

void keyPressed() {
  if (key==CODED) {
    switch(keyCode) {
    case UP:
      jumpState = true;
      break;
    case LEFT:
      backState = true;
      break;
    case DOWN:
      slipState  = true;
      break;
    }
  }
}

void keyReleased() {
  if (key==CODED) {
    switch(keyCode) {
    case UP:
      jumpState = false;
      break;
    case LEFT:
      backState = false;
      break;
    case DOWN:
      slipState = false;
      break;
    }
  }
}
