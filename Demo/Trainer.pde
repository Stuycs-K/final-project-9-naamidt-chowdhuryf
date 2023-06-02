import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Trainer {
  private String name;
  private int[] position;
  private int badges;
  private PImage sprite;
  private Pokemon[] party;
   private Bag bag;
  public Trainer(String name, int[] position, int badges) {
    this.name = name;
    this.position = position;
    this.badges = badges;
    party = new Pokemon[6];
    bag = new Bag();
  }
  public int getBadges() {
    return badges;
  }
  public Bag getBag() {
    return bag;
  }
  public Pokemon[] getParty() {
    return party;
  }
  public void setPokemon(int slot, Pokemon pokemon) {
    party[slot] = pokemon;
  }
  
  public int checkParty() {
   for (int i = 0; i < party.length; i++) {
     if (party[i] == null) {
       return i;
     }
   }
   return -1;
  }
  
  public void swapSlot(int slot1, int slot2) {
    Pokemon pokemon = party[slot1];
    party[slot1] = party[slot2];
    party[slot2] = pokemon;
  }
  public Pokemon getSlot(int slot) {
    return party[slot];
  }
  public String toString() {
    String ret = name+" ("+badges+" badges): \n";
    for (Pokemon pokemon : party) {
      if (pokemon == null) {
        break;
      }
      ret+=pokemon.toString()+"\n";
    } return ret;
  }
  public String getName() {
    return name;
  }
}
