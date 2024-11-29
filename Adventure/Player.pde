boolean borderCollision=false;
boolean canGoUp=true;
boolean canGoDown=true;
boolean canGoLeft=true;
boolean canGoRight=true;
boolean anim2;
boolean animup,animdown,animleft,animright;
String collisionSide;
PImage playersprite[] = new PImage[9];
int walktimer;
boolean breakCheck=false;
boolean shouldStore=false;
int amount=0;
int amountCV=0;
int OWx;
int OWy;
int CVspawnX;
int CVspawnY;
boolean regen=false;
boolean regentimer=false;
  int ri=0;
int spritei(){
if(down==true){
return 1;
}else if(left==true){
return 3;
}else if(right==true){
return 5;
}else if(up==true){
return 7;
}else{
return 0;
}
}
class player{
  mob aMob=new mob();
  player() {
    x=10000;
    y=10000;
playersprite[0]=loadImage("frontstand.png");
playersprite[1]=loadImage("frontwalk.png");
playersprite[2]=loadImage("leftstand.png");
playersprite[3]=loadImage("leftwalk.png");
playersprite[4]=loadImage("rightstand.png");
playersprite[5]=loadImage("rightwalk.png");
playersprite[6]=loadImage("backstand.png");
playersprite[7]=loadImage("backwalk.png");
playersprite[8]=loadImage("playerdead.png");
  }
  
     void display(){ 
    if(moveRocket==false){
    if(badend==false){
    if(down==true){
    image(playersprite[0],playerX,playerY);
    }else if(left==true){
    image(playersprite[2],playerX,playerY);
    }else if(right==true){
    image(playersprite[4],playerX,playerY);
    }else if(up==true){
    image(playersprite[6],playerX,playerY);
    }else if(move==false){
    image(playersprite[0],playerX,playerY);
    }
    }
    if(badend==true){
    image(playersprite[8],playerX,playerY);
    }
  }
}

  
  
