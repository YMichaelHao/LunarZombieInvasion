int playerX=900;
int playerY=450;
int speed = 4;
boolean move;
int moveTimer;
int mobi;
boolean lunarLander=false;
boolean up=false, down=false, left=false, right=false;
terrain t;
lunarLander l;
rain r;
player p;
cave c;
sword s;
status q;
cutscene z;
int seed;
int seedCV;
ArrayList<mob> mobList;
//screens
boolean mainMenu=true;
boolean GameScreen=false;
boolean PauseScreen=false;
boolean spawnedImage=false;
PImage pause;
PImage menu;
//generate spawns
boolean generateSpawnOW=false;
boolean validSpawnOW=false;
boolean generateSpawnCV=false;
boolean validSpawnCV=false;

int mobSpawnTimer;

boolean transitionScreen=false;
int tTimer;
void setup() {
  size(1850, 950, P2D);
  noStroke();
  frameRate(60);
  t = new terrain();
  r= new rain();
  p = new player();
  c = new cave();
  s = new sword();
  q = new status();
  z = new cutscene();
  l = new lunarLander();
  mobList = new ArrayList<mob>();
  cavedIn=false;
  pause = loadImage("PauseScreen.png");
  menu = loadImage("Menu1.png");
  cavedIn=false;
}

void draw() {
  MainMenu();
  GameGo();
  PauseScreen();
  println(frameRate);
}
void mobSpawn() {
    if (mobList.size()<(5)) {
    mobSpawnTimer++;
    }
    if (mobSpawnTimer>=90) {
      mobList.add(new mob());
      mobSpawnTimer=0;
    }
}
void GameGo() {
    if (GameScreen==true) {
              z.decisionmaking();
      if(lunarLander==true){
      if(prompting==false){
      l.update();
      }
      }
      if(exposition==true){
      introscreen();
      }
      else if (transitionScreen==true) {
          transitionScreen();
        }
        else {
          stroke(0);
          strokeWeight(1);
      if(lunarLander==false){
      if(gameover==false){
      p.movement();
      p.terrainBorder();
      }
      if(cavedIn==false){
        t.nightday();
        t.drawTerrain();
        p.blockBreak();
        p.waterBorder();
      p.rockBorder();
      p.bushBorder();
      t.waterChange();
      p.caveOWBorder();
      r.rainGo();
      }
      
      if (cavedIn==true) {
        c.drawTerrain();
        p.caveBorder();
        p.blockBreakCV();
        c.caveSpawnBorder();
      }
      mobSpawn();
      if(gameover==false){
      q.hp();
      q.shield();
      q.collection();
      q.statusUpdate();
      q.crafting();
      }
      fill(55);
      stroke(55);
      strokeWeight(10);
      rect(40,40,305,215);
      if(gameover==false){
      t.minimap();
      s.display();
      s.swingattack();
      }
        p.display();}
      tint(255, tint);
      for (mobi=0;mobi<mobList.size()-1;mobi++) {//mitchell
        mob aMob=mobList.get(mobi);
        if (aMob.whacked==false) {
        aMob.BotMove();
        }
        else {
          aMob.stunned();

        }
        if(cavedIn==false){
        aMob.terrainBorder();
        aMob.waterBorder();
        aMob.bushBorder();
        aMob.rockBorder();
        }
        if(cavedIn==true){
        aMob.cavewallBorder();
        }
        aMob.mobWhack();
        if(aMob.mobDied()==true){//mitchell
        mobList.remove(mobi);
        }
        aMob.display();
        z.missionFailed();
        z.rocketLaunch();
      }
  }
        }
}

