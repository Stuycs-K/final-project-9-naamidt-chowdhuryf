void setup() {
  size(400,500);
  //String dir = sketchPath();
  //System.out.println(dir);
  //dir = dir.substring(0,dir.length()-4);
  //char what = dir.charAt(dir.length()-1);
  //dir+="Demo";
  ////dir+="front";
  //dir+=what;
  //dir+="data";
  //dir+=what;
  //dir+="front";
  //dir+=what;
  //dir+="800.gif";
  //System.out.println(dir);
  //PImage marshadow = loadImage(dir);
  // tl;dr, get the filepath, go to data, then go into the folder, then take sprite
  //Pokedex dex = new Pokedex();
  //Pokemon randy = dex.randomPokemon(12);
  //image(randy.getFrontSprite(),110,110);
  //image(marshadow,100,100);
  Pokedex dex = new Pokedex();
  Pokemon randy = dex.randomPokemon(1);
  System.out.println(randy);
  randy.setLevel(100);
  System.out.println(randy);
  randy.addEvs(new int[]{0,252,0,0,0,0,0});
  System.out.println(randy);
} 
void draw() {
  //background(255);
  //Pokedex dex = new Pokedex();
  //Pokemon randy = dex.randomPokemon(100);
  ////image(randy.getFrontSprite(),110,110);
  //System.out.println(randy);
}
