import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Battle {
  private Trainer player, npc;
  private Pokemon playerActive, npcActive;
  private PriorityQueue<Action> turnOrder;
  private Pokedex dex;
  private String userChoice;
  private int moveChoice;
  private boolean encounter;
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
  public void win() {
    System.out.println("yay you win");
  }
  public void lose() {
    System.out.println("no you lose");
  }
  public void updateActive() {
    playerActive = player.getSlot(0);
    npcActive = npc.getSlot(0);
  }
  public void swapDead(Trainer trainer, int slot) {
    trainer.swapSlot(0,slot);
    while (slot<5&&trainer.getSlot(slot+1).getCurrentHP()>0) {
      trainer.swapSlot(slot,slot+1);
      slot++;
    } 
  }
  public void setUserChoice(String choice) {
    userChoice = choice;
  }
  public void setMoveChoice(int choice) {
    moveChoice = choice;
  }
}
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
