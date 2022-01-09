class DNA {
  PVector[] genes;

  DNA(PVector[] gns) {
    if (gns == null) {
      genes = new PVector[round((width/1.4+height/1.06)/2)];
      for (int i = 0; i < genes.length; i++) {
        genes[i] = PVector.random2D();
        genes[i].setMag(0.1);
      }
    } else
      genes = gns;
  }
}

DNA incorporate(DNA gns1, DNA gns2, float mutation) {
  PVector[] newGenes;
  newGenes = new PVector[int((gns1.genes.length+gns2.genes.length)/2)];

  boolean mutate = random(0, 100) < mutation;

  for (int i = 0; i < newGenes.length; i++) {
    if (!mutate)
      newGenes[i] = random(0, 1) < 0.5 ? gns1.genes[i] : gns2.genes[i];
    else {
      newGenes[i] = PVector.random2D();
      newGenes[i].setMag(0.1);
    }

    if (i%240 == 0)
      mutate = random(0, 100) < mutation;
  }

  return new DNA(newGenes);
}
