class rain{
//rain number
int rainNum = 200;
//rain arrays
float[] rainX= new float[rainNum];
float[] rainY= new float[rainNum];
int[] rainProb= new int[rainNum];
int[] rainSpeed= new int[rainNum];
int[] rainSize= new int[rainNum];
float[] rainsizeX= new float[rainNum];
int[] rainColor= new int[rainNum];
boolean[] rainGo=new boolean[rainNum];
//rainTimer for when rain drops
int[] lightning=new int[rainNum];
int lightningTimer;
int rainTimer;
int sizeX;
int sizeY;
rain() {
  sizeX=1850;
  sizeY=950;
  //intializing stored values
  for (int i=0;i<rainNum;i++) {
    //rain coords
    rainX[i]=int(random(sizeX));
    rainY[i]=-20*sizeY/500;
    //probability of rain spawn
    rainProb[i]=int(random(0,10000));
    //rain values
    rainSpeed[i]=int(random(5*sizeY/500,15*sizeY/500));
    rainSize[i]=int(random(5*sizeY/500,15*sizeY/500));
    rainsizeX[i]=rainSpeed[i]/5;
    rainColor[i]=int(800/(rainSpeed[i]*500/sizeY));
    //lightning
    lightning[i]=int(random(170000));
  }
}



void rainGo() {
  //draws rain
  for (int i=0;i<rainNum;i++) {
    //rain probability of spawn
    if (rainProb[i]==rainTimer) {
      rainGo[i]=true;
    }
    //if raingo=true rain will draw
    if (rainGo[i]==true) {
      fill(100,100,abs(300-rainColor[i]));
      stroke(100,100,abs(300-rainColor[i]));
      strokeWeight(rainsizeX[i]);
      line(rainX[i],rainY[i],rainX[i],rainY[i]-rainSize[i]);
      rainY[i]+=rainSpeed[i];
    }
    //rain probability
    if (rainProb[i]>=60) {
      rainProb[i]=int(random(0,100000));
      
    }
    //resets rain
    if (rainY[i]>=520*sizeY/500) {
      rainGo[i]=false;
      rainX[i]=random(int(sizeX));
      rainY[i]=0;
      rainSpeed[i]=int(random(5*sizeY/500,15*sizeY/500));
      rainSize[i]=int(random(10*sizeY/500,20*sizeY/500));
      rainsizeX[i]=rainSpeed[i]/5;
      rainColor[i]=int(800/(rainSpeed[i]*500/sizeY));
    }
    //if lightning=1 then this runs
    if (lightning[i]==1) {
      stroke(255);
      background(0);
      lightningTimer++;
      strokeWeight(50);
      line(int(random(sizeX)),-20,int(random(sizeX)),520*sizeY/500);
      //lightning duration
      if (lightningTimer>=15) {
        lightning[i]=int(random(200000));
        lightningTimer=0;
      }
    }
    else {
      lightning[i]=int(random(200000));
    }
  }
  //rainTimer
  rainTimer++;
  if (rainTimer>=60) {
    rainTimer=0;
  }
}
}
