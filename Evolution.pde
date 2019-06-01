World world;

float distSq(PVector p1, PVector p2) {
  return PVector.sub(p1, p2).magSq();
}

void setup() {
  world = new World(13, 50);
  size(800, 600);
}

void draw() {
  background(52);
  world.update();
}

void keyPressed() {
  if(key == ' ') {
    world.thanos();
  }
}
