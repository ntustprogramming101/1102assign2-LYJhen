PImage bgImg, soilImg,titleImg,robotImg,lifeImg,cabbageImg; //<>// //<>// //<>// //<>//
  int block = 80;
  float lifeCount = 2;
  
  //badcabbage;(
  float cabbageRandomX;
  float cabbageRandomY;
  float cabfinalX;
  float cabfinalY;
  
  //gooooooood start/end plz
  PImage restartHoveredImg;
  PImage startHoveredImg;
  PImage restartNormalImg;
  PImage startNormalImg;
  PImage gameOverImg;
  int button_W = 144;
  int button_H = 60;
  int buttonX = 248;
  int buttonY = 360;
  
  //the doesn't move groundhog rrrrrrrrr
  PImage groundhogImg;
  float groundhogX = 4*block;
  float groundhogY = block;  
  float groundhogXPlus;
  float groundhogYPlus;
  PImage downImg;
  PImage rightImg;
  PImage leftImg;
  int hogStat;
  int timer;
  final int GR_NORM=0, GR_DOWN=1, GR_RIGHT=2, GR_LEFT=3;
  //groundhog
  
  PImage soldierImg;
  float soldierRandomX;
  float soldierRandomY;
  float soldierSpeedX;//soldierSpeed
  float xSoldier;
  float ySoldier;//soldier//soldierPlace
  
  boolean downPressed = false;
  boolean rightPressed = false;
  boolean leftPressed = false;

  final int GAME_START = 0;  
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;  
  int gameState = GAME_START;
  
  int actionFrame;
  float newTime = millis();//time when the groundhog started moving (1)
  float lastTime = millis();//last groundhog moving (14)
  
