/*
  Michael Hao
  5/25/2023
  Project 5: Lunar Lander
  Mission: There's been a fuel leak and your objective is to land on the moon and come back without losing your ship!
*/

int moonColorR=128;
int moonColorG=128;
int moonColorB=128;
int fuel=2700;
//fuel timer
int fuelTimer;
//checks if game is running
boolean gameRun=true;
//win condition
boolean success=false;
boolean landed=false;
//lose conditions
boolean lose=false;
boolean uncompleted=false;
boolean connectionLost=false;
boolean crashed=false;
boolean stranded=false;
int connection=4;
int glitchNum;
int glitchOdd=998;
//planet booleans
ship e;
moon m;
boolean moon=false;
boolean earth=true;
class lunarLander{
//glitch visual variables

//initiate classes

//moon color (kinda useless, was about to be good idea)


lunarLander() {
  //sets upL canvas and classes
  e = new ship();
  m = new moon();
}

void update() {
  //checks if win/lose
  lose();
  win();
  //if gamesRuns, then the game runs
  if (gameRun==true){
    tint(255,255);
  //if close to moon then this
  if (moon==false && earth==false) {
    background(0);
    
    //stars
    for (int i=0;i<150;i++) {
      fill(255);
      stroke(255);
      line(starX[i],starY[i],starX[i]+1,starY[i]+1);
    }
    //moon
    stroke(moonColorR,moonColorG,moonColorB);
    fill(moonColorR,moonColorG,moonColorB);
    ellipse(750,1100,1000,1000);
    //checks if goes to next location
    if(shipY>=550) {
    moon=true;
    shipY=0;
    }
  }
  //checks if goes to next location
  if(shipY<=50 && moon==false && earth==false) {
      earth=true;
      shipY=600;
  }
  //checks if goes to next location
  if(shipY<=220 && earth==true && landed==false) {
      shipY=500;
      shipX=-50;
      curSpeedY=0;
      curSpeedX=2;
      lose=true;
      uncompleted=true;
  }
  //checks if goes to reaches earth and mission completed
  if(shipY<=220 && earth==true && landed==true) {
    shipY=500;
    shipX=-50;
    curSpeedY=0;
    curSpeedX=2;
    success=true;
    gameRun=false;
  }
  fill(130);
  //upLdates ship speed
  shipX+=curSpeedX;
  shipY+=curSpeedY;
  //checks if goes to next location
  if (moon==true) {
    m.onMoon();
  }
  //checks borders
  if(shipX<-50) {
    shipY=500;
    shipX=-50;
    curSpeedY=0;
    curSpeedX=2;
    lose=true;
    connectionLost=true;
    
  }
  //checks borders
  if (shipX>1550) {
    shipY=500;
    shipX=-50;
    curSpeedY=0;
    curSpeedX=2;
    lose=true;
    connectionLost=true;
  }
  //runs functions
  earth();
  e.move();
  glitch();
  info();
  //checks and updates fuel
  if(fuel<0) {
    fuel=0;
  }
  if(fuelTimer>=10 && fuel>0) {
    fuelTimer=0;
    if(prompting==false){
    fuel--;
    }
  }
  fuelTimer++;
}
fill(100);
stroke(0);
    rect(1500,0,350,950);
    fill(100);
    rect(0,750,1850,200);
}
void earth() {
  //if close to moon then this
  if(earth==false && moon==false) {
    //small earth
    fill(70,130,60);
    stroke(70,130,60);
    ellipse(750,-50,150,150);
  }
  //if close to earth then this
  if (earth==true) {
    background(0);
    //stars
    for (int i=0;i<150;i++) {
      fill(255);
      stroke(255);
      line(starX[i],starY[i],starX[i]+1,starY[i]+1);
    }
    //green earth
    stroke(70,130,60);
    fill(70,130,60);
    ellipse(750,-600,2400,1600);
    //blue earth
    fill(70,60,130);
    stroke(70,60,130);
    ellipse(750,-600,1600,1600);
    //moon
    stroke(moonColorR,moonColorG,moonColorB);
    fill(moonColorR,moonColorG,moonColorB);
    ellipse(750,800,150,150);
    //checks if goes to next location
    if (shipY>=600) {
      shipY=75;
      earth=false;
    }
  }
}
void glitch() {
  //glitch visuals
  glitchOdd=1003-abs(int((750-shipX)/20));
  connection=int(random(14));
  fill(int(random(180,256)));
  for (int i=0;i<connection;i++) {
    
    for (int j=0; j<100;j++) {
      glitchNum=int(random(1000));
      if (glitchNum>glitchOdd) {
      square(i*30,j*30,30);
      }
    }
  }
  for (int i=0;i<connection+1;i++) {
    for (int j=0; j<100;j++) {
      glitchNum=int(random(1000));
      if (glitchNum>glitchOdd) {
      square(1500-i*30,j*30,30);
      }
    }
  }
  for (int i=0;i<connection-1;i++) {
    for (int j=0; j<100;j++) {
      glitchNum=int(random(1000));
      if (glitchNum>glitchOdd) {
      square(j*30,i*30,30);
      }
    }
  }for (int i=0;i<connection;i++) {
    for (int j=0; j<100;j++) {
      glitchNum=int(random(1000));
      if (glitchNum>glitchOdd) {
      square(j*30,750-i*30,30);
      } 
    }
  }
}
void info() {
  //visual info text
  textSize(30);
  fill(255);
  if(moon==true) {
    text("Horizontal Speed: "+curSpeedX*100+"m/s",10,50);
    text("Vertical Speed: "+curSpeedY*100+"m/s",10,100);
  }
  else {
    text("Horizontal Speed: "+curSpeedX*1000+"m/s",10,50);
    text("Vertical Speed: "+curSpeedY*1000+"m/s",10,100);
  }
  if (landed==false) {
    fill(200,20,30);
    text("Mission Completed: "+landed,1150,50);
  }
  else {
    fill(80,240,100);
    text("Mission Completed: "+landed,1150,50);
  }
  fill(255);
  text("Fuel: "+fuel+"kg",10,150);
  if (120>abs(750-shipX)){
    fill(100,230,80);
    text("Connection Status: Excellent",10,200);
  }
  else if (300>abs(750-shipX)){
    fill(50,180,40);
    text("Connection Status: Good",10,200);
  }
  else if (560>abs(750-shipX)){
    fill(210,120,20);
    text("Connection Status: Not Good",10,200);
  }
  else {
    fill(150,30,40);
    text("Connection Status: Bad",10,200);
  }
}
void lose() {
  //shows the lose screen based on what happened
  if(lose==true) {
    gameRun=false;
    background(0);
    for (int i=0;i<150;i++) {
      fill(255);
      stroke(255);
      line(starX[i],starY[i],starX[i]+1,starY[i]+1);
    }
    fill(170,40,30);
    textSize(100);
    if (connectionLost==true) {
      
      text("LOST CONNECTION",380,350);
    }
    if (stranded==true) {
      text("STRANDED",525,350);
    }
    if (crashed==true) {
      text("CRASHED",550,350);
    }
    if (uncompleted==true) {
      text("MISSION UNCOMPLETED",250,350);
      
    }
    
    if (landed==false) {
      fill(200,20,30);
      textSize(30);
      text("Mission Completed: "+landed,1150,50);
    }
    else {
      fill(80,240,100);
      textSize(30);
      text("Mission Completed: "+landed,1150,50);
    }
    fill(255);
    textSize(50);
    text("Fuel Remaining: "+fuel+"kg",500,450);
    posA+=0.05;
    shipX+=curSpeedX;
    pushMatrix();
    translate(shipX,shipY);
    rotate(posA+PI/2);
    image(shipSpace,-20,-23);
    popMatrix();
  }
}

void win() {
  //shows the win screen
  if (success==true) {
    background(0);
    for (int i=0;i<150;i++) {
      fill(255);
      stroke(255);
      line(starX[i],starY[i],starX[i]+1,starY[i]+1);
    }
    fill(40,200,30);
    textSize(100);
    text("MISSION COMPLETED",325,350);
    fill(255);
    textSize(50);
    text("Fuel Remaining: "+fuel+"kg",500,450);
    posA=0;
    shipX+=curSpeedX;
    pushMatrix();
    translate(shipX,shipY);
    rotate(posA+PI/2);
    image(shipSpaceFire,-20,-23);
    popMatrix();
  }
  
}
}
