static final int TILE_SIZE = 50;
static final int PATH = 1;
static final int WALL = 0;
static final int GRASS = 2;
static final int EVENT = 3;
static final int WATER = 4;
int gridWidth;
int gridHeight;
int [][]mapValues; 
Tile [][]tileValues;
int[] PCoords;
BufferedReader reader;
String line;
int[] tiles;
int[] startCoords;
public class Map {

  public Map(String input) {
    try {
      reader = createReader(input);
      line = reader.readLine();
      int[]  dimensions = int(split(line, " "));
      gridWidth = dimensions[1];
      gridHeight = dimensions[0];
      line = reader.readLine();
      int[] start = int(split(line," "));
      startCoords = new int[2];
      startCoords[0] = start[1];
      startCoords[1] = start[0];
      mapValues = new int[gridWidth/TILE_SIZE][gridHeight/TILE_SIZE];
      tileValues = new Tile[gridWidth/TILE_SIZE][gridHeight/TILE_SIZE];
      for (int a = 0; a < gridWidth/TILE_SIZE; a++) {
        line = reader.readLine();
        tiles = int(split(line," "));
        for (int b = 0; b < gridHeight/TILE_SIZE; b++) {
          mapValues[a][b] = tiles[b];
        }
      }
      grid();
      PCoords = new int[2];
      PCoords[0] = startCoords[0] / TILE_SIZE;
      PCoords[1] = startCoords[1] / TILE_SIZE;
      tileValues[startCoords[0] / TILE_SIZE][startCoords[1] / TILE_SIZE].person(DOWN);
      tileValues[startCoords[0] / TILE_SIZE][startCoords[1] / TILE_SIZE].place();
      reader.close();
    }
    catch (IOException e) {
    }
  }
  
  public void resetToStart() {
    
  }
  
  void grid() {
    for (int x = 0; x < gridWidth/TILE_SIZE; x++ ) {
      for (int y = 0; y < gridHeight/TILE_SIZE; y++) {
        if (mapValues[x][y] == WALL) {
          tileValues[x][y] = new Tile(WALL, y*TILE_SIZE-startCoords[1] + width/2, x*TILE_SIZE-startCoords[0] + height/4);
          tileValues[x][y].place();
        }
        if (mapValues[x][y] == PATH) {
          tileValues[x][y] = new Tile(PATH, y*TILE_SIZE-startCoords[1] + width/2, x*TILE_SIZE-startCoords[0]+ height/4);
          tileValues[x][y].place();
        }
        if (mapValues[x][y] == GRASS) {
          tileValues[x][y] = new Tile(GRASS, y*TILE_SIZE-startCoords[1] + width/2, x*TILE_SIZE-startCoords[0]+ height/4);
          tileValues[x][y].place();
        }
        if (mapValues[x][y] == EVENT) {
          tileValues[x][y] = new Tile(EVENT, y*TILE_SIZE-startCoords[1] + width/2, x*TILE_SIZE-startCoords[0]+ height/4);
          tileValues[x][y].place();
        }
        if (mapValues[x][y] == WATER) {
          tileValues[x][y] = new Tile(WATER, y*TILE_SIZE-startCoords[1] + width/2, x*TILE_SIZE-startCoords[0]+ height/4);
          tileValues[x][y].place();
        }
      }
    }
  }
  
  void replace() {
    for (int x = 0; x < gridWidth/TILE_SIZE; x++) {
      for (int y = 0; y < gridHeight/TILE_SIZE; y++) {
        tileValues[x][y].place();
      }
    }
  }
  
  void move(int direction) {
    boolean disable = false;
    tileValues[PCoords[0]][PCoords[1]].person(NONE);
    tileValues[PCoords[0]][PCoords[1]].place();
    if (direction == UP) {
      if (tileValues[PCoords[0] - 1][PCoords[1]].checkWalkable()) {
        PCoords[0]--;
      } else {
        disable = true;
      }
    }
    if (direction == DOWN) {
      if (tileValues[PCoords[0] + 1][PCoords[1]].checkWalkable()) {
        PCoords[0]++;
      } else {
        disable = true;
      }
    }
    if (direction == RIGHT) {
      if (tileValues[PCoords[0]][PCoords[1] + 1].checkWalkable()) {
        PCoords[1]++;
      } else {
        disable = true;
      }
    }
    if (direction == LEFT) {
      if (tileValues[PCoords[0]][PCoords[1] - 1].checkWalkable()) {
        PCoords[1]--;
      } else {
        disable = true;
      }
    }
    tileValues[PCoords[0]][PCoords[1]].person(direction);
    tileValues[PCoords[0]][PCoords[1]].place();
    if (!disable) {
      for (int x = 0; x < gridWidth/TILE_SIZE; x++) {
        for (int y = 0; y < gridHeight/TILE_SIZE; y++) {
          tileValues[x][y].place(direction);
        }
      }
    }
  }
}
