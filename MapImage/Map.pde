static final int SQUARE_SIZE = 50;//this is a constant.
static final int PATH = 1;
static final int WALL = 0;
static final int GRASS = 2;
static final int EVENT = 3;
static final int WATER = 4;
int gridWidth;
int gridHeight;
int [][]mapValues;
Tile [][]tileValues;
BufferedReader reader;
String line;
int[] tiles;
public class Map {

  public Map(String input) {
    try {
      reader = createReader(input);
      line = reader.readLine();
      int[]  dimensions = int(split(line, " "));
      gridWidth = dimensions[0];
      gridHeight = dimensions[1];
      mapValues = new int[gridWidth/SQUARE_SIZE][gridHeight/SQUARE_SIZE];
      tileValues = new Tile[gridWidth/SQUARE_SIZE][gridHeight/SQUARE_SIZE];
      for (int a = 0; a < gridWidth/SQUARE_SIZE; a++) {
        line = reader.readLine();
        tiles = int(split(line,""));
        for (int b = 0; b < gridHeight/SQUARE_SIZE; b++) {
          mapValues[a][b] = tiles[b];
        }
      }
      grid();
      reader.close();
    }
    catch (IOException e) {
    }
  }

  void grid() {
    int i = 0;
    int t = 0;
    for (int x = 0; x < gridWidth; x = x + SQUARE_SIZE) {
      for (int y = 0; y < gridHeight; y = y + SQUARE_SIZE) {
        if (mapValues[i][t] == WALL) {
          tileValues[i][t] = new Tile(WALL, x, y);
          tileValues[i][t].place();
        }
        if (mapValues[i][t] == PATH) {
          tileValues[i][t] = new Tile(PATH, x, y);
          tileValues[i][t].place();
        }
        if (mapValues[i][t] == GRASS) {
          tileValues[i][t] = new Tile(GRASS, x, y);
          tileValues[i][t].place();
        }
        if (mapValues[i][t] == EVENT) {
          tileValues[i][t] = new Tile(EVENT, x, y);
          tileValues[i][t].place();
        }
        if (mapValues[i][t] == WATER) {
          tileValues[i][t] = new Tile(WATER, x, y);
          tileValues[i][t].place();
        }
        t++;
      }
      i++;
      t = 0;
    }
  }

}
