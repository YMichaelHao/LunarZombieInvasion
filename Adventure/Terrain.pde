int tileSize = 50;
float scl = 0.02;
PImage[] sprites = new PImage[8];
int xRO, yRO, xTO, yTO, x, y;
int w, h;
int[] tiles;

int coordX[];
int coordY[];
int cc=0;
int cc2=0;

int blockHitAmount=0;
float blockOpacityShow[];


boolean blockDestroyed[];
boolean blockDamaged[];
int blockDestroyedAmount=10000;
int blockDestroyedX[];
int blockDestroyedY[];
int blockDamagedX[];
int blockDamagedY[];
int waterXBorder[];
int waterYBorder[];
int bushXBorder[];
int bushYBorder[];
int rockXBorder[];
int rockYBorder[];
int caveXBorder[];
int caveYBorder[];

PImage water1;
PImage water2;
boolean waterSwitch;
int waterTimer;
float tint=125;
boolean tintChange=false;
float blockHealth[];//mitchell
int tileOpac[];//mitchell


class terrain {
  terrain() {
    sprites[1] = loadImage("sand.png");
    sprites[2] = loadImage("grass.png");
    sprites[3] = loadImage("plant.png"); 
    sprites[4] = loadImage("stone.png"); 
    sprites[7] = loadImage("CaveEntrance.png");
    water1  = loadImage("water.png");
    water2  = loadImage("water2.png");
    sprites[0]=water1;
    w = width/tileSize+20;
    h = height/tileSize+20;
    tiles = new int[(w) * (h)];
    waterXBorder = new int[(w) * (h)];
    waterYBorder = new int[(w) * (h)];
    bushXBorder = new int[(w) * (h)];
    bushYBorder = new int[(w) * (h)];
    rockXBorder = new int[(w) * (h)];
    rockYBorder = new int[(w) * (h)];
    coordX = new int[(w) * (h)];
    coordY = new int[(w) * (h)];
    blockDestroyedX = new int[blockDestroyedAmount];
    blockDestroyedY = new int[blockDestroyedAmount];
    blockDestroyed = new boolean[blockDestroyedAmount];
    blockDamagedX = new int[blockDestroyedAmount];
    blockDamagedY = new int[blockDestroyedAmount];
    blockDamaged = new boolean[blockDestroyedAmount];
    blockOpacityShow = new float[blockDestroyedAmount];
    caveXBorder = new int[(w) * (h)];
    caveYBorder = new int[(w) * (h)];
    blockHealth = new float[blockDestroyedAmount];//mitchell
    for(int i=0;i<blockDestroyedAmount;i++){//mitchell
    blockHealth[i]=50;

    }
  }
  
  void waterChange() {
  if (waterTimer>=30 && waterSwitch==false) {
    sprites[0]=water1;
    waterTimer=0;
    waterSwitch=true;
  }
  else if (waterTimer>=30 && waterSwitch==true) {
    sprites[0]=water2;
    waterTimer=0;
    waterSwitch=false;
    
  }
  waterTimer++;
  }
  
  void nightday() {
  if (tint>=150 || tintChange==true) {
    tint-=0.1;
    tintChange=true;
  }
  if (tint<=100 || tintChange==false) {
  tint+=0.1;
  tintChange=false;
  }
    
  }
  void drawTerrain() {
    
  scl=0.02;
  
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
    waterXBorder[i]=0;
    waterYBorder[i]=0;
    rockXBorder[i]=0;
    rockYBorder[i]=0;
    bushXBorder[i]=0;
    bushYBorder[i]=0;
    caveXBorder[i]=0;
    caveYBorder[i]=0;
    blockDestroyed[i]=false;
    blockDamaged[i]=false;
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
    for (int k=0;k<blockHitAmount;k++) {
      if (blockDamagedX[k]==coordX[i] && blockDamagedY[k]==coordY[i] && blockDestroyed[i]==false) {
        blockDamaged[i]=true;
        blockOpacityShow[i]=blockHealth[k]*2+tint-100;
        break;
      }
    }
  }
  for (int i=0;i<w*h;i++) {
    for (int k=0;k<amount;k++) {
      if (blockDestroyedX[k]==coordX[i] && blockDestroyedY[k]==coordY[i]) {
        blockDestroyed[i]=true;
        break;
      }
    }
  }
  
  for(int i = 0; i < w; i ++) {
    for(int j = 0; j < h; j ++) {
      coordX[cc]=x+(i) * tileSize - xRO;
      coordY[cc]=y+(j) * tileSize - yRO;
      if (blockDestroyed[cc]==true) {
        //(tint,tileOpac[i]); //mitchell
        tint(tint,255);
        image(sprites[2], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        
      }
      else if (blockDamaged[cc]==true) {
        tint(tint,blockOpacityShow[cc]);
        image(sprites[tiles[i + j * w]], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        tint(tint,255);
      }
      else {
        tint(tint,255);
        image(sprites[tiles[i + j * w]], (i) * tileSize - xRO, (j) * tileSize - yRO, tileSize, tileSize);
        
      }

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
      if (tiles[i + j * w]==7) {
        caveXBorder[j+i*h]=(i) * tileSize - xRO;
        caveYBorder[j+i*h]=(j) * tileSize - yRO;
      }
      cc++;
    }
    
  }
  cc=0;
  
  
}

void minimap() {
  ///potential minimap
  for(int i = 0; i < w; i ++) {
    for(int j = 0; j < h; j ++) {
      tint(255);
      
      image(sprites[tiles[i + j * w]], (i)*5 - xRO/tileSize+60, (j)*5 - yRO/tileSize+60, 5, 5);
      
    }
  }
  tint(tint);
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
  else if(v<0.77){
    //plant
    return 3;
  }
  else if(v<0.79) {
    return 2;
  }
  else {
    return 7;
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
