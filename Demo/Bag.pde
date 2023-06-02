import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

class Bag {
  private int[] pokeballs, healingItems;
  private String[] pokeballNames, healingItemNames;
  public Bag() {
    pokeballs = new int[3];
    pokeballNames = new String[]{"Pokeball", "Great Ball", "Ultra Ball"};
    healingItems = new int[4];
    // might make a seperate array for status ailment stuff
    healingItemNames = new String[]{"Potion", "Super Potion", "Hyper Potion", "Ultra Potion"};
  }
  // encounter makes sure you're not pokeballing on an enemy trainer
  // name is the name of the item that you want to use
  // target is the pokemon either being caught or healed
  
  public boolean use(boolean encounter, String name, Pokemon target) {
    // basically, youre not using pokeballs in anything but encounters
    for (int i=0;i<pokeballNames.length;i++) {
      if (name.equals(pokeballNames[i])&&pokeballs[i]>0) {
        if (!encounter) {
          pokeballs[i]--;
          return catchAttempt(target, getValue(name));
        } return false;
      }
    } for (int i=0;i<healingItemNames.length;i++) {
      if (healingItemNames[i].equals(name)&&healingItems[i]>0) {
        healingItems[i]--;
        target.changeHP((int)getValue(name));
      }
    } return false;
  }
  // oops, this is not the proper catch formula. oh well, use it i guess??
  // mult is the multiplier by the pokeball type
  public boolean catchAttempt(Pokemon encounter, double mult) {
    double odds = ((3*encounter.getStats()[0]-2*encounter.getCurrentHP())*4096*mult)/(3*encounter.getStats()[0]);
    double roll = Math.random()*4096;
    if (roll<odds) {
      return true;
    } return false;  
  }
  // set/get methods use the name of the item itself
  public void setPokeball(String name, int amount) {
    for (int i=0;i<pokeballNames.length;i++) {
      if (pokeballNames[i].equals(name)) {
        pokeballs[i]=amount;
      }
    }
  }
  public int getPokeball(String name) {
    for (int i=0;i<pokeballNames.length;i++) {
      if (pokeballNames[i].equals(name)) {
        return pokeballs[i];
      }
    } return -1;
  }
  public void setHealingItem(String name, int amount) {
    for (int i=0;i<healingItemNames.length;i++) {
      if (healingItemNames[i].equals(name)) {
        healingItems[i]=amount;
      }
    }
  }
  public int getHealingItem(String name) {
    for (int i=0;i<healingItemNames.length;i++) {
      if (healingItemNames[i].equals(name)) {
        return healingItems[i];
      }
    } return -1;
  }
  // get value returns either the catch multiplier if it is a pokeball
  // or the healing amount if it is a potion
  public double getValue(String name) {
    double value = 1;
    for (int i=0;i<pokeballNames.length;i++) {
      if (pokeballNames[i].equals(name)) {
        return value;
      } value+=0.5;
    } value = 20;
    for (int i=0;i<healingItemNames.length;i++) {
      if (healingItemNames[i].equals(name)) {
        return value;
      } value*=2.5;
    } return (double)-1;
  }
}
