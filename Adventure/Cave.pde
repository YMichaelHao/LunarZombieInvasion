boolean cavedIn;
int cavewallXBorder[];
int cavewallYBorder[];
int caveEntranceX[];
int caveEntranceY[];
boolean caveEntranceSpawn=false;
int blockHitAmountCV;
boolean blockDestroyedCV[];
boolean blockDamagedCV[];
int blockDestroyedAmountCV=10000;
int blockDestroyedXCV[];
int blockDestroyedYCV[];
int blockDamagedXCV[];
int blockDamagedYCV[];

float blockOpacityShowCV[];
int blockHealthCV[];
class cave{
  cave() {
    cavewallXBorder = new int[(w) * (h)];
    cavewallYBorder = new int[(w) * (h)];
    tiles = new int[(w) * (h)];
    sprites[5] = loadImage("cavefloor.png");
    sprites[6] = loadImage("cavewall.png");
    blockDestroyedXCV = new int[blockDestroyedAmountCV];
    blockDestroyedYCV = new int[blockDestroyedAmountCV];
    blockDestroyedCV = new boolean[blockDestroyedAmountCV];
    blockDamagedXCV = new int[blockDestroyedAmountCV];
    blockDamagedYCV = new int[blockDestroyedAmountCV];
    blockDamagedCV = new boolean[blockDestroyedAmountCV];
    blockOpacityShowCV = new float[blockDestroyedAmountCV];
    blockHealthCV = new int[blockDestroyedAmountCV];//mitchell
    for(int i=0;i<blockDestroyedAmountCV;i++){//mitchell
    blockHealthCV[i]=50;

    }
  }
  void drawTerrain() {
  scl=0.0275;
  background(30);
  //buffer
  xRO = x % tileSize+500;
  yRO = y % tileSize+500;
  xTO = (int)x/tileSize;
  yTO = (int)y/tileSize;
  for(int i = 0; i < w; i ++) {
    for(int j = 0; j < h; j ++) {
      tiles[i + j * w] = getTile(i, j);
    }
  }
  for (int i=0;i<w*h;i++) {
    cavewallXBorder[i]=0;
    cavewallYBorder[i]=0;
    blockDestroyedCV[i]=false;
    blockDamagedCV[i]=false;
  }
  for(int i = 0; i < w; i ++) {
    
    for(int j = 0; j < h; j ++) {
      coordX[cc2]=x+(i) * tileSize - xRO;
      coordY[cc2]=y+(j) * tileSize - yRO;
      cc2++;
    }
  }
  cc2=0;
  for (int i=0;i<w*h;i++) {
    for (int k=0;k<blockHitAmountCV;k++) {
      if (blockDamagedXCV[k]==coordX[i] && blockDamagedYCV[k]==coordY[i] && blockDestroyedCV[i]==false) {
        blockDamagedCV[i]=true;
        blockOpacityShowCV[i]=blockHealthCV[k]*2+tint-100;
        break;
      }
    }
  }
  for (int i=0;i<w*h;i++) {
    for (int k=0;k<blockDestroyedAmountCV;k++) {
      if (blockDestroyedXCV[k]==coordX[i] && blockDestroyedYCV[k]==coordY[i]) {
        blockDestroyedCV[i]=true;
        break;
      }
    }
  }
  for(int i = 0; i < w; i ++) {
    for(int j = 0; j < h; j ++) {
      coordX[cc]=x+(i) * tileSize - xRO;
      coordY[cc]=y+(j) * tileSize - yRO;
      if (blockDestroyedCV[cc]==true) {
        //(tint,tileOpac[i]); //mitchell
        tint(tint,255);
        image(sprites[5], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        
      }
      else if (blockDamagedCV[cc]==true) {
        tint(tint,blockOpacityShowCV[cc]);
        image(sprites[tiles[i + j * w]], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        tint(tint,255);
      }
      else {
        tint(tint,255);
        image(sprites[tiles[i + j * w]], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        
      }
      if (tiles[i + j * w]==6) {
        cavewallXBorder[j+i*h]=(i) * tileSize - xRO;
        cavewallYBorder[j+i*h]=(j) * tileSize - yRO;
      }
      cc++;
    }
    
  }
  cc=0;
}
void caveSpawnBorder() {
    //water border
    fill(255,255,255,50);
    stroke(255,255,255,50);
    strokeWeight(0);
    ellipse(CVspawnX-x+950,CVspawnY-y+550,75,75);
    
    if (playerY<=CVspawnY-y+587 &&
      playerY+50>=CVspawnY-y+513 &&
      playerX+50>CVspawnX-x+913 &&
      playerX<= CVspawnX-x+987) {
      cavedIn=false;
      validSpawnCV=false;
      generateSpawnCV=false;
      noiseSeed(seed);
      x=OWx;
      y=OWy;
      t.drawTerrain();
      checkSpawn();
      transitionScreen=true;
      for(int j=0; j<mobList.size();j++) {
      mobList.remove(j);
      }
   }
   
  }


int getTile(int x, int y) {
  float v = noise((xTO + x) * scl, (yTO + y) * scl);
  if(cavedIn==false){
  if(v < 0.35) {
    //water
    return 0;
  } 
  else if(v < 0.42) {
    //sand
    return 1;
  } 
  else if(v<0.559) {
    return 2;
    
  }
  else if(v<0.56) {
    return 4;
    
  }
  else if(v < 0.6) {
    //grass
    return 2;
  } 
  else {
    //plant
    return 3;
  }
}else{
if(v<0.45){
return 6;
}else if(v<0.6){
return 5;
}else{
return 6;
}
}

}
}
 
