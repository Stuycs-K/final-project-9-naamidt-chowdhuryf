import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Evolution {
  int preEvolutionID, postEvolutionID, levelReq;
  // constructor, dont worry
  public Evolution (String[] data) {
    postEvolutionID = Integer.parseInt(data[0]);
    preEvolutionID = Integer.parseInt(data[2]);
  }
  // get the pre-evo of the chain
  public int getPreEvolutionID() {
    return preEvolutionID;
  }
  // get the post-evo of the chain
  public int getPostEvolutionID() {
    return postEvolutionID;
  }
  // get / set the level req for the chain
  public void setLevelReq(int level) {
    levelReq = level;
  }
  public Integer getLevelReq() {
    return levelReq;
  }
  public String toString() {
    return preEvolutionID+"--"+levelReq+"-->"+postEvolutionID;
  }
}
