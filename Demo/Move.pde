import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

// EFFECTS KEY:
// for secondaryType:
//    0 = status-inflicting (burn, freeze, etc)
//    1 = stat-boosting (+def, +atk, etc)
//    recoil = recoil OR siphon (- or + values)
// for secondaryTarget:
//    0 = targetting the enemy slot
//    1 = targetting itself (swords dance +2 on itself
// for secondaryEffect:
//    0 = burn
//    1 = freeze
//    2 = paralyze
//    3 = sleep
//    4 = poison
//    5 = atk
//    6 = def
//    7 = spatk
//    8 = spdef
//    9 = spe (speed)
//    anu other number is just a recoil value
// for secondaryExtra:
//   this is just showing the # of stage changes if there is a stat stage change (+ and - vals)

public class Move {
  private int power, accuracy, pp, maxPP, id, type, priority, split, secondaryChance, secondaryType, secondaryTarget, secondaryEffect, secondaryExtra;
  private String name;
  private boolean hasSecondary;

  public Move(String[] data) {
    //dex = new Pokedex();
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
      
    }
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
