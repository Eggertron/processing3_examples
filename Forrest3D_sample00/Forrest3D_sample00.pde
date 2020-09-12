private Ground ground;
private Tree[] trees;
private CameraController cc;
private Skybox sb;
private BigTree bt;
private Bird[] birds;
private Boulder[] boulders;
private Boulder[] mountains;
private Rabbit[] rabbits;
private UFO ufo;
private Slenderman slenderman;
private PenisRocket penisRocket;
private Coin coin;
private CaptureWebcam cw;
private BouncingBoob bb;

int offsetX, resetTime;

PImage bark, bush, grass, sky, bigbark,
        bat1, bat2, boulder, animals, totoroImg,
        burgerImg, ufoImg, candycaneImg, slendermanImg,
        penisImg, coinImg, smokinggirlImg, barwaitressImg,
        pinupgirl01Img, cheshiresmileImg, pedobearImg,
        bark2, nessImg, teleportImg, boobImg, fuImg,
        sexyesImg, sexyfairyImg, sexImg;

void setup() {
  loadTextures();
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  //size(1000, 1000, P3D);
  //cw = new CaptureWebcam(this); // camera does not need to be initialized multiple times.
  initObjects();
}

void draw() {
  sb.draw();
  if(ufo.isLit) pointLight(100, 255, 100, ufo.pos.x, ufo.pos.y, ufo.pos.z+10); // UFO Light
  spotLight(255, 255, 255, -3000, -3000, 3000, 1, -1, -1, PI / 2, .5);
  ground.draw();
  drawBoulders();
  drawMountains();
  drawTrees();
  ufo.draw();
  cc.updateCamera();
  // lights for the big tree
  spotLight(255, 255, 255, 0, -2000, 3000, 0, 1, -1, PI / 2, .5);
  lightSpecular(255, 255, 255);
  //specular(255, 255, 255);
  //bt.draw();
  // lights for the animals
  lights();
  lightSpecular(255, 255, 255);
  drawBirds();
  drawRabbits();
  //coin.draw();
  penisRocket.draw();
  slenderman.draw();
  bb.draw();
  if (mousePressed || millis() > resetTime) {
    initObjects(); //RESET
  }
  if (cw != null) cw.updateCapture();
}

void drawTrees() {
  for(int i = 0; i < trees.length; i++) {
    trees[i].draw();
  }
}

void drawBirds() {
  for (int i = 0; i < birds.length; i++) {
    birds[i].draw();
  }
}

void drawBoulders() {
  for (int i = 0; i < boulders.length; i++) boulders[i].draw();
}

void drawMountains() {
  for (int i = 0; i < mountains.length; i++) mountains[i].draw();
}

void drawRabbits() {
  for (int i = 0; i < rabbits.length; i++) rabbits[i].draw();
}

void loadTextures() {
  //load all the images at the begining to reduce the loading time
  // and save RAM.
  //bush = loadImage("res/leaves.jpg");
  bush = loadImage("res/leaves2.png");
  bark = loadImage("res/old_oak_bark.jpg");
  sky = loadImage("skybox05.jpg");
  bigbark = loadImage("res/old_oak_bark.jpg");
  bat1 = loadImage("bat.png");
  bat2 = loadImage("bat_fly.png");
  boulder = loadImage("boulder-close-texture.jpg");
  animals = loadImage("animalscrbetween.png");
  totoroImg = loadImage("res/totoro.png");
  burgerImg = loadImage("res/whole-burger.png");
  ufoImg = loadImage("res/ufo.gif");
  candycaneImg = loadImage("res/Candy_Cane_Background.PNG");
  slendermanImg = loadImage("res/slender_man.png");
  penisImg = loadImage("res/penis.png");
  grass = loadImage("res/deep-grass.jpg");
  coinImg = loadImage("res/coin.jpg");
  smokinggirlImg = loadImage("res/smokingGirl.png");
  barwaitressImg = loadImage("res/barwaitress.png");
  pinupgirl01Img = loadImage("res/pinupgirl01.png");
  cheshiresmileImg = loadImage("res/cheshiresmile.png");
  pedobearImg = loadImage("res/pedobear.png");
  bark2 = loadImage("res/old_oak_bark2.png");
  nessImg = loadImage("res/ness.png");
  teleportImg = loadImage("res/teleport.png");
  boobImg = loadImage("res/boob.png");
  boobImg.resize(200, 0); // boob is too big
  fuImg = loadImage("res/fu.png");
  sexyesImg = loadImage("res/sexyes.png");
  sexyfairyImg = loadImage("res/sexyfairy.png");
  sexImg = loadImage("res/sex.gif");
}

