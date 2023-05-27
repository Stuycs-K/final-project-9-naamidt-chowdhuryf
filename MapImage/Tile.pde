static final int NONE = 0;
static final int UP = 1;
static final int LEFT = 2;
static final int RIGHT = 3;
static final int DOWN = 4;

static final int WALK = 1;
static final int RUN = 2;

public class Tile{
  PImage sprite;
  //Event event;
  boolean walkable;
  boolean swimmable;
  int[] pStatus;
  int[] coords;
  
  public Tile(int type, int x, int y) {
    coords = new int[2];
    coords[0] = x;
    coords[1] = y;
    pStatus = new int[]{0,0};
    if (type == WALL) {
      sprite = loadImage("wall.png");
      walkable = false;
      swimmable = false;
    }
    if (type == PATH) {
      sprite = loadImage("path.png");
      walkable = true;
      swimmable = false;
    }
    if (type == GRASS) {
      sprite = loadImage("grass.png");
      walkable = false;
      swimmable = false;
    }
    if (type == EVENT) {
      sprite = loadImage("path.png");
      walkable = false;
      swimmable = false;
    }
    if (type == WATER) {
      sprite = loadImage("water.png");
      walkable = false;
      swimmable = true;
    }
  }
  
  void place() {
    image(sprite, coords[0], coords[1]);
  }
    
    
    
}
