static final int NONE = 0;
static final int UP = 1;
static final int RIGHT = 2;
static final int DOWN = 3;
static final int LEFT = 4;

static final int WALK = 1;
static final int RUN = 2;

public class Tile{
  PImage sprite;
  PImage alsosprite;
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
      sprite = loadImage("wall.PNG");
      alsosprite = loadImage("wall.PNG");
      walkable = false;
      swimmable = false;
    }
    if (type == PATH) {
      sprite = loadImage("path.PNG");
      alsosprite = loadImage("path.PNG");
      walkable = true;
      swimmable = false;
    }
    if (type == GRASS) {
      sprite = loadImage("grass.PNG");
      alsosprite = loadImage("grass.PNG");
      walkable = false;
      swimmable = false;
    }
    if (type == EVENT) {
      sprite = loadImage("path.PNG");
      alsosprite = loadImage("path.PNG");
      walkable = false;
      swimmable = false;
    }
    if (type == WATER) {
      sprite = loadImage("water.PNG");
      alsosprite = loadImage("water.PNG");
      walkable = false;
      swimmable = true;
    }
  }
  
  void place() {
    image(sprite, coords[0], coords[1]);
  }
  
  void place(int direction) {
    if (direction == UP) {
      setCoords(coords[0], coords[1] + TILE_SIZE);
    }
    if (direction == RIGHT) {
      setCoords(coords[0] - TILE_SIZE, coords[1]);
    }
    if (direction == DOWN) {
      setCoords(coords[0], coords[1] - TILE_SIZE);
    }
    if (direction == LEFT) {
      setCoords(coords[0] + TILE_SIZE, coords[1]);
    }
    place();
  }
  
  void setCoords(int x, int y) {
    coords[0] = x;
    coords[1] = y;
  }
  
  void person(int direction) {
    pStatus[0] = direction;
    if (direction == NONE) {
      sprite = alsosprite;
    }
    if (direction == UP) {
      sprite = loadImage("BackBrendan.PNG");
    }
    if (direction == RIGHT) {
      sprite = loadImage("RightBrendan.PNG");  
    }
    if (direction == DOWN) {
      sprite = loadImage("ForwardBrendan.PNG"); 
    }
    if (direction == LEFT) {
      sprite = loadImage("LeftBrendan.PNG");
    }
  }
  
  boolean hasPerson() {
    return pStatus[0] > 0;
  }
  
  boolean checkCoords(int x, int y) {
    return (coords[0] == x && coords[1] == y);
  }
  
  boolean checkWalkable(){
    return walkable;
  }
  boolean checkSwimable() {
    return swimmable;
  }
    
    
}
