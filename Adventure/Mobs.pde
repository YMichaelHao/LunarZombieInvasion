
class mob{ 
  //collided boolean
  boolean collided=false;
  //position values
  int mobX;
  int mobY;
  PImage mobsprites[]=new PImage[4];//mitchell
  PImage cmobsprites[]=new PImage[4];//mitchell
  //hitboxes
  int left;
  int right;
  int bottom;
  int top;
  //movement timers
  int timer=0;
  int timeReset=int(random(15,45));;
  //movement booleans
  boolean Up=false;
  boolean Down=false;
  boolean Right=false;
  boolean Left=false;
  
  boolean hitCoolDown=false;
  boolean whacked=false;
  int whackedTimer; 
  
  int cdtimer=0;
  
  int mobHealth;//mitchell
  int mobStartHealth;//mitchell
  boolean checkoob=false;
  int oobtimer=0;
  
  //check if image has been drawn
  boolean showedImage=false;
  
  
  mob() {
    //randimizes where it should spawn
    int RandomSpawn = int(random(1,5));
    if (RandomSpawn ==1) {
      mobX= int(random(2050));
      mobY = -200;
    }

    if (RandomSpawn ==2) {
      mobX= int(random(2050));
      mobY = 1150;
    }

    if (RandomSpawn ==3) {
      mobX= -200;
      mobY = int(random(1150));
    }

    if (RandomSpawn ==4) {
      mobX= 2050;
      mobY = int(random(1150));
    }
    mobsprites[0]=loadImage("mobfront.png");
    mobsprites[1]=loadImage("mobback.png");
    mobsprites[2]=loadImage("mobleft.png");
    mobsprites[3]=loadImage("mobright.png");
    cmobsprites[0]=loadImage("skelfront.png");
    cmobsprites[1]=loadImage("skelback.png");
    cmobsprites[2]=loadImage("skelleft.png");
    cmobsprites[3]=loadImage("skelright.png");
    if(cavedIn==true){
    mobStartHealth=int(random(200,400));
    }else{
    mobStartHealth=int(random(100,200));
    }
    mobHealth=mobHealth+mobStartHealth;
  }
  
  public void BotMove() {
    stroke(255,0,0);
    fill(255,0,0);
  //  if (timer>=timeReset) {
    showedImage=false;
    if (Down==true) {
      mobY+=4;
      //rect(mobX,mobY,50,50);
      showedImage=true;
    }
    if (Left==true ) {
      mobX-=4;
      //rect(mobX,mobY,50,50);
      showedImage=true;
    }

    if (Right==true ) {
      mobX+=4;
      //rect(mobX,mobY,50,50);
      showedImage=true;
    }

    if (Up==true ) {
      mobY-=4;
      //rect(mobX,mobY,50,50);
      showedImage=true;
    }
  //  }
      //rect(mobX,mobY,50,50);
    Animation();
  }

  void display(){//mitchell
  if(Down==true){
  if(cavedIn==false){
  image(mobsprites[0],mobX,mobY);
  }else{
  image(cmobsprites[0],mobX,mobY);
  }
  }else if(Left==true){
  if(cavedIn==false){
  image(mobsprites[2],mobX,mobY);
  }else{
  image(cmobsprites[2],mobX,mobY);
  }
  }else if(Right==true){
  if(cavedIn==false){
  image(mobsprites[3],mobX,mobY);
  }else{
  image(cmobsprites[3],mobX,mobY);
  }
  }else if(Up==true){
  if(cavedIn==false){
  image(mobsprites[1],mobX,mobY);
  }else{
  image(cmobsprites[1],mobX,mobY);
  }
  }

  }
  public void Animation() {
    //probability ints
    int probX=1;
    int probY=1;
    int prob=1;
    //animation odds
    int AnimationThing;
    //after certain amount of time, enemy will reroll direction
    if (timer>=timeReset) {
      Left=false;
      Right=false;
      Down=false;
      Up=false;
      //if player in certain direction, enemy will have influence to go in that direction

      if (playerX>=mobX) {
          probX=15;
      }

      if (playerY>=mobY) {
          probY=15;
      }

      if (playerX<mobX) {
          probX=85;
      }

      if (playerY<mobY) {
          probY=85;
      }

      //intializes odds
      AnimationThing=int(random(0,100));
      prob = int(random(1,3));
      if (AnimationThing>=probX  && prob==1) {
          Right=true;
      }

      if (AnimationThing>=probY && prob==2) {
          Down=true;
      }

      if (AnimationThing<probX && prob==1) {
          Left=true;
      }

      if (AnimationThing<probY && prob==2) {
          Up=true;
      }
      //timer reset
      timer=0;
      timeReset=int(random(5,30));
    }
    timer++;
}

