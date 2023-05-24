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
  private static String[] types;
  private static HashMap<String,HashMap<String,Float>> typeChart;
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
    makeTypeChart();
  }
  public void makeTypeChart() {
    types = new String[]{"Typeless", "Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"};
    typeChart = new HashMap<String,HashMap<String,Float>>();
    for (int i=0;i<types.length;i++) {
      Hashmap<String,Float> oneTypeChart = new HashMap<String,Float>();
      for (int j=0;j<types.length;j++) {
        oneTypeChart.put(types[j],1);
      } typeChart.put(types[i],oneTypeChart);
    }
    // now we do all the actual type interactions manually i guess
    // jk ill just do another .txt file to make it easier maybe
    BufferedReader br = new BufferedReader(new FileReader("typeChart.txt"));
    br.readLine();
    String line = null;
    while ((line = br.readLine())!=null) {
      String[] data = line.split(" ");
      String offensive = data[0];
      String defensive = data[1];
      float multiplier = Float.parseFloat(data[2]);
      typeChart.get(offensive).replace(defensive,multiplier);
    }
  }
  public int damageCalculator(Pokemon attacker, Pokemon defender, Move move) {
    int level = attacker.getLevel();
    int power = Move.getBasePower();
    int attack, defense;
    int attackerDex = attacker.getDexNumber();
    int defenderDex = defender.getDexNumber();
    if (move.getSplit().equals("Physical")) {
      attack = baseStats[attackerDex][1];
      defense = baseStats[defenderDex][2];
    } else if (move.getSplit().equals("Special")) {
      attack = baseStats[attackerDex][3];
      defense = baseStats[defenderDex][4];
    } double critMultiplier = 1;
    if ((int)(Math.random()*16)==0) {
      critMultiplier=1.5;
    } double stab = 1;
    if (primaryType[attackerDex].equals(move.getType())||secondaryType[attackerDex].equals(move.getType())) {
      stab = 1.5;
    } double typeAdvantage = 1;
    typeAdvantage*=typeChart.get(move.getType()).get(primaryType[defenderDex]);
    typeAdvantage*=typeChart.get(move.getType()).get(secondaryType[defenderDex]);
    double roll = ((int)(Math.random()*16)+85)/100.0;
    int damage = ((2*level/5+2)*power*attack/defense)/50+2;
    damage=(int)(damage*critMultiplier*stab*typeAdvantage*roll);
    return damage;
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
