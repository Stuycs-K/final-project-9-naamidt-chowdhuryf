import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokedex {
  private HashMap<String, Integer> speciesToDex;
  private String[] speciesName, primaryType, secondaryType, types;
  private int[][] baseStats;
  private PImage[] sprite;
  private double[] expCurve;
  private int[] evolutionLvl, evolution;
  public HashMap<String,Move> movedex;
  private HashMap<String,HashMap<String,Double>> typeChart;
  private HashMap<String,double[]> natures;
  private int maxDexNumber;
  public Pokedex() {
    speciesToDex = new HashMap<String,Integer>();
    movedex = new HashMap<String,Move>();
    typeChart = new HashMap<String,HashMap<String,Double>>();
    natures = new HashMap<String,double[]>();
    maxDexNumber = 1010;
    speciesName = new String[maxDexNumber];
    primaryType = new String[maxDexNumber];
    secondaryType = new String[maxDexNumber];
    baseStats = new int[maxDexNumber][];
     sprite = new PImage[maxDexNumber];
    expCurve = new double[maxDexNumber];
    evolutionLvl = new int[maxDexNumber];
    evolution = new int[maxDexNumber];
    // im thinking of having the map for type charts here as well
    try {
      BufferedReader PokemonBR = createReader("pokemon.txt");
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
         //sprite[dexNumber] = loadImage(data[10]);
        expCurve[dexNumber] = Double.parseDouble(data[11]);
        evolutionLvl[dexNumber] = Integer.parseInt(data[12]);
        evolution[dexNumber] = Integer.parseInt(data[13]);
      } PokemonBR.close();
      BufferedReader MovesBR = createReader("moves.txt");
      MovesBR.readLine();
      line = null;
      while ((line = MovesBR.readLine())!=null) {
        String[] data = line.split(" ");
        Move move = new Move(data);
        movedex.put(move.getName(),move);
      } MovesBR.close();
      BufferedReader NaturesBR = createReader("natures.txt");
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
    } catch (Exception e) {}
  }
  public void makeTypeChart() {
    types = new String[]{"Typeless", "Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Psychic", "Rock", "Steel", "Water"};
    typeChart = new HashMap<String,HashMap<String,Double>>();
    for (int i=0;i<types.length;i++) {
      HashMap<String,Double> oneTypeChart = new HashMap<String,Double>();
      for (int j=0;j<types.length;j++) {
        oneTypeChart.put(types[j],(double)1);
      } typeChart.put(types[i],oneTypeChart);
    }
    try {
      BufferedReader br = createReader("typeChart.txt");
      br.readLine();
      String line = null;
      while ((line = br.readLine())!=null) {
        String[] data = line.split(" ");
        String offensive = data[0];
        String defensive = data[1];
        double multiplier = Double.parseDouble(data[2]);
        typeChart.get(offensive).replace(defensive,multiplier);
      } br.close();
    } catch (Exception e) {}
  }
  public int damageCalculator(Pokemon attacker, Pokemon defender, Move move) {
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
  public String randomNature() {
    int boost = (int)(Math.random()*5)+1;
    int detriment = (int)(Math.random()*5);
    String line = "";
    try {
      BufferedReader br = createReader("natures.txt");
      br.readLine();
      for (int i=0;i<boost;i++) {
        line = br.readLine();
      } br.close();
      return line.split(" ")[detriment];
    } catch (Exception e) {return "";}
  }

  //---------- GET METHODS USING DEX BELOW ----------//
  public String getName(int dex) {
    return speciesName[dex];
  }
  public int getDex(String name) {
    return speciesToDex.get(name);
  }
  public String getPrimaryType(int dex) {
    return primaryType[dex];
  }
  public String getSecondaryType(int dex) {
    return secondaryType[dex];
  }
  public int[] getBaseStats(int dex) {
    return baseStats[dex];
  }
   public PImage getSprite(int dex) {
     return sprite[dex];
   }
  public double getExpCurve(int dex) {
    return expCurve[dex];
  }
  public int getEvolutionLvl(int dex) {
    return evolutionLvl[dex];
  }
  public int getEvolution(int dex) {
    return evolution[dex];
  }
  public double[] getNature(String name) {
    return natures.get(name);
  }
  public Move getMove(String name) {
    return movedex.get(name);
  }
}
