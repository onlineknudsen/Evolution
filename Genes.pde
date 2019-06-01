class Genes {
  float[] traits = new float[2];
  
  static final int METABOLISM = 0;
  static final int SIZE = 1;
  
  Genes() {
      traits = new float[2];
      for(int i = 0; i < traits.length; i++) {
        traits[i] = random(0, 1);  
      }
  }
  
  Genes(float[] newTraits) {
    traits = newTraits;  
  }
  
  Genes copy() {
    float[] newTraits = new float[traits.length];
    for(int i = 0; i < newTraits.length; i++) {
      newTraits[i] = traits[i];  
    }
    return new Genes(newTraits);
  }
  
  void mutate(float probability) {
    for(int i = 0; i < traits.length; i++) {
      if(random(1) < probability) {
         traits[i] = random(0, 1); 
      }
    }
  }
}
