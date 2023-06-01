import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Nature {
  String name;
  int id;
  double[] boosts;
  public Nature(String[] data) {
    id = Integer.parseInt(data[0]);
    name = data[1];
    boosts = new double[]{-1,1,1,1,1,1,1}; // starting at index 1;
    if (!data[2].equals(data[3])) {
      boosts[Double.parseDouble(data[2])] = 0.9;
      boosts[Double.parseDouble(data[3])] = 1.1;
    }
  }
  public String getName() {
    return name;
  }
  public int getID() {
    return id;
  }
  public double[] getBoosts() {
    return boosts;
  }
}
