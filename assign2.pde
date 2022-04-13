final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState  = 0;

PImage bg;
PImage soil;
PImage life;
PImage soldier;
PImage cabbage;
PImage gameover;
PImage restartHovered;
PImage restartNormal;
PImage startHovered;
PImage startNormal;
PImage title;

int x,y;

int soliderX , soliderY;
int robotX , robotY;
int laserX , move , laserY;
int cabbageX, cabbageY;

float frames = 15;
int block = 80;
float lifeCount = 2;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int buttonW = 144;
int buttonH = 60;
int buttonX = 248;
int buttonY = 360;

PImage groundhogIdle;
float groundhogX = 4*block;
float groundhogY = block;  
float groundhogXPlus;
float groundhogYPlus;
PImage groundhogDown;
PImage groundhogRight;
PImage groundhogLeft;
int groundhogStat;
int timer;
final int GH_IDLE=0, GH_DOWN=1, GH_RIGHT=2, GH_LEFT=3;


 
void setup() {
	size(640, 480, P2D);
  frameRate(60);
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
  
  gameState = GAME_START;
}



void draw() { //<>//
	switch (gameState){
    case GAME_START:
    image(title,0,0);
    image(startNormal,buttonX,buttonY);
      
      if(mouseX > buttonX && mouseX < buttonX + buttonW 
      && mouseY > buttonY && mouseY < buttonY + buttonH){
        image(startHovered,buttonX, buttonY);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }
  break;  
  //<>//
    case GAME_RUN:
		// Game Run
  
  
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

  
  //if(x)
    switch(groundhogStat){
    case GH_IDLE:
      image(groundhogIdle,groundhogX,groundhogY);
      break;
    case GH_DOWN:
      image(groundhogDown,groundhogX,groundhogY);
      timer+=1;
      groundhogY+=80.0/15;
      break;
    case GH_RIGHT:
      image(groundhogRight,groundhogX,groundhogY);
      timer+=1;
      groundhogX+=80.0/15;
      break;
    case GH_LEFT:
      image(groundhogLeft,groundhogX,groundhogY);
      timer+=1;
      groundhogX-=80.0/15;
      break;
    }
    //check timer
    if(timer==15){
      groundhogStat=GH_IDLE;
    if(groundhogY%block<30){//fix float point offset
      groundhogY=groundhogY-groundhogY%block;
      }else{
      groundhogY=groundhogY-groundhogY%block+block;
      }
    if(groundhogX%block<30){
      groundhogX=groundhogX-groundhogX%block;
      }else{
      groundhogX=groundhogX-groundhogX%block+block;
      }
      //println(hogX);
      //println(hogY);
      timer=0;
   }
  
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
    groundhogY = block;
    lifeCount -= 1;
  if( lifeCount < 1){
    gameState = GAME_LOSE;
  }
 }
 
//cabbage
  image(cabbage,80*cabbageX,80*cabbageY);
  if(groundhogX >= 80*cabbageX+80 && groundhogX + block <= 80*cabbageX +block
    && groundhogY >= 80*cabbageY && groundhogY + block <= 80*cabbageY +block){
    //cabfinalX = -1000;
    //cabfinalY = -1000;
    lifeCount += 1;            
    if (lifeCount > 3){
    lifeCount = 3;
    }  
   }
  break;
		
  case GAME_LOSE :
// Game Lose //<>//
  image(gameover,0,0);
  image(restartNormal,360,248);
    
      if(mouseX > buttonX && mouseX < buttonX + buttonW 
      && mouseY > buttonY && mouseY < buttonY + buttonH){
        image(startHovered,buttonX, buttonY);
        if(mousePressed){
         gameState = GAME_START;
      
    }
  break;}
} //<>//
}

void keyPressed(){
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
      if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(groundhogY+block<height&&groundhogStat==GH_IDLE){
          groundhogStat=GH_DOWN;
          timer=0;
        }
        break;
      case RIGHT:
        if(groundhogX+block<width&&groundhogStat==GH_IDLE){
          groundhogStat=GH_RIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(groundhogX>0&&groundhogStat==GH_IDLE){
         groundhogStat=GH_LEFT;
          timer=0;
      break;
    }}
  }
  }
