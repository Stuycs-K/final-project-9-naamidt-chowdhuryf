import java.util.*;
import java.io.*;
import java.lang.*;

public class Move{
  private static String type;
  private static int power, accuracy, pp, maxPP;
  //private static int split;
  private static String name;

  public Move(String line) {
    String[] data = line.split(" ");
    name = "";
    if (data[0].indexOf("_") > -1) {
      String[] moveName = data[0].split("_");
      for (String a : moveName) {
        name += a;
        name += " "
      }
    } else {
      name += data[0];
    }
    type = data[1];
    power = Integer.parseInt(data[2]);
    accuracy = Integer.parseInt(data[3]);
    pp = Integer.parseInt(data[4]);
    maxPP = pp;
  }
}
