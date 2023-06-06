import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

class Bag {
  private HashMap<Integer,Integer> idToAmt;
  private HashMap<Integer,String> idToName;
  private HashMap<String,Integer> nameToId;
  private HashMap<Integer,Double> idToValue;
  private HashMap<Integer,Boolean> idIsPokeball;
  public Bag() {
    try {
      BufferedReader itemReader = createReader("itemInfo.txt");
      String line = itemReader.readLine();
      while (line!=null) {
        String[] data = line.split(" ");
        int id = Integer.parseInt(data[0]);
        String name = String.join(" ",data[1].split("_"));
        Double value = Double.parseDouble(data[2]);
        Boolean isPokeball = Boolean.parseBoolean(data[3]);
        int amount = Integer.parseInt(data[4]);
        idToAmt.put(id,amount);
        idToName.put(id,name);
        nameToId.put(name,id);
        idToValue.put(id,value);
        idIsPokeball.put(id,isPokeball);
        line = itemReader.readLine();
      }
    } catch (Exception e) {
      System.out.println("an item oopsie occurred");
    }
  }
  // little wrapper method if you want to use item name (WITH SPACES)
  public boolean use(boolean encounter, String itemName, Pokemon target) {
    return use(encounter,nameToId.get(itemName),target);
  }
  public boolean use(boolean encounter, int itemId, Pokemon target) {
    if (idIsPokeball.get(itemId)) { //if we are trying to use a pokeball
      if (idToAmt.get(itemId)<=0 || !encounter) { // if we either dont have any more of the pokeball or its not an encounter (we cant catch it) 
        return false;
      } // try to catch it otherwise
      idToAmt.put(itemId,idToAmt.get(itemId)-1);
      return catchAttempt(target,idToValue.get(itemId));
    } else { // if we are not using a pokeball (the only option left rn is healing item)
      if (idToAmt.get(itemId)<=0 || target.getCurrentHP()==target.getStats()[1]) { // if we don't have any more of that item or the pokemon is already at max hp
        return false;
      } idToAmt.put(itemId,idToAmt.get(itemId)-1);
      target.changeHP(idToValue.get(itemId));
      return true;
    }
  }
  public boolean catchAttempt(Pokemon encounter, double mult) {
    double odds = ((3*encounter.getStats()[1]-2*encounter.getCurrentHP())*4096*mult)/(3*encounter.getStats()[0]);
    double roll = Math.random()*4096;
    if (roll<odds) {
      return true;
    } return false;  
  }
  public void setItemAmount(int itemId, int amount) {
    idToAmt.put(itemId,amount);
  }
  public int getItemAmount(int itemId) {
    return idToAmt.get(itemId);
  }
  public double getItemValue(int itemId) {
    return idToValue.get(itemId);
  }
  public String idToName(int itemId) {
    return idToName.get(itemId);
  }
  public int nameToId(String name) {
    return nameToId.get(name);
  }
  public boolean idIsPokeball(int itemId) {
    return idIsPokeball.get(itemId);
  }
}