  void terrainBorder() {
    canGoUp=true;
    canGoDown=true;
    canGoRight=true;
    canGoLeft=true;
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
        if (playerY<=waterBottom &&
            playerY+50>=waterTop &&
            playerX+50>waterLeft &&
            playerX<= waterLeft) {
            canGoRight=false;
            validSpawnOW=false;
            x-=speed;
            for (mob aMob : mobList) {
              aMob.mobX +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from right
         if (playerY<=waterBottom &&
            playerY+50>=waterTop &&
            playerX+50>=waterRight &&
            playerX<= waterRight) {
            canGoLeft=false;
            validSpawnOW=false;
            x+=speed;
            for (mob aMob : mobList) {
              aMob.mobX -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from top
         if (playerY<=waterTop &&
            playerY+50>=waterTop &&
            playerX+50>=waterLeft &&
            playerX<= waterRight) {
            canGoDown=false;
            validSpawnOW=false;
            y-=speed;
            for (mob aMob : mobList) {
              aMob.mobY +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
         //check from bottom
         if (playerY<=waterBottom &&
            playerY+50>=waterBottom &&
            playerX+50>=waterLeft &&
            playerX<= waterLeft) {
            canGoUp=false;
            validSpawnOW=false;
            y+=speed;
            for (mob aMob : mobList) {
              aMob.mobY -=speed;
              //aMob.hitbox();
              //aMob.collision();
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
        if (playerY+2<=rockBottom &&
            playerY+48>=rockTop &&
            playerX+48>rockLeft &&
            playerX+2<= rockLeft) {
            canGoRight=false;
            x-=speed;
            for (mob aMob : mobList) {
              aMob.mobX +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from right
         if (playerY+2<=rockBottom &&
            playerY+48>=rockTop &&
            playerX+48>=rockRight &&
            playerX+2<= rockRight) {
            canGoLeft=false;
            x+=speed;
            for (mob aMob : mobList) {
              aMob.mobX -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from top
         if (playerY+2<=rockTop &&
            playerY+48>=rockTop &&
            playerX+48>=rockLeft &&
            playerX+2<= rockRight) {
            canGoDown=false;

            y-=speed;
            for (mob aMob : mobList) {
              aMob.mobY +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
         //check from bottom
         if (playerY+2<=rockBottom &&
            playerY+48>=rockBottom &&
            playerX+48>=rockLeft &&
            playerX+2<= rockLeft) {
            canGoUp=false;

            y+=speed;
            for (mob aMob : mobList) {
              aMob.mobY -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
        }
      }
    }
  }
  void bushBorder() {
    //water border
    for (int i=0;i<w*h;i++) {
      if (bushXBorder[i]+bushYBorder[i]!=0) {
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
        if (playerY<=bushBottom &&
            playerY+50>=bushTop &&
            playerX+50>bushLeft &&
            playerX<= bushLeft) {
            canGoRight=false;
            x-=speed;
            for (mob aMob : mobList) {
              aMob.mobX +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from right
         if (playerY<=bushBottom &&
            playerY+50>=bushTop &&
            playerX+50>=bushRight &&
            playerX<= bushRight) {
            canGoLeft=false;
            x+=speed;
            for (mob aMob : mobList) {
              aMob.mobX -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from top
         if (playerY<=bushTop &&
            playerY+50>=bushTop &&
            playerX+50>=bushLeft &&
            playerX<= bushRight) {
            canGoDown=false;
            y-=speed;
            for (mob aMob : mobList) {
              aMob.mobY +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
         //check from bottom
         if (playerY<=bushBottom &&
            playerY+50>=bushBottom &&
            playerX+50>=bushLeft &&
            playerX<= bushLeft) {
            canGoUp=false;

            y+=speed;
            for (mob aMob : mobList) {
              aMob.mobY -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
        }
      }
      breakCheck=false;
    }
    
  }
  void caveOWBorder() {
    //water border
    for (int i=0;i<w*h;i++) {
      if (caveXBorder[i]+caveYBorder[i]!=0) {
        int caveLeft= caveXBorder[i];
        int caveRight= caveXBorder[i]+tileSize;
        int caveTop= caveYBorder[i];
        int caveBottom= caveYBorder[i]+tileSize;
        //check from left
        if (playerY+2<=caveBottom &&
            playerY+48>=caveTop &&
            playerX+48>caveLeft &&
            playerX+2<= caveRight) {
            cavedIn=true;
            generateSpawnOW=false;
            validSpawnOW=false;
            OWx=x;
            OWy=y;
            noiseSeed(seedCV);
            checkSpawnCV();
            for(int j=0; j<mobList.size();j++) {
            mobList.remove(j);
            }
            }
            
      }
    }
  }
  
  void blockBreak() {
    for (int i=0;i<w*h;i++) {
      boolean shouldStoreDestroyed=false;
      if (bushXBorder[i]+bushYBorder[i]!=0) {
        int bushLeft= bushXBorder[i];
        int bushRight= bushXBorder[i]+tileSize;
        int bushTop= bushYBorder[i];
        int bushBottom= bushYBorder[i]+tileSize;
  //check from left
        if(playerY-30<=bushBottom &&
          playerY+80>=bushTop &&
          playerX+80>bushLeft &&
          playerX-30<= bushRight && dist(playerX,playerY,coordX[i],coordY[i])>10 && //mitchell
          swing==true) {
          shouldStore=true;
          for (int u=0;u<blockHitAmount;u++) {
            if (coordX[i]==blockDamagedX[u] 
              && coordY[i]==blockDamagedY[u]){
               shouldStore=false;
                blockHealth[u]-=pDamage/4; // mitchell
                if(blockHealth[u]<=0){//mitchell
                  shouldStoreDestroyed=true;
                }
                
               break;
            }
          }
         if (shouldStore==true) {
              blockDamagedX[blockHitAmount]=coordX[i];
              blockDamagedY[blockHitAmount]=coordY[i];
              blockHitAmount++;
              break; 
         }
         if(shouldStoreDestroyed==true) {
           shouldStore=true;
            for (int u=0;u<amount;u++) {
              if (coordX[i]==blockDestroyedX[u] 
                && coordY[i]==blockDestroyedY[u]){
                 shouldStore=false;
                 break;
              }
            }
           if (shouldStore==true) {
                blockDestroyedX[amount]=coordX[i];
                blockDestroyedY[amount]=coordY[i];
                amount++;
                woodAmount++;
                curExp+=1;
                break; 
                
           }
         }
       }
   }
}
for (int i=0;i<w*h;i++) {
      boolean shouldStoreDestroyed=false;
      if (rockXBorder[i]+rockYBorder[i]!=0) {
        int rockLeft= rockXBorder[i];
        int rockRight= rockXBorder[i]+tileSize;
        int rockTop= rockYBorder[i];
        int rockBottom= rockYBorder[i]+tileSize;
  //check from left
        if(playerY-30<=rockBottom &&
          playerY+80>=rockTop &&
          playerX+80>rockLeft &&
          playerX-30<= rockRight && dist(playerX,playerY,coordX[i],coordY[i])>10 && //mitchell
          swing==true) {
          shouldStore=true;
          for (int u=0;u<blockHitAmount;u++) {
            if (coordX[i]==blockDamagedX[u] 
              && coordY[i]==blockDamagedY[u]){
               shouldStore=false;
                blockHealth[u]-=pDamage/6; // mitchell
                if(blockHealth[u]<=0){//mitchell
                  shouldStoreDestroyed=true;
                }
                
               break;
            }
          }
         if (shouldStore==true) {
              blockDamagedX[blockHitAmount]=coordX[i];
              blockDamagedY[blockHitAmount]=coordY[i];
              blockHitAmount++;
              break; 
         }
         if(shouldStoreDestroyed==true) {
           shouldStore=true;
            for (int u=0;u<amount;u++) {
              if (coordX[i]==blockDestroyedX[u] 
                && coordY[i]==blockDestroyedY[u]){
                 shouldStore=false;
                 break;
              }
            }
           if (shouldStore==true) {
                blockDestroyedX[amount]=coordX[i];
                blockDestroyedY[amount]=coordY[i];
                amount++;
                stoneAmount++;
                curExp+=2;
                break; 
                
           }
         }
       }
   }
}
    
    
  }
  void caveBorder(){
  for (int i=0;i<w*h;i++) {
      if (cavewallXBorder[i]+cavewallYBorder[i]!=0) {
        int cavewallLeft= cavewallXBorder[i];
        int cavewallRight= cavewallXBorder[i]+tileSize;
        int cavewallTop= cavewallYBorder[i];
        int cavewallBottom= cavewallYBorder[i]+tileSize;
        for (int k=0;k<blockDestroyedAmountCV;k++) {
                if (blockDestroyedXCV[k]==coordX[i] && blockDestroyedYCV[k]==coordY[i]) {
                  breakCheck=true;
                  break;
                }
              }
        if (breakCheck==false) {
        //check from left
        if (playerY<=cavewallBottom &&
            playerY+50>=cavewallTop &&
            playerX+50>cavewallLeft &&
            playerX<= cavewallLeft) {
            canGoRight=false;
            x-=speed;
            for (mob aMob : mobList) {
              aMob.mobX +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from right
         if (playerY<=cavewallBottom &&
            playerY+50>=cavewallTop &&
            playerX+50>=cavewallRight &&
            playerX<= cavewallRight) {
            canGoLeft=false;
            x+=speed;
            for (mob aMob : mobList) {
              aMob.mobX -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
         }
         
         //check from top
         if (playerY<=cavewallTop &&
            playerY+50>=cavewallTop &&
            playerX+50>=cavewallLeft &&
            playerX<= cavewallRight) {
            canGoDown=false;

            y-=speed;
            for (mob aMob : mobList) {
              aMob.mobY +=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
         //check from bottom
         if (playerY<=cavewallBottom &&
            playerY+50>=cavewallBottom &&
            playerX+50>=cavewallLeft &&
            playerX<= cavewallLeft) {
            canGoUp=false;

            y+=speed;
            for (mob aMob : mobList) {
              aMob.mobY -=speed;
              //aMob.hitbox();
              //aMob.collision();
            }
            
         }
         
        }
      }
      breakCheck=false;
    }
  }

  
  void blockBreakCV() {
    
    for (int i=0;i<w*h;i++) {
      boolean shouldStoreDestroyed=false;
      if (cavewallXBorder[i]+cavewallYBorder[i]!=0) {
        int cavewallLeft= cavewallXBorder[i];
        int cavewallRight= cavewallXBorder[i]+tileSize;
        int cavewallTop= cavewallYBorder[i];
        int cavewallBottom= cavewallYBorder[i]+tileSize;
  //check from left
        if(playerY-30<=cavewallBottom &&
          playerY+80>=cavewallTop &&
          playerX+80>cavewallLeft &&
          playerX-30<= cavewallRight && dist(playerX,playerY,coordX[i],coordY[i])>10 && //mitchell
          swing==true) {
          shouldStore=true;
          for (int u=0;u<blockHitAmountCV;u++) {
            if (coordX[i]==blockDamagedXCV[u] 
              && coordY[i]==blockDamagedYCV[u]){
               shouldStore=false;
                blockHealthCV[u]-=pDamage/10; // mitchell
                if(blockHealthCV[u]<=0){//mitchell
                  shouldStoreDestroyed=true;
                }
                
               break;
            }
          }
         if (shouldStore==true) {
              blockDamagedXCV[blockHitAmountCV]=coordX[i];
              blockDamagedYCV[blockHitAmountCV]=coordY[i];
              blockHitAmountCV++;
              break; 
         }
         if(shouldStoreDestroyed==true) {
           shouldStore=true;
            for (int u=0;u<amountCV;u++) {
              if (coordX[i]==blockDestroyedXCV[u] 
                && coordY[i]==blockDestroyedYCV[u]){
                 shouldStore=false;
                 break;
              }
            }
           if (shouldStore==true) {
                blockDestroyedXCV[amountCV]=coordX[i];
                blockDestroyedYCV[amountCV]=coordY[i];
                amountCV++;
                stoneAmount++;
                curExp+=3;
                break; 
                
           }
         }
       }
   }
}
    
    
  }
  
  void movement() {
    
    if (up==true && canGoUp==true) {
      y -= speed;
      for (mob aMob : mobList) {
          aMob.mobY +=speed;
          //aMob.hitbox();
          //aMob.collision();
        }
      
    }
    if (down==true && canGoDown==true) {
      y += speed;
      for (mob aMob : mobList) {
          aMob.mobY -=speed;
          //aMob.hitbox();
          //aMob.collision();
        }
      
    }
    if (left==true && canGoLeft==true) {
      x -= speed;
      for (mob aMob : mobList) {
          aMob.mobX +=speed;
          //aMob.hitbox();
          //aMob.collision();
        }
      
    }
    if (right==true && canGoRight==true) {
      x += speed;
      for (mob aMob : mobList) {
          aMob.mobX -=speed;
          //aMob.hitbox();
          //aMob.collision();
        }

    }
    
    
    
  }
  
  
}
void keyPressed() {
  if(key == 'y'){
  if(prompting==true){
  deci1=true;
  }
  }if(key == 'n'){
  if(prompting==true){
  deci2=true;
  }
  }
  if(key == 'o') {
    noiseSeed(millis());
    mobList.add(new mob());
  }
  if(key == 'j'){
  if((heartAmount>=1)&&(pHealth<100)){
  pHealth=pHealth+10;
  heartAmount--;
  }
  }
  if(key == 'k'){
  if((woodAmount>=2)&&(stoneAmount>=1)&&(pShield<50)){
  pShield=pShield+10;
  woodAmount-=2;
  stoneAmount-=1;
  }
  }
  if(key == 'l'){
  if((woodAmount>=20)&&(stoneAmount>=20)&&(heartAmount>=10)&&(boneAmount>=10)){
  gameover=true;
  rocketcutscene=true;
  }
  }
  
  if(key == ' '){
  swing=true;
  swingStop=false;
  }
  //////////MENU
  if(key == 'l' && mainMenu==true) {
    exit();
  }
  if(key == 'j' && mainMenu==true) {
    seed=int(random(2,100000));//3671
    exposition=true;
    seedCV=seed-1;
    pHealth=100;
    pShield=50;
    gameover=false;
    badend=false;
    noiseSeed(seed);
    println(seed);
    generateSpawnOW=false;
    validSpawnOW=false;
    checkSpawn();
    GameScreen=true;
    mainMenu=false;
    
  }
  
  if(key == 'm' && PauseScreen==true) {
    PauseScreen=false;
    GameScreen=false;
    mainMenu=true;
    spawnedImage=false;
  }
  if(key == 'p' && mainMenu==true) {
    GameScreen=true;
    mainMenu=false;
  }
  else if(key == 'p' && GameScreen==true && mainMenu==false) {
    PauseScreen=true;
    GameScreen=false;
    spawnedImage=false;
  }
  else if(key == 'p' && GameScreen==false && mainMenu==false) {
    PauseScreen=false;
    GameScreen=true;
    spawnedImage=false;
  }
  ///////////////////
  if(key == 'w') {
    animdown=false;
    animright=false;
    animleft=false;
    animup=true;
    if(prompting==false){
    up=true;
    upL=true;
    }
  }
  if(key == 's') {
    animup=false;
    animleft=false;
    animright=false;
    animdown=true;
    if(prompting==false){
    down=true;
    downL=true;
    }
  }
  if(key == 'a') {
    animright=false;
    animdown=false;
    animup=false;
    animleft=true;
    if(prompting==false){
    left=true;
    leftL=true;
    }
  }
  if(key == 'd') {
    animleft=false;
    animup=false;
    animdown=false;
    animright=true;
    if(prompting==false){
    right=true;
    rightL=true;
    }
  }
  if (key != 'w' && key != 's' && key != 'a' && key != 'd') {
    move=false;
    moveTimer=0;
  }
  else {
    move=true;
  }
}
void keyReleased() {
  if(key == 'w') {
    up=false;
    move=false;
    upL=false;
    speedX=0;
    speedY=0;
    shipFire=false;
  }
  if(key == 's') {
    down=false;
    move=false;
    downL=false;
  }
  if(key == 'a') {
    left=false;
    move=false;
    leftL=false;
    shipFirerightL=false;
  }
  if(key == 'd') {
    right=false;
    move=false;
    rightL=false;
    shipFireleftL=false;
  }
  if (key == ' ') {
    swingStop=true;
    
  }
}
