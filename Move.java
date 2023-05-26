import java.util.*;
import java.io.*;
import java.lang.*;

public class Move{
  private  String type;
  private  int power, accuracy, pp, maxPP;
  //private  int split;
  private  String name, split;

  public Move(String[] data) {
    name = String.join(" ",data[0].split("_"));
    type = data[1];
    power = Integer.parseInt(data[2]);
    accuracy = Integer.parseInt(data[3]);
    pp = Integer.parseInt(data[4]);
    maxPP = pp;
    split = data[5];
  }
  public int getBasePower() {
    return power;
  }
  public String getSplit() {
    return split;
  }
  public String getType() {
    return type;
  }
  public int getAccuracy() {
    return accuracy;
  }
  public int getPP() {
    return pp;
  }
  public void decreasePP(int amount) {
    pp-=amount;
  }
  public int getMaxPP() {
    return maxPP;
  }
  public String getName() {
    return name;
  }

  public void setPP(int num) {
    pp = num;
  }

  public void setAccuracy(int num) {
    accuracy = num;
  }
  public String toString() {
    return name+" "+type+" "+split+" Power: "+power+" Accuracy: "+accuracy+" PP: "+pp+" MaxPP: "+maxPP;
  }
}
