Map map;

void setup() {
  size(300, 600);
  background(0);
  map = new Map("testmap.txt");
}

void keyPressed() {
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
}

void draw() {
  rect(0, height/2, width, height/2);
}
