PImage girlIdle, girlJump, Potion, Bat, lightImg;
float playerX, playerY;
int cameraSpeed;
Player player;
Light light;
Background[] bg = new Background[3]; 
Object[] object = new Object[5];

float speedUpTimer;

boolean jumpState = false;

void setup() {
  size(800, 450, P2D);

  cameraSpeed = 4;
  girlIdle = loadImage("img/girlIdle.png");
  girlJump = loadImage("img/girlJump.png");  
  lightImg=loadImage("img/light.png");
  player = new Player();

  for (int i=0; i<bg.length; i++) {
    bg[i] = new Background(i*800, 0);
  }

  for (int i=0; i<object.length; i++) {
    int objectRandom = floor(random(0, 8));
    switch(objectRandom) {      
      //item      
    case 0:
      object[i] = new Torch(360 + i*360, height-300);
      object[i].isTorch = true;
      break;        
    case 1:
      object[i] = new Potion(360 + i*360, height-240);
      break;

      //enemy in the air      
    case 2:
      object[i] = new Spider(360 + i*360, height-240);
      break;     
    case 3:
      object[i] = new Bat(360 + i*360, height-300);
      break;

      //enemy on the ground            
    case 4:
      object[i] = new Thorn(360 + i*360, height-100);
      break;     
    case 5:
      object[i] = new Brick(360 + i*360, height-80);
      break;
    case 6:
      object[i] = new MummyCat(360 + i*360, height-100);
      break;    
    case 7:
      object[i] = new Mummy(360 + i*360, height-120);
      break;
    }
  }

  //light
  light= new Light();
}

void draw() {
  background(0);
  //Background
  for (int i=0; i<bg.length; i++) {
    bg[i].move(cameraSpeed);
    bg[i].display();
  }

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

  speedUpTimer --;
  if (speedUpTimer < 0) {
    cameraSpeed = 4;
    for (int i=0; i<object.length; i++) {
      object[i].canHit = true;
    }
  } else {
    for (int i=0; i<object.length; i++) {
      object[i].canHit = false;
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

Object renew() {
  Object object;
  int objectRandom = floor(random(0, 8));
  switch(objectRandom) {
    //item    
  case 0:
    object = new Torch( 800+360*2, height-300);
    object.isTorch = true;
    return object;
  case 1:
    object = new Potion( 800+360*2, height-240);
    return object;

    //enemy in the air  
  case 2:
    object = new Spider( 800+360*2, height-240);
    return object;
  case 3:
    object = new Bat( 800+360*2, height-300);
    return object;

    //enemy on the ground      
  case 4:
    object = new Thorn( 800+360*2, height-100);
    return object;
  case 5:
    object = new Brick( 800+360*2, height-80);
    return object;    
  case 6:
    object = new MummyCat( 800+360*2, -900);
    return object;    
  case 7:
    object = new Mummy( 800+360*2, height-120);
    return object;
  }
  return null;
}

void speedUp() {
  speedUpTimer = 45;
  cameraSpeed = 10;
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
      //case DOWN:
      //downState = true;
      //break;
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
      //case DOWN:
      //downState = false;
      //break;
    }
  }
}