static final int SQUARE_SIZE = 50;//this is a constant.
static final int PATH = 1;
static final int WALL = 0;
static final int GRASS = 2;
static final int EVENT = 3;
static final int DOOR = 4;
int gridWidth;
int gridHeight;
int [][]mapValues;
void setup() {
  size(1500, 1000);
  gridWidth = width;
  gridHeight = height;
  mapValues = new int[gridWidth/SQUARE_SIZE][gridHeight/SQUARE_SIZE];
}

void grid() {
background(255);
int i = 0;
int t = 0;
for (int x = 0; x < gridWidth; x = x + SQUARE_SIZE) {
  for (int y = 0; y < gridHeight; y = y + SQUARE_SIZE) {
  if (mapValues[i][t] == WALL){
    fill(0);
  }
  if (mapValues[i][t] == PATH){
    fill(100, 24, 38);
  }
  if (mapValues[i][t] == GRASS){
    fill(58, 144, 75);
  }
  if (mapValues[i][t] == EVENT){
    fill(135, 58, 144);
  }
  if (mapValues[i][t] == DOOR){
    fill(255);
  }
  stroke(0);
  rect(x,y, SQUARE_SIZE, SQUARE_SIZE);
  t++;
  }
  i++;
  t = 0;
}
}

void draw() {
  grid();
}

void createArray(int[][] thing) {
  for (int[] itemm : thing) {
    for (int item : itemm) {
      item = color(int(random(255)));
    }
  }
}

void mouseClicked() {
  int locX = mouseX/SQUARE_SIZE;
  int locY = mouseY/SQUARE_SIZE;
  mapValues[locX][locY] += 1;
  if (mapValues[locX][locY] > 4) {
    mapValues[locX][locY] = 0;
  }
}
