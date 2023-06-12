static final int MAP = 0;
static final int BATTLE = 1;
static final int MOVES = 2;
static final int BAG = 3;
static final int TEXTBOX = 4;
static final int WIN = 5;
static final int POTIONS = 6;
static final int MPOTIONS = -6;
static final int POKEBALLS = 7;
static final int FAINTED = 8;

static final int BPOKEMON = 9;
static final int SPOKEMON = 11;
static final int P1 = -111;
static final int P2 = -222;
static final int P3 = -333;
static final int P4 = -444;
static final int P5 = -555;
static final int P6 = -666;
static final int POKEMON = -1;

static final int HPot = 10;
static final int Pot = 12;
static final int SPot = 13;
static final int MPot = -12;
static final int MSPot = -13;
static final int MHPot = -10;

static final int LEFT_WIDTH = 10;
static final int RIGHT_WIDTH = 160;
static final int TOP_HEIGHT = 360;
static final int BOT_HEIGHT = 480;

static final int EFFECTIVETEXT = 3000;
static final int BALLTEXT = 5000;
static final int EFFECTIVETEXT2 = 3001;
static final int BALLTEXT2 = 5001;
static final int POTIONTEXT = 6000;
static final int AFTERTURN = 1010;
static final int AFTERTURN2 = 101;

Map map;
int state;
Battle battle;
int countdown;
Trainer player;
Pokedex dex;
int buttonCount;
void setup() {
  countdown = 0;
  imageMode(CENTER);
  state = 0;
  size(300, 600);
  background(0);
  map = new Map("testmap.txt");
  mapUI();
  dex = new Pokedex();
  player = new Trainer("Me!", new int[]{0, 0}, 0);
  Pokemon random = dex.randomPokemon(player);
  random.addExp(100);
  player.setPokemon(0, random);
  buttonCount = 4;

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
  if (state == MAP || state == POKEMON) {
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
      battle = new Battle(player);
      // TESTING PURPOSES //
      battle.getNpcActive().setStatus(1);
      //////////////////////
      state = BATTLE;
    }
    if (key == 't') {
      Trainer enemy = new Trainer("Rival!", new int[]{0, 0}, 0);
      dex.randomizeParty(enemy);
      battle = new Battle(player, enemy);
      state = BATTLE;
    }
    if (key == 'h') {
      player.getSlot(0).setCurrentHP(player.getSlot(0).getStats()[1]);
    }
    if (key == 'r') {
      dex.randomizeParty(player);
    }
    if (state == MAP) {
      mapUI();
    }
    if (state == POKEMON) {
      PokeUI();
    }
  }
  if (state > MAP) {
    if (key == 'm') {
      state = MAP;
    }
    if (key == 'f') {
      state = MOVES;
    }
    battleUI();
  }
}

void draw() {
  if (countdown > 0) {
    countdown--;
  }
  fill(0);
  text(mouseX + " " + mouseY, 0, 0);
}