  void terrainBorder() {
    //an attempt to stop stutter
    xRO = x % tileSize+500;
    yRO = y % tileSize+500;
    for(int i = 0; i < w; i ++) {
      for(int j = 0; j < h; j ++) {
        if (tiles[i + j * w]==0) {
          waterXBorder[j+i*h]=(i) * tileSize - xRO;
          waterYBorder[j+i*h]=(j) * tileSize - yRO;
        }
        if (tiles[i + j * w]==4) {
        rockXBorder[j+i*h]=(i) * tileSize - xRO;
        rockYBorder[j+i*h]=(j) * tileSize - yRO;
        }
        if (tiles[i + j * w]==3) {
          bushXBorder[j+i*h]=(i) * tileSize - xRO;
          bushYBorder[j+i*h]=(j) * tileSize - yRO;
        }
      }
    }
    /////
  }

  void waterBorder() {
    //water border
    for (int i=0;i<w*h;i++) {
      if (waterXBorder[i]+waterYBorder[i]!=0) {
        int waterLeft= waterXBorder[i];
        int waterRight= waterXBorder[i]+tileSize;
        int waterTop= waterYBorder[i];
        int waterBottom= waterYBorder[i]+tileSize;
        //check from left
        if (mobY<=waterBottom &&
            mobY+50>=waterTop &&
            mobX+50>waterLeft &&
            mobX<= waterLeft) {
            mobX-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from right
         if (mobY<=waterBottom &&
            mobY+50>=waterTop &&
            mobX+50>=waterRight &&
            mobX<= waterRight) {
            mobX+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from top
         if (mobY<=waterTop &&
            mobY+50>=waterTop &&
            mobX+50>=waterLeft &&
            mobX<= waterRight) {
            mobY-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from bottom
         if (mobY<=waterBottom &&
            mobY+50>=waterBottom &&
            mobX+50>=waterLeft &&
            mobX<= waterLeft) {
            mobY+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         if(checkoob==true){//mitchell
         oobtimer++;
         }else{
         oobtimer+=0;
         }
         if((oobtimer>=180)){
         if(checkoob==true){
         mobHealth-=mobHealth;
         }
         }
      }
    }
  }

  void rockBorder() {
    //water border
    for (int i=0;i<w*h;i++) {
      if (rockXBorder[i]+rockYBorder[i]!=0) {
        breakCheck=false;
        for (int k=0;k<blockDestroyedAmount;k++) {
                if (blockDestroyedX[k]==coordX[i] && blockDestroyedY[k]==coordY[i]) {
                  breakCheck=true;
                  break;
                }
              }
              
        if (breakCheck==false) {
        int rockLeft= rockXBorder[i];
        int rockRight= rockXBorder[i]+tileSize;
        int rockTop= rockYBorder[i];
        int rockBottom= rockYBorder[i]+tileSize;
        //check from left
        if (mobY<=rockBottom &&
            mobY+50>=rockTop &&
            mobX+50>rockLeft &&
            mobX<= rockLeft) {
            mobX-=speed;
         }
         //check from right
         if (mobY<=rockBottom &&
            mobY+50>=rockTop &&
            mobX+50>=rockRight &&
            mobX<= rockRight) {
            mobX+=speed;
         }
         //check from top
         if (mobY<=rockTop &&
            mobY+50>=rockTop &&
            mobX+50>=rockLeft &&
            mobX<= rockRight) {
            mobY-=speed;
         }
         //check from bottom
         if (mobY<=rockBottom &&
            mobY+50>=rockBottom &&
            mobX+50>=rockLeft &&
            mobX<= rockLeft) {
            mobY+=speed;
         }
      }
      }
    }
  }

  void bushBorder() {
    //water border
    for (int i=0;i<w*h;i++) {
      if (bushXBorder[i]+bushYBorder[i]!=0) {
        breakCheck=false;
        for (int k=0;k<blockDestroyedAmount;k++) {
                if (blockDestroyedX[k]==coordX[i] && blockDestroyedY[k]==coordY[i]) {
                  breakCheck=true;
                  break;
                }
              }
              
        if (breakCheck==false) {
        int bushLeft= bushXBorder[i];
        int bushRight= bushXBorder[i]+tileSize;
        int bushTop= bushYBorder[i];
        int bushBottom= bushYBorder[i]+tileSize;
        //check from left
        if (mobY<=bushBottom &&
            mobY+50>=bushTop &&
            mobX+50>bushLeft &&
            mobX<= bushLeft) {
            mobX-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from right
         if (mobY<=bushBottom &&
            mobY+50>=bushTop &&
            mobX+50>=bushRight &&
            mobX<= bushRight) {
            mobX+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from top
         if (mobY<=bushTop &&
            mobY+50>=bushTop &&
            mobX+50>=bushLeft &&
            mobX<= bushRight) {
            mobY-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from bottom
         if (mobY<=bushBottom &&
            mobY+50>=bushBottom &&
            mobX+50>=bushLeft &&
            mobX<= bushLeft) {
            mobY+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         if(checkoob==true){//mitchell
         oobtimer++;
         }else{
         oobtimer+=0;
         }
         if((oobtimer>=180)){
         if(checkoob==true){
         mobHealth-=mobHealth;
         }
         }
      }
      }
    }
  }
    void mobWhack(){//mitchell
    strokeWeight(10);
    if(cavedIn==false){
    rect(mobX,mobY-20,mobHealth/2,5);
    }else{
    rect(mobX,mobY-20,mobHealth/4,5);
    }
    if(mobX<=playerX+50 &&
       mobX+50>=playerX &&
       mobY<=playerY+50 &&
       mobY+50>=playerY &&
       dist(playerX,playerY,mobX,mobY)>10 &&
       (swing==true)){
       whacked=true;
       mobHealth-=pDamage;//-(player experience level)
       if(mobHealth<=0 && cavedIn==false){
         curExp+=5;
         heartAmount++;
       }
       if(mobHealth<=0 && cavedIn==true){
         curExp+=10;
         boneAmount++;
       }
       
       }
       if(mobX<=playerX+50 &&
       mobX+50>=playerX &&
       mobY<=playerY+50 &&
       mobY+50>=playerY &&
       dist(playerX,playerY,mobX,mobY)>5 &&
       (whacked==false)){
       if(pShield>0){
       pShield--;
       }else{
       pHealth--;
       }
       }
       if(pHealth<=0){
       gameover=true;
       badend=true;
       }
    }
boolean mobDied(){//mitchell
if(mobHealth<=0){
return true;
}else{
return false;
}
}

void stunned() {
  whackedTimer++;
  if (whackedTimer>=30) {
    whacked=false;
  }
  
  
  
}
    void cavewallBorder(){ //mitchell
      for (int i=0;i<w*h;i++) {
      if (cavewallXBorder[i]+cavewallYBorder[i]!=0) {
        breakCheck=false;
        for (int k=0;k<blockDestroyedAmount;k++) {
                if (blockDestroyedX[k]==coordX[i] && blockDestroyedY[k]==coordY[i]) {
                  breakCheck=true;
                  break;
                }
              }
              
        if (breakCheck==false) {
        int cavewallLeft= cavewallXBorder[i];
        int cavewallRight= cavewallXBorder[i]+tileSize;
        int cavewallTop= cavewallYBorder[i];
        int cavewallBottom= cavewallYBorder[i]+tileSize;
  //check from left
        if (mobY<=cavewallBottom &&
            mobY+50>=cavewallTop &&
            mobX+50>cavewallLeft &&
            mobX<= cavewallLeft) {
            mobX-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from right
         if (mobY<=cavewallBottom &&
            mobY+50>=cavewallTop &&
            mobX+50>=cavewallRight &&
            mobX<= cavewallRight) {
            mobX+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from top
         if (mobY<=cavewallTop &&
            mobY+50>=cavewallTop &&
            mobX+50>=cavewallLeft &&
            mobX<= cavewallRight) {
            mobY-=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         //check from bottom
         if (mobY<=cavewallBottom &&
            mobY+50>=cavewallBottom &&
            mobX+50>=cavewallLeft &&
            mobX<= cavewallLeft) {
            mobY+=speed;
            checkoob=true;
         }else{
         checkoob=false;
         }
         if(checkoob==true){//mitchell
         oobtimer++;
         }else{
         oobtimer+=0;
         }
         if((oobtimer>=180)){
         if(checkoob==true){
         mobHealth-=mobHealth;
         }
         }
      }
    }
}
}
}
