/*  Interactive Nature scene using shapes
    Author: Edgar H. Han
    Version: 20161110
*/

// GLOBALS
private PImage  bark,
                smallTrees,
                sky,
                mountain,
                village,
                bird1, bird2;
private BigTree bigTree;
private Background background;
private Mountain00 mountain00;
private Foreground foreground;
private Bird bird;
private Pixelate pixelate;

void setup() {
  //size(1000, 1000, P3D);
  fullScreen(P3D);
  pixelate = new Pixelate();
  loadImages();
  initObjects();
}

void draw() {
  background.draw();
  mountain00.draw();
  foreground.draw();
  bird.draw();
  addLights();
  bigTree.draw(); // make sure big tree is drawn last so that it's on top of everything else.
}

void loadImages() {
  bark = loadImage("res/old_oak_bark.jpg");
  sky = loadImage("res/background.jpg");
  mountain = loadImage("res/midground.png");
  village = loadImage("res/foreground.png");
  village = pixelate.pixelate(village, 2);
  bird1 = loadImage("res/bat.png");
  bird2 = loadImage("res/bat_fly.png");
}

void initObjects() {
  bigTree = new BigTree(bark);
  background = new Background(sky);
  mountain00 = new Mountain00(mountain);
  foreground = new Foreground(village);
  bird = new Bird(bird1, bird2);
}

void addLights() {
    //lights();
    //pointLight(255, 0, 0, width/2, height/2, 400);
    //directionalLight(255, 255, 255, -1, 1, -2);
    directionalLight(255, 255, 255, 0, 0, -3);
}