void mouseClicked() {
  if (countdown == 0) {
    if (buttonCount == 1) {
      bigButton();
    } else if (buttonCount == 2) {
      if (mouseX >  LEFT_WIDTH && mouseX < LEFT_WIDTH + 130 && mouseY > TOP_HEIGHT + 60 && mouseY < TOP_HEIGHT + 160) {
        buttonLeft();
      }
      if (mouseX >  RIGHT_WIDTH && mouseX < RIGHT_WIDTH + 130 && mouseY > TOP_HEIGHT + 60 && mouseY < TOP_HEIGHT + 160) {
        buttonRight();
      }
    } else if (buttonCount == 4) {
      if (mouseX > width/2 + 10 && mouseX < width - 10 && mouseY > height/2 + height/5 + 60 && mouseY < height/2 + height/6 + height/5 + 60) {
        buttonBR();
      }
      if (mouseX > width/2 + 10 && mouseX < width - 10 && mouseY < height/2 + 60 + height/6 && mouseY > height/2 + height/6 - 40) {
        buttonTR();
      }
      if (mouseX >  10 && mouseX < width/2 - 10 &&mouseY > height/2 + height/5 + 60 && mouseY < height/2 + height/6 + height/5 + 60) {
        buttonBL();
      }
      if (mouseX >  10 && mouseX < width/2 - 10 && mouseY < height/2 + 60 + height/6 && mouseY > height/2 + height/6 - 40) {
        buttonTL();
      }
      if (mouseX > width/2 - 20 && mouseX < width/2 + 20 && mouseY > height/2 && mouseY < height/2 + 20) {
        buttonBack();
      }
      countdown = 15;
    } else if (buttonCount == 6) {
      if (mouseX > LEFT_WIDTH && mouseX < LEFT_WIDTH + 130 && mouseY > 340 && mouseY < 390) {
        button00();
      }
      if (mouseX > LEFT_WIDTH && mouseX < LEFT_WIDTH + 130 && mouseY > 440 && mouseY < 490) {
        button10();
      }
      if (mouseX > LEFT_WIDTH && mouseX < LEFT_WIDTH + 130 && mouseY > 540 && mouseY < 590) {
        button20();
      }
      if (mouseX > RIGHT_WIDTH && mouseX < RIGHT_WIDTH + 130 && mouseY > 340 && mouseY < 390) {
        button01();
      }
      if (mouseX > RIGHT_WIDTH && mouseX < RIGHT_WIDTH + 130 && mouseY > 440 && mouseY < 490) {
        button11();
      }
      if (mouseX > RIGHT_WIDTH && mouseX < RIGHT_WIDTH + 130 && mouseY > 540 && mouseY < 590) {
        button21();
      }
      if (mouseX > width/2 - 20 && mouseX < width/2 + 20 && mouseY > height/2 && mouseY < height/2 + 20) {
        buttonBack();
      }
    }
  }
}

void buttonBack() {
  if (state == POKEMON || state == MPOTIONS) {
    state = MAP;
    mapUI();
  } else if (state == MOVES || state == POTIONS || state == POKEBALLS || state == BPOKEMON || state == SPOKEMON) {
    state = BATTLE;
    battleButtons();
  } else if (state == MHPot || state == MSPot || state == MPot) {
    state = MPOTIONS;
    potionsUI();
  } else if (state == HPot || state == SPot || state == Pot) {
    state = POTIONS;
    potionsUI();
  } else if (state == BATTLE) {
    state = MAP;
    mapUI();
  } else if (state == P1 || state == P2 || state == P3 || state == P4 || state == P5 || state == P6) {
    state = POKEMON;
    PokeUI();
  }
}

