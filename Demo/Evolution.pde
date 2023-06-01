import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Evolution {
  int preEvolutionID, postEvolutionID, levelReq;
  public Evolution (String[] data) {
    postEvolutionID = Integer.parseInt(data[0]);
    preEvolutionID = Integer.parseInt(data[2]);
  }
  public int getPreEvolutionID() {
    return preEvolutionID;
  }
  public int getPostEvolutionID() {
    return postEvolutionID;
  }
  public void setLevelReq(int level) {
    levelReq = level;
  }
}
