class World {
  ArrayList<Creature> creatures;
  Food food;
  
  World(int numCreatures, int numFood) {
    food = new Food(numFood);
    creatures = new ArrayList<Creature> ();
    
    for(int i = 0; i < numCreatures; i++) {
      addCreature(random(width), random(height));
    }
  }
  
  void addCreature(float x, float y) {
    creatures.add(new Creature(x, y));
  }
  
  void addCreature(Creature c) {
    creatures.add(c);  
  }
  
  void update() {
    int i = 0;
    while(i < creatures.size()) {
      Creature c = creatures.get(i);
      if(c.isDead()) {
        //food.points.add(new PVector(c.position.x, c.position.y));
        creatures.remove(i);
      }
      else {
        i++;  
      }
    }
    
    for(int j = creatures.size() - 1; j >= 0; j--) {
      Creature c = creatures.get(j);
      c.hunt(food);
      c.boundaries();
      Creature newCreature = c.reproduce();
      if(newCreature != null)
        addCreature(newCreature);
      c.update();
      c.display();
    }
    food.update();
    food.display();
  }
  
  void thanos() {
    for(int i = creatures.size() - 1; i >= 0; i--) {
      if(random(1) >= 0.5)
        creatures.remove(i);
    }
  }
}
