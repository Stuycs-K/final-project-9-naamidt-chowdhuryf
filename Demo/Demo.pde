void setup() {
  size(1450,1000);
  String dir = sketchPath();
  System.out.println(dir);
  dir = dir.substring(0,dir.length()-4);
  System.out.println(dir);
  char what = dir.charAt(dir.length()-1);
  dir+="Demo";
  //dir+="front";
  System.out.println(dir);
  dir+=what;
  System.out.println(dir);
  dir+="data";
  dir+=what;
  dir+="front";
  dir+=what;
  dir+="802.gif";
  // tl;dr, get the filepath, go to data, then go into the folder, then take sprite
  System.out.println(dir);
  PImage thing = loadImage(dir);
  image(thing,0,0);
} 
