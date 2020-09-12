class Ground {
  
  PShape ground;
  
  public Ground(PImage img) {
    int normal = 25;
    int gwidth = 4000;
    textureMode(NORMAL);
    textureWrap(REPEAT);
    ground = createShape();
    ground.beginShape();
    ground.texture(img);
    ground.vertex(-gwidth, 0, gwidth, 0, 0);
    ground.vertex(-gwidth, 0, -gwidth, 0, normal);
    ground.vertex(gwidth, 0, -gwidth, normal, normal);
    ground.vertex(gwidth, 0, gwidth, normal, 0);
    ground.endShape();
  }
  
  public void draw() {
    shape(ground);
  }
}