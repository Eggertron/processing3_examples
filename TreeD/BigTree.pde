class BigTree {
  PImage img;
  PVector pos;
  PShape tree;
  float rotScale;
  
  public BigTree(PImage img) {
    float radius = width * 0.25;
    int step = 30;
    rotScale = 0.34 / width;
    pos = new PVector();
    this.img = img;
    pos.x = width * 0.5;
    pos.y = 0;
    pos.z = 300;
    
    tree = createShape();
    tree.beginShape();
    tree.textureMode(NORMAL);
    tree.texture(img);
    float radianss;
    for (float delta = 0; delta <= 180; delta += step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), 0, radius * sin(radianss), delta/180, 0);  // generate the bottom curve
    }
    for (float delta = 180; delta >= 0; delta -= step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), height, radius * sin(radianss), delta/180, 1); // generate the top curve.
    }
    tree.endShape();
  }
  
  public void draw() {
    tree.resetMatrix();
    tree.rotateY(-mouseX * rotScale);
    //shapeMode(CENTER);
    shape(tree, pos.x, pos.y);
  }
}