void MainMenu() {
  if (mainMenu==true) {
    background(0);
    image(menu,0,0);
  }
  
  
  
  
}
void PauseScreen() {
  if (PauseScreen==true) {
    if (spawnedImage==false) {
      tint(255,220);
      image(pause,700,100);
      spawnedImage=true;
    }
  }
}
void checkSpawn() {
  for (int j=0;j<10;j++) {
    for (int i=0;i<w*h;i++) {
      if (waterXBorder[i]+waterYBorder[i]!=0) {
        int waterLeft= waterXBorder[i];
        int waterRight= waterXBorder[i]+tileSize;
        int waterTop= waterYBorder[i];
        int waterBottom= waterYBorder[i]+tileSize;
        if (playerY<=waterBottom &&
            playerY+50>=waterTop &&
            playerX+50>waterLeft &&
            playerX<= waterRight) {
            validSpawnOW=false;
            
         }
      }
      if (bushXBorder[i]+bushYBorder[i]!=0) {
        int bushLeft= bushXBorder[i];
        int bushRight= bushXBorder[i]+tileSize;
        int bushTop= bushYBorder[i];
        int bushBottom= bushYBorder[i]+tileSize;
        //check from left
        if (playerY<=bushBottom &&
            playerY+50>=bushTop &&
            playerX+50>bushLeft &&
            playerX<= bushRight) {
            validSpawnOW=false;
         }
      }
      if (rockXBorder[i]+rockYBorder[i]!=0) {
        int rockLeft= rockXBorder[i];
        int rockRight= rockXBorder[i]+tileSize;
        int rockTop= rockYBorder[i];
        int rockBottom= rockYBorder[i]+tileSize;
        //check from left
        if (playerY+2<=rockBottom &&
            playerY+48>=rockTop &&
            playerX+48>rockLeft &&
            playerX+2<= rockRight) {
            validSpawnOW=false;
         }
      }
      
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
            validSpawnOW=false;
         }
      }
      
    }
    if (validSpawnOW==true) {
      generateSpawnOW=true;
      break;
    }
    else {
      validSpawnOW=true;
    y+=50;
    t.drawTerrain();
    j=0;
    }

  }
}
void checkSpawnCV() {
  for (int j=0;j<10;j++) {
    for (int i=0;i<w*h;i++) {
      if (cavewallXBorder[i]+cavewallYBorder[i]!=0) {
        int cavewallLeft= cavewallXBorder[i];
        int cavewallRight= cavewallXBorder[i]+tileSize;
        int cavewallTop= cavewallYBorder[i];
        int cavewallBottom= cavewallYBorder[i]+tileSize;
        if (playerY<=cavewallBottom &&
            playerY+50>=cavewallTop &&
            playerX+50>cavewallLeft &&
            playerX<= cavewallRight) {
            validSpawnCV=false;
         }
      }
      }
    if (validSpawnCV==true) {
      generateSpawnCV=true;
      CVspawnX=x-100;
      CVspawnY=y-200;
      break;
      }
      else {
      validSpawnCV=true;
      y+=100;
      c.drawTerrain();
      j=0;
      }
  }
}
void transitionScreen() {
  if (transitionScreen==true) {
    background(0);
    fill(255);
    textSize(70);
    text("You Mysteriously Spawn In Somewhere Close",300,475);
    tTimer++;
    if ((tTimer>=120)) {
      transitionScreen=false;
    }
  }
}

  void introscreen(){
if(exposition==true){
    tint(255,255);
    image(intro,0,0);
    fill(100,225);
    stroke(255,0,0);
    rect(200,200,1450,550);
    textSize(32);
    fill(255);
    text("A long time ago (very recently), an alien spaceship appeared over earth, with the intent to conquer it.",250,300);
    text("However someone left the ship running while it was parked, and the battery died.",355,360);
    text("And so, with not many other options, they landed on the moon to continue to plot their nefarious plans.",240,420);
    text("And thus begins your journey. You must build a ship in order to get to the moon to defeat the aliens.",250,520);
    text("Be warned though, the invasion is already underway. Do not expect your efforts to go unchallenged.",248,580);
    textSize(50);
    text("Good Luck!",800,670);
    textSize(26);
    text("(Press space to continue)",782,720);
}
if(keyPressed){
if(key == ' '){
exposition=false;
}
}
}
