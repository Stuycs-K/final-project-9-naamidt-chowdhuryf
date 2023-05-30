void setup() {
  size(300,600);
  background(255);
  UI();
  rect(width/2, 3*height/8, width/2, height/8);
}

void UI() {
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
  text("RUN", width/2 + 60, 3*height/4 + 80);
}
