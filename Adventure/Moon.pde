//moon terrain variables
int[] prevLineX=new int[300];
int[] prevLineY=new int[300];
int[] lineX=new int[300];
int[] lineY=new int[300];
int newX;
int newY;
int landingZone;
int landingX1;
int landingY1;
int landingX2;
int landingY2;
//peak and min of terrain
int peak;
int min;
boolean changed=false;
//star variables
int[] starX = new int[150];
int[] starY = new int[150];



boolean peaked=false;
class moon{
  moon() {
    //generates landing zone
    landingZone=int(random(50,150));
    //generates first peak
    peak = int(random(400,650));
    //generates first line for terrain
    lineY[0]=int(random(600,700));
    lineX[0]=-30;
    //generates star
    for (int i=0;i<150;i++) {
      starX[i]=int(random(1500));
      starY[i]=int(random(750));
    }
    //generates terrain
    for (int i=1;i<300;i++) {

      if (i==landingZone) {
        newX=int(random(75,150));
      }
      else if (peaked==false) {
      newX=int(random(15));
      newY=int(random(10));
      }
      else if (peaked==true) {
        
        newX=int(random(15));
        newY=int(random(-10,0));
        
      }
      if (changed==false) {
          min=peak+int(random(700-peak));
          changed=true;
        }
      prevLineX[i]=lineX[i-1];
      prevLineY[i]=lineY[i-1];
      lineX[i]=prevLineX[i]+newX;
      lineY[i]=prevLineY[i]-newY;
      if (peaked==false && lineY[i]<=peak) {
        peaked=true;
        changed=false;
      }
      if (peaked==true && lineY[i]>=min) {
        peak=min-int(random(300));
        peaked=false;
      } 
    }
  }
void onMoon() {
  background(0);
  //draws stars
  for (int i=0;i<150;i++) {
    for (int j=0; j<300;j++) {
      fill(255);
      stroke(255);
      if((starY[i]<=lineY[j])&&(starX[i]>=prevLineX[j])&&(starX[i]<=lineX[j])) {
        line(starX[i],starY[i],starX[i]+1,starY[i]+1);
      }
    }
    }
    //draws terrain
  for (int i=0;i<300;i++) {
    stroke(255);
    if (i==landingZone) {
      stroke(255,0,0);
    }
    line(prevLineX[i],prevLineY[i],lineX[i],lineY[i]);
  }
  //gravity
  curSpeedY+=0.015;
  //checks collision with ship
  for (int i=0; i<300;i++) {
    if((shipY>=lineY[i])&&(shipX>=prevLineX[i])&&(shipX<=lineX[i]) && curSpeedY<0.6) {
      curSpeedY=0;
      curSpeedX=0;
    }
    if((shipY>=lineY[i])&&(shipX>=prevLineX[i])&&(shipX<=lineX[i]) && curSpeedY>0.6) {
      crashed=true;
      shipY=500;
      shipX=-50;
      curSpeedY=0;
      curSpeedX=2;
      lose=true;
    }
  }
  //checks if landed on landing zone
  if((shipY>=lineY[landingZone])&&(shipX>=prevLineX[landingZone])&&(shipX<=lineX[landingZone]) && curSpeedY<0.6) {
    landed=true;
    prompting=true;
  }
  //checks if stranded
  if (curSpeedX==0 && curSpeedY==0 && fuel==0) {
    shipY=500;
    shipX=-50;
    curSpeedY=0;
    curSpeedX=2;
    stranded=true;
    lose=true;
  }
  //check if next location
  if (shipY<=-50) {
    shipY=540;
    moon=false;
    
  }
}

  
  
}