void buttonBR() {
  if (state == MAP) {
    exit();
  } else if (state == BATTLE) {
    buttonBack();
  } else if (state == MOVES) {
    battle.turn(0, 3);
    afterTurn(battle.getNextTurn());
    noFill();
  } else if (state == BAG) {
    state = BATTLE;
    battleButtons();
  } else if (state == POTIONS || state == MPOTIONS) {
    buttonBack();
  } else if (state == POKEBALLS) {
    buttonBack();
  }
}
void buttonTR() {
  if (state == BATTLE) {
    bagUI();
    state = BAG;
  } else if (state == MOVES) {
    battle.turn(0, 2);
    afterTurn(battle.getNextTurn());
    noFill();
  } else if (state == POTIONS) {
    PokeUI();
    state = HPot;
  } else if (state == MPOTIONS) {
    PokeUI();
    state = MHPot;
  } else if (state == POKEBALLS) {
    battle.turn(2, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == MAP) {
    state = MPOTIONS;
    potionsUI();
  }
}
void buttonBL() {
  if (state == MOVES) {
    battle.turn(0, 1);
    afterTurn(battle.getNextTurn());
    noFill();
  } else if (state == POTIONS) {
    PokeUI();
    state = SPot;
  } else if (state == MPOTIONS) {
    PokeUI();
    state = MSPot;
  } else if (state == POKEBALLS) {
    battle.turn(2, 2);
    afterTurn(battle.getNextTurn());
  } else if (state == BATTLE) {
    PokeUI();
    state = SPOKEMON;
  } else if (state == MAP) {
    link("https://www.pokemon.com/us/pokedex");
  }
}
void buttonTL() {
  if (state == MAP) {
    state = POKEMON;
    PokeUI();
  } else if (state == BATTLE) {
    fill(255);
    rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
    rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
    fill(0);
    textSize(12);
    if (battle.getPlayerActive().getMoves()[0] != null) {
      text(battle.getPlayerActive().getMoves()[0].getName().toUpperCase(), LEFT_WIDTH + 20, TOP_HEIGHT + 50);
    }
    if (battle.getPlayerActive().getMoves()[1] != null) {
      text(battle.getPlayerActive().getMoves()[1].getName().toUpperCase(), LEFT_WIDTH + 20, BOT_HEIGHT + 50);
    }
    if (battle.getPlayerActive().getMoves()[2] != null) {
      text(battle.getPlayerActive().getMoves()[2].getName().toUpperCase(), RIGHT_WIDTH + 20, TOP_HEIGHT + 50);
    }
    if (battle.getPlayerActive().getMoves()[3] != null) {
      text(battle.getPlayerActive().getMoves()[3].getName().toUpperCase(), RIGHT_WIDTH + 20, BOT_HEIGHT + 50);
    }
    state = MOVES;
    fill(51);
    rect(width/2 - 20, height/2, 40, 20);
    fill(255);
    text("BACK", width/2 - 13, height/2 + 10);
  } else if (state == MOVES) {
    battle.turn(0, 0);
    afterTurn(battle.getNextTurn());
    noFill();
  } else if (state == WIN) {
    state = MAP;
    mapUI();
  } else if (state == POTIONS) {
    PokeUI();
    state = Pot;
  } else if (state == MPOTIONS) {
    PokeUI();
    state = MPot;
  } else if (state == POKEBALLS) {
    battle.turn(2, 1);
    afterTurn(battle.getNextTurn());
  }
}

void bigButton() { //when its just checking for a mouse press to go past a text segment
  if (state == TEXTBOX) {
    checkBattle(battle);
  }
  else if (state == WIN) {
    state = MAP;
    mapUI();
  }
  else if (state == AFTERTURN) {
    Turn turn = battle.getNextTurn();
    
  }
}

void buttonLeft() { //when theres only two buttons
  if (state == BAG) {
    state = POTIONS;
    potionsUI();
  }
}

void buttonRight() {
  if (state == BAG) {
    state = POKEBALLS;
    pokeballsUI();
  }
}


void button00() { //for when theres 6 buttons, top left
  if (state == Pot) {
    battle.turn(2, 4, 0);
    afterTurn(battle.getNextTurn());
  } else if (state == SPot) {
    battle.turn(2, 5, 0);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 0);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(0));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(0));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(0));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P1;
    pokeSummaryUI();
  }
    
}

void button01() { //top right
  if (state == SPOKEMON) {
    battle.turn(1, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == FAINTED) {
    battle.swapDead(player, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == Pot) {
    battle.turn(2, 4, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == SPot) {
    battle.turn(2, 5, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 3);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(3));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(3));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(3));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P4;
    pokeSummaryUI();
  }
}

void button10() { //middle left
  if (state == SPOKEMON) {
    battle.turn(1, 1);
    afterTurn(battle.getNextTurn());
  } else if (state == FAINTED) {
    battle.swapDead(player, 1);
    state = TEXTBOX;
    textboxUI();
    text("You switched in " + player.getSlot(0).getNickname() + "!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
  } else if (state == Pot) {
    battle.turn(2, 4, 1);
    afterTurn(battle.getNextTurn());
  } else if (state == SPot) {
    battle.turn(2, 5, 1);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 1);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(1));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(1));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(1));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P2;
    pokeSummaryUI();
  }
}

