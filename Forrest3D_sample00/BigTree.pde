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
    pos.x = radius * .5;
    pos.y = 0;
    pos.z = 3000 - (radius * 1.5);
    
    tree = createShape();
    tree.beginShape();
    tree.textureMode(NORMAL);
    tree.texture(img);
    float radianss;
    for (float delta = 0; delta <= 180; delta += step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), height * .5, radius * sin(radianss), delta/180, 1);  // generate the bottom curve
    }
    for (float delta = 180; delta >= 0; delta -= step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), -height * .8, radius * sin(radianss), delta/180, 0); // generate the top curve.
    }
    tree.endShape();
  }
  
  public void draw() {
    // need to implement the fuck you image and the sex gif.
    tree.resetMatrix();
    tree.translate(pos.x, pos.y + 600, pos.z);
    tree.rotateY(-cc.xPos*.001);
    shapeMode(CENTER);
    shape(tree, pos.x, pos.y);
    shapeMode(CORNER);
  }
}