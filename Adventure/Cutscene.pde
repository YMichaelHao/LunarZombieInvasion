boolean rocketcutscene=false;
boolean gameover=false;
boolean badend=false;
boolean exposition=true;
boolean prompting=false;
boolean deci1=false,deci2=false;
PImage badending,intro,prompt,decision1,decision2;
PImage rocket;
int rockety,rocketsy=0;
boolean moveRocket;
float cutsopac=0;

class cutscene{

  cutscene(){
  intro = loadImage("introtalk.png");
  rocket = loadImage("lander.png");
  badending = loadImage("badending.png");
  prompt = loadImage("promptimage.png");
  decision1 = loadImage("machineending.png");
  decision2 = loadImage("boomending.png");
  rockety=(height/2)-60;
  }
  void missionFailed(){
  if((gameover==true)&&(badend==true)){
  tint(255,cutsopac);
  image(badending,0,0);
  fill(255,cutsopac);
  textSize(100);
  text("Game Over",675,500);
  textSize(35);
  text("You have been defeated.",725,575);
  cutsopac+=0.05;
  }
  }
  void rocketLaunch(){
  if((gameover==true)&&(rocketcutscene==true)){
  tint(tint,255);
  image(rocket,(width/2)-60,rockety-rocketsy);
  moveRocket=true;
  //lunarLander=true;
  }
  if(moveRocket==true){
  rocketsy+=2;
  }
  if(rocketsy>=1000){
  lunarLander=true;
              for(int j=0; j<mobList.size();j++) {
            mobList.remove(j);
            }
  rocketcutscene=false;
  }
  }
  void decisionmaking(){
  if((prompting==true)&&(landed==true)){
  tint(255,cutsopac);
  image(prompt,0,0);
  fill(100,225);
  stroke(255,0,0);
  rect(200,200,1450,550);
  fill(255);
  textSize(40);
  text("You have arrived on the moon, however your hastily built craft has sprung a leak.",250,300);
  text("With your fuel running low, you must decide what to do with the alien ship.",275,375);
  text("(Press Y to stay on the moon to destroy the generator)",350,500);
  text("(Press N to blow up the moon)",350,560);
  cutsopac+=0.1;
  }
  if(deci1==true){
  deci2=false;
  tint(255);
  image(decision1,0,0);
    fill(100,225);
  stroke(255,0,0);
  rect(200,200,1450,550);
  fill(255);
  textSize(60);
  text("SACRIFICE ENDING",700,300);
    fill(255);
  textSize(40);
  text("You destroy the machine with your last ounce of strength, ending",360,400);
  text("the onslaught of aliens on earth.",630,500);
  text("Though the earth and moon may have been saved, it has costed you your life.",300,600);
  }
  if(deci2==true){
  deci1=false;
  tint(255);
  image(decision2,0,0);
    fill(100,225);
  stroke(255,0,0);
  rect(200,200,1450,550);
  fill(255);
  textSize(60);
  text("KABOOM ENDING",700,300);
  textSize(70);
  text("You've won, but at what cost?",500,500);
  }
  }
}
 
  