void setup() {
  
  size(640, 480, P2D);
  bgImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhogIdle.png");
  lifeImg = loadImage("img/life.png");
  robotImg = loadImage("img/robot.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  gameOverImg = loadImage("img/gameover.jpg");
  downImg= loadImage("img/groundhogDown.png");
  rightImg= loadImage("img/groundhogRight.png");
  leftImg= loadImage("img/groundhogLeft.png");
  restartHoveredImg= loadImage("img/restartHovered.png");
  startHoveredImg= loadImage("img/startHovered.png");
  restartNormalImg= loadImage("img/restartNormal.png");
  startNormalImg= loadImage("img/startNormal.png");
  titleImg= loadImage("img/title.jpg");
  cabbageImg= loadImage("img/cabbage.png");
  
  cabbageRandomX = floor(random(6));
  cabbageRandomY = floor(random(4));
  soldierRandomX = floor(random(6));
  soldierRandomY = floor(random(4));
  xSoldier = soldierRandomX*80;
  ySoldier = 160+soldierRandomY*80;//soldierMovement
  
  //the framerate of the groundhog moves
  frameRate(60);
  gameState = GAME_START;
  lastTime = millis();
  
  cabbageRandomX = floor(random(7));
  cabbageRandomY = floor(random(4));
}

void draw(){ 
  
  switch(gameState){
   
   case GAME_START :
      image(titleImg,0,0);
      image(startNormalImg, buttonX, buttonY);
      if (mouseX > buttonX && mouseX < buttonX + button_W 
      && mouseY > buttonY && mouseY < buttonY + button_H){ 
          image(startHoveredImg, buttonX, buttonY);
          if(mousePressed){ 
            gameState = GAME_RUN;
          }
        }
        break;
     
    case GAME_RUN :
          //basic settings
          image(bgImg,0,0);//bg
          fill(253,184,19);
          strokeWeight(5);
          stroke(255,255,0);
          ellipse(590,50,120,120);//sun
          noStroke();
          fill(124,204,25);
          rect(0,145,640,15);//grass
          image(soilImg,0,160);
          //soil
          
          /////////////////////////////boundary detection
          if(groundhogY >= height){
          groundhogY = height-block;
          }//down boundary
          
          if(groundhogX >= width){
          groundhogX = width-block;
          }//right boundary
          
          if(groundhogX <= 0){
          groundhogX = 0;
          } //left boundary
          //Draw hog
        switch(hogStat){
          case GR_NORM:
            image(groundhogImg,groundhogX,groundhogY);
            break;
          case GR_DOWN:
            image(downImg,groundhogX,groundhogY);
            timer+=1;
            groundhogY+=80.0/15;
            break;
          case GR_RIGHT:
            image(rightImg,groundhogX,groundhogY);
            timer+=1;
            groundhogX+=80.0/15;
            break;
          case GR_LEFT:
            image(leftImg,groundhogX,groundhogY);
            timer+=1;
            groundhogX-=80.0/15;
            break;
        }
        //check timer
        if(timer==15){
          hogStat=GR_NORM;
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
          ///////////////////////////////groundhog      
          
          //heart
          if(lifeCount == 2){
            image(lifeImg,10,10);
            image(lifeImg,80,10);   
            gameState = GAME_RUN;
          }else if(lifeCount == 3){
            image(lifeImg,10,10);
            image(lifeImg,80,10);
            image(lifeImg,150,10);  
            gameState = GAME_RUN;
          }else if(lifeCount == 1){           
            image(lifeImg,10,10); 
            gameState = GAME_RUN;
          }else if(lifeCount <= 0){
           gameState = GAME_LOSE;
           break;
          }  
                  
          //soldier moves
          soldierRandomX = floor(random(7));
          soldierRandomY = floor(random(4));
          image(soldierImg , xSoldier , ySoldier);
          xSoldier = xSoldier+5;
          xSoldier %=640;
          
            
          //soldier and groundhog touch detection
          if(groundhogX < xSoldier+80 &&//hog touch soldier
              groundhogX+80 > xSoldier &&
              groundhogY < ySoldier+80 &&
              groundhogY+80 > ySoldier){
          groundhogX = 4*block;
          groundhogY = block;
          lifeCount -= 1;
          if (lifeCount < 1){
          gameState = GAME_LOSE;
            }
          }
          
          //where's the cabbage 
          float cabfinalX = cabbageRandomX*block;
          float cabfinalY = 2*block+cabbageRandomY*block;
          image(cabbageImg , cabfinalX, cabfinalY);
          
          //eat the cabbage and recover the heart
          if(groundhogX >= cabfinalX && groundhogX + block <= cabfinalX +block
          && groundhogY >= cabfinalY && groundhogY + block <= cabfinalY +block){
            cabbageRandomX = -10;
            cabbageRandomY = -10;
            lifeCount += 1;            
            if (lifeCount > 3){
            lifeCount = 3;
            }  
      //////////////////////////////////////////////////////////////////////////framerate setting   
          //groundhog frame 
          if (downPressed) {
            actionFrame++;
            groundhogYPlus = groundhogY;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogYPlus += block / 15.0;
              image(downImg, groundhogX, groundhogYPlus);
            } else {
              groundhogY = groundhogY + block;
         }
        }
      
          if (rightPressed) {
            actionFrame++;
            groundhogXPlus = groundhogX;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXPlus += block / 15.0;
              image(rightImg, groundhogXPlus, groundhogY);
            } else {
              groundhogX = groundhogX + block;
         }
        }
                
          if (leftPressed) {
            actionFrame++;
            groundhogXPlus = groundhogX;
            if (actionFrame > 0 && actionFrame < 15) {
              groundhogXPlus -= block / 15.0;
              image(leftImg, groundhogXPlus, groundhogY);
            } else {
              groundhogX = groundhogX - block;
         }
        }
 }       
          break;
          ////////////////////////////////////////////////////////////////////////
          
      
    case GAME_LOSE :
      image(gameOverImg, 0, 0);
      image(restartNormalImg, buttonX, buttonY);
      if (mouseX > buttonX && mouseX < buttonX + button_W 
      && mouseY > buttonY && mouseY < buttonY + button_H){ 
        image(restartHoveredImg, buttonX, buttonY);
          if(mousePressed){ 
            lifeCount = 2;
            cabbageRandomX = floor(random(7));
            cabbageRandomY = floor(random(4));
            soldierRandomX = floor(random(7));
            soldierRandomY = floor(random(4));
            groundhogX = 4*block;
            groundhogY = block;
            image(groundhogImg, groundhogX, groundhogY);
            gameState = GAME_RUN;
          }
          break;}
        }}

void keyPressed(){
  if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(groundhogY+block<height&&hogStat==GR_NORM){
          hogStat=GR_DOWN;
          timer=0;
        }
        break;
      case RIGHT:
        if(groundhogX+block<width&&hogStat==GR_NORM){
          hogStat=GR_RIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(groundhogX>0&&hogStat==GR_NORM){
          hogStat=GR_LEFT;
          timer=0;
      break;
    }}
  }
}

void keyReleased(){
}
