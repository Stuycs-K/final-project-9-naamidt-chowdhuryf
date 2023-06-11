import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

// EFFECTS KEY:
// for secondaryType:
//    1 = status-inflicting (burn, freeze, etc)
//    2 = stat-boosting (+def, +atk, etc)
//    3 = recoil OR siphon (- or + values)
//    4 = mental infliction (confusion, flinch)
// for secondaryTarget:
//    1 = targetting itself (swords dance +2 on itself
//    2 = targetting the enemy slot
// for secondaryEffect:
//    1 = burn
//    2 = freeze
//    3 = paralyze
//    4 = sleep
//    5 = poison
//    6 = atk
//    7 = def
//    8 = spatk
//    9 = spdef
//    10 = spe (speed)
//    11 = flinch
//    12 = confusion
//    any other number is just a recoil value
// for secondaryExtra:
//   this is just showing the # of stage changes if there is a stat stage change (+ and - vals)

public class Move {
  private int power, accuracy, pp, maxPP, id, type, priority, split, secondaryChance, secondaryType, secondaryTarget, secondaryEffect, secondaryExtra;
  private String name;
  private boolean hasSecondary;

  public Move(String[] data) {
    id = Integer.parseInt(data[0]);
    name = String.join(" ", data[1].split("-"));
    type = Integer.parseInt(data[2]);
    power = Integer.parseInt(data[3]);
    pp = Integer.parseInt(data[4]);
    maxPP = pp;
    accuracy = Integer.parseInt(data[5]);
    priority = Integer.parseInt(data[6]);
    split = Integer.parseInt(data[7]);
    secondaryChance = Integer.parseInt(data[8]);
    if (secondaryChance==0) {
      hasSecondary = false;
      secondaryType = -1;
      secondaryTarget = -1;
      secondaryEffect = -1;
      secondaryExtra = -1; // this is actually a real value for secondaryExtra but were just initializing stuff
    } else {
      secondaryType = Integer.parseInt(data[9]);
      secondaryTarget = Integer.parseInt(data[10]);
      secondaryEffect = Integer.parseInt(data[11]);
      secondaryExtra = Integer.parseInt(data[12]);
    }
  }
  public boolean applySecondary(Pokemon user, Pokemon otherPokemon, int damageDealt) { // return true if it worked and false if it didnt
    int secondaryCheck = (int)(Math.random()*100);
    if (secondaryCheck>secondaryChance) {
      return false;
    } Pokemon target = user;
    if (secondaryTarget == 1) {
      target = user;
    } if (secondaryTarget == 2) {
      target = otherPokemon;
    } if (secondaryType == 1) {
      return target.setStatus(secondaryEffect);
    } if (secondaryType == 2) {
      return target.setStatBoost(secondaryEffect,secondaryExtra);
    } if (secondaryType == 3) {
      if (damageDealt == 0) {
        user.changeHP(user.getStats()[1]/(secondaryEffect/100.0));
      } else {
        user.changeHP(damageDealt*secondaryEffect/100.0);
      }
    } if (secondaryType == 4) {
      if (secondaryEffect == 11) {
        return target.setFlinchedStatus(true);
      } if (secondaryEffect == 12) {
        return target.setConfusedStatus(true);
      }
    } return true;
  }
  public int getID() {
    return id;
  }
  public int getBasePower() {
    return power;
  }
  public int getPP() {
    return pp;
  }
  public int getMaxPP() {
    return maxPP;
  }
  public String getName() {
    return name;
  }
  public void changePP(int change) {
    pp = Math.max(0,pp-change);
    pp = Math.min(pp, maxPP);
  }
  public int getType() {
    return type;
  }
  public int getPriority() {
    return priority;
  }
  public int getAccuracy() {
    return accuracy;
  }
  public int getSplit() {
    return split;
  }
  public boolean hasSecondary() {
    return hasSecondary;
  }
  public int secondaryChance() {
    return secondaryChance;
  }
  public int secondaryType() {
    return secondaryType;
  }
  public int secondaryTarget() {
    return secondaryTarget;
  }
  public int secondaryEffect() {
    return secondaryEffect;
  }
  public int secondaryExtra() {
    return secondaryExtra;
  }
  public String toString() {
    return "ID: "+id+" "+name+" "+type+" "+"Power: "+power+" PP: "+pp+"/"+maxPP+" Accuracy: "+accuracy+" Priority: "+priority+" Split: "+split;
  }
}
