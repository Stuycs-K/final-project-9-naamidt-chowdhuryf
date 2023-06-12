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
  private int pokeNum;
  private Bag bag;
  public Trainer(String name, int[] position, int badges) {
    this.name = name;
    this.position = position;
    this.badges = badges;
    party = new Pokemon[6];
    bag = new Bag();
  }
  public int[] getPosition() {
    return position;
  }
  public void setPosition(int[] newPosition) {
    position = newPosition;
  }
  public int getBadges() {
    return badges;
  }
  public void setBadges(int newBadges) {
    badges = newBadges;
  }
  public Bag getBag() {
    return bag;
  }
  public Pokemon[] getParty() {
    return party;
  }
  public void setPokemon(int slot, Pokemon pokemon) {
    party[slot] = pokemon;
    pokeNum++;
  }
  
  public int checkParty() {
   for (int i = 0; i < party.length; i++) {
     if (party[i] == null) {
       return i;
     }
   }
   return 6;
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
  
  public int getNum() {
    return pokeNum;
  }
}
