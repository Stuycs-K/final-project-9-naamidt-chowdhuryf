import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Battle {
    private Trainer player;
    private Trainer npc;
    private Pokemon playerActive;
    private Pokemon npcActive;
    private PriorityQueue<Action> turnOrder;
    public Battle(Trainer player, Trainer npc) {
        this.player = player;
        this.npc = npc;
        playerActive = player.getSlot(0);
        npcActive = npc.getSlot(0);
        turnOrder = new PriorityQueue<Action>(2, new Action());
    }
    public void turn(String choice, int moveChoice) {
        Action playerAction = new Action(player, npc, playerActive, choice, moveChoice);
        Action npcAction = new Action(npc, player, npcActive,"Attack",(int)(Math.random()*4));
        turnOrder.add(playerAction);
        turnOrder.add(npcAction);
        Action turn;
        turn = turnOrder.poll();
        perform(turn);
        turn = turnOrder.poll();
        perform(turn);
    }
    public void perform(Action turn) {
        Trainer trainer,otherTrainer;
        trainer = turn.getTrainer();
        otherTrainer = turn.getOtherTrainer();
        Pokemon attacker = trainer.getSlot(0);
        Pokemon defender = otherTrainer.getSlot(0);
        otherTrainer = turn.getOtherTrainer();
        if (turn.getChoice().equals("Switch")) {
            if (trainer.getSlot(turn.getMoveChoice()).getCurrentHP()>0) {
                trainer.swapSlot(0, turn.getMoveChoice());
                playerActive = player.getSlot(0);
                npcActive = npc.getSlot(0);
            }
        } else {
            int damage = Pokedex.damageCalculator(attacker,defender,attacker.getMoveSlot(turn.getMoveChoice()));
            attacker.getMoveSlot(turn.getMoveChoice()).decreasePP(1);
            otherTrainer.getSlot(0).changeHP(-1*damage);
            if (otherTrainer.getSlot(0).getCurrentHP()<=0) {
                Boolean end = true;
                for (int i=1;i<6;i++) {
                    if (otherTrainer.getSlot(i).getCurrentHP()>0) {
                        otherTrainer.swapSlot(0, i);
                        playerActive = player.getSlot(0);
                        npcActive = npc.getSlot(0);
                        end = false;
                        break;
                    }
                } if (end) {
                    if (otherTrainer==npc) {
                        win();
                    } lose();
                }
            }
        }
    }
    public void win() {
        System.out.println("yay");
    }
    public void lose() {
        System.out.println("no");
    }
}
class Action implements Comparator<Action> {
    private int priority, moveChoice;
    private Trainer trainer, otherTrainer;
    private Pokemon pokemon;
    private String choice;
    public Action() {}
    public Action(Trainer trainer, Trainer otherTrainer, Pokemon pokemon, String choice, int moveChoice) {
        this.trainer = trainer;
        this.otherTrainer = otherTrainer;
        this.pokemon = pokemon;
        this.choice = choice;
        this.moveChoice = moveChoice;
        priority = 1;
        if (choice.equals("Switch")) {
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
            } return 1;
        } if (action1.pokemon.getStats()[5]>action2.pokemon.getStats()[5]) {
            return -1;
        } if (action1.pokemon.getStats()[5]<action2.pokemon.getStats()[5]) {
            return 1;
        } return 0;
    }
}
