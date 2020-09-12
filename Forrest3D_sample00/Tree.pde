class Tree {
  PShape tree, top, bottom;
  PImage leaves, bark;
  float angle;
  PVector pos;
  
  public Tree(float x, float y, float z, PImage l, PImage b, int s) {
    leaves = l;
    bark = b;
    int trunkHeight = (int)random(400, 2000);
    int trunkGirth = (int)random(80, 120);
    int sphereSize = 200;
    if (s == 1) sphereSize = 300;
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    pos.z = z;
    angle = random(radians(180));
    textureMode(IMAGE);
    //textureWrap(CLAMP);
    noStroke(); // removes sphere wire
    tree = createShape(GROUP); //intialize group
    int sphears = (int)random(s) + 1;
    int offsets = 35;
    for (int i = 0; i < sphears; i++) {
      top = createShape(SPHERE, sphereSize + random(-50, 50)); //create
      top.setTexture(leaves);
      //top.texture(leaves);
      top.translate(0 + random(-offsets, offsets), -(trunkHeight) - sphereSize / 2 + random(-offsets - (i * offsets), offsets - (i * offsets)));
      if (s == 1) top.rotateY(-angle);
      else top.rotateY(random(7));
      tree.addChild(top);
      //top = genLeaves();
      //top.rotateY(random(radians(180)));
      //top.rotateX(random(radians(160)));
      //top.translate(0 + random(-offsets, offsets), -(trunkHeight) - sphereSize / 2 + random(-offsets - (i * offsets), offsets - (i * offsets)));
      //tree.addChild(top);
    }
    bottom = createShape(BOX, trunkGirth, trunkHeight, trunkGirth);
    bottom.setTexture(bark);
    bottom.translate(0, -trunkHeight * 0.5); // move up
    tree.addChild(bottom);
    int branches = (int)random(6);
    for (int i = 0; i < branches; i++) {
      bottom = createShape(BOX, trunkGirth / 4, trunkHeight / 4, trunkGirth / 4);
      bottom.setTexture(bark);
      bottom.translate(0, -trunkHeight / 8, 0);
      bottom.rotateX(.52);
      bottom.rotateY(random(7));
      bottom.translate(0, -random(trunkHeight * .5, trunkHeight * .8));
      tree.addChild(bottom);
    }
    tree.rotateY(angle);
    tree.translate(pos.x, pos.y, pos.z);
  }
  
  public void draw() {
    pushMatrix();
    shape(tree);
    //tree.rotateY(0.05);
    popMatrix();
  }
  
  private PShape genLeaves() {
    PShape shape = createShape();
    shape.beginShape();
    shape.textureMode(NORMAL);
    shape.texture(leaves);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(400, 0, 1, 0);
    shape.vertex(400, 400, 1, 1);
    shape.vertex(0, 400, 0, 1);
    shape.endShape();
    return shape;
  }
  
  public void addTotoro(PImage img) {
    //img.resize(0, 100);
    PShape shape = createShape();
    shape.beginShape();
    shape.textureMode(NORMAL);
    shape.texture(img);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(img.width, 0, 1, 0);
    shape.vertex(img.width, img.height, 1, 1);
    shape.vertex(0, img.height, 0, 1);
    shape.endShape();
    shape.rotateY(-angle);
    shape.translate(pos.x + 50, pos.y - img.height, pos.z);
    tree.addChild(shape);
  }
}