void button11() { //middle right
  if (state == SPOKEMON) {
    battle.turn(1, 4);
    afterTurn(battle.getNextTurn());
  } else if (state == FAINTED) {
    battle.swapDead(player, 4);
    state = TEXTBOX;
    textboxUI();
    text("You switched in " + player.getSlot(0).getNickname() + "!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
  } else if (state == Pot) {
    battle.turn(2, 4, 4);
    afterTurn(battle.getNextTurn());
    updateHealthBar();
  } else if (state == SPot) {
    battle.turn(2, 5, 4);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 4);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(4));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(4));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(4));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P5;
    pokeSummaryUI();
  }
}

void button20() { //bottom left
  if (state == SPOKEMON) {
    battle.turn(1, 2);
    afterTurn(battle.getNextTurn());
  } else if (state == FAINTED) {
    battle.swapDead(player, 2);
    state = TEXTBOX;
    textboxUI();
    text("You switched in " + player.getSlot(0).getNickname() + "!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
  } else if (state == Pot) {
    battle.turn(2, 4, 2);
    afterTurn(battle.getNextTurn());
  } else if (state == SPot) {
    battle.turn(2, 5, 2);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 2);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(2));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(2));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(2));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P3;
    pokeSummaryUI();
  }
}

void button21() { //bottom right
  if (state == SPOKEMON) {
    battle.turn(1, 5);
    afterTurn(battle.getNextTurn());
  } else if (state == FAINTED) {
    battle.swapDead(player, 5);
    state = TEXTBOX;
    textboxUI();
    text("You switched in " + player.getSlot(0).getNickname() + "!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
  } else if (state == Pot) {
    battle.turn(2, 4, 5);
    afterTurn(battle.getNextTurn());
  } else if (state == SPot) {
    battle.turn(2, 5, 5);
    afterTurn(battle.getNextTurn());
  } else if (state == HPot) {
    battle.turn(2, 6, 5);
    afterTurn(battle.getNextTurn());
  } else if (state == MPot) {
    player.getBag().use(false, 4, player.getSlot(5));
    state = MAP;
    mapButtons();
  } else if (state == MSPot) {
    player.getBag().use(false, 5, player.getSlot(5));
    state = MAP;
    mapButtons();
  } else if (state == MHPot) {
    player.getBag().use(false, 6, player.getSlot(5));
    state = MAP;
    mapButtons();
  } else if (state == POKEMON) {
    state = P6;
    pokeSummaryUI();
  }
}


void mapUI() {
  map.replace();
  mapButtons();
}


void battleUI() {
  background(255);
  battleButtons();
  updateEXP();
  updateHealthBar();
  battle.drawStatusEffects();
}

void updateHealthBar() {
  Pokemon player = battle.getPlayerActive();
  Pokemon enemy = battle.getNpcActive();
  noFill();
  fill(150);
  ellipse(75, 3*height/8 + 60, 150, 20);
  ellipse(3*width/4, height/20 + 70, 150, 20);
  fill(255);
  rect(width/2, 3*height/8, width/2, height/12, 10); // the location of the player's info box thing
  fill(255, 0, 0);
  rect(width/2, 3*height/8+30, width/2, height/12-30, 10); //hp red underlay
  fill(0, 255, 0);
  rect(width/2, 3*height/8+30, width/2 * player.getCurrentHP()/1.0/player.getStats()[1], height/12-30, 10); // hp green overlay
  fill(0);
  textSize(20);
  text(player.getNickname(), width/2+5, 3*height/8-7);
  text(player.getCurrentHP()+"/"+player.getStats()[1], width/2+5, 3*height/8+23);
  textSize(12);
  fill(255);
  rect(0, height/20, width/2, height/12, 10); // enemy hp box thing
  fill(255, 0, 0);
  rect(0, height/20+30, width/2, height/12-25, 10); // enemy red overlay
  fill(0, 255, 0);
  rect(0, height/20+30, width/2 * enemy.getCurrentHP()/1.0/enemy.getStats()[1], height/12-25, 10); // enemy green overlay
  fill(0);
  textSize(20);
  text(enemy.getNickname(), 0+5, height/20-10);
  text(enemy.getCurrentHP()+"/"+enemy.getStats()[1], 0+5, height/20+20);
  textSize(12);
  image(enemy.getFrontSprite(), 220, 70);
  image(player.getBackSprite(), 80, 260);
}

void updateEXP() {
  Pokemon fren = battle.getPlayerActive();
  Pokemon enemy = battle.getNpcActive();
  fill(0);  
  rect(width/2, 3*height/8+50, width/2, height/12-30, 10); // black exp br underlay
  double expPercentPlayer = (fren.getExp()-fren.getTotalLevelExp())/(fren.getNextLevelExp()-fren.getTotalLevelExp()*1.0); // blue exp bar overlay
  fill(0, 0, 255);
  rect(width/2, 3*height/8+50, width/2+(int)(width/2 * expPercentPlayer), height/12-30, 10); // blue bar
  fill(0);
  textSize(20);
  text(fren.getNickname(), width/2+5, 3*height/8-7);
  text(fren.getCurrentHP()+"/"+fren.getStats()[1], width/2+5, 3*height/8+23);
  text("Level: "+fren.getLevel(), width/2+5, 3*height/8-28);
  textSize(12);
  fill(0);
  rect(0, height/20+50, width/2, height/12-25, 10); // exp bar black underlay
  fill(0, 0, 255);
  double expPercentEnemy = -1*(enemy.getExp()-enemy.getTotalLevelExp())/(enemy.getNextLevelExp()-enemy.getTotalLevelExp()*1.0); // blue exp bar overlay
  rect(0, height/20+50, (int)(width/2 * expPercentEnemy)+1, height/12-25, 10); // exp bar
  fill(0);
  textSize(20);
  text(enemy.getNickname(), 0+5, height/20-10);
  text(enemy.getCurrentHP()+"/"+enemy.getStats()[1], 0+5, height/20+20);
  text("Level: "+enemy.getLevel(), 5, height/20+95);
  textSize(12);
}

void battleButtons() {
  buttonCount = 4;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
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

void mapButtons() {
  buttonCount = 4;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
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

void PokeUI() {
  buttonCount = 6;
  PImage tiny;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
  rect(LEFT_WIDTH, 340, width/2 - 20, 50);
  rect(LEFT_WIDTH, 440, width/2 - 20, 50);
  rect(LEFT_WIDTH, 540, width/2 - 20, 50);
  rect(RIGHT_WIDTH, 340, width/2 - 20, 50);
  rect(RIGHT_WIDTH, 440, width/2 - 20, 50);
  rect(RIGHT_WIDTH, 540, width/2 - 20, 50);
  fill(0);
  if (player.getParty()[0] != null) {
    text(player.getParty()[0].getNickname(), LEFT_WIDTH + 5, 370);
    tiny = player.getParty()[0].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, LEFT_WIDTH + width/2 - 50, 370);
  }
  if (player.getParty()[1] != null) {
    text(player.getParty()[1].getNickname(), LEFT_WIDTH + 5, 470);
    tiny = player.getParty()[1].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, LEFT_WIDTH + width/2 - 50, 470);
  }
  if (player.getParty()[2] != null) {
    text(player.getParty()[2].getNickname(), LEFT_WIDTH + 5, 570);
    tiny = player.getParty()[2].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, LEFT_WIDTH + width/2 - 50, 570);
  }
  if (player.getParty()[3] != null) {
    text(player.getParty()[3].getNickname(), RIGHT_WIDTH + 5, 370);
    tiny = player.getParty()[3].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, RIGHT_WIDTH + width/2 - 50, 370);
  }
  if (player.getParty()[4] != null) {
    text(player.getParty()[4].getNickname(), RIGHT_WIDTH + 5, 470);
    tiny = player.getParty()[4].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, RIGHT_WIDTH + width/2 - 50, 470);
  }
  if (player.getParty()[5] != null) {
    text(player.getParty()[5].getNickname(), RIGHT_WIDTH + 5, 570);
    tiny = player.getParty()[5].getFrontSprite();
    tiny.resize(30, 30);
    image(tiny, RIGHT_WIDTH + width/2 - 50, 570);
  }

  fill(51);
  rect(width/2 - 20, height/2, 40, 20);
  fill(255);
  text("BACK", width/2 - 13, height/2 + 10);
}

