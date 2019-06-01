class Food {
  ArrayList<PVector> points;
  final static int ENERGY = 40;
  Food(int amount) {
    points = new ArrayList<PVector>();
    for(int i = 0; i < amount; i++) {
      points.add(new PVector(random(width), random(height)));  
    }
  }
  
  void update() {
    if(random(1) < 0.97) {
      points.add(new PVector(random(width), random(height)));  
    }
  }
  
  void display() {
    push();
    noStroke();
    fill(231, 209, 23);
    for(PVector pt : points) {
      ellipse(pt.x, pt.y, 4, 4);
    }
    pop();
  }
  
  int getClosest(PVector position) {
    int closest = 0;
    float recordDistance = distSq(points.get(0), position);
    for(int i = 1; i < points.size(); i++) {
      float dist = distSq(points.get(i), position);
      if(dist < recordDistance) {
        closest = i;
        recordDistance = dist;
      }
    }
    return closest;
  }
}
