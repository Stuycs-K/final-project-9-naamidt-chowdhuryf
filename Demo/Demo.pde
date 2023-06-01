Map map;
int state;

void setup() {
  state = 0;
  size(300, 600);
  background(0);
  map = new Map("testmap.txt");
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
  Pokedex dex = new Pokedex();
  Pokemon randy = dex.randomPokemon(12);
  image(randy.getFrontSprite(),110,110);
  //image(marshadow,100,100);
}

void keyPressed() {
  if (state == 0) {
    if (key == 'w') {
      map.move(UP);
    }
    if (key == 'd') {
      map.move(RIGHT);
    }
    if (key == 's') {
      map.move(DOWN);
    }
    if (key == 'a') {
      map.move(LEFT);
    }
    if (key == 'b') {
      state++;
    }
    mapUI();
  }
 if (state == 1) {
   if (key == 'm') {
     state--;
   }
   battleUI();
  }
}

void draw() {
  if (state == 0) {
    mapUI();
  }
  else if (state == 1) {
    battleUI();
  }
}

void mousePressed() {
  if (mouseX > width/2 + 10 && mouseX < width - 10 && mouseY > height/2 + height/5 + 60 && mouseY < height/2 + height/6 + height/5 + 60){
    exit();
  }
}

void mapUI() {
  fill(0);
  rect(0, height/2, width, height/2);
  fill(255, 0, 0);
  circle(width/2, 3*height/4, height/2);
  noFill();
  fill(255);
  arc(width/2, 3 * height/4, 320, 320, 0, PI, OPEN);
  noFill();
  fill(0);
  circle(width/2, 3*height/4, 50);
  noFill();
  fill(255);
  circle(width/2, 3*height/4, 30);
  rect(10, height/2 + 60, width/2 - 20, height/6);
  rect(10, height/2 + height/5 + 60, width/2 - 20, height/6);
  rect(width/2 + 10, height/2 + 60, width/2 - 20, height/6);
  rect(width/2 + 10, height/2 + height/5 + 60, width/2 - 20, height/6);
  noFill();
  fill(0);
  text("POKEMON", 45, 2*height/3 + 10); 
  text("POKEDEX", 45, 3*height/4 + 80);
  text("BAG", width/2 + 65, 2*height/3+10);
  text("QUIT", width/2 + 60, 3*height/4 + 80);
}


void battleUI() {
  background(255);
  fill(0);
  rect(0, height/2, width, height/2);
  fill(255, 0, 0);
  circle(width/2, 3*height/4, height/2);
  noFill();
  fill(255);
  arc(width/2, 3 * height/4, 320, 320, 0, PI, OPEN);
  noFill();
  fill(0);
  circle(width/2, 3*height/4, 50);
  noFill();
  fill(255);
  circle(width/2, 3*height/4, 30);
  rect(10, height/2 + 60, width/2 - 20, height/6);
  rect(10, height/2 + height/5 + 60, width/2 - 20, height/6);
  rect(width/2 + 10, height/2 + 60, width/2 - 20, height/6);
  rect(width/2 + 10, height/2 + height/5 + 60, width/2 - 20, height/6);
  noFill();
  fill(0);
  text("FIGHT", 55, 2*height/3 + 10); 
  text("POKEMON", 45, 3*height/4 + 80);
  text("BAG", width/2 + 65, 2*height/3+10);
  text("RUN", width/2 + 65, 3*height/4 + 80);
  noFill();
  fill(150);
  ellipse(75, 3*height/8 + 60, 150, 20);
  ellipse(3*width/4, height/20 + 70, 150, 20);
  fill(255);
  rect(width/2, 3*height/8, width/2, height/12, 10);
  rect(0, height/20, width/2, height/12, 10);
  Pokedex dex = new Pokedex();
  Pokemon randy = dex.randomPokemon(12);
  image(randy.getFrontSprite(),110,110);
}
