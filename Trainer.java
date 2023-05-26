import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Trainer {
  private String name;
  private int[] position;
  private int badges;
  // private PImage sprite;
  private Pokemon[] party;
  // private Bag bag;
  public Trainer(String name, int[] position, int badges) {
    this.name = name;
    this.position = position;
    this.badges = badges;
    party = new Pokemon[6];
  }
  public void setPokemon(int slot, Pokemon pokemon) {
    party[slot] = pokemon;
  }
  public void swapSlot(int slot1, int slot2) {
    Pokemon pokemon = party[slot1];
    party[slot1] = party[slot2];
    party[slot2] = pokemon;
  }
  public Pokemon getSlot(int slot) {
    return party[slot];
  }
}
