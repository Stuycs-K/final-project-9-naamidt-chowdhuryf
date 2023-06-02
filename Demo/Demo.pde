static final int MAP = 0;
static final int BATTLE = 1;
static final int MOVES = 2;
static final int BAG = 3;
static final int TEXTBOX = 4;
static final int LEFT_WIDTH = 10;
static final int RIGHT_WIDTH = 160;
static final int TOP_HEIGHT = 360;
static final int BOT_HEIGHT = 480;

Map map;
int state;
Battle battle;
int countdown;
void setup() {
  countdown = 0;
  imageMode(CENTER);
  state = 0;
  size(300, 600);
  background(0);
  map = new Map("testmap.txt");
  mapUI();
  Pokedex dex = new Pokedex();
  Trainer player = new Trainer("Me!",new int[]{0,0}, 0);
  Pokemon random = dex.randomPokemon(100);
  random.changeHP((int)(random.getStats()[1]*Math.random()));
  player.setPokemon(0,random);
  Trainer enemy = new Trainer("Evil!",new int[]{0,0}, 0);
  random = dex.randomPokemon(100);
  random.changeHP((int)(random.getStats()[1]*Math.random()));
  enemy.setPokemon(0,random);
  battle = new Battle(player,enemy);
  
  //String dir = sketchPath();
  //System.out.println(dir);
  //dir = dir.substring(0,dir.length()-4);
  //char what = dir.charAt(dir.length()-1);
  //dir+="Demo";
  ////dir+="front";
  //dir+=what;
  //dir+="data";
  //dir+=what;
  //dir+="front";
  //dir+=what;
  //dir+="800.gif";
  //System.out.println(dir);
  //PImage marshadow = loadImage(dir);
  // tl;dr, get the filepath, go to data, then go into the folder, then take sprite
  //Pokedex dex = new Pokedex();
  //Pokemon randy = dex.randomPokemon(12);
  //image(randy.getFrontSprite(),110,110);
  //image(marshadow,100,100);
}

void keyPressed() {
  if (state == MAP) {
    if (key == 'w') {
      map.move(UP);
    }
    if (key == 'd') {
      map.move(RIGHT);
    }
    if (key == 's') {
      map.move(DOWN);
    }
    if (key == 'a') {
      map.move(LEFT);
    }
    if (key == 'b') {
      state = BATTLE;
    }
    mapUI();
  }
 if (state > MAP) {
   if (key == 'm') {
     state = MAP;
   }
   battleUI(battle);
  }
}

void draw() {
  if (countdown > 0) {
    countdown--;
  }
}

void mousePressed() {
  if (countdown == 0) {
    if (mouseX > width/2 + 10 && mouseX < width - 10 && mouseY > height/2 + height/5 + 60 && mouseY < height/2 + height/6 + height/5 + 60){
      buttonBR();
    } if (mouseX > width/2 + 10 && mouseX < width - 10 && mouseY < height/2 + 60 + height/6 && mouseY > height/2 + height/6 - 40) {
      buttonTR();
    } if (mouseX >  10 && mouseX < width/2 - 10 &&mouseY > height/2 + height/5 + 60 && mouseY < height/2 + height/6 + height/5 + 60) {
      buttonBL();
    } if (mouseX >  10 && mouseX < width/2 - 10 && mouseY < height/2 + 60 + height/6 && mouseY > height/2 + height/6 - 40) {
      buttonTL();
    }
    countdown = 60;
  }
}
void buttonBR() {
  if (state == MAP) {
    exit();
  }
  if (state == BATTLE) {
    state = MAP;
    mapUI();
  }
  if (state == MOVES) {
     battle.turn("Fight", 3);
     updateHealthBar();
     state = TEXTBOX;
     noFill();
     fill(255);
     rect(LEFT_WIDTH, TOP_HEIGHT, width - 30, height/2 - 30);
     fill(0);
     text(battle.getPlayerActive() + " used " + battle.getPlayerActive().getMoves()[3].getName() + "!", LEFT_WIDTH, TOP_HEIGHT); 
     noFill();
  }
  if (state == BAG) {
    state = BATTLE;
    battleButtons();
  }
}
void buttonTR() {
  if (state == BATTLE) {
    noFill();
    fill(255);
    rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
    noFill();
    fill(0);
    text("POKEBALL", 45, 2*height/3 + 10); 
    text("GREAT BALL", 45, 3*height/4 + 80);
    text("ULTRA BALL", width/2 + 65, 2*height/3+10);
    text("QUIT", width/2 + 60, 3*height/4 + 80);
    state = BAG;
  }
  if (state == MOVES) {
     battle.turn("Fight", 2);
     updateHealthBar();
     state = TEXTBOX;
     noFill();
     fill(255);
     rect(LEFT_WIDTH, TOP_HEIGHT, width - 30, height/2 - 30);
     fill(0);
     text(battle.getPlayerActive() + " used " + battle.getPlayerActive().getMoves()[2].getName() + "!", LEFT_WIDTH, TOP_HEIGHT); 
     noFill();
  }
}
void buttonBL() {
  if (state == MOVES) {
     battle.turn("Fight", 1);
     updateHealthBar();
     state = TEXTBOX;
     noFill();
     fill(255);
     rect(LEFT_WIDTH, TOP_HEIGHT, width - 30, height/2 - 30);
     fill(0);
     text(battle.getPlayerActive() + " used " + battle.getPlayerActive().getMoves()[1].getName() + "!", LEFT_WIDTH, TOP_HEIGHT); 
     noFill();
  }
}
void buttonTL() {
  if (state == BATTLE) {
    fill(255);
    rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
    fill(0);
    textSize(12);
    text(battle.getPlayerActive().getMoves()[0].getName().toUpperCase(), LEFT_WIDTH + 20, TOP_HEIGHT + 50); 
    if (battle.getPlayerActive().getMoves()[1] != null) {
      text(battle.getPlayerActive().getMoves()[1].getName().toUpperCase(), LEFT_WIDTH + 20, BOT_HEIGHT + 50); 
    }
    if (battle.getPlayerActive().getMoves()[1] != null) {
      text(battle.getPlayerActive().getMoves()[2].getName().toUpperCase(), RIGHT_WIDTH + 20, TOP_HEIGHT + 50); 
    }
    if (battle.getPlayerActive().getMoves()[1] != null) {
      text(battle.getPlayerActive().getMoves()[3].getName().toUpperCase(), RIGHT_WIDTH + 20, BOT_HEIGHT + 50); 
    }
    state = MOVES;
  }
  if (state == MOVES) {
     battle.turn("Fight", 0);
     updateHealthBar();
     state = TEXTBOX;
     noFill();
     fill(255);
     rect(LEFT_WIDTH, TOP_HEIGHT, width - 30, height/2 - 30);
     fill(0);
     text(battle.getPlayerActive() + " used " + battle.getPlayerActive().getMoves()[2].getName() + "!", LEFT_WIDTH, TOP_HEIGHT); 
     noFill();
  }
}

