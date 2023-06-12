import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Event {
  private int[] coords;
  private PImage sprite;
  private int type, amt;
  private Trainer player;
  private Pokedex dex;
  // 0 == encounter, 1 == trainer, 2 == healer, 3 == item guy, 4 == statue, 5 == gym
  public Event(int type, int[] locat, Trainer player) {
    this.type = type;
    if (type == 0) {
      sprite = loadImage("rock.png");
      amt = 5;
    }
    if (type == 1) {
      sprite = loadImage("npcLeft.png");
      amt = 3;
    }
    if (type == 2) {
      sprite = loadImage("nurseLeft.png");
      amt = 1;
    }
    if (type == 3) {
      sprite = loadImage("shopLeft.png");
      amt = 1;
    }
    if (type == 4) {
      sprite = loadImage("statue.png");
      amt = 1;
    }
    if (type == 5) {
      sprite = loadImage("leaderLeft.png");
      amt = 1;
    }
    coords = new int[2];
    coords[0] = locat[0];
    coords[1] = locat[1];
    this.player = player;
    dex = new Pokedex();
  }
  public int interact(int[] PCoords, int PDirection) {
    if (PCoords[0] == coords[0] + 1 && PCoords[1] == coords[1] && PDirection == 3) {
      if (type == 0) {
        encounterInteract();
      }
      if (type == 1) {
        trainerInteract();
      }
      if (type == 2) {
        healerInteract();
      }
      if (type == 3) {
        shopInteract();
      }
      if (type == 4) {
        statueInteract();
      }
      if (type == 5) {
        gymInteract();
      }
    }
    return 1;
  } 
   void place() {
    image(sprite, coords[0], coords[1]);
  }
  
  void place(int direction) {
    if (direction == UP) {
      setCoords(coords[0], coords[1] + TILE_SIZE);
    }
    if (direction == RIGHT) {
      setCoords(coords[0] - TILE_SIZE, coords[1]);
    }
    if (direction == DOWN) {
      setCoords(coords[0], coords[1] - TILE_SIZE);
    }
    if (direction == LEFT) {
      setCoords(coords[0] + TILE_SIZE, coords[1]);
    }
    place();
  } 
  
  void setCoords(int x, int y) {
    coords[0] = x;
    coords[1] = y;
  }
  
  
  Battle encounterInteract() {
    amt--;
    checkAmt();
    return new Battle(player);
  }
  
  Battle trainerInteract() {
    Trainer enemy = new Trainer("Rival!", new int[]{0, 0}, 0);
    dex.randomizeParty(enemy);
    amt--;
    checkAmt();
    return new Battle(player, enemy);
  }
  
  void healerInteract() {
    for (int i = 0; i < player.checkParty(); i++) {
      player.getSlot(i).setCurrentHP(player.getSlot(i).getStats()[1]);
      player.getSlot(i).clearStatus();
      player.getSlot(i).setFlinchedStatus(false);
      player.getSlot(i).setConfusedStatus(false);
    }
    amt--;
    checkAmt();
  }
  
  void shopInteract() {
    int potOrBall = (int)(Math.random() * 2) + 1;
    if (potOrBall == 1) {
      int typeOfPot = (int)(Math.random() * 3) + 3;
      int amtOfPot = (int)(Math.random() * 10) + 1;
      player.getBag().setItemAmount(typeOfPot, player.getBag().getItemAmount(typeOfPot) + amtOfPot);
    } else {
      int typeOfBall = (int)(Math.random() * 3) + 1;
      int amtOfBall = (int)(Math.random() * 10) + 1;
      player.getBag().setItemAmount(typeOfBall, player.getBag().getItemAmount(typeOfBall) + amtOfBall);
    }
    amt--;
    checkAmt();
  }
  
  Battle statueInteract() {
    Trainer standee = new Trainer("Standee", new int[]{0,0}, player.getBadges() + 2);
    Pokemon foe = dex.randomPokemon(standee);
    amt--;
    checkAmt();
    return new Battle(player, foe);
  }
  
  Battle gymInteract() {
    Trainer gymLeader = new Trainer("Leader", new int[]{0,0}, player.getBadges() + 1);
    dex.randomizeParty(gymLeader);
    amt--;
    checkAmt();
    return new Battle(player, gymLeader);
  }
  
  Battle champInteract() {
    Trainer champion = new Trainer("champ", new int[]{0,0}, player.getBadges() + 2);
    dex.randomizeParty(champion);
    return new Battle(player, champion);
  }
  
  Event randomize() {
    int newType = (int)(Math.random() * 4) + 1;
    return new Event(newType, coords, player);
  }
  
  void checkAmt() {
    if (amt < 1) {
      setCoords(-100,-100);
    }
  }
}
