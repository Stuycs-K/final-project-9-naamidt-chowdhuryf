import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class dexit {
  
  HashMap<Integer,int[]> expChart;
  HashMap<Integer,String> splitToWords, dexToSpecies;
  HashMap<Integer,Move> movedex;
  HashMap<Integer,Nature> naturedex;
  HashMap<Integer,Integer> baseExp, captureRate, growthRate, primaryType, secondaryType;
  HashMap<Integer,Move[]> learnset;
  HashMap<Integer,Evolution> evolutionData, evolutions;
  HashMap<Integer,int[]> baseStats, evYields;
  HashMap<String, Integer> speciesToDex;
  HashMap<Integer,HashMap<Integer, Double>> typeChart;
  HashMap<Integer,String> typesToWords;
  
  public dexit() {
    try {
      // Exp Chart
      expChart = new HashMap<Integer,int[]>();
      BufferedReader expChartMaker = createReader("experience.csv");
      expChartMaker.readLine(); // ignore data descriptions
      for (int i=1;i<=6;i++) { // for each of the 6 growth curves
        int[] totalExpReq = new int[101]; // 100 levels +1 to offset index 0
        totalExpReq[0] = -1; // you shouldn't be level 0 ever
        for (int j=0;j<100;j++) { // for each level
          String[] data = expChartMaker.readLine().split(",");
          totalExpReq[Integer.parseInt(data[1])] = Integer.parseInt(data[2]); 
          // puts the val in the array position == level
        } expChart.put(i,totalExpReq);
      } expChartMaker.close();
      
      // Move Split to Words
      splitToWords = new HashMap<Integer,String>();
      splitToWords.put(1,"Status");
      splitToWords.put(2,"Physical");
      splitToWords.put(3,"Special");
      // this is all the data we need, so I just inputted it manually
      
      // Movedex Initialization
      movedex = new HashMap<Integer,Move>();
      BufferedReader movedexMaker = createReader("moves.csv");
      movedexMaker.readLine(); // skipping input description line
      for (int i=1;i<=902;i++) { // for every move
        String[] data = movedexMaker.readLine().split(","); // get input;
        Move newMove = new Move(data); // turn it into a move
        movedex.put(newMove.getID(),newMove); // put it into the movedex
      } movedexMaker.close();
      
      // Naturedex Initialization
      naturedex = new HashMap<Integer,Nature>();
      Bufferedreader naturedexMaker = createReader("natures.csv");
      naturedexMaker.readLine(); // skipping input description
      for (int i=1;i<=25;i++) { // for every nature
        String[] data = naturedexMaker.readLine().split(",");
        Nature newNature = new Nature(data);
        movedex.put(newNature.getID(),newNature);
      } naturedexMaker.close();
      
      // Base Exp Stuff (Get XP on enemy Pokemon faints)
      baseExp = new HashMap<Integer, Integer>();
      dexToSpecies = new HashMap<Integer,String>();
      speciesToDex = new HashMap<String,Integer>();
      BufferedReader baseExpMaker = createReader("pokemon.csv");
      baseExpMaker.readLine(); // skip line 1
      for (int i=1;i<=1010;i++) { // for every pokemon
        String[] data = baseExpMaker.readLine().split(",");
        baseExp.put(i,Integer.parseInt(data[2]));
        // add their base exp
        String name = (data[1].charAt(0)-'a'+'A')+data[1].substring(1);
        dexToSpecies.put(i,name);
        speciesToDex.put(name,i);
      } baseExpMaker.close();
      
      // Learnset Intialization
      learnset = new HashMap<Integer,Move[]>();
      BufferedReader learnsetMaker = createReader("pokemon_moves.csv");
      learnsetMaker.readLine(); // skip line 1
      String line = null;
      int currentPokemon = 0;
      Move[] movepool = new Move[0];
      while ((learnsetMaker.readLine())!=null) {
        String[] data = line.split(",");
        if (Integer.parseInt(data[0])!=currentPokemon) {
          learnset.put(currentPokemon,movepool);
          movepool = new Move[101]; // 100 levels + 1 for index 0 offset
          currentpokemon = Integer.parseInt(data[0]);
        } movepool[Integer.parseInt(data[3])] = movedex.get(Integer.parseInt(data[1]));
      } learnsetMaker.close();
      
      // Variety of Initializations
      captureRate = new HashMap<Integer,Integer>();
      growthRate = new HashMap<Integer,Integer>();
      evolutionData = new HashMap<Integer,Evolution>();
      BufferedReader varietyMaker = createReader("pokemon_species.csv");
      varietyMaker.readLine(); // skip the first line
      for (int i=1;i<=1010;i++) { // for every pokemon
        String[] data = varietyMaker.readLine().split(",");
        captureRate.put(Integer.parseInt(data[0]),Integer.parseInt(data[4]));
        growthRate.put(Integer.parseInt(data[0]),Integer.parseInt(dat[5]));
        // add capture and growth rates
        Evolution evo = new Evolution(data);
        evolutionData.put(evo.getPostEvolution(),evo);
        // add some of evolution
      } varietyMaker.close();
      
      // Finishing Initialization of Evolutions
      evolutions = new HashMap<Integer,Evolution>();
      Bufferedreader evolutionMaker = createReader("pokemon_evolutions.csv");
      evolutionMaker.readLine(); // the first line is for humans
      for (int i=1;i<=352;i++) { // for every level-up evolution
        String[] data = evolutionMaker.readLine().split(",");
        Evolution evo = evolutionData.get(Integer.parseInt(data[1]));
        evo.setLevelReq(Integer.parseInt(data[2]));
        // add the level requirement to the evolution
        evolutions.put(evo.getPreEvolution(),evo);
        // make a new map that evos are accessible from the pre evolution
      } evolutionMaker.close();
      
      // Initializing the base stats and ev yields
      baseStats = new HashMap<Integer,int[]>();
      evYields = new HashMap<Integer,int[]>();
      BufferedReader statsMaker = createReader("pokemon_stats.csv");
      statsMaker.readLine(); // the first line
      for (int i=1;i<=1010;i++) {
        int[] base = new int[7];
        int[] evs = new int[7];
        // again, 7 to offset the -1 index
        for (int j=1;j<=6;j++) {
          String[] data = br.readLine().split(",");
          base[j] = Integer.parseInt(data[2]);
          evs[j] = Integer.parseInt(data[3]);
        } baseStats.put(i,base);
        evYields.put(i,evs);
      } statsMaker.close();
      
      // Initializing Each Pokemon's Types
      primaryType = new HashMap<Integer,Integer>();
      secondaryType = new HashMap<Integer,Integer>();
      BufferedReader typeMaker = createReader("pokemon_types.csv");
      typeMaker.readLine(); // you know the rules, and so do i
      for (int i=1;i<=1522;i++) { // for every pokemon's typing
        String[] data = typeMaker.readLine().split(",");
        if (Integer.parseInt(data[2])==1) {
          primaryType.put(Integer.parseInt(data[0]),Integer.parseInt(data[1]));
        } else {
          secondaryType.put(Integer.parseInt(data[0]),Integer.parseInt(data[1]));
        }
      } typeMaker.close();
      
      // Initializing the Type Chart
      typeChart = new HashMap<Integer, HashMap<Integer,Double>>();
      BufferedReader typeChartMaker = createReader("type_efficacy.csv");
      typeChartMaker.readLine(); // almost there
      for (int i=1;i<=18;i++) {
        HashMap<Integer,Double> oneTypeChart = new HashMap<Integer,Double>();
        for (int j=1;j<=18;j++) {
          String[] data = typeChartMaker.readLine().split(",");
          oneTypeChart[j] = Integer.parseInt(data[2])/100.0;
        } typeChart.put(i,oneTypeChart);
      } typeChartMaker.close();
      
      // Making the Integer Value for Types Into Words
      typesToWords = new HashMap<Integer,String>();
      BufferedReader typeNameMaker = createReader("types.csv");
      typeNameMaker.readLine(); // the last first skip
      for (int i=1;i<=18;i++) {
        String[] data = typeNameMaker.split(",");
        typesToWords.put(i,data[1]);
      } typesToWords.close();
      
    } catch (Exception e) {}
  }
  
  public int[] getExpChart(int growthRate) {
    return expChart.get(growthRate);
  }
  public String splitToWords(int split) {
    return splitToWords.get(split);
  }
  public Move getMove(int id) {
    return movedex.get(id);
  }
  public Nature getNature(int id) {
    return naturedex.get(id);
  }
  public int getBaseExp(int id) {
    return baseExp.get(id);
  }
  public Move[] getLearnset(int id) {
    return learnset.get(id);
  }
  public Move getLevelUpMove(int id, int level) {
    return learnset.get(id)[level];
  }
  public Evolution getEvolution(int id) {
    return evolution.get(id);
  }
  public int getCaptureRate(int id) {
    return captureRate.get(id);
  }
  public int getGrowthRate(int id) {
    return growthRate.get(id);
  }
  public int getDex(String name) {
    return speciesToDex.get(name);
  }
  public int getSpecies(int id) {
    return dexToSpecies.get(id);
  }
  public int[] getBaseStats(int id) {
    return baseStats.get(id);
  }
  public int[] getEvYield(int id) {
    return evYields.get(id);
  }
  public int getPrimaryType(int id) {
    return primaryType.get(id);
  }
  public int getSecondaryType(int id) {
    return secondaryType.get(id);
  }
  public double getTypeAdvantage(int offensiveType, int defensiveType) {
    return typeChart.get(offensiveType).get(defensiveType);
  }
  public String typeToWord(int id) {
    return typesToWords.get(id);
  }
}
