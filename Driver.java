import java.util.*;
import java.lang.*;
import java.io.*;

public class Driver{
  public static void main(String[] args) {
    Pokedex also = new Pokedex();
    Pokemon bulbasaur = new Pokemon(also.getBaseStats(also.getDexNumber("Bulbasaur"))[0], 1, 0, "Bulbasaur", also.getDexNumber("Bulbasaur"));
    
  }
}