void initObjects() {
  resetTime = millis() + 300000; // initialize reset time value
  ground = new Ground(grass);
  //offsetX = (int)(width * 0.5);
  offsetX = 0;
  int numOfTrees = (int)random(40, 75), numOfBirds = 70;
  trees = new Tree[numOfTrees];
  birds = new Bird[numOfBirds];
  int max = 4000;
  int treemax = 2500, sphears;
  PImage img1, img2;
  for(int i = 0; i < trees.length; i++) {
    if ((int)random(5) == 0) {
      img1 = burgerImg;
      img2 = candycaneImg;
      sphears = 1;
    } else {
      img1 = bush;
      img2 = bark;
      sphears = 25;
    }
    trees[i] = new Tree(random(-treemax * .6, treemax * .6), 0, random(-treemax * .5, treemax * .8),
                          img1, img2, sphears);
    if ((int)random(20) == 0) { // adding random totoro
      trees[i].addTotoro(totoroImg);
    }
    //if ((int)random(
  }
  for (int i = 0; i < birds.length; i++) {
    birds[i] = new Bird(bat1, bat2);
  }
  cc = new CameraController(this, cw);
  sb = new Skybox(sky);
  //bt = new BigTree(bigbark);
  bt = new BigTree(bark2);
  int numOfBoulders = (int)random(4, 10);
  boulders = new Boulder[numOfBoulders];
  for (int i = 0; i < boulders.length; i++) {
    int base = (int)random(20, 400);
    int bheight = base + (int)random(-10, 10);
    boulders[i] = new Boulder(boulder, (int)random(-treemax * .6, treemax * .6), 0, (int)random(-treemax * .5, treemax * .8), bheight, base, 3 * (int)random(1,4));
  }
  int numOfMountains = (int)random(2, 5);
  mountains = new Boulder[numOfMountains];
  for (int i = 0; i < mountains.length; i++) 
    mountains[i] = new Boulder(boulder, (int)random(-max, max), 0, -3500, (int)random(1000, 2000), (int)random(1000, 2000), 3 * (int)random(1,4));
  int numOfRabbits = (int)random(2, 12);
  rabbits = new Rabbit[numOfRabbits];
  int animalsh = animals.height / 8,
      animalsw = animals.width / 12;
  for (int i = 0; i < rabbits.length; i++)
    rabbits[i] = new Rabbit(animals.get(animalsw * 9, animalsh * 6, animalsw, animalsh),
                            animals.get(animalsw * 10, animalsh * 6, animalsw, animalsh),
                            animals.get(animalsw * 9, animalsh * 4, animalsw, animalsh));
  
  // create ufo dimensions.
  int dimW = 58, dimH = 45, dimY = 0;
  int[] dims = {      0, dimY, dimW, dimH,
                   58, dimY, dimW, dimH,
                   116, dimY, dimW, dimH,
                   174, dimY, dimW, dimH,
                   232, dimY, dimW, dimH,
                   5 * dimW, dimY, dimW, dimH,
                   6 * dimW, dimY, dimW, dimH,
                   7 * dimW, dimY, dimW, dimH,
                   8 * dimW, dimY, dimW, dimH,
                   9 * dimW, dimY, dimW, dimH,
                   10 * dimW, dimY, dimW, dimH,
                   11 * dimW, dimY, dimW, dimH};
  ufo = new UFO(ufoImg, dims, this);
  slenderman = new Slenderman(slendermanImg, cc);
  penisRocket = new PenisRocket(penisImg);
  coin = new Coin(coinImg);
  bb = new BouncingBoob();
}


/**
    Artist Statement:
    Something is back there, behind this obscuring oak tree, and you will never know what it is
    whether it is beautiful or ugly, cute or scary, controversial or boring. Part of it is up to
    your imagination and part of it is the sneak peek offered by such a limiting view but all of it
    will never be revealed.
    
    About the artwork: where did this come from and why am i doing this.
    This artwork comes from a moment that I had in the mountains of blacksburg one fine clear night.
    I was entranced and felt enormous relaxation while absorbing the clear starry sky contrasting with
    the dark forest. I want to capture this moment and feeling in this piece and give it a form
    of stress which is presented as a giant tree that blocks the relaxing view. I am doing this to
    express that our lives will be encountered by obstacles whether our own or something from outside.
    We can only get small peaks of our peaceful moments as long as this obstacle is in our way. Let's take
    winning the lottery for an example, we can only imagine what we will do with the money but never get
    the full moment of it until we can really be lucky enough to win it.
    
    The Process:
    This piece captures the viewer's position using a webcam and virtually projects their position in front
    of the large oak tree obstacle which they can never fully maneuver around. All objects are rendered
    behind the large oak tree obstacle and have some sort of animation or attention grabbing features that
    will cause the viewer to desperately seek an optimal vantage point from behind the oak tree. A dark
    setting and strategically casted lighting effects will continue to obscure the viewer from capturing
    the truth behind the oak tree obstacle.

*/