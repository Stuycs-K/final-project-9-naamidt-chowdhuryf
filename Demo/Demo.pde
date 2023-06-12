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
static final int EFFECTIVETEXTFINAL = -3000;
static final int BALLTEXTFINAL = -5000;
static final int POTIONTEXT = 6000;
static final int AFTERTURN = 1010;
static final int AFTERTURN2 = 101;

Map map;
int state;
Battle battle;
int countdown;
Trainer player, chad;
Pokedex dex;
int buttonCount, direction, encountersLeft, trainersLeft, elite4progress;
Turn turn;
void setup() {
  countdown = 0;
  imageMode(CENTER);
  state = 0;
  size(300, 600);
  background(0);
  map = new Map("testmap.txt");
  mapUI();
  dex = new Pokedex();
  player = new Trainer("Me!", new int[]{7,4}, 0);
  Pokemon random = dex.randomPokemon(player);
  random.addExp(100);
  player.setPokemon(0, random);
  encountersLeft = 10;
  trainersLeft = 5;
  /////////// TESTING ///////////////////////
  // bulbasaur
  Pokemon bulbasaur = new Pokemon(35,"Bulbasaur",1);
  bulbasaur.addEvs(new int[]{0,0,0,0,252,0,252});
  bulbasaur.setMoveSlot(0,dex.getMove(202));
  bulbasaur.setMoveSlot(1,dex.getMove(38));
  bulbasaur.setMoveSlot(2,dex.getMove(261));
  bulbasaur.setMoveSlot(3,dex.getMove(105));
  bulbasaur.setMoveSlot(3,dex.getMove(153)); // art is an explosion
  //walrein
  Pokemon walrein = new Pokemon(30,"works",365);
  walrein.addEvs(new int[]{0,252,0,0,0,0,0});
  walrein.setMoveSlot(0,dex.getMove(252));
  walrein.setMoveSlot(1,dex.getMove(109));
  walrein.setMoveSlot(2,dex.getMove(14));
  walrein.setMoveSlot(3,dex.getMove(103));
  walrein.setMoveSlot(3,dex.getMove(97));
  //player.setPokemon(1,bulbasaur);
  //player.setPokemon(0,walrein);
  //System.out.println(walrein.getStats()[1]);
  ////////////////////////////////////////
  buttonCount = 4;
  turn = new Turn();

  chad = new Trainer("Chad",new int[]{0,0},100);
  // marshadow
  Pokemon marshadow = new Pokemon(100,"no yoinkage",802);
  marshadow.addEvs(new int[]{0,0,252,0,0,0,252});
  marshadow.setMoveSlot(0,dex.getMove(712));
  marshadow.setMoveSlot(1,dex.getMove(370));
  marshadow.setMoveSlot(2,dex.getMove(409));
  marshadow.setMoveSlot(3,dex.getMove(8));
  // metagross
  Pokemon metagross = new Pokemon(100,"bell had no say",376);
  metagross.addEvs(new int[]{0,0,252,0,0,0,252});
  metagross.setMoveSlot(0,dex.getMove(309));
  metagross.setMoveSlot(1,dex.getMove(89));
  metagross.setMoveSlot(2,dex.getMove(428));
  metagross.setMoveSlot(3,dex.getMove(153));
  // rayquaza
  Pokemon rayquaza = new Pokemon(100,"inevitable",384);
  rayquaza.addEvs(new int[]{0,0,0,0,252,0,252});
  rayquaza.setMoveSlot(0,dex.getMove(434));
  rayquaza.setMoveSlot(1,dex.getMove(63));
  rayquaza.setMoveSlot(2,dex.getMove(53));
  rayquaza.setMoveSlot(3,dex.getMove(85));
  // regieleki
  Pokemon regieleki = new Pokemon(100,"zoom zoom",894);
  regieleki.addEvs(new int[]{0,252,0,0,252,0,0});
  regieleki.setMoveSlot(0,dex.getMove(85));
  regieleki.setMoveSlot(1,dex.getMove(58));
  regieleki.setMoveSlot(2,dex.getMove(802));
  regieleki.setMoveSlot(3,dex.getMove(417));
  // regigigas
  Pokemon regigigas = new Pokemon(100,"no slow anymo",486);
  regigigas.addEvs(new int[]{0,0,252,0,0,0,252});
  regigigas.setMoveSlot(0,dex.getMove(416));
  regigigas.setMoveSlot(1,dex.getMove(153));
  regigigas.setMoveSlot(2,dex.getMove(893));
  regigigas.setMoveSlot(3,dex.getMove(413));
  // xerneas
  Pokemon xerneas = new Pokemon(100,"geomancy nerf",716);
  xerneas.addEvs(new int[]{0,0,0,0,252,0,252});
  xerneas.setMoveSlot(0,dex.getMove(601));
  xerneas.setMoveSlot(1,dex.getMove(585));
  xerneas.setMoveSlot(2,dex.getMove(53));
  xerneas.setMoveSlot(3,dex.getMove(94));
  chad.setPokemon(0,marshadow);
  chad.setPokemon(1,metagross);
  chad.setPokemon(2,rayquaza);
  chad.setPokemon(3,regieleki);
  chad.setPokemon(4,regigigas);
  chad.setPokemon(5,xerneas);
}