void caughtUI() {
  buttonCount = 1;
  Pokemon player = battle.getPlayerActive();
  Pokemon enemy = battle.getNpcActive();
  background(255);
  fill(255);
  rect(width/2, 3*height/8, width/2, height/12, 10); // the location of the player's info box thing
  fill(255, 0, 0);
  rect(width/2, 3*height/8+30, width/2, height/12-30, 10); //hp red underlay
  fill(0, 255, 0);
  rect(width/2, 3*height/8+30, width/2 * player.getCurrentHP()/1.0/player.getStats()[1], height/12-30, 10); // hp green overlay
  fill(0);
  textSize(20);
  text(player.getNickname(), width/2+5, 3*height/8-7);
  text(player.getCurrentHP()+"/"+player.getStats()[1], width/2+5, 3*height/8+23);
  textSize(12);
  fill(255);
  rect(0, height/20, width/2, height/12, 10); // enemy hp box thing
  fill(255, 0, 0);
  rect(0, height/20+30, width/2, height/12-25, 10); // enemy red overlay
  fill(0, 255, 0);
  rect(0, height/20+30, width/2 * enemy.getCurrentHP()/1.0/enemy.getStats()[1], height/12-25, 10); // enemy green overlay
  fill(0);
  textSize(20);
  text(enemy.getNickname(), 0+5, height/20-10);
  text(enemy.getCurrentHP()+"/"+enemy.getStats()[1], 0+5, height/20+20);
  textSize(12);
  image(player.getBackSprite(), 80, 260);
}

