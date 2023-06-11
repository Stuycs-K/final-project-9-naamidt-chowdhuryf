import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Battle {
  private Trainer player, npc;
  private Pokemon playerActive, npcActive;
  private PriorityQueue<Turn> turnOrder;
  private Pokedex dex;
  private boolean isEncounter;
  private int battleStatus;
  private Move npcRecentMove;
  // battleStatus will return a number based on whether or not the battle is done and if it is won/lost
  // it be 0 if the battle is ongoing, 1 if the player won the battle (it ended), or -1 if the player lost the battle (it ended)
  public Battle(Trainer player, Trainer npc) {
    isEncounter = false;
    this.player = player;
    this.npc = npc;
    updateActive();
    playerActive.clearStatBoosts();
    npcActive.clearStatBoosts();
    dex = new Pokedex();
    turnOrder = new PriorityQueue<Turn>(2, new Turn());
    battleStatus = 0;
    npcRecentMove = null;
  }
  // here's a constructor for wild encounters
  public Battle(Trainer player) {
    Pokemon encounter = dex.randomPokemon(player);
    isEncounter = true;
    this.player = player;
    Trainer temp = new Trainer("Wild "+encounter.getNickname(),new int[]{0,0},player.getBadges());
    temp.setPokemon(0,encounter);
    npc = temp;
    updateActive();
    dex = new Pokedex();
    turnOrder = new PriorityQueue<Turn>(2, new Turn());
    battleStatus = 0;
  }
  public void updateActive() {
    playerActive = player.getSlot(0);
    npcActive = npc.getSlot(0);
  }
  public void win() {
    battleStatus = 1;
  }
  public void lose() {
    battleStatus = -1;
  }
  public void rewardKill(Pokemon murderer, Pokemon victim) {
    murderer.addEvs(victim.getEvYield());
    int expYield = victim.getBaseExp()*victim.getLevel()/5;
    expYield*=(int)(Math.sqrt(Math.pow((2*victim.getLevel()+10)/(victim.getLevel()+murderer.getLevel()+10), 5)))+1;
    murderer.addExp(expYield);
  }
  // NOTE: this method assumes that you are giving it valid arguments, which means the slot that the trainer is swapping into
  // (the slot they are swapping into their first slot) will BOTH have a pokemon AND the pokemon will >0 hp
  // please make sure this is valid before allowing them to swap to a different pokemon
  public void swapDead(Trainer trainer, int slot) {
    trainer.swapSlot(0, slot);
    while (slot<5 && trainer.getSlot(slot+1)!=null && trainer.getSlot(slot+1).getCurrentHP()>0) {
      trainer.swapSlot(slot,slot+1);
      slot++;
    } updateActive();
    trainer.getSlot(0).clearStatBoosts();
  }
  // IMPORTANT: see turn constructor to reference what category and choice mean, and what to initialize them as
  // you will be inputting the player's choice here and it will perform with it
  // also please make sure that the thing they are doing is valid before it goes into the methods
  // ALSO, remember to check win/loss/continue states after every turn to see what you want to do to continue
  // ALSO ALSO, make sure to check if the player needs to swap dead pokemon into battle every turn, and just use the swapDead method directly
  public void turn(int category, int choice, int choice2) {
    Turn playerTurn = new Turn(player, npc, category, choice, choice2);
    int npcChoice = (int)(Math.random() * 4);
    npcRecentMove = null;
    while (npcActive.getMoveSlot(npcChoice)==null) {
       npcChoice = (int)(Math.random() * 4);
    } Turn npcTurn = new Turn(npc, player, 0, npcChoice);
    turnOrder.add(playerTurn);
    turnOrder.add(npcTurn);
  }
  // returns -1 if there is no turn (a pokemon moved first and KOd the other pokemon, so the turn ends after they switch)
  // else, returns a perform key code
  public int stepTurn() {
    Turn turn = turnOrder.poll();
    if (turn==null) {
      return -1;
    } return perform(turn);
  }
  public void turn(int category, int choice) {
    turn(category, choice, -1);
  }
  
  // RETURN KEY
  // 0 - normal attack/item use, did nothing special
  // 1 - critical hit
  // 2 - move missed
  // 3 - capture success
  // 4 - paralyzed and couldnt move
  // 5 - frozen and couldnt move
  // 6 - asleep and couldnt move
  public int perform(Turn turn) {
    int returnVal = 0;
    Trainer trainer = turn.getTrainer();
    Trainer otherTrainer = turn.getOtherTrainer();
    if (turn.getCategory()==0) { // using a pokemons move
      Pokemon attacker = turn.getPokemon();
      Pokemon defender = turn.getOtherPokemon();
      int paraCheck = (int)(Math.random()*4);
      if (paraCheck==0&&attacker.getStatus()==3) {
        return 4;
      }
      int freezeCheck = (int)(Math.random()*5);
      if (freezeCheck!=0&&attacker.getStatus()==2) {
        return 5;
      } if (attacker.getStatus()==2) {
        attacker.clearStatus();
      }
      int sleepCheck = (int)(Math.random()*10);
      if (sleepCheck>3&&attacker.getStatus()==4) {
        return 6;
      } if (attacker.getStatus()==4) {
        attacker.clearStatus();
      }
      // basically, these are checks for para/sleep/freeze conditions
      Move move = attacker.getMoveSlot(turn.getChoice());
      if (trainer==npc) { // if the attacking trainer is the npc, save their move
        npcRecentMove = move;
      } int damage = dex.damageCalculator(attacker, defender, move);
      double critMultiplier = 1;
       if ((int)(Math.random()*16)==0) {
         critMultiplier=1.5;
         returnVal = 1;
      } damage=(int)(damage*critMultiplier);
      move.changePP(1);
      int accuracyCheck = (int)(Math.random()*100);
      if (accuracyCheck>move.getAccuracy()) {
        return 2;
      }
      defender.changeHP(damage);
      if (move.getType()==10&&defender.getStatus()==2) { // if the defending pokemon is hit with a fire-type move while frozen, then thaw them out
        defender.clearStatus();
      }
      // deals standard damage by this point
      if (defender.getCurrentHP()<=0) { // if the defending pokemon faints
        rewardKill(attacker, defender);
        if (otherTrainer.getSlot(1)==null || otherTrainer.getSlot(1).getCurrentHP()<=0) { // if the other trainer doesnt have any more usable pokemon
          if (trainer == player) { // if we are the trainer that just attacked and beat the other trainer\
            win();
          } else { // if we just got beat up
            lose();
          }
        } if (otherTrainer == npc) { 
          // if the npc lost a pokemon, just swap it with the next pokemon they have
          // if they didnt have a next pokemon to swap into, they wouldve alr lost in the stuff above
          // this means that if the PLAYER loses a pokemon, you need to check in the ui for that and swapDead according to their input
          swapDead(npc,1);
          npcActive.clearStatBoosts();
        }
      } return returnVal;
    } if (turn.getCategory()==1) { // switching active pokemon
      trainer.swapSlot(0,turn.getChoice());
      updateActive();
      playerActive.clearStatBoosts();
    } if (turn.getCategory()==2) { // using an item
      Bag bag = trainer.getBag();
      if (turn.getChoice2()==-1) { // we are targeting the enemy's active pokemon
        if (bag.use(isEncounter,turn.getChoice(),otherTrainer.getSlot(0))) {
          win();
          return 3;
        }
      } else { // we are using a healing item on our own party
        bag.use(isEncounter,turn.getChoice(),trainer.getSlot(turn.getChoice2()));
      }
    } return returnVal;
  }
  public void endTurn() { // make sure that you force the player to switch if their pokemon died after burn/poison damage 
    if (playerActive.getStatus()==1||playerActive.getStatus()==5) {
      playerActive.changeHP(playerActive.getStats()[1]/8);
    } if (npcActive.getStatus()==1||npcActive.getStatus()==5) {
      npcActive.changeHP(npcActive.getStats()[1]/8);
    } if (playerActive.getCurrentHP()<=0&&(player.getSlot(1)==null||player.getSlot(1).getCurrentHP()<=0)) { //if your pokemon died & you have nothing to switch in
      lose();
    } if (npcActive.getCurrentHP()<=0) { // if the npcs pokemon died 
      if (npc.getSlot(1)==null||npc.getSlot(1).getCurrentHP()<=0) { // if it has nothing to switch in
        win();
      } swapDead(npc,1);
    }
  }
  
  public Trainer getPlayer() {
    return player;
  }
  public Trainer getNpc() {
    return npc;
  }
  public Pokemon getPlayerActive() {
    return playerActive;
  }
  public Pokemon getNpcActive() {
    return npcActive;
  }
  public boolean isEncounter() {
    return isEncounter;
  }
  public int battleStatus() {
    return battleStatus;
  }
  // this will return null if the enemy has not recently made a move
  public Move getEnemyMove() {
    return npcRecentMove;
  }
}
class Turn implements Comparator<Turn> { 
  private int priority, category;
  // category represents the type of turn the player is taking
  // 0 is for a standard attacking move, 1 is for switching, 2 is for using an item
  private Trainer trainer, otherTrainer;
  private Pokemon pokemon, otherPokemon;
  // choice is meant to represent either the moveslot that is being used (if attacking)
  // the pokemon slot that is being switched into the field (if switching)
  // the id of an item that is being used (if using an item)
  // choice2 is only used for when you are using a healing item, and it indicates which slot of your own pokemon you want to use it on
  // this is because choice1 already needs to take up the item id for when you sue items
  private int choice, choice2;
  // Do not use this empty constructor pls ty
  public Turn() {}
  // CONSTRUCTOR NOTE: if the player is using an item, use this constructor. Otherwise, use the one below it to specify which slot it will be targeting
  // don't worry about pokeball vs healing item, my code does that for you so long as you give it valid ids
  // this -1 in choice2 means we are not selecting our own pokemon, which means we are either attacking the enemy pokemon, switching, or using a pokeball
  public Turn(Trainer trainer, Trainer otherTrainer, int category, int choice) {
    this(trainer,otherTrainer,category,choice,-1);
  }
  public Turn(Trainer trainer, Trainer otherTrainer, int category, int choice, int choice2) {
    this.choice2 = choice2;
    this.trainer = trainer;
    this.otherTrainer = otherTrainer;
    this.category = category;
    this.choice = choice;
    pokemon = trainer.getSlot(0);
    otherPokemon = otherTrainer.getSlot(0);
    if (category==0) { // attacking move
      Move move = pokemon.getMoveSlot(choice);
      priority = move.getPriority();
    } if (category==1) { // switching
      priority = 6;
    } if (category==2) { // item
      priority = 7;
    }
  }
  public Trainer getTrainer() {
    return trainer;
  }
  public Trainer getOtherTrainer() {
    return otherTrainer;
  }
  public int getChoice() {
    return choice;
  }
  public int getChoice2() {
    return choice2;
  }
  public int getPriority() {
    return priority;
  }
  public int getCategory() {
    return category;
  }
  public Pokemon getPokemon() {
    return pokemon;
  }
  public Pokemon getOtherPokemon() {
    return otherPokemon;
  }
  @Override 
  public int compare(Turn turn1, Turn turn2) {
    if (turn1.getPriority()!=turn2.getPriority()) {
      if (turn1.getPriority()>turn2.getPriority()) {
        return -1;
      } if (turn1.getPriority()<turn2.getPriority()) {
        return 1;
      } return 0;
    }
    double speedMult1 = dex.getBoostToVal(turn1.getPokemon.getStatBoosts()[6]);
    if (turn1.getPokemon().getStatus()==3) { // if they are parad
      speedMult1 = 0.5;
    } 
    double speedMult2 = dex.getBoostToVal(turn2.getPokemon.getStatBoosts()[6]);
    if (turn2.getPokemon().getStatus()==3) { // if they are parad
      speedMult2 = 0.5;
    } 
    if (turn1.getPokemon().getStats()[5]*speedMult1>turn2.getPokemon().getStats()[5]*speedMult2) {
      return -1;
    } if (turn1.getPokemon().getStats()[5]*speedMult1<turn2.getPokemon().getStats()[5]*speedMult2) {
      return 1;
    } return 0;
  }
}
