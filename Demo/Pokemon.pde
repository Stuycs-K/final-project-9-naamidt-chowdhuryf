import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokemon {
  private int currentHP, level, exp, dexNumber;
  private String nickname, nature;
  private Move[] moves;
  private int[] stats, evs, ivs;
  private Pokedex dex;
  public Pokemon(int level, String nickname, int dexNumber) {
    this.level = level;
    exp = 0;
    this.nickname = nickname;
    this.dexNumber = dexNumber;
    moves = new Move[4];
    dex = new Pokedex();
    ivs = new int[6];
    evs = new int[6];
    nature = dex.randomNature();
    for (int i=0; i<6; i++) {
      ivs[i] = (int)(Math.random()*32);
      evs[i] = 0;
    }
    stats = new int[6];
    int[] baseStats = dex.getBaseStats(dexNumber);
    double[] natureBoosts = dex.getNature(nature);
    for (int i=0; i<stats.length; i++) {
      stats[i] = calculateStats(baseStats[i], ivs[i], evs[i], level, natureBoosts[i]);
    }
    currentHP = stats[0];
    exp = 0;
  }
  public int calculateStats(int base, int iv, int ev, int level, double nature) {
    int stat;
    stat = (((2*base+iv+(ev/4))*level)/100)+level+10;
    return (int)(stat*nature);
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
    double expCurve = dex.getExpCurve(dexNumber);
    int n = level+1;
    int expReq = (int)(4*Math.pow(n, 3)/5.0*expCurve);
    if (expReq<=exp) {
      exp-=expReq;
      level++;
      currentHP=dex.getBaseStats(dexNumber)[0];
      return true;
    }
    return false;
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
    level = newLevel;
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
  public String toString() {
    String ret = "\""+nickname+"\" "+dexNumber+" "+dex.getName(dexNumber)+" "+dex.getPrimaryType(dexNumber);
    ret += " "+dex.getSecondaryType(dexNumber)+" "+Arrays.toString(dex.getBaseStats(dexNumber))+" ";
    ret += dex.getExpCurve(dexNumber)+" "+dex.getEvolutionLvl(dexNumber)+" "+dex.getEvolution(dexNumber);
    ret += "\n"+"Evs: "+Arrays.toString(evs)+" Ivs: "+Arrays.toString(ivs)+" Stats: "+Arrays.toString(stats);
    ret += "\n"+"Nature: "+nature+" "+Arrays.toString(dex.getNature(nature));
    ret += "\nMoves:\n";
    for (Move move : moves) {
      ret+=move+"\n";
    }
    return ret;
  }
}
