import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Nature {
  String name;
  int id;
  double[] boosts;
  // constructor, dont worry
  public Nature(String[] data) {
    id = Integer.parseInt(data[0]);
    name = data[1];
    boosts = new double[]{-1,1,1,1,1,1,1}; // starting at index 1;
    if (!data[2].equals(data[3])) {
      boosts[Integer.parseInt(data[2])] = 0.9;
      boosts[Integer.parseInt(data[3])] = 1.1;
    }
  }
  // returns the name
  public String getName() {
    return name;
  }
  // returns the id
  public int getID() {
    return id;
  }
  // returns the boosts[] array (starts at index 1, so ignore index 0 here
  public double[] getBoosts() {
    return boosts;
  }
}
