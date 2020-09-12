int x, y;
float rotationY;
TreeObj tree;
TreeSmall[] smalltree;

void setup() {
  size(2000, 1500, P3D); //must be used for 3d
  noStroke();
  tree = new TreeObj();
  x = 0;
  y = 0;
  rotationY = 0;
  smalltree = new TreeSmall[5];
  //initialize trees
  for (int i = 0; i < smalltree.length; i++) {
    smalltree[i] = new TreeSmall();
  }
}

void draw() {
  background(124);
  pushMatrix();
  //rotateY(rotationY+=.01);
  if (mousePressed) {
    //lights();
    //pointLight(255, 0, 0, width/2, height/2, 400);
    directionalLight(255, 255, 255, -1, 1, -2);
  }
  //tree.draw();
  for (int i = 0; i < smalltree.length; i++) {
    translate(400, 0);
    smalltree[i].draw();
  }
  popMatrix();
}