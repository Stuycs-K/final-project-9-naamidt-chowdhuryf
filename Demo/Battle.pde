import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;
// tl;dr you will want to change this class a lot
public class Battle {
  private Trainer player, npc;
  private Pokemon playerActive, npcActive;
  private PriorityQueue<Action> turnOrder;
  private Pokedex dex;
  private String userChoice;
  private int moveChoice;
  private boolean encounter;
  // this is the nromal constructor for trainer battles
  public Battle(Trainer player, Trainer npc) {
    this.player = player;
    this.npc = npc;
    updateActive();
    turnOrder = new PriorityQueue<Action>(2, new Action());
    dex = new Pokedex();
    encounter = false;
  }
  // this constructor is used for wild encounters
  public Battle(Trainer player) {
    this.player = player;
    Pokemon random = dex.randomPokemon((int)(Math.random()*(player.getBadges()*10+10))+1);
    npc = new Trainer("Wild "+random.getNickname(),new int[]{0,0},0);
    npc.setPokemon(0,random);
    encounter = true;
  }
  // turn means like 1 user choice (like they select to use a move or to use an item)
  // choice is the general thing they do (item, fight, switch)
  // moveChoice is like the # thing they use 
      // so like fight 3 would mean the last moveslot of a pokemon depending
      // on how you want to interpret it
  public void turn(String choice, int moveChoice) {
    Action playerAction = new Action(player, npc, playerActive, choice, moveChoice);
    Action npcAction = new Action(npc, player, npcActive, "Attack", (int)(Math.random()*4));
    turnOrder.add(playerAction);
    turnOrder.add(npcAction);
    Action turn;
    turn = turnOrder.poll();
    perform(turn);
    turn = turnOrder.poll();
    perform(turn);
  }
  // perform is just meant to do the turn
  public void perform(Action turn) {
    Trainer trainer, otherTrainer;
    trainer = turn.getTrainer();
    otherTrainer = turn.getOtherTrainer();
    Pokemon attacker = trainer.getSlot(0);
    Pokemon defender = otherTrainer.getSlot(0);
    otherTrainer = turn.getOtherTrainer();
    if (turn.getChoice().equals("Switch")) {
      trainer.swapSlot(0, turn.getMoveChoice());
      updateActive();
      return;
    } if (!turn.getChoice().equals("Fight")) {
      boolean catchAttempt = trainer.getBag().getPokeball(turn.getChoice())!=-1;
      boolean result;
      if (catchAttempt) {
        result = trainer.getBag().use(encounter,turn.getChoice(),otherTrainer.getSlot(0));
        if (result) {
          trainer.setPokemon(5, otherTrainer.getSlot(0));
          win();
        }
      } else {
        result = trainer.getBag().use(encounter,turn.getChoice(),trainer.getSlot(0));
      }
    }
    else {
      int damage = dex.damageCalculator(attacker, defender, attacker.getMoveSlot(turn.getMoveChoice()));
      attacker.getMoveSlot(turn.getMoveChoice()).changePP(1);
      otherTrainer.getSlot(0).changeHP(-1*damage);
      if (otherTrainer.getSlot(0).getCurrentHP()<=0) {
        if (otherTrainer.getSlot(1).getCurrentHP()<=0) {
          if (otherTrainer==npc) {
            win();
          } else {
            lose();
          }
        } swapDead(otherTrainer, 1);
      }
    }
  }
  // win shit here, you probably want to make something better
  public void win() {
    System.out.println("yay you win");
  }
  // same idea for loss
  public void lose() {
    System.out.println("no you lose");
  }
  // helper method to make sure everyone on the field is everyone's slot 0 in party
  public void updateActive() {
    playerActive = player.getSlot(0);
    npcActive = npc.getSlot(0);
  }
  // use this method when the current active pokemon is dead for the trainer
  // slot is the pokemon the slot they want to swap in
      // this method basically puts dead pokemon at the end of the party
  public void swapDead(Trainer trainer, int slot) {
    trainer.swapSlot(0,slot);
    while (slot<5&&trainer.getSlot(slot+1).getCurrentHP()>0) {
      trainer.swapSlot(slot,slot+1);
      slot++;
    } 
  }
  // set methods
  public void setUserChoice(String choice) {
    userChoice = choice;
  }
  public void setMoveChoice(int choice) {
    moveChoice = choice;
  }
  // give evs and exp upon killing a pokemon, so you can level up and stuff
  public void rewardKill(Pokemon murderer, Pokemon victim) {
    murderer.addEvs(victim.getEvYield());
    int expYield = victim.getBaseExp()*victim.getLevel()/5;
    expYield*=(int)(Math.sqrt(Math.pow((2*victim.getLevel()+10)/(victim.getLevel()+murderer.getLevel()+10),5)))+1;
    murderer.addExp(expYield);
  }
}
// helper class, primarily to implement priority for switching
// ironically, it was not build very well for normal priority moves and
// we will not have switching probably so... yeah
class Action implements Comparator<Action> {
  private int priority, moveChoice;
  private Trainer trainer, otherTrainer;
  private Pokemon pokemon;
  private String choice;
  public Action() {
  }
  public Action(Trainer trainer, Trainer otherTrainer, Pokemon pokemon, String choice, int moveChoice) {
    this.trainer = trainer;
    this.otherTrainer = otherTrainer;
    this.pokemon = pokemon;
    this.choice = choice;
    this.moveChoice = moveChoice;
    priority = 1;
    if (choice.equals("Switch") || choice.equals("Item")) {
      priority = 6;
    }
  }
  public String getChoice() {
    return choice;
  }
  public Trainer getTrainer() {
    return trainer;
  }
  public Trainer getOtherTrainer() {
    return otherTrainer;
  }
  public int getMoveChoice() {
    return moveChoice;
  }
  @Override
    public int compare(Action action1, Action action2) {
    if (action1.priority!=action2.priority) {
      if (action1.priority==6) {
        return -1;
      }
      return 1;
    }
    if (action1.pokemon.getStats()[5]>action2.pokemon.getStats()[5]) {
      return -1;
    }
    if (action1.pokemon.getStats()[5]<action2.pokemon.getStats()[5]) {
      return 1;
    }
    return 0;
  }
}