void keyPressed() {
  if (state == MAP || state == POKEMON) {
    int[] position = player.getPosition();
    if (key == 'w') {
      if (map.getTileGrid()[position[0]-1][position[1]].checkWalkable()) {
        int[] newPosition = player.getPosition();
        newPosition[0]--;
        player.setPosition(newPosition);
        map.move(UP);
      }
      direction = 0;
    }
    if (key == 'd') {
      if (map.getTileGrid()[position[0]][position[1]+1].checkWalkable()) {
        int[] newPosition = player.getPosition();
        newPosition[1]++;
        player.setPosition(newPosition);
        map.move(RIGHT);
        direction = 3;
      }
    }
    if (key == 's') {
      if (map.getTileGrid()[position[0]-1][position[1]].checkWalkable()) {
        int[] newPosition = player.getPosition();
        newPosition[0]++;
        player.setPosition(newPosition);
        map.move(DOWN);
      }
      direction = 2;
    }
    if (key == 'a') {
      if (map.getTileGrid()[position[0]][position[1]-1].checkWalkable()) {
        int[] newPosition = player.getPosition();
        newPosition[1]--;
        player.setPosition(newPosition);
        map.move(LEFT);
      }
      direction = 1;
    }
    if (key == 'b') {
      if (encountersLeft>0) {
        battle = new Battle(player);
        state = BATTLE;
        encountersLeft--;
      }
    }
    if (key == 't') {
      if (trainersLeft>0) {
        Trainer enemy = new Trainer("Rival!", new int[]{0, 0}, player.getBadges());
        dex.randomizeParty(enemy);
        battle = new Battle(player, enemy);
        state = BATTLE;
        trainersLeft--;
      } else {
        if (elite4progress==3) {
          Trainer enemy = new Trainer("Champion!", new int[]{0, 0}, player.getBadges()+2);
          dex.randomizeParty(enemy);
          battle = new Battle(player, enemy);
          state = BATTLE;
          if (player.getSlot(0).getCurrentHP()>0) {
            System.out.println("yay win");
          } else {
            System.out.println("noo loss");
          }
        } else {
          Trainer enemy = new Trainer("Leader!", new int[]{0, 0}, player.getBadges()+1);
          dex.randomizeParty(enemy);
          battle = new Battle(player, enemy);
          state = BATTLE;
          if (player.getBadges()==8) {
            elite4progress++;
          } else {
            player.setBadges(player.getBadges()+1);
          } encountersLeft = 10;
          trainersLeft = 5;
        }
      }
    }
    if (key == 'h') {
      for (int i = 0; i < player.checkParty(); i++) {
        player.getSlot(i).setCurrentHP(player.getSlot(i).getStats()[1]);
        player.getSlot(i).clearStatus();
        player.getSlot(i).setFlinchedStatus(false);
        player.getSlot(i).setConfusedStatus(false);
      }
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
    //if (key == 'f') {
    //  map.getTileGrid()[position[0]][position[1]].interact(direction);
    //}
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
  if (key == 'p') {
    for (int i=0;i<6;i++) { // swap all your pokemon with chad;
      Pokemon middleman = chad.getSlot(i);
      chad.setPokemon(i,player.getSlot(i));
      player.setPokemon(i,middleman);
    }
  }
}

void draw() {
  if (countdown > 0) {
    countdown--;
  }
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
    afterTurn(battle.getNextTurn()); //<>//
    noFill();
  } else if (state == POTIONS) {
    PokeUI();
    state = SPot; //<>//
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
    battle.turn(2, 1); //<>//
    afterTurn(battle.getNextTurn());
  }
}
 //<>//
void bigButton() { //when its just checking for a mouse press to go past a text segment
  if (state == TEXTBOX) {
    checkBattle(battle);
  }
  else if (state == WIN) {
    state = MAP;
    mapUI();
  }
  else if (state == AFTERTURN) {
    turn = battle.getNextTurn();
    int step = battle.stepTurn();
    int val = stepUp(turn, step);
    updateHealthBar();
    updateEXP();
    if (val == 0) {
      state = AFTERTURN2;
    }
    else if (val < 0) {
      if (val == -1) {
        state = EFFECTIVETEXTFINAL;
      } else {
        state = BALLTEXTFINAL;
      }
    }
    else if (val > 0) {
      if (val == 1) {
        state = EFFECTIVETEXT;
      } else {
        state = BALLTEXT;
      }
    }
  }
  else if (state == BALLTEXT) {
    textboxUI(); //<>//
    fill(0);
    text(battle.getNpcActive().getNickname().toUpperCase() + " BROKE FREE!", 15, 400);
    noFill();
    state = AFTERTURN2; //<>//
  }
  else if (state == BALLTEXTFINAL) {
    textboxUI();
    fill(0);
    text("YOU SUCCESFULLY CAPTURED " + battle.getNpcActive().getNickname().toUpperCase() + "!", 15, 400);
    noFill();
    if (player.checkParty() < 6) {
      player.setPokemon(player.checkParty(), battle.getNpcActive());
    } else {
      player.setPokemon(5, battle.getNpcActive());
    }
    state = TEXTBOX;
  }
  else if (state == EFFECTIVETEXT) {
    effectiveText(dex.getAdvantage(turn.getOtherPokemon(), turn.getPokemon().getMoves()[turn.getChoice()]));
    state = AFTERTURN2;
  }
  else if (state == EFFECTIVETEXTFINAL) {
    if (turn==null) {
      state = TEXTBOX;
      return;
    }
    effectiveText(dex.getAdvantage(turn.getOtherPokemon(), turn.getPokemon().getMoves()[turn.getChoice()]));
    state = TEXTBOX;
  } //<>//
  else if (state == AFTERTURN2) { //<>//
    turn = battle.getNextTurn();
    int step = battle.stepTurn(); //<>//
    int val = stepUp(turn, step); //<>//
    afterTurn(turn);
    battle.endTurn();
    updateHealthBar();
    updateEXP();
    if (val < 0) {
      if (val == -1) {
        state = EFFECTIVETEXTFINAL;
      } else {
        state = BALLTEXTFINAL;
      }
    }
    else if (val > 0) {
      if (val == 1) {
        state = EFFECTIVETEXTFINAL;
      } else {
        state = BALLTEXTFINAL;
      }
    }
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

void effectiveText(double effect) {
  fill(0);
  if (effect > 1) {
    textboxUI();
    text("IT's SUPER EFFECTIVE!", 15, 400);
  } else if (effect > 0 && effect < 1) {
    textboxUI();
    text("IT'S NOT VERY EFFECTIVE...", 15, 400);
  } else if (effect == 0) {
    textboxUI();
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
  String types = dex.typeToWord(dex.getPrimaryType(player.getSlot(pokeSlot).getDexNumber())).toUpperCase() + " ";
  if (dex.typeToWord(dex.getSecondaryType(player.getSlot(pokeSlot).getDexNumber())) != null) {
    types += dex.typeToWord(dex.getSecondaryType(player.getSlot(pokeSlot).getDexNumber())).toUpperCase();
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
  if (first==null) {
    return;
  }
  if (first.getCategory() == 0) {
    text(first.getPokemon().getNickname().toUpperCase() + " TRIED TO USE " + first.getPokemon().getMoves()[first.getChoice()].getName().toUpperCase() + "!", 15, 400);
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

int stepUp(Turn second, int step) {
  int val = 0; //nothing special needs to be shown
  fill(0);
  if (second==null) {
    return -1;
  }
  if (second.getCategory() == 0) {
    moveTextHit(second, step);
    if (battle.battleStatus() != 0) {
      val = -1; //battle is over, need to show effective
    } else {
      val = 1; //battle is not over, need to show effective
    }
  }
  else if (second.getCategory() == 2) {
    if (second.getChoice() < 4) {
      if (step == 3) {
        val = -2; //battle is over, poke caught
      }
      else {
        val = 2; //battle is not over, poke free
      }
    }
  }
  return val;
}
