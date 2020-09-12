/*
  Author: Edgar Han
  Version: 20161020
  attempt to make a 3d tree fractal
*/

// constant values;
final float eyeCenterX = width/2, eyeCenterY = height/2, eyeCenterZ = (height/2) / tan(PI/6);
final float sceneCenterX = width/2, sceneCenterY = height/2, sceneCenterZ = 0;
final float upCenterX = 0, upCenterY = 1, upCenterZ = 0;
final int MINLENGTH = 5;
final int MINANGLE = 25;
final int MAXANGLE = 90;
final float LENGTHSCALE = 0.5;
final float STROKEWEIGHTSCALE = 0.2;
final int MAXBRANCHES = 7;
final int MINBRANCHES = 2;

float eyeX, eyeY, eyeZ;
float camX, camY, camZ;
float upX, upY, upZ;
float mouseZ;
float rotate;

PVector[] tree;

void setup() {
  size(1000, 1000, P3D);
  tree = genTree(0, height, -height, (float)Math.PI/2, 0, height);
  
  initCamera();
}

void draw() {
  background(124);
  updateCamera();
  //rotateY(rotate += radians(2));
  //translate(width * 0.5, 0, -width); // shift over to the right
  drawTree(tree);
  //box(45);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // negative for upscroll, positive for downscroll.
  //println(e);
  mouseZ += e * 50;
}

void initCamera() {
  eyeX = eyeCenterX;
  eyeY = eyeCenterY;
  eyeZ = eyeCenterZ;
  camX = sceneCenterX;
  camY = sceneCenterY;
  camZ = sceneCenterZ;
  upX = upCenterX;
  upY = upCenterY;
  upZ = upCenterZ;
}

void drawTree(PVector[] tree) {
  for (int i = 0; i < tree.length; i += 2) {
    float x1 = tree[i].x;
    float x2 = tree[i + 1].x;
    float y1 = tree[i].y;
    float y2 = tree[i + 1].y;
    float z1 = tree[i].z;
    float z2 = tree[i + 1].z;
    line(x1, y1, z1, x2, y2, z2);
  }
}

PVector[] genTree(float x, float y, float z, float angle, float rotation, float length) {
  PVector[] result, branches, root;
  if (length < MINLENGTH) return null;
  root = new PVector[2]; //two points
  root[0] = new PVector();
  root[0].x = x; //initial points
  root[0].y = y;
  root[0].z = z; 
  float x2 = x - (length * cos(angle));
  float y2 = y - (length * sin(angle));
  float z2 = z - (length * sin(rotation));
  root[1] = new PVector();
  root[1].x = x2; //end points
  root[1].y = y2;
  root[1].z = z2;
  result = new PVector[2];
  System.arraycopy(root, 0, result, 0, root.length);
  int rand = (int)random(MAXBRANCHES - MINBRANCHES) + MINBRANCHES;
  int alternate = -1;
  for (int i = 0; i < rand; i++) {
    float newLength = length * LENGTHSCALE;
    float newLendthD = newLength + random(newLength);
    alternate *= -1;
    float newAngle = angle + (alternate * radians(random(MAXANGLE - MINANGLE) + MINANGLE));
    //float newRotation = rotation + radians(30);
    //float newRotation = rotation + radians(random(-10, 10));
    float newRotation = rotation + (-angle * radians(90));
    float newX = x - (cos(angle) * newLendthD);
    float newY = y - (sin(angle) * newLendthD);
    float newZ = z - (sin(rotation) * newLendthD);
    branches = genTree(newX, newY, newZ, newAngle, newRotation, newLength);
    if (branches != null) {
      root = new PVector[result.length + branches.length];
      System.arraycopy(result, 0, root, 0, result.length);
      System.arraycopy(branches, 0, root, result.length, branches.length);
      result = root;
    }
  }
  return result;
}

/*
  Consider the vanishing points of the 3D space, is it set by the size() function?
*/
void updateCamera() {
  //camX = mouseY - (height * 0.5);
  //camY = mouseX - (width * 0.5);
  int scale = 9;
  camera((mouseY -(height * 0.5)) * scale, eyeCenterY + mouseZ, (eyeCenterZ + (mouseX - (width * 0.5))) * scale, sceneCenterX, camY, camZ, 
       upX, upY, upZ);
}