void mapUI() {
  map.replace();
  fill(0);
  rect(0, height/2, width, height/2);
  fill(255, 0, 0);
  circle(width/2, 3*height/4, height/2);
  noFill();
  fill(255);
  arc(width/2, 3 * height/4, 320, 320, 0, PI, OPEN);
  noFill();
  fill(0);
  circle(width/2, 3*height/4, 50);
  noFill();
  fill(255);
  circle(width/2, 3*height/4, 30);
  rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
  noFill();
  fill(0);
  text("POKEMON", 45, 2*height/3 + 10); 
  text("POKEDEX", 45, 3*height/4 + 80);
  text("BAG", width/2 + 65, 2*height/3+10);
  text("QUIT", width/2 + 60, 3*height/4 + 80);
}


void battleUI(Battle battle) {
  Pokemon player = battle.getPlayerActive();
  Pokemon enemy = battle.getNpcActive();
  background(255);
  fill(0);
  rect(0, height/2, width, height/2);
  fill(255, 0, 0);
  circle(width/2, 3*height/4, height/2);
  noFill();
  fill(255);
  arc(width/2, 3 * height/4, 320, 320, 0, PI, OPEN);
  noFill();
  fill(0);
  circle(width/2, 3*height/4, 50);
  noFill();
  fill(255);
  circle(width/2, 3*height/4, 30);
  rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
  noFill();
  fill(0);
  text("FIGHT", 55, 2*height/3 + 10); 
  text("POKEMON", 45, 3*height/4 + 80);
  text("BAG", width/2 + 65, 2*height/3+10);
  text("RUN", width/2 + 65, 3*height/4 + 80);
  noFill();
  fill(150);
  ellipse(75, 3*height/8 + 60, 150, 20);
  ellipse(3*width/4, height/20 + 70, 150, 20);
  fill(255);
  rect(width/2, 3*height/8, width/2, height/12, 10); // the location of the player's info box thing
  fill(255,0,0);
  rect(width/2, 3*height/8+30, width/2, height/12-30, 10); //hp red underlay
  fill(0,255,0);
  rect(width/2, 3*height/8+30, width/2 * player.getCurrentHP()/1.0/player.getStats()[1], height/12-30, 10); // hp green overlay
  fill(0);
  textSize(20);
  text(player.getNickname(),width/2+5, 3*height/8-7);
  text(player.getCurrentHP()+"/"+player.getStats()[1],width/2+5, 3*height/8+23);
  textSize(12);
  fill(255);
  rect(0, height/20, width/2, height/12, 10); // enemy hp box thing
  fill(255,0,0);
  rect(0, height/20+30, width/2, height/12-25, 10); // enemy red overlay
  fill(0,255,0);
  rect(0, height/20+30, width/2 * enemy.getCurrentHP()/1.0/enemy.getStats()[1], height/12-25, 10); // enemy green overlay
  fill(0);
  textSize(20);
  text(enemy.getNickname(),0+5, height/20-10);
  text(enemy.getCurrentHP()+"/"+enemy.getStats()[1],0+5, height/20+20);
  textSize(12);
  image(enemy.getFrontSprite(),220,70);
  image(player.getBackSprite(),80,260);
}

void updateHealthBar() {
  Pokemon player = battle.getPlayerActive();
  Pokemon enemy = battle.getNpcActive();
  fill(255,0,0);
  rect(width/2, 3*height/8+30, width/2, height/12-30, 10); //hp red underlay
  fill(0,255,0);
  rect(width/2, 3*height/8+30, width/2 * player.getCurrentHP()/1.0/player.getStats()[1], height/12-30, 10); // hp green overlay
  fill(255,0,0);
  rect(0, height/20+30, width/2, height/12-25, 10); // enemy red underlay
  fill(0,255,0);
  rect(0, height/20+30, width/2 * enemy.getCurrentHP()/1.0/enemy.getStats()[1], height/12-25, 10); // enemy green overlay
  noFill();
}

void battleButtons() {
  fill(255);
  rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
  noFill();
  fill(0);
  text("FIGHT", 55, 2*height/3 + 10); 
  text("POKEMON", 45, 3*height/4 + 80);
  text("BAG", width/2 + 65, 2*height/3+10);
  text("RUN", width/2 + 65, 3*height/4 + 80);
  noFill();
}
