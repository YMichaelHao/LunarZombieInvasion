int pHealth=100;
int pShield=50;
float pDamage=3;
float ppDamage;
int showHealth;
int showShield;
int woodAmount=10;
int stoneAmount=10;
int heartAmount=5;
int boneAmount=0;
int level;
int curExp;
int nextExp=20;
boolean rocketcraftable=false;

class status{
  status() {
  ppDamage=pDamage;
  pHealth=100;
  pShield=50;
  }
  void hp() {
    showHealth=pHealth*630/100;
    strokeWeight(20);
    stroke(0);
    fill(180);
    rect(1150,850,650,79,93);
    strokeWeight(0);
    fill(255,0,0);
    rect(1160,858,pHealth*(630/100),63,93);
  }
  void shield() {
    showShield=pShield*630/50;
    strokeWeight(20);
    stroke(0);
    fill(180);
    rect(1150,800,650,50,93);
    strokeWeight(0);
    fill(0,0,130);
    rect(1160,808,pShield*(630/50),35,93);
  }
  void collection() {
    textSize(50);
    fill(255);
    text("Hearts: "+heartAmount+"/10",30,750);
    text("Wood: "+woodAmount+"/20",30,800);
    text("Stone: "+stoneAmount+"/20",30,850);
    text("Bones: "+boneAmount+"/10",30,900);
    text("Stone: "+stoneAmount+"/20",30,850);
    text((x-10000)/50+ ", " + (y-10000)/50,1600,50);
    text("Level: "+level,850,50);
    text("Exp: "+curExp+"/"+nextExp,800,100);
  }
  void statusUpdate() {
    if (curExp>=nextExp) {
      curExp=curExp-nextExp;
      nextExp+=5;
      level++;
      pDamage++;
      ppDamage=pDamage;
    }
  }
  void crafting(){
  textSize(40);
  fill(255);
  if(heartAmount>=1){
  text("Press J to heal!",375,800);
  }
  if(woodAmount>=2 && stoneAmount>=1){
  text("Press K to craft armor!",375,840);
  }
  if(heartAmount>=10 &&
     boneAmount>=10 && stoneAmount>=20
     && woodAmount>=20){
     rocketcraftable=true;
     }
  if(rocketcraftable==true){
  if(cavedIn==true){
  text("Go to Overworld to build rocket!",375,880);
  }else{
  text("Press L to build rocket!",375,880);
  }
  }
  }
}
