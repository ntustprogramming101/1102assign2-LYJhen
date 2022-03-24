final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

PImage bg;
PImage soil;
PImage life;
PImage soldier;
PImage cabbage;
PImage gameover;
PImage groundhogDown;
PImage groundhogIdle;
PImage groundhogLeft;
PImage groundhogRight;
PImage restartHovered;
PImage restartNormal;
PImage startHovered;
PImage startNormal;
PImage title;

int soliderX , soliderY;
int robotX , robotY;
int laserX , move , laserY;
int cabbageX, cabbageY;

float groundhogX;
float groundhogY;
float frames = 15;
int block = 80;
float lifeCount = 2;

 
int gameState;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life= loadImage("img/life.png");
  soldier= loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  title = loadImage("img/title.jpg");
  bg = loadImage("img/bg.jpg");
  soliderY = floor(random(2,6));
  cabbageY = floor(random(2,6));
  cabbageX = floor(random(2,6));
  x = 320;
  y = 80;
}

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

gameState = GAME_START;

void draw() { //<>//
	switch (gameState){
    case GAME_START:
    image(title,0,0);
    image(startNormal,360,248);
      
      if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
        image(startHovered,360,248);
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(startNormal,360,248);
        }
      }
  break;  
  //<>//
    case GAME_RUN:
		// Game Run
  if(downPressed){
    y += frames;
      if(y >= 400){
        y = 400;
      }
  }
  if(leftPressed){
    x -= frames;
      if(x <= 0){
        x = 0;
      }
  }
  if(rightPressed){
    x += frames;
      if(x >= 560){
        x = 560;
      }
  }
  
  image(bg,0,0);
  image(soil,0,160);
//grassland
  stroke(124,204,25);
  fill(124,204,25);
  rect(0,145,640,15);
//sun
  noStroke();
  fill(253,184,19);
  ellipse(590,50,120,120);
  
  strokeWeight(5);
  stroke(255,255,0);
  arc(590,50,120,120,radians(0),radians(360));
 
//groundhogIdle
  image(groundhogIdle,groundhogX,groundhogY);
  
  //if(x)
  
//life
   if(lifeCount == 2){
     image(life,10,10);
     image(life,80,10);   
     gameState = GAME_RUN;
   }else if(lifeCount == 3){
     image(life,10,10);
     image(life,80,10);
     image(life,150,10);  
     gameState = GAME_RUN;
   }else if(lifeCount == 1){           
     image(life,10,10); 
     gameState = GAME_RUN;
   }else if(lifeCount <= 0){
     gameState = GAME_LOSE;
     }  
  

//soldier
  soliderX+=3;
  
  image(soldier,soliderX,80*soliderY);
  
  if(soliderX >= 700){
    soliderX-=780;
  }

// groundhog touch soldier
  if(groundhogX >= soliderX && groundhogX + block <= soliderX + block && groundhogY == 80*soliderY){
    groundhogX = 4*block;
    80*groundhogY = block;
    lifeCount -= 1;
  if( lifeCount < 1){
    gameState = GAME_LOSE;
  }
 }
 
//cabbage
  image(cabbage,80*cabbageX,80*cabbageY);
  if(groundhogX >= 80*cabbageX && groundhogX + block <= 80*cabbageX +block
    && groundhogY >= 80*cabbageY && groundhogY + block <= 80*cabbageY +block){
    cabfinalX = -1000;
    cabfinalY = -1000;
    lifeCount += 1;            
    if (lifeCount > 3){
    lifeCount = 3;
    }  
  
  break;
		
  case GAME_LOSE:
// Game Lose //<>//
  image(gameover,0,0);
  image(restartNormal,360,248);
      
    if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
      image(startHovered,360,248);
      if(mousePressed){
        gameState = GAME_START;
      }else{
        image(restartHovered,360,248);
    }
  break; //<>//
  }
}

void keyPressed(){ //<>//
  if(key == CODED){
    switch(keyCode){
      case DOWN:
        downPressed = true;
        y = y+block;
        break;
      case LEFT:
        leftPressed = true;
        x = x-block;
        break;
      case RIGHT:
        rightPressed = true;
        x = x+block;
        break;
    }
  }
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case DOWN:
        downPressed = false;
        y = y+0;
        break;
      case LEFT:
        leftPressed = false;
        x = x-0;
        break;
      case RIGHT:
        rightPressed = false;
        x = x+0;
        break;
    }
  }
}
