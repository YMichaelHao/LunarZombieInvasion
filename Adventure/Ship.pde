//images
PImage shipSpace;
PImage shipSpaceFire;
PImage shipSpaceFireleftL;
PImage shipSpaceFirerightL;
//boolean images
boolean shipFire=false;
boolean shipFireleftL=false;
boolean shipFirerightL=false;
//ship variables
float shipX, shipY;
float speedX,speedY,curSpeedX,curSpeedY;
//checks movement booleans
boolean upL=false, downL=false, leftL=false, rightL=false;
//angle of ship
float posA;
float curPos;
class ship {
  ship() {
    //initiats variables of ship
    shipX=750;
    shipY=300;
    shipSpace=loadImage("LunarLanderSpace.png");
    shipSpaceFire=loadImage("LunarLanderSpaceFire.png");
    shipSpaceFireleftL=loadImage("LunarLanderSpaceFireLeft.png");
    shipSpaceFirerightL=loadImage("LunarLanderSpaceFireRight.png");
  }
  void move() {
    //checks movement of ship
  if(upL==true && fuel>0) {
    shipFire=true;
    speedX=0.03*(cos(posA));
    speedY=0.03*(sin(posA));
    curSpeedX+=speedX;
    curSpeedY+=speedY;
    fuel-=3;
  }
  if(downL==true) {
    
  }
  if(leftL==true && fuel>0) {
    posA-=0.025;
    shipFirerightL=true;
    fuel--;
  }
  if(rightL==true && fuel>0) {
    posA+=0.025;
    shipFireleftL=true;
    fuel--;
  }
  //rotates image based on movement keys
  pushMatrix();
  translate(shipX,shipY);
  rotate(posA+PI/2);
  if (shipFire==false || fuel<=0) {
    image(shipSpace,-20,-23);
    }
    else if (shipFire==true) {
      image(shipSpaceFire,-20,-23);
  }
  if (shipFireleftL==true && fuel>0) {
    image(shipSpaceFireleftL,-20,-23);
  }
  if (shipFirerightL==true && fuel>0) {
    image(shipSpaceFirerightL,-20,-23);
  }
  popMatrix();
}
}
