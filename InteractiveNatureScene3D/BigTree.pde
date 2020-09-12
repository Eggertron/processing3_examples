class BigTree {
  PImage img;
  PVector pos;
  PShape tree;
  
  public BigTree(PImage img) {
    float radius = width * 0.25;
    int step = 30;
    pos = new PVector();
    this.img = img;
    pos.x = 100;
    pos.y = 100;
    pos.z = 300;
    
    //textureMode(NORMAL);
    tree = createShape();
    tree.beginShape();
    tree.textureMode(NORMAL);
    tree.texture(img);
    float radianss;
    for (float delta = 0; delta <= 180; delta += step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), 0, radius * sin(radianss), delta/180, 0);  // generate the first curve
    }
    for (float delta = 180; delta >= 0; delta -= step) {
      radianss = radians(delta);
      tree.vertex(radius * cos(radianss), height, radius * sin(radianss), delta/180, 1); // generate the top curve.
    }
    //tree.vertex(0,      0,    0,    0,  0);      // bottom left
    //tree.vertex(50,     0,   50, 0.25,  0);      // bottom 
    //tree.vertex(100,    0,  100,  0.5,  0);      // bottom middle
    //tree.vertex(200,    0,    0,    1,  0);      // bottom right
    //tree.vertex(200,  600,    0,    1,  1);      // top right
    //tree.vertex(100,  600,  100,  0.5,  1);      // top middle
    //tree.vertex(0,    600,    0,    0,  1);      // top left
    tree.endShape();
    //tree.translate(0, 0, pos.z);
  }
  
  public void draw() {
    pushMatrix();
    tree.rotateY(.01);
    shape(tree, 300, 000);
    popMatrix();
  }
}