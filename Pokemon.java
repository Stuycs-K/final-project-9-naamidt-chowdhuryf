import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Pokemon {
  // lets assume we go for the big pokemon info plan
  private int currentHP;
  // private int primaryType;
  // private int secondaryType;
  private int level;
  private int exp;
  // private int expCurve;
  // private int evolutionLvl;
  private String nickname;
  // private String speciesName
  // private int[] baseStats;
  private Moves[] moves;
  private int dexNumber;
  public Pokemon(int currentHP, int level, int exp, String nickname, int dexNumber) {
    this.currentHP = currentHP;
    this.level = level;
    this.exp = exp;
    this.nickname = nickname;
    this.dexNumber = dexNumber;
  }
  public int changeHP(int changeVal) {
    int initial = currentHP;
    int maxHP = Pokedex.getBaseStats(dexNumber)[0];
    currentHP+=changeVal;
    currentHP = Math.min(maxHP,currentHP);
    currentHP = Math.max(0,currentHP);
    return initial;
  }
  public void addExp(int additionalExp) {
    exp+=additionalExp;
    while (levelUp());
  }
  public boolean levelUp() {
    int expCurve = Pokedex.getExpCurve(dexNumber);
    int n = level+1;
    int expReq = 4*(int)Math.pow(n,3)/5*expCurve;
    if (expReq<=exp) {
      exp-=expReq;
      level++;
      currentHP=Pokedex.getBaseStats(dexNumber)[0];
      return true;
    } return false;
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
  public Moves[] getMoves() {
    return moves;
  }
  public void setMoves(Moves[] newMoves) {
    moves = newMoves;
  }
}
