Pokedex also;
Trainer player, npc;
Battle battle;
void setup() {
  also = new Pokedex();
  player = new Trainer("Taam", new int[]{0,0}, 0);
  npc = new Trainer("Bell", new int[]{0,0}, 0);
  Move[] allMoves = new Move[]{also.getMove("Vine Whip"), also.getMove("Ember"), also.getMove("Water Gun"), also.getMove("Tackle")};
  Pokemon bulbasaur = new Pokemon(5,"Bulbasaur",1);
  Pokemon ivysaur = new Pokemon(16,"Ivysaur",2);
  Pokemon venusaur = new Pokemon(36,"Venusaur",3);
  Pokemon charmander = new Pokemon(5,"Charmander",4);
  Pokemon charmeleon = new Pokemon(16,"Charmeleon",5);
  Pokemon charizard = new Pokemon(36,"Charizard",6);
  Pokemon[] parties = new Pokemon[]{bulbasaur,ivysaur,venusaur,charmander,charmeleon,charizard};
  for (Pokemon pokemon : parties) {
    pokemon.setMoves(allMoves);
  }
  player.setPokemon(0,bulbasaur);
  player.setPokemon(1,ivysaur);
  player.setPokemon(2,venusaur);
  npc.setPokemon(0,charmander);
  npc.setPokemon(1,charmeleon);
  npc.setPokemon(2,charizard);
  battle = new Battle(player, npc);
  size(1200,900);
  inputs = new int[]{-1,-1};
}
int[] inputs;
String[] action = new String[]{"Fight","Switch"};
int[] moveChoice = new int[]{0,1,2,3};
int selection = 0;
void draw() {
  background(255);
  fill(0);
  Pokemon playerActive = player.getSlot(0);
  Pokemon npcActive = npc.getSlot(0);
  text(player.getName()+" (YOU): "+playerActive.getNickname()+" "+playerActive.getCurrentHP()+"/"+playerActive.getStats()[0],100,100);
  text(npc.getName()+" (ENEMY): "+npcActive.getNickname()+" "+npcActive.getCurrentHP()+"/"+npcActive.getStats()[0],100,120);
} 
