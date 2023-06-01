import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokemon {
  private int currentHP, level, exp, dexNumber, nature, growthRate, baseExp, captureRate, primaryType, secondaryType, evolutionLevel, availableEvs;
  private PImage spriteFront, spriteBack;
  private String nickname;
  private Move[] moves, learnset;
  private int[] stats, evs, ivs, expChart, baseStats, evYield;
  private Pokedex dex;
  private int currentMove = 0;
  public Pokemon(int level, String nickname, int dexNumber) {
    this.level = level;
    this.nickname = nickname;
    this.dexNumber = dexNumber;
    availableEvs = 510;
    moves = new Move[4];
    dex = new Pokedex();
    ivs = new int[7];
    evs = new int[7];
    if (dex.getEvolution(dexNumber)!=null&&dex.getEvolution(dexNumber).getLevelReq()!=null) {
      evolutionLevel = dex.getEvolution(dexNumber).getLevelReq();
    } else {
      evolutionLevel = -1;
    } learnset = dex.getLearnset(dexNumber);
    for (int i=1;i<=level;i++) {
      if (learnset[i]!=null) {
        moves[currentMove] = learnset[i];
        currentMove++;
        currentMove%=4;
      }
    }
    nature = dex.randomNature();
    evYield = dex.getEvYield(dexNumber);
    baseStats = dex.getBaseStats(dexNumber);
    spriteFront = loadImage(dex.getFrontSprite(dexNumber));
    spriteBack = loadImage(dex.getBackSprite(dexNumber));
    growthRate = dex.getGrowthRate(dexNumber);
    expChart = dex.getExpChart(growthRate);
    baseExp = dex.getBaseExp(dexNumber);
    captureRate = dex.getCaptureRate(dexNumber);
    primaryType = dex.getPrimaryType(dexNumber);
    secondaryType = dex.getSecondaryType(dexNumber);
    for (int i=1; i<=6; i++) {
      ivs[i] = (int)(Math.random()*32);
      evs[i] = 0;
    }
    stats = new int[6];
    updateStats();
    currentHP = stats[1];
    exp = expChart[level];
  }
  public int calculateStats(int base, int iv, int ev, int level, double nature) {
    int stat;
    stat = (((2*base+iv+(ev/4))*level)/100)+level+10;
    return (int)(stat*nature);
  }
  public void updateStats() {
    Nature innate = dex.getNature(nature);
    double[] natureBoosts = innate.getBoosts();
    for (int i=1; i<=stats.length; i++) {
      stats[i-1] = calculateStats(baseStats[i], ivs[i], evs[i], level, natureBoosts[i]);
    }
  }
  public int changeHP(int changeVal) {
    int initial = currentHP;
    int maxHP = dex.getBaseStats(dexNumber)[0];
    currentHP+=changeVal;
    currentHP = Math.min(maxHP, currentHP);
    currentHP = Math.max(0, currentHP);
    return initial;
  }
  public void addExp(int additionalExp) {
    exp+=additionalExp;
    while (levelUp());
  }
  public boolean levelUp() {
    if (level>=100) {
      return false;
    }
    if (exp>=expChart[level]) {
      level++;
      if (learnset[level]!=null) {
        moves[currentMove] = learnset[level];
        currentMove++;
        currentMove%=4;
      } updateStats();
      if (evolutionLevel!=-1&&level>=evolutionLevel) {
        evolve();
      }
      return true;
    } return false;
  }
  public void evolve() {
    Evolution evo = dex.getEvolution(dexNumber);
    if (nickname.equals(dex.getSpecies(dexNumber))) {
      dexNumber = evo.getPostEvolutionID();
      nickname = dex.getSpecies(dexNumber);
    } dexNumber = evo.getPostEvolutionID();
    if (dex.getEvolution(dexNumber)!=null&&dex.getEvolution(dexNumber).getLevelReq()!=null) {
      evolutionLevel = dex.getEvolution(dexNumber).getLevelReq();
    } else {
      evolutionLevel = -1;
    } learnset = dex.getLearnset(dexNumber);
    evYield = dex.getEvYield(dexNumber);
    baseStats = dex.getBaseStats(dexNumber);
    spriteFront = loadImage(dex.getFrontSprite(dexNumber));
    spriteBack = loadImage(dex.getBackSprite(dexNumber));
    growthRate = dex.getGrowthRate(dexNumber);
    expChart = dex.getExpChart(growthRate);
    baseExp = dex.getBaseExp(dexNumber);
    captureRate = dex.getCaptureRate(dexNumber);
    primaryType = dex.getPrimaryType(dexNumber);
    secondaryType = dex.getSecondaryType(dexNumber);
    updateStats();
    currentHP = stats[1];
  }
  //---------- STANDARD GET/SET METHODS BELOW ----------//
  public int getCurrentHP() {
    return currentHP;
  }
  public void setCurrentHP(int newHP) {
    currentHP = newHP;
  }
  public int getLevel() {
    return level;
  }
  public void setLevel(int newLevel) {
    exp = expChart[newLevel];
    addExp(0);
  }
  public int getExp() {
    return exp;
  }
  public void setExp(int newExp) {
    exp = newExp;
  }
  public String getNickname() {
    return nickname;
  }
  public void setNickname(String newNickname) {
    nickname = newNickname;
  }
  public int getDexNumber() {
    return dexNumber;
  }
  public void setDexNumber(int newDexNumber) {
    dexNumber = newDexNumber;
  }
  public Move[] getMoves() {
    return moves;
  }
  public void setMoves(Move[] newMoves) {
    moves = newMoves;
  }
  public int[] getStats() {
    return stats;
  }
  public Move getMoveSlot(int slot) {
    return moves[slot];
  }
  public void setMoveSlot(int slot, Move move) {
    moves[slot] = move;
  }
  public PImage getFrontSprite() {
    return spriteFront;
  }
  public PImage getBackSprite() {
    return spriteBack;
  }
  public int getGrowthRate() {
    return growthRate;
  }
  public int getCaptureRate() {
    return captureRate;
  }
  public int getBaseExp() {
    return baseExp;
  }
  public int getPrimaryType() {
    return primaryType;
  }
  public int getSecondaryType() {
    return secondaryType;
  }
  public int getEvolutionLevel() {
    return evolutionLevel;
  }
  public int[] getEvYield() {
    return evYield;
  }
  public void addEvs(int[] evYield) {
    for (int i=1;i<evYield.length;i++) {
       if (evYield[i]+evs[i]<=252&&availableEvs>=evYield[i]) {
         evs[i]+=evYield[i];
       }
    } updateStats();
  }
  public String toString() {
    String ret = "\""+nickname+"\" "+dexNumber+" "+dex.getSpecies(dexNumber)+" Level: "+level+" "+dex.getPrimaryType(dexNumber);
    ret += " "+dex.getSecondaryType(dexNumber)+" "+Arrays.toString(dex.getBaseStats(dexNumber))+" ";
    ret += dex.getGrowthRate(dexNumber)+" "+getEvolutionLevel()+" "+dex.getEvolution(dexNumber);
    ret += "\n"+"Evs: "+Arrays.toString(evs)+" Ivs: "+Arrays.toString(ivs)+" Stats: "+Arrays.toString(stats);
    ret += "\n"+"Nature: "+nature+" "+Arrays.toString(dex.getNature(nature).getBoosts());
    ret += "\nMoves:\n";
    for (Move move : moves) {
      ret+=move+"\n";
    }
    return ret;
  }
}
