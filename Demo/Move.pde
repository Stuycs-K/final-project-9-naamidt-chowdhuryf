import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Move {
  private int power, accuracy, pp, maxPP, id, type, priority, split;
  private String name;

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
  }
  public int getID() {
    return id;
  }
  public int getPower() {
    return power;
  }
  public int getPP() {
    return pp;
  }
  public int getMaxPP() {
    return maxPP;
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
  public String toString() {
    return "ID: "+id+" "+name+" "+Pokedex.typeToWord(type)+" "+"Power: "+power+" PP: "+pp+"/"+maxPP+" Accuracy: "+accuracy+"Priority: "+priority+" Split: "+Pokedex.splitToWords();
  }
}
