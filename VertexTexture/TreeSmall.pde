class TreeSmall {
  PShape tree, top, bottom;
  PImage leaves, bark;
  float angle;
  
  public TreeSmall() {
    leaves = loadImage("bushes.jpg");
    bark = loadImage("old_oak_bark.jpg");
    tree = createShape(GROUP); //intialize group
    top = createShape(SPHERE, 200); //create
    top.setTexture(leaves);
    bottom = createShape(BOX, 80, 600, 80);
    bottom.setTexture(bark);
    bottom.translate(0, 200); // move only the bottom shape
    tree.addChild(top);
    tree.addChild(bottom);
    angle = 0;
  }
  
  public void draw() {
    pushMatrix();
    translate(0, 500);
    shape(tree);
    tree.rotateY(0.05);
    popMatrix();
  }
  
  public PShape getShape() {
    return tree;
  }
}