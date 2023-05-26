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
  // private static PImage[] sprite;
  private static double[] expCurve;
  private static int[] evolutionLvl;
  private static int[] evolution; // <-- returns dex # of evolution
  public static HashMap<String,Move> movedex;
  private static String[] types;
  private static HashMap<String,HashMap<String,Double>> typeChart;
  private static HashMap<String,double[]> natures;
  private int maxDexNumber;
  public Pokedex() throws Exception {
    speciesToDex = new HashMap<String,Integer>();
    movedex = new HashMap<String,Move>();
    typeChart = new HashMap<String,HashMap<String,Double>>();
    natures = new HashMap<String,double[]>();
    maxDexNumber = 1010;
    speciesName = new String[maxDexNumber];
    primaryType = new String[maxDexNumber];
    secondaryType = new String[maxDexNumber];
    baseStats = new int[maxDexNumber][];
    // sprite = new PImage[maxDexNumber];
    expCurve = new double[maxDexNumber];
    evolutionLvl = new int[maxDexNumber];
    evolution = new int[maxDexNumber];
    // im thinking of having the map for type charts here as well
    BufferedReader PokemonBR = new BufferedReader(new FileReader("pokemon.txt"));
    PokemonBR.readLine();
    String line = null;
    while ((line = PokemonBR.readLine())!=null) {
      String[] data = line.split(" ");
      int dexNumber = Integer.parseInt(data[0]);
      speciesName[dexNumber] = data[1];
      speciesToDex.put(data[1],dexNumber);
      primaryType[dexNumber] = data[2];
      secondaryType[dexNumber] = data[3];
      baseStats[dexNumber] = new int[6];
      for (int i=4;i<10;i++) {
        baseStats[dexNumber][i-4] = Integer.parseInt(data[i]);
      }
      // sprite[dexNumber] = data[10];
      expCurve[dexNumber] = Double.parseDouble(data[11]);
      evolutionLvl[dexNumber] = Integer.parseInt(data[12]);
      evolution[dexNumber] = Integer.parseInt(data[13]);
    } PokemonBR.close();
    BufferedReader MovesBR = new BufferedReader(new FileReader("moves.txt"));
    MovesBR.readLine();
    line = null;
    while ((line = MovesBR.readLine())!=null) {
      String[] data = line.split(" ");
      Move move = new Move(data);
      movedex.put(move.getName(),move);
    } MovesBR.close();
    BufferedReader NaturesBR = new BufferedReader(new FileReader("natures.txt"));
    NaturesBR.readLine();
    for (int i=1;i<6;i++) {
      String[] data = NaturesBR.readLine().split(" ");
      for (int j=1;j<6;j++) {
        double[] nature = new double[]{1,1,1,1,1,1};
        if (i!=j) {
          nature[i]=1.1;
          nature[j]=0.9;
        } natures.put(data[j-1],nature);
      }
    }
    NaturesBR.close();
    makeTypeChart();
  }
  public void makeTypeChart() throws Exception {
    types = new String[]{"Typeless", "Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"};
    typeChart = new HashMap<String,HashMap<String,Double>>();
    for (int i=0;i<types.length;i++) {
      HashMap<String,Double> oneTypeChart = new HashMap<String,Double>();
      for (int j=0;j<types.length;j++) {
        oneTypeChart.put(types[j],1.0);
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
      double multiplier = Double.parseDouble(data[2]);
      typeChart.get(offensive).replace(defensive,multiplier);
    }
  }
  public static int damageCalculator(Pokemon attacker, Pokemon defender, Move move) {
    int level = attacker.getLevel();
    int power = move.getBasePower();
    int attack, defense;
    int attackerDex = attacker.getDexNumber();
    int defenderDex = defender.getDexNumber();
    if (move.getSplit().equals("Physical")) {
      attack = baseStats[attackerDex][1];
      defense = baseStats[defenderDex][2];
    } else if (move.getSplit().equals("Special")) {
      attack = baseStats[attackerDex][3];
      defense = baseStats[defenderDex][4];
    } else {
      attack = 0;
      defense = 1;
    }double critMultiplier = 1;
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
    return Math.max(1,damage);
  }
  public String randomNature() throws Exception {
    int boost = (int)(Math.random()*5)+1;
    int detriment = (int)(Math.random()*5);
    String line = null;
    BufferedReader br = new BufferedReader(new FileReader("natures.txt"));
    br.readLine();
    for (int i=0;i<boost;i++) {
      line = br.readLine();
    } return line.split(" ")[detriment];
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
  // public static PImage getSprite(int dex) {
  //   return sprite[dex];
  // }
  public static double getExpCurve(int dex) {
    return expCurve[dex];
  }
  public static int getEvolutionLvl(int dex) {
    return evolutionLvl[dex];
  }
  public static int getEvolution(int dex) {
    return evolution[dex];
  }
  public static double[] getNature(String name) {
    return natures.get(name);
  }
  public static Move getMove(String name) {
    return movedex.get(name);
  }
}