void checkBattle(Battle battle) {
  if (battle.battleStatus() == 0) {
    if (battle.getPlayerActive().getCurrentHP() == 0) {
      PokeUI();
      state = FAINTED;
    } else {
      state = BATTLE;
      battleUI();
    }
  } else {
    state = WIN;
    fill(255);
    rect(LEFT_WIDTH, TOP_HEIGHT, width - 20, height/2 - 80);
    fill(0);
    if (battle.battleStatus() > 0) {
      text("YOU WIN!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
    }
    if (battle.battleStatus() < 0) {
      text("YOU LOSE!", LEFT_WIDTH + 10, TOP_HEIGHT + 60);
    }
    noFill();
  }
}

void potionsUI() {
  buttonCount = 4;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
  rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
  noFill();
  fill(0);
  text("POTION", 55, 2*height/3 + 10);
  text("SUPER POTION", 45, 3*height/4 + 80);
  text("HYPER POTION", width/2 + 35, 2*height/3+10);
  text("BACK", width/2 + 65, 3*height/4 + 80);
  noFill();
}

void pokeballsUI() {
  buttonCount = 4;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
  rect(LEFT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(LEFT_WIDTH, BOT_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT, 130, 100);
  rect(RIGHT_WIDTH, BOT_HEIGHT, 130, 100);
  noFill();
  fill(0);
  text("POKEBALL", 55, 2*height/3 + 10);
  text("GREAT BALL", 45, 3*height/4 + 80);
  text("ULTRA BALL", width/2 + 65, 2*height/3+10);
  text("BACK", width/2 + 65, 3*height/4 + 80);
  noFill();
}

void textboxUI() {
  buttonCount = 1;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
  rect(LEFT_WIDTH, TOP_HEIGHT, width - 20, height/2 - 80);
  fill(0);
}

void circleDeco() {
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
  noFill();
}

void bagUI() {
  buttonCount = 2;
  fill(0);
  rect(0, height/2, width, height/2);
  circleDeco();
  fill(255);
  rect(LEFT_WIDTH, TOP_HEIGHT + 60, 130, 100);
  rect(RIGHT_WIDTH, TOP_HEIGHT + 60, 130, 100);
  fill(0);
  text("POTIONS", LEFT_WIDTH + 35, TOP_HEIGHT + 120);
  text("POKEBALLS", RIGHT_WIDTH + 35, TOP_HEIGHT + 120);
}

int checkCaught(int step) {
  int val = 0;
  if (step == 3) {
    state = WIN;
    caughtUI();
    textboxUI();
    text("You succesfully caught " + battle.getNpcActive().getNickname() + "!", 15, 400);
    val = 1;
    if (player.checkParty() != 6) {
      player.setPokemon(player.checkParty(), battle.getNpcActive());
    }
  } else {
    state = TEXTBOX;
    textboxUI();
    text(battle.getNpcActive().getNickname() + " broke free!", 15, 400);
  }
  return val;
}

//LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME LOOK AT ME


void moveTextHit(Turn first, int step) {
  fill(0);
  String name = first.getPokemon().getNickname().toUpperCase();
  if (step != 0) {
    textboxUI();
  }
  if (step == 1) {
    text("IT WAS A CRITICAL HIT!", 15, 400);
  } else if (step == 2) {
    text(name + " MISSED!", 15, 400);
  } else if (step == 4) {
    text(name + " WAS PARALYZED AND COULDN'T MOVE!", 15, 400);
  } else if (step == 5) {
    text(name + " WAS FROZEN AND COULDN'T MOVE!", 15, 400);
  } else if (step == 6) {
    text(name + "  WAS ASLEEP AND COULDN't MOVE!", 15, 400);
  } else if (step == 7) {
    text("IT FAILED!", 15, 400);
  } else if (step == 8) {
    text(name + " FLINCHED AND COULDN'T MOVE!", 15, 400);
  } else if (step == 9) {
    text(name + " HURT ITSELF IN ITS CONFUSION!", 15, 400);
  }
  noFill();
}

void ballTextSummary(Turn turn) {
  String ballType = player.getBag().idToName(turn.getChoice());
  fill(0);
  text("YOU THREW A " + ballType + " AT " + battle.getNpcActive().getNickname().toUpperCase(), 15, 400);
  noFill();
}

void potionTextSummary(Turn turn) {
  String potionType = player.getBag().idToName(turn.getChoice());
  fill(0);
  text("YOU USED A " + potionType + " ON " + turn.getTrainer().getSlot(turn.getChoice2()).getNickname() + "!", 15, 400);
  noFill();
}

void effectiveText(int effect) {
  fill(0);
  if (effect > 1) {
    text("IT's SUPER EFFECTIVE!", 15, 400);
  } else if (effect > 0 && effect < 1) {
    text("IT'S NOT VERY EFFECTIVE...", 15, 400);
  } else if (effect == 0) {
    text("IT HAD NO EFFECT...", 15, 400);
  }
  noFill();
}

void pokeSummaryUI() {
  fill(0);
  rect(0, height/2, width, height/2);
  noFill();
  PImage summ = loadImage("pokesummary.png");
  image(summ, width/2, 3*height/4);
  fill(255);
  text("BACK", width/2 - 13, height/2 + 10);
  int pokeSlot = state / -111 - 1;
  text(player.getSlot(pokeSlot).getNickname(), 10, 360);
  text(player.getSlot(pokeSlot).getLevel(), 30, 389);
  PImage big = player.getSlot(pokeSlot).getFrontSprite();
  big.resize(100,0);
  image(big,60,500);
  String types = dex.typeToWord(dex.getPrimaryType(dex.getDex(player.getSlot(pokeSlot).getNickname()))).toUpperCase() + " ";
  if (dex.typeToWord(dex.getSecondaryType(dex.getDex(player.getSlot(pokeSlot).getNickname()))) != null) {
    types += dex.typeToWord(dex.getSecondaryType(dex.getDex(player.getSlot(pokeSlot).getNickname()))).toUpperCase();
  }
  text(types, 70 , 389);
  for (int i = 0; i < 4; i++) {
    if (player.getSlot(pokeSlot).getMoves()[i] != null) {
      text(dex.typeToWord(player.getSlot(pokeSlot).getMoves()[i].getType()), 145, 410 + i*45);
      text(player.getSlot(pokeSlot).getMoves()[i].getName().toUpperCase(), 190, 410 + i*45);
      text("PP:" + player.getSlot(pokeSlot).getMoves()[i].getPP() + "/" + player.getSlot(pokeSlot).getMoves()[i].getMaxPP(), 240, 435 + i*45);
    }
  }
  fill(255, 0, 0);
  rect(25, 580, 100, 20, 10); //hp red underlay
  fill(0, 255, 0);
  rect(25, 580, 100 * player.getSlot(pokeSlot).getCurrentHP()/1.0/player.getSlot(pokeSlot).getStats()[1], 20, 10); // hp green overlay
  fill(0);
  text(player.getSlot(pokeSlot).getCurrentHP()+"/"+player.getSlot(pokeSlot).getStats()[1], 60, 595);
}

void afterTurn(Turn first) {
  buttonCount = 1;
  textboxUI();
  fill(0);
  if (first.getCategory() == 0) {
    text(first.getPokemon().getNickname().toUpperCase() + " TRIED TO USE " + first.getPokemon().getMoves()[first.getChoice()] + "!", 15, 400);
  }
  else if (first.getCategory() == 1) {
    text(first.getTrainer().getName() + " SWITCHED OUT " + first.getPokemon().getNickname() + " FOR " + first.getTrainer().getSlot(first.getChoice()).getNickname() + "!", 15, 400);
  }
  else if (first.getCategory() == 2) {
    if (first.getChoice2() > -1) {
      potionTextSummary(first);
    } else {
      ballTextSummary(first);
    }
  }
  state = AFTERTURN;
  noFill();
}

void afterTurn2(Turn second) {
  textboxUI();
  fill(0);
  if (second.getCategory() == 0) {
    text(second.getPokemon().getNickname().toUpperCase() + " TRIED TO USE " + second.getPokemon().getMoves()[second.getChoice()] + "!", 15, 400);
  }
  else if (second.getCategory() == 1) {
    text(second.getTrainer().getName() + " SWITCHED OUT " + second.getPokemon().getNickname() + " FOR " + second.getTrainer().getSlot(second.getChoice()).getNickname() + "!", 15, 400);
  }
  else if (second.getCategory() == 2) {
    if (second.getChoice2() > -1) {
      potionTextSummary(second);
    } else {
      ballTextSummary(second);
    }
  }
  state = AFTERTURN2;
  noFill();
}

int stepUp(Turn first, int step) {
  int val = 0;
  fill(0);
  if (first.getCategory() == 0) {
    moveTextHit(first, step);
    if (battle.battleStatus() != 0) {
      val = 1;
    }
    state = EFFECTIVETEXT;
  }
  else if (first.getCategory() == 2) {
    if (first.getChoice() < 4) {
      val = checkCaught(step);
    }
    state = BALLTEXT;
  }
  return val;
}

int stepUp2(Turn second, int step) {
  int val = 0;
  fill(0);
  if (second.getCategory() == 0) {
    moveTextHit(second, step);
    if (battle.battleStatus() != 0) {
      val = 1;
    }
    state = EFFECTIVETEXT2;
  }
  else if (second.getCategory() == 2) {
    if (second.getChoice() < 4) {
      val = checkCaught(step);
    } else {
      state = BALLTEXT2;
    }
  }
  return val;
}
