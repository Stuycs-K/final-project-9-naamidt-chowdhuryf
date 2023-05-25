import java.util.*;
import java.lang.*;
import java.io.*;

public class Driver{
  public static void main(String[] args) throws Exception {
    Pokedex also = new Pokedex();
    Pokemon bulbasaur = new Pokemon(1, "Bulbasaur", also.getDex("Bulbasaur"));
    Pokemon squirtle = new Pokemon(1, "Squirtle", also.getDex("Squirtle"));
    Pokemon charmander = new Pokemon(1, "Charmander", also.getDex("Charmander"));
    Move[] allMoves = new Move[]{also.getMove("Vine Whip"), also.getMove("Ember"), also.getMove("Water Gun"), also.getMove("Tackle")};
    bulbasaur.setMoves(allMoves);
    squirtle.setMoves(allMoves);
    charmander.setMoves(allMoves);

    for (int i = 0; i < 4; i++) {
      System.out.println("BULBASAUR HITS CHARMANDER WITH " + bulbasaur.getMoves()[i].getName());
      System.out.println(also.damageCalculator(bulbasaur, charmander, bulbasaur.getMoves()[i]));
      System.out.println("CHARMANDER HITS BULBASAUR WITH " + charmander.getMoves()[i].getName());
      System.out.println(also.damageCalculator(charmander, bulbasaur, charmander.getMoves()[i]));
      System.out.println("BULBASAUR HITS SQUIRTLE WITH " + bulbasaur.getMoves()[i].getName());
      System.out.println(also.damageCalculator(bulbasaur, squirtle, bulbasaur.getMoves()[i]));
      System.out.println("SQUIRTLE HITS BULBASAUR WITH " + squirtle.getMoves()[i].getName());
      System.out.println(also.damageCalculator(squirtle, bulbasaur, squirtle.getMoves()[i]));
      System.out.println("SQUIRTLE HITS CHARMANDER WITH " + bulbasaur.getMoves()[i].getName());
      System.out.println(also.damageCalculator(squirtle, charmander, squirtle.getMoves()[i]));
      System.out.println("CHARMANDER HITS SQUIRTLE WITH " + bulbasaur.getMoves()[i].getName());
      System.out.println(also.damageCalculator(charmander, squirtle, charmander.getMoves()[i]));
    }

  }
}
