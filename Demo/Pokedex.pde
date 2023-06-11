import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokedex {
  
  HashMap<Integer,int[]> expChart, baseStats, evYields;
  HashMap<Integer,String> splitToWords, dexToSpecies, typesToWords, spritedexFront, spritedexBack, idToStatus;
  HashMap<Integer,Move> movedex;
  HashMap<Integer,Nature> naturedex;
  HashMap<Integer,Integer> baseExp, captureRate, growthRate, primaryType, secondaryType;
  HashMap<Integer,HashMap<Integer,ArrayList<Move>>> learnset;
  HashMap<Integer,Evolution> evolutionData, evolutions;
  HashMap<String, Integer> speciesToDex, statusToId;
  HashMap<Integer,HashMap<Integer, Double>> typeChart;
  HashMap<Integer,Double> boostToVal;
  HashMap<String,String> typeIcons, statusIcons;
  
  public Pokedex() { //<>// //<>//
    try {
      expChart = new HashMap<Integer,int[]>(); //<>// //<>// //<>// //<>//
      BufferedReader expChartMaker = createReader("experience.csv");
      expChartMaker.readLine(); // ignore data descriptions
      for (int i=1;i<=6;i++) { // for each of the 6 growth curves
        int[] totalExpReq = new int[101]; // 100 levels +1 to offset index 0
        totalExpReq[0] = -1; // you shouldn't be level 0 ever //<>// //<>//
        for (int j=1;j<=100;j++) { // for each level //<>// //<>//
          String[] data = expChartMaker.readLine().split(","); //<>// //<>// //<>// //<>// //<>// //<>//
          totalExpReq[Integer.parseInt(data[1])] = Integer.parseInt(data[2]);  //<>// //<>// //<>// //<>// //<>// //<>//
          // puts the val in the array position == level //<>// //<>// //<>// //<>// //<>// //<>//
        } expChart.put(i,totalExpReq); //<>// //<>// //<>// //<>// //<>// //<>//
      } expChartMaker.close(); //<>// //<>// //<>// //<>// //<>// //<>//
       //<>// //<>// //<>// //<>//
      // Move Split to Words //<>// //<>// //<>// //<>// //<>// //<>//
      splitToWords = new HashMap<Integer,String>(); //<>// //<>//
      splitToWords.put(1,"Status"); //<>// //<>// //<>// //<>// //<>// //<>//
      splitToWords.put(2,"Physical"); //<>// //<>// //<>// //<>// //<>// //<>//
      splitToWords.put(3,"Special"); //<>// //<>// //<>// //<>// //<>// //<>//
      // this is all the data we need, so I just inputted it manually //<>// //<>// //<>// //<>//
       //<>// //<>// //<>// //<>//
      // Movedex Initialization
      movedex = new HashMap<Integer,Move>(); //<>// //<>//
      BufferedReader movedexMaker = createReader("moves.csv"); //<>// //<>//
      movedexMaker.readLine(); // skipping input description line //<>// //<>// //<>// //<>// //<>// //<>//
      for (int i=1;i<=902;i++) { // for every move //<>// //<>// //<>// //<>// //<>// //<>//
        String[] data = movedexMaker.readLine().split(","); // get input; //<>// //<>// //<>// //<>// //<>// //<>//
        Move newMove = new Move(data); // turn it into a move //<>// //<>// //<>// //<>//
        movedex.put(newMove.getID(),newMove); // put it into the movedex //<>// //<>// //<>// //<>// //<>// //<>//
      } movedexMaker.close(); //<>// //<>//
       //<>// //<>// //<>// //<>//
      // Naturedex Initialization //<>// //<>// //<>// //<>// //<>// //<>//
      naturedex = new HashMap<Integer,Nature>(); //<>// //<>//
      BufferedReader naturedexMaker = createReader("natures.csv"); //<>// //<>// //<>// //<>// //<>// //<>//
      naturedexMaker.readLine(); // skipping input description //<>// //<>// //<>// //<>//
      for (int i=1;i<=25;i++) { // for every nature //<>// //<>// //<>// //<>// //<>// //<>//
        String[] data = naturedexMaker.readLine().split(",");
        Nature newNature = new Nature(data); //<>// //<>// //<>// //<>//
        naturedex.put(newNature.getID(),newNature);
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
        String name = (char)(data[1].charAt(0)-'a'+'A')+data[1].substring(1);
        dexToSpecies.put(i,name);
        speciesToDex.put(name,i);
      } baseExpMaker.close();
      
      // Learnset Intialization
      //learnset = new HashMap<Integer,ArrayList<Move>>();
      //BufferedReader learnsetMaker = createReader("pokemon_moves.csv");
      //learnsetMaker.readLine(); // skip line 1
      //String line = null;
      //int currentPokemon = 0;
      //Move[] movepool = new Move[0];
      //while ((line=learnsetMaker.readLine())!=null) {
      //  String[] data = line.split(",");
      //  if (Integer.parseInt(data[0])!=currentPokemon) {
      //    learnset.put(currentPokemon,movepool);
      //    movepool = new Move[101]; // 100 levels + 1 for index 0 offset
      //    currentPokemon = Integer.parseInt(data[0]);
      //  } movepool[Integer.parseInt(data[3])] = movedex.get(Integer.parseInt(data[1]));
      //} learnsetMaker.close();
      
      learnset = new HashMap<Integer,HashMap<Integer,ArrayList<Move>>>();
      BufferedReader learnsetMaker = createReader("pokemon_moves.csv");
      learnsetMaker.readLine(); // line 1 bad
      String line = null;
      int currentPokemon = 0;
      int currentLevel = 0;
      HashMap<Integer,ArrayList<Move>> levelLearnset = new HashMap<Integer,ArrayList<Move>>();
      ArrayList<Move> newMoves = new ArrayList<Move>();
      while ((line=learnsetMaker.readLine())!=null) {
        String[] data = line.split(",");
        if (Integer.parseInt(data[0])!=currentPokemon) {
          levelLearnset.put(currentLevel,newMoves);
          currentLevel=0;
          learnset.put(currentPokemon,levelLearnset);
          levelLearnset = new HashMap<Integer,ArrayList<Move>>();
          currentPokemon = Integer.parseInt(data[0]);
        } if (Integer.parseInt(data[3])!=currentLevel) {
          levelLearnset.put(currentLevel,newMoves);
          newMoves = new ArrayList<Move>();
          currentLevel = Integer.parseInt(data[3]);
        } newMoves.add(movedex.get(Integer.parseInt(data[1])));
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
        growthRate.put(Integer.parseInt(data[0]),Integer.parseInt(data[5]));
        // add capture and growth rates
        Evolution evo = new Evolution(data);
        evolutionData.put(evo.getPostEvolutionID(),evo);
        // add some of evolution
      } varietyMaker.close();
      
      // Finishing Initialization of Evolutions
      evolutions = new HashMap<Integer,Evolution>();
      BufferedReader evolutionMaker = createReader("pokemon_evolution.csv");
      evolutionMaker.readLine(); // the first line is for humans
      for (int i=1;i<=352;i++) { // for every level-up evolution
        String[] data = evolutionMaker.readLine().split(",");
        Evolution evo = evolutionData.get(Integer.parseInt(data[1]));
        evo.setLevelReq(Integer.parseInt(data[2]));
        // add the level requirement to the evolution
        evolutions.put(evo.getPreEvolutionID(),evo);
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
          String[] data = statsMaker.readLine().split(",");
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
          if (secondaryType.get(Integer.parseInt(data[0])-1)==null) {
            secondaryType.put(Integer.parseInt(data[0])-1,0);
          } primaryType.put(Integer.parseInt(data[0]),Integer.parseInt(data[1]));
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
        oneTypeChart.put(0,(double)1);
        for (int j=1;j<=18;j++) {
          String[] data = typeChartMaker.readLine().split(",");
          oneTypeChart.put(j,(double)Integer.parseInt(data[2])/100.0);
        } typeChart.put(i,oneTypeChart);
      } typeChartMaker.close();
      
      // Making the Integer Value for Types Into Words
      typesToWords = new HashMap<Integer,String>();
      BufferedReader typeNameMaker = createReader("types.csv");
      typeNameMaker.readLine(); // the last first skip
      for (int i=1;i<=18;i++) {
        String[] data = typeNameMaker.readLine().split(",");
        typesToWords.put(i,data[1]);
      } typeNameMaker.close();
      
      // spritedex stuff now
      spritedexFront = new HashMap<Integer,String>();
      spritedexBack = new HashMap<Integer,String>();
      String dir = sketchPath();
      dir = dir.substring(0,dir.length()-4);
      char slash = dir.charAt(dir.length()-1);
      dir+="Demo"+slash+"data"+slash;
      String front = dir+"front"+slash;
      String back = dir+"back"+slash;
      for (int i=1;i<=1010;i++) {
        String name = i+".gif";
        spritedexFront.put(i,front+name);
        spritedexBack.put(i,back+name);
      }
      
      typeIcons = new HashMap<String,String>();
      dir = sketchPath();
      dir = dir.substring(0,dir.length()-4);
      slash = dir.charAt(dir.length()-1);
      dir+="Demo"+slash+"data"+slash+"typeIcons"+slash;
      for (int i=1;i<=18;i++) {
        String type = typesToWords.get(i);
        typeIcons.put(type,dir+type+".png");
      }
      
      statusIcons = new HashMap<String,String>();
      String[] statuses = new String[]{"burn","freeze","paralyze","sleep","poison"};
      for (int i=0;i<statuses.length-1;i++) {
        statusIcons.put(statuses[i],dir+statuses[i]+".png");
      } statusIcons.put("poison",dir+"poisonStatus.png");
      
      idToStatus = new HashMap<Integer,String>();
      statusToId = new HashMap<String,Integer>();
      for (int i=0;i<statuses.length;i++) {
        idToStatus.put(i,statuses[i]);
        statusToId.put(statuses[i],i);
      }
      
      // stat change boost vals
      boostToVal = new HashMap<Integer,Double>();
      boostToVal.put(-6,(double)0.25);
      boostToVal.put(-5,(double)0.28);
      boostToVal.put(-4,(double)0.33);
      boostToVal.put(-3,(double)0.4);
      boostToVal.put(-2,(double)0.5);
      boostToVal.put(-1,(double)0.66);
      boostToVal.put(0,(double)1);
      boostToVal.put(1,(double)1.5);
      boostToVal.put(2,(double)2);
      boostToVal.put(3,(double)2.5);
      boostToVal.put(4,(double)3);
      boostToVal.put(5,(double)3.5);
      boostToVal.put(6,(double)4);
      
    } catch (Exception e) {
      e.printStackTrace(); 
      System.out.println(e);
      System.out.println("Oh no, an error");
    }
  }

  
  public double getAdvantage(Pokemon defender, Move m) {
    int defenderDex = defender.getDexNumber();
    double typeAdvantage = 1;
    typeAdvantage*=typeChart.get(m.getType()).get(primaryType.get(defenderDex));
    if (secondaryType.get(defenderDex)!=null) {
      typeAdvantage*=typeChart.get(m.getType()).get(secondaryType.get(defenderDex));
    }
    return typeAdvantage;
  }
  

  public int confusionDamageCalculator(Pokemon user) {
    int damage = damageCalculator(user,user,movedex.get(145));
    double typeAdvantage = 1;
    Move m = movedex.get(145);
    int defenderDex = user.getDexNumber();
    typeAdvantage*=typeChart.get(m.getType()).get(primaryType.get(defenderDex));
    if (secondaryType.get(defenderDex)!=null) {
      typeAdvantage*=typeChart.get(m.getType()).get(secondaryType.get(defenderDex));
    } return (int)(damage/typeAdvantage);
  }
  public int damageCalculator(Pokemon attacker, Pokemon defender, Move m) {
    if (m==null) {
      return -1;
    }
    int level = attacker.getLevel();
    int power = m.getBasePower();
    int attack, defense;
    int attackerDex = attacker.getDexNumber();
    int defenderDex = defender.getDexNumber();
    if (m.getSplit()==2) {
      attack = (int)(attacker.getStats()[2]*boostToVal.get(attacker.getStatBoosts()[2]));
      defense = (int)(defender.getStats()[3]*boostToVal.get(defender.getStatBoosts()[3]));
    } else if (m.getSplit()==3) {
      attack = (int)(attacker.getStats()[4]*boostToVal.get(attacker.getStatBoosts()[4]));
      defense = (int)(defender.getStats()[5]*boostToVal.get(defender.getStatBoosts()[5]));
    } else {
      attack = 0;
      defense = 1;
    }
    double stab = 1;
    if (primaryType.get(attackerDex).equals(m.getType())||secondaryType.get(attackerDex).equals(m.getType())) {
      stab = 1.5;
    }
    double typeAdvantage = 1;
    typeAdvantage*=typeChart.get(m.getType()).get(primaryType.get(defenderDex));
    if (secondaryType.get(defenderDex)!=0) {
      typeAdvantage*=typeChart.get(m.getType()).get(secondaryType.get(defenderDex));
    }
    if (power==0||typeAdvantage==(double)0) {
      return 0;
    }
    double roll = ((int)(Math.random()*16)+85)/100.0;
    int damage = ((2*level/5+2)*power*attack/defense)/50;
    if (attacker.getStatus()==1&&m.getSplit()==2) { // burn halves physical damage
      damage=(int)(damage*0.5);
    } damage=(int)(damage*stab*typeAdvantage*roll);
    return Math.max(1, damage);
  }
  public int randomNature() {
    return (int)(Math.random()*25)+1;
  }
  public Pokemon randomPokemon(Trainer trainer) {
    while (true) {
      int dexNumber = (int)(Math.random()*920)+1;
      int level = (int)(Math.random() * 100) + 1;
      Pokemon pokemon = new Pokemon(level, dexToSpecies.get(dexNumber), dexNumber);
      if (pokemon.getBst()>60*trainer.getBadges()&&pokemon.getBst()<350+60*trainer.getBadges()) {
        return pokemon;
      }
    }
  }
  public void randomizeParty(Trainer trainer) {
    int pokemon = Math.min(Math.max(2,trainer.getBadges()+1),6)
    for (int i=0;i<pokemon;i++) {
      trainer.setPokemon(i,randomPokemon(trainer));
    }
    for (int i=pokemon;i<6;i++) {
      trainer.setPokemon(i,null);
    }
  }
  
  
  // GET AND WHATEVER METHODS BOOO BORING
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
  public HashMap<Integer,ArrayList<Move>> getLearnset(int id) {
    return learnset.get(id);
  }
  public ArrayList<Move> getLevelUpMoves(int id, int level) {
    return learnset.get(id).get(level);
  }
  public Evolution getEvolution(int id) {
    return evolutions.get(id);
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
  public String getSpecies(int id) {
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
  public String getFrontSprite(int id) {
    return spritedexFront.get(id);
  }
  public String getBackSprite(int id) {
    return spritedexBack.get(id);
  }
  public Double getBoostToVal(int boost) {
    return boostToVal.get(boost);
  }
  public String getTypeIcon(String type) {
    return typeIcons.get(type);
  }
  public String getStatusIcon(String status) {
    return statusIcons.get(status);
  }
  public String getIdToStatus(int id) {
    return idToStatus.get(id);
  }
  public int getStatusToId(String status) {
    return statusToId.get(status);
  }
  public String getItemSprite(String name) {
    String dir = sketchPath();
    dir = dir.substring(0,dir.length()-4);
    char slash = dir.charAt(dir.length()-1);
    dir+="Demo"+slash+"data"+slash;
    return dir+"items"+slash+name;
  }
}
