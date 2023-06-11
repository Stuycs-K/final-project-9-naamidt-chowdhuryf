import java.util.*;
import java.io.*;
import java.lang.*;
import java.math.*;

public class Event {
  private int type;
  // 0 == encounter, 1 == trainer, 2 == healer, 3 == item guy?
  public Event(int type) {
    this.type = type;
  }
  public int interact() {
    return 1;
  } 
}
