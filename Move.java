import java.util.*;
import java.io.*;
import java.lang.*;

public class Move{
  private static Pokemon poke;
  private static int type, power, split, accuracy;
  private static String name;

  public Move(String line) {
    String[] data = line.split(" ");
    name = "";
    if (data[1].indexOf("_") > -1) {
      String[] moveName = data[1].split("_");
      for (String a : moveName) {
        name += a;
        name += " "
      }
    } else {
      name += data[1];
    }
    //type = Integer.parse(data[2]);
    power = Integer.parse(data[3]);
    accuracy = Integer.parse(data[4]);
  }


  public apply(Move action, Pokemon user, Pokemon victim) {}



}
