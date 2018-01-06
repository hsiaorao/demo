PImage Potion, Bat, lightImg;
PImage girlIdle, girlJump, girlFly, girlSlip, girlWalk2, girlWalk3;
float playerX, playerY;
int cameraSpeed, gametime;
Player player;
Light light;
Background[] bg = new Background[3]; 
Object[] object = new Object[5];
PFont papyrus;
float speedUpTimer;
boolean objectCanHit;
boolean jumpState = false;
boolean slipState = false;
final int uptoFly = 0, flying = 1, downtoRun = 2;

void setup() {
  size(800, 450, P2D);

  cameraSpeed = 7;
  girlIdle = loadImage("img/girlIdle.png");
  girlJump = loadImage("img/girlJump.png"); 
  girlFly = loadImage("img/girlFly.png");
  girlSlip = loadImage("img/girlSlip.png");
  girlWalk2 = loadImage("img/girlWalk2.png");  
  girlWalk3 = loadImage("img/girlWalk3.png");  
  lightImg=loadImage("img/light.png");
  player = new Player();
  objectCanHit = true;
  papyrus = createFont("font/papyrus.ttf", 45, true);
  textFont(papyrus);

  for (int i=0; i<bg.length; i++) {
    bg[i] = new Background(i*800, 0);
  }

  for (int i=0; i<object.length; i++) {
    int objectRandom = floor(random(0, 9));
    switch(objectRandom) {      
      //item      
    case 0:
      object[i] = new Torch(360 + i*360, height-360);
      object[i].isTorch = true;
      break;        
    case 1:
      object[i] = new Potion(360 + i*360, height-330);
      break;

      //enemy in the air      
    case 2:
      object[i] = new Spider(360 + i*360, height-300);
      break;     
    case 3:
      object[i] = new Bat(360 + i*360, height-random(240, 360));
      break;

      //enemy on the ground            
    case 4:
      object[i] = new Thorn(360 + i*360, height-110);
      break;     
    case 5:
      object[i] = new Brick(360 + i*360, height-110);
      break;
    case 6:
      object[i] = new MummyCat(360 + i*360, height-140);
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
  gametime ++ ;
  
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


  // m Count UI
  //gametime ++ ;
  String depthString = ( cameraSpeed*gametime/50 + 1 ) + " m ";
  textSize(45);
  textAlign(RIGHT, TOP);
  textFont(papyrus);
  fill(0, 120);
  text(depthString, width + 3, height + 3);
  fill(#ffcc00);
  text(depthString, width-10, 0);
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
    object = new Potion(800+360*2, height-330);
    return object;

    //enemy in the air  
  case 2:
    object = new Spider(800+360*2, height-300);
    return object;
  case 3:
    object = new Bat( 800+360*2, height-random(240, 360));
    return object;

    //enemy on the ground      
  case 4:
    object = new Thorn( 800+360*2, height-110);
    return object;
  case 5:
    object = new Brick( 800+360*2, height-110);
    return object;    
  case 6:
    object = new MummyCat( 800+360*2, -60);
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