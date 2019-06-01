class Creature {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  final float maxForce = 0.14;
  final float mutationRate = 0.02;
  final float reproductionEnergy = 70;
  
  float size;
  
  float maxSpeed;
  Genes genes;
  
  float energy;
  
  Creature(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector();
    genes = new Genes();
    
    size = map(genes.traits[Genes.SIZE], 0, 1, 8, 50);
    maxSpeed = map(genes.traits[Genes.METABOLISM], 0, 1, 0, 12);
    energy = map(genes.traits[Genes.SIZE], 0, 1, 70, 100);
  }
  
  Creature(float x, float y, Genes genes) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector();
    this.genes = genes;
    genes.mutate(mutationRate);
    
    size = map(genes.traits[Genes.SIZE], 0, 1, 10, 63);
    maxSpeed = map(genes.traits[Genes.METABOLISM], 0, 1, 0, 12);
    energy = map(genes.traits[Genes.SIZE], 0, 1, 70, 100);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    
    position.add(velocity);
    acceleration.mult(0);
    
    energy -= size * genes.traits[Genes.METABOLISM] / 10;
  }
  
  boolean isDead() {
    return energy <= 0;  
  }
  
  void boundaries() {
    PVector correction = new PVector();
    if(position.x < 0) {
      correction.x = maxSpeed;  
    } else if(position.x > width) {
      correction.x = -maxSpeed;  
    }
    
    if(position.y < 0) {
      correction.y = maxSpeed;  
    } else if(position.y > height) {
      correction.y = -maxSpeed;  
    }
    
    if(correction.magSq() == 0)
      return;
    
    correction.setMag(maxSpeed);
    PVector steer = PVector.sub(correction, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);  
  }
  
  void seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.setMag(maxSpeed);
    //print(desired);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void hunt(Food food) {
    if(food.points.size() == 0)
      return;
    int i = food.getClosest(position);
    PVector closest = food.points.get(i);
    seek(closest);
    if(PVector.dist(closest, position) <= size / 2 * 0.8) {
      food.points.remove(i);
      energy += Food.ENERGY;
    }
  }
  
  Creature reproduce() {
    if(random(1) < 0.993) {
      return null;
    }
    if(energy > reproductionEnergy) {
      Genes newGenes = genes.copy();
      newGenes.mutate(mutationRate);
      energy -= reproductionEnergy / 3;
      return new Creature(position.x + random(-1, 1), position.y + random(-1, 1), newGenes);
    }
    return null;
  }
  
  void display() {
    float alpha = map(energy, 0, 90, 0, 255);
    push();
    translate(position.x, position.y);
    stroke(255);
    fill(32, 64, 215, alpha);
    ellipse(0, 0, size, size);
    pop();
  }
}
