boolean swing;
boolean swingStop=false;
class sword{

int swingTimer;
float swordA;
float swordS;
PImage sword;
PImage swordswing;
  
sword(){
swing=false;
swordS=0.5;
sword = loadImage("Sword.png");
swordswing= loadImage("SwordSwing.png");
}



void display(){
noStroke();
fill(255,0,0,100);
ellipseMode(CENTER);
ellipse(playerX+25,playerY+25,125,125);
fill(255,0,0);
pushMatrix();
translate(playerX+25,playerY+25);
rotate(swordA);
if(swing==false){
image(sword,-27,-65);
}else{
image(swordswing,-27,-65);
}
popMatrix();
rectMode(CORNER);
}

void swingattack(){
if(swing==true){
swingTimer++;
swordA=swordA+swordS;
swordS-=0.00503;
pDamage-=0.001;
}
if(swingTimer>=12){
  if(swingStop==true) {
    swordA=0;
    swing=false;
    pDamage=ppDamage;
    swordS=0.5;
    swingTimer=0;
    }
  }

if(swordS<=0){
swordA=0;
swing=false;
pDamage=ppDamage;
swordS=0.5;
swingTimer=0;
}
}

}
