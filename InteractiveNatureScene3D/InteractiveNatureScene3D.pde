/*
  Author: Edgar H. Han
 Version: 20160918
 The base of my canvas for 3D nature scene. All classes will be imported into this 
 pde file.
 */
import processing.video.*;

// constant variables
final float eyeCenterX = width/2, eyeCenterY = height/2, eyeCenterZ = (height/2) / tan(PI/6);
final float sceneCenterX = width/2, sceneCenterY = height/2, sceneCenterZ = 0;
final float upCenterX = 0, upCenterY = 1, upCenterZ = 0;

float eyeX, eyeY, eyeZ;
float camX, camY, camZ;
float upX, upY, upZ;

// global variables
private BoxObj[] _box;
private HUDObj _hud;
private TreeSprite[] _trees;
private BoulderSprite[] _boulders;
private GroundObj _ground;
private Skybox skybox;
private int _mouseZ;
private Capture cam;
private SpriteObj bigTree;
private CameraController camController;
private BigTree tree;
private CaptureCam captureCam;

PImage bark;

void setup() {
  bark = loadImage("old_oak_bark.jpg");
  tree = new BigTree(bark);
  size(800, 800, P3D);
  int numOfObjects = 500;
  camController = new CameraController(this);
  captureCam = new CaptureCam(this);
  //initCamera();
  _hud = new HUDObj();
  _hud.updateNumOfBoxes(numOfObjects);
  _ground = new GroundObj();

  hint(ENABLE_DEPTH_SORT); // fpr png transparancy

  _mouseZ = 0;
  //genBoxes(numOfObjects);
  genTrees(numOfObjects);
  genBoulders(100);

  skybox = new Skybox();
  skybox.init();
  //initCapture(cam);
  
  //genBigTree();
}

void draw() {
  background(255);
  if (mousePressed) {
    drawLights();
  }
  if (cam != null && cam.available() == true) {
    cam.read();
    //println("camera width: " + cam.width);
    //println("camera height: " + cam.height);
    pixelateImage(80);
  }
  captureCam.draw();
  //image(cam, 0, 0);
  //filter(THRESHOLD);
  //camController.updateCamera();
  //updateBoxes();
  _ground.draw();
  updateTrees();
  updateBoulders();
  _hud.drawHUD();
  //skybox.draw();
  //bigTree.draw();
  //tree.draw();
  //updateCamera();
  camController.updateCamera();
}

void mouseDragged() {
}

void mouseClicked() {
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // negative for upscroll, positive for downscroll.
  //println(e);
  _mouseZ += e * 50;
  _hud.updateMouseZ(_mouseZ);
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

void drawLights() {
    //lights();
    //pointLight(255, 0, 0, width/2, height/2, 400);
    directionalLight(255, 255, 255, -1, 1, -2);
    directionalLight(255, 255, 255, 1, 1, 1);
}

void updateCamera() {
  //camX = mouseY - (height * 0.5);
  //camY = mouseX - (width * 0.5);
  int scale = 1;
  camera((mouseX -(width * 0.5)) * scale, eyeCenterY + _mouseZ, (eyeCenterZ + (mouseY - (height * 0.5))) * 2 * scale, sceneCenterX, camY, camZ, 
    upX, upY, upZ);
}

void updateBoxes() {
  for (int i = 0; i < _box.length; i++) {
    _box[i].draw();
  }
}

void updateTrees() {
  for (int i = 0; i < _trees.length; i++) { 
    _trees[i].draw();
  }
}

void updateBoulders() {
  for (int i = 0; i < _boulders.length; i++) { 
    _boulders[i].draw();
  }
}

void genBoxes(int numOfBoxes) {
  _box = new BoxObj[numOfBoxes];
  for (int i = 0; i < numOfBoxes; i++) {
    _box[i] = new BoxObj();
    _box[i].genRandom();
  }
}

void genTrees(int numOfTrees) {
  _trees = new TreeSprite[numOfTrees];
  for (int i = 0; i < numOfTrees; i++) {
    _trees[i] = new TreeSprite();
  }
}

void genBoulders(int numOfBoulders) {
  _boulders = new BoulderSprite[numOfBoulders];
  for (int i = 0; i < numOfBoulders; i++) { 
    _boulders[i] = new BoulderSprite();
  }
}

void genBigTree() {
  bigTree = new SpriteObj("PNG/treebark.png");
  bigTree.setLocation(0, 0, 400);
}

/*
  Initializing the Capture source/webcam
*/
void initCapture(Capture cam) {
  String[] cameras = Capture.list();
  if (cameras.length == 0) println("No Cameras Available");
  else for (int i = 0; i < cameras.length; i++) println("Camera["+i+"] is "+cameras[i]);
  cam = new Capture(this, cameras[0]);
  cam.start();
  if (cam.available()) cam.read();
}

void pixelateImage(int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (cam.width < cam.height) {
    ratio = cam.height/cam.width;
  }
  else {
    ratio = cam.width/cam.height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  
  noStroke();
  for (int x = 0; x < cam.width; x += pxSize) {
    for (int y = 0; y < cam.height; y += pxH) {
      fill(cam.get(x, y));
      rect(x, y, pxSize, pxH);
    }
  }
}