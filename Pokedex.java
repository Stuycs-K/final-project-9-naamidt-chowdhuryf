import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokedex {
  // changed things from maps to arrays since you werent familiar with them
  // the first thing is an exception since its not really easy to do otherwise
  private static HashMap<String, Integer> speciesToDex;
  private static String[] speciesName;
  private static String[] primaryType;
  private static  String[] secondaryType;
  // we can make types ints to map onto an array later
  // right now with strings it'd make sense for maps
  private static int[][] baseStats;
  private static PImage[] sprite;
  private static int[] expCurve;
  private static int[] evolutionLvl;
  private static int[] evolution; // <-- returns dex # of evolution
  private static HashMap<String,Move> movedex;
  private int maxDexNumber;
  public Pokedex() {
    maxDexNumber = 1010;
    speciesName = new String[maxDexNumber];
    primaryType = new String[maxDexNumber];
    secondaryType = new String[maxDexNumber];
    baseStats = new int[maxDexNumber][];
    sprite = new PImage[maxDexNumber];
    expCurve = new int[maxDexNumber];
    evolutionLvl = new int[maxDexNumber];
    evolution = new int[maxDexNumber];
    // im thinking of having the map for type charts here as well
    BufferedReader br = new BufferedReader(new FileReader("info.txt"));
    br.readLine();
    String line = null;
    while ((line = br.readLine())!=null) {
      String[] data = line.split(" ");
      if (data[0].equals("Move")) {
        break;
      }
      int dexNumber = Integer.parseInt(data[0]);
      speciesName[dexNumber] = data[1];
      speciesToDex.put(data[1],dexNumber);
      primaryType[dexNumber] = data[2];
      secondaryType[dexNumber] = data[3];
      baseStats[dexNumber] = new int[6];
      for (int i=4;i<10;i++) {
        baseStats[dexNumber][i] = Integer.parseInt(data[i]);
      }
      sprite[dexNumber] = data[10];
      expCurve[dexNumber] = Integer.parseInt(data[11]);
      evolutionLvl[dexNumber] = Integer.parseInt(data[12]);
      evolution[dexNumber] = Integer.parseInt(data[13]);
    }
    while ((line = br.readLine())!=null) {
      String[] data = line.split(" ");
      movedex.put(data[0],new Move(line));
    } br.close();
  }


  //---------- GET METHODS USING DEX BELOW ----------//
  public static String getName(int dex) {
    return speciesName[dex];
  }
  public static int getDex(String name) {
    return speciesToDex.get(name);
  }
  public static String getPrimaryType(int dex) {
    return primaryType[dex];
  }
  public static String getSecondaryType(int dex) {
    return secondaryType[dex];
  }
  public static int[] getBaseStats(int dex) {
    return baseStats[dex];
  }
  public static PImage getSprite(int dex) {
    return sprite[dex];
  }
  public static int getExpCurve(int dex) {
    return expCurve[dex];
  }
  public static int getEvolutionLvl(int dex) {
    return evolutionLvl[dex];
  }
  public static int getEvolution(int dex) {
    return evolution[dex];
  }
}
