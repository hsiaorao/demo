PImage Potion, Bat, lightImg;
PImage girlIdle, girlJump, girlFly, girlSlip, girlWalk2, girlWalk3;
float playerX, playerY;
int cameraSpeed;

Player player;
Light light;
Background[] bg = new Background[3]; 
Object[] object = new Object[5];

float speedUpTimer;
boolean objectCanHit;
boolean jumpState = false;
boolean slipState = false;
final int uptoFly = 0, flying = 1, downtoRun = 2;

import ddf.minim.*;
Minim minim;
AudioPlayer playingSong, openingSong;
AudioSample eatPotionSound, openBoxSound, dieSound, flySound, meowSound, mummySound, spiderSound;

void setup() {
  size(800, 450, P3D);
  minim=new Minim(this);
  playingSong = minim.loadFile("song/Pyramids.wav");
  openingSong = minim.loadFile("song/mystery.wav");
  //eatPotionSound = minim.loadSample("song/eatPotion.wav");
  openBoxSound = minim.loadSample("song/magic.wav");
  //dieSound = minim.loadSample("song/gameover.wav",128);
  flySound = minim.loadSample("song/fly.wav");
  meowSound = minim.loadSample("song/meow.wav");
  mummySound = minim.loadSample("song/mummy.wav");
  spiderSound = minim.loadSample("song/spider.wav");
  playingSong.play();
  playingSong.loop();

  cameraSpeed = 7;
  girlIdle = loadImage("img/girlIdle.png");
  girlJump = loadImage("img/girlJump.png");  //girl invincible_idle  //girlJump
  girlFly = loadImage("img/girl fly3.png");
  girlSlip = loadImage("img/girl slide.png");  //invincible_slide  //slide
  girlWalk2 = loadImage("img/girl walk_left4.png");  //girl walk_left4  //invincible_right
  girlWalk3 = loadImage("img/girl walk_right4.png");  //girl walk_right4   //invincible_left
  lightImg=loadImage("img/light.png");
  player = new Player();
  objectCanHit = true;

  for (int i=0; i<bg.length; i++) {
    bg[i] = new Background(i*800, 0);
  }

  for (int i=0; i<object.length; i++) {
    int objectRandom = floor(random(0, 2));  //it was 9
    switch(objectRandom) {      
      //item      
    case 0:
      object[i] = new Torch(360 + i*360, height-360);
      object[i].isTorch = true;
      break;        
    case 1:
      object[i] = new Potion(360 + i*360, height-300);
      break;

      //enemy in the air      
    case 2:
      object[i] = new Spider(360 + i*360, height-300);
      break;     
    case 3:
      object[i] = new Bat(360 + i*360, height-360);
      break;

      //enemy on the ground            
    case 4:
      object[i] = new Thorn(360 + i*360, height-110);
      break;     
    case 5:
      object[i] = new Brick(360 + i*360, height-140);
      break;
    case 6:
      object[i] = new MummyCat(360 + i*360, height-160);
      break;    
    case 7:
      object[i] = new Mummy(360 + i*360, height-160);
      break;
    case 8:
      object[i] = new Box(360 + i*360, height-160);
      break;
    }
  }

  //light
  light= new Light();
}

void draw() {
  background(0);


  cameraSpeed=7;

  //Background
  for (int i=0; i<bg.length; i++) {
    bg[i].move(cameraSpeed);
    bg[i].display();
  }
  objectCanHit(objectCanHit);
  //Object
  for (int i=0; i<object.length; i++) {
    object[i].move(cameraSpeed);
    object[i].display();
    object[i].update();   
    object[i].checkCollision(player);
    object[i].playsound();
    if (object[i].reset()) {
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
}

void objectCanHit(boolean objectCanHit) {
  if (player.isFly) {
    player.fly();
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
  switch(objectRandom) {
    //item    
  case 0:
    object = new Torch(800+360*2, height-360);
    object.isTorch = true;
    return object;
  case 1:
    object = new Potion(800+360*2, height-300);
    return object;

    //enemy in the air  
  case 2:
    object = new Spider(800+360*2, height-300);
    return object;
  case 3:
    object = new Bat( 800+360*2, height-360);
    return object;

    //enemy on the ground      
  case 4:
    object = new Thorn( 800+360*2, height-110);
    return object;
  case 5:
    object = new Brick( 800+360*2, height-140);
    return object;    
  case 6:
    object = new MummyCat( 800+360*2, -540);
    return object;    
  case 7:
    object = new Mummy( 800+360*2, height-160);
    return object;
  case 8:
    object = new Box(800+360*2, height-160);
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
      //case RIGHT:
      //rightState = true;
      //break;
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
      //case RIGHT:
      //rightState = false;
      //break;
    case DOWN:
      slipState = false;
      break;
    }
  }
}
