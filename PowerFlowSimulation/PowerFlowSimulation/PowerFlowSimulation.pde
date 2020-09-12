// put global variables
/*
  10 buildings
  3 power sources
  9 transmission line segments
  10 transformers
  10 fuses / switches
*/
int numberOfElements, numberOfSources, numberOfRelays, numberOfSEL, numberOfLoads, numberOfFuses,
    numberOfTXF, numberOfTS, numberOfGenerators, numberOfArrows;
BaseObject elements[];
boolean elementsGraph[][]; // The connections between elements
int powerSources[]; // roots for graph
int powerGenerators[];
boolean elementsGraphVisited[][];
int backgroundColor = 0;
boolean isUpdated;
boolean isObjectPressed;
boolean debug = true;
PApplet main = this;
// Images
PImage load_img, transformer_img, powerstation_img, sel_img, backupgen_img, fuse_img;
String filename = "saved.json";
SaveButton saveButton;
LoadButton loadButton;

void setup() {
  //size(900,500);
  fullScreen();
  init();
  saveButton = new SaveButton(0, 300);
  loadButton = new LoadButton(0, 400);
}

void draw() {
  if (isUpdated) {
    isUpdated = false;
    background(backgroundColor);
    // update and draw all elements
    drawEdges();
    for (int i = 0; i < numberOfElements; i++) {
      elements[i].update();
      elements[i].draw();
    }
  }
  saveButton.draw();
  loadButton.draw();
  // Debugging
  if (debug)
    debug();
}

void mouseClicked() {
  for (int i = 0; i < numberOfElements; i++)
    elements[i].onClick();
  saveButton.onClick();
  loadButton.onClick();
}

void mouseDragged() {
  for (int i = 0; i < numberOfElements; i++)
    elements[i].onDrag();
}

void mouseReleased() {
  for (int i = 0; i < numberOfElements; i++)
    elements[i].onReleased();
}

void mousePressed() {
  for (int i = 0; i < numberOfElements; i++)
    elements[i].onPressed();
}

void drawEdges() {
  strokeWeight(10);
  stroke(255, 0, 0);
  drawEdgesRed(0);
  stroke(0, 255, 0);
  resetVisitedGraph();
  for (int i = 0; i < numberOfSources; i++)
    drawEdgesGreen(powerSources[i]);
  stroke(0, 0, 255);
  resetVisitedGraph();
  for (int i = 0; i < numberOfGenerators; i++)
    drawEdgesBlue(powerGenerators[i]);
  strokeWeight(1);
}

void drawEdgesRed(int a) {
  for (int i = a + 1; i < numberOfElements; i++) {
    if (elementsGraph[a][i]) {
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      drawEdgesRed(i);
    }
  }
}

void drawEdgesGreen(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (a == i) continue;
    else if (elementsGraph[a][i] && elements[a].isPowered() && elements[i].isPowered() && !elementsGraphVisited[a][i]) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      drawEdgesGreen(i);
    }
  }
}

void drawEdgesBlue(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (a == i) continue;
    else if (elementsGraph[a][i] && elements[a].isPowered() && elements[i].isPowered() && !elementsGraphVisited[a][i]
              && elements[i].getClass() != elements[numberOfRelays+numberOfSEL+numberOfSources].getClass() ) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      drawEdgesBlue(i);
    }
  }
}
void resetVisitedGraph() {
  for (int i = 0; i < numberOfElements; i++)
    for (int j = 0; j < numberOfElements; j++)
      elementsGraphVisited[i][j] = false;
}

void saveFile() {
  JSONObject json, item;
  String id;
  json = new JSONObject();
  for (int i = 0; i < numberOfElements; i++) {
    item = new JSONObject();
    item.setInt("x", (int)elements[i].getX());
    item.setInt("y", (int)elements[i].getY());
    item.setBoolean("isPowered", elements[i].isPowered());
    item.setInt("halfsize", elements[i].getHalfSize());
    id = "element"+i;
    json.setJSONObject(id, item);
  }
  saveJSONObject(json, filename);
}

void loadFile() {
  JSONObject json, tmp;
  String id;
  int halfsize;
  try {
    json = loadJSONObject(filename);
    for (int i = 0; i < numberOfElements; i++) {
      id = "element"+i;
      tmp = json.getJSONObject(id);
      halfsize = tmp.getInt("halfsize");
      elements[i].setIsPowered(tmp.getBoolean("isPowered"));
      elements[i].setX((float)tmp.getInt("x")-halfsize);
      elements[i].setY((float)tmp.getInt("y")-halfsize);
    }
  }
  catch (Exception e) {
    println(e);
    background(255,0,0);
  }
}
void debug() {
  fill(0);
  rect(0, 0, 200, 100);
  fill(255);
  text("mouse x: ", 5, 20);
  text("mouse y: ", 5, 40);
  text(mouseX, 55, 20);
  text(mouseY, 55, 40);
  text("isObjectPressed: ", 5, 60);
  text(isObjectPressed ? "true" : "false", 100, 60);
}

void init() {
  load_img = loadImage("load.png");
  transformer_img = loadImage("transformer.png");
  powerstation_img = loadImage("powerstation.png");
  sel_img = loadImage("sel.png");
  backupgen_img = loadImage("backupgenerator.png");
  fuse_img = loadImage("fuse.png");
  isUpdated = true;
  isObjectPressed = false;
  numberOfSources = 2;
  numberOfSEL = 2;
  numberOfRelays = 10;
  numberOfGenerators = numberOfTS = numberOfTXF = numberOfFuses = numberOfLoads = 10;
  numberOfArrows = 1;
  numberOfElements = numberOfSources + numberOfSEL + numberOfRelays + numberOfFuses + numberOfTXF + numberOfLoads + numberOfTS + numberOfGenerators + numberOfArrows; // TODO: remove this when testing is done.
  elements = new BaseObject[numberOfElements];
  elementsGraph = new boolean[numberOfElements][numberOfElements];
  elementsGraphVisited = new boolean[numberOfElements][numberOfElements];
  powerSources = new int[numberOfSources];
  powerGenerators = new int[numberOfGenerators];
  // Load Relay objects in a circle
  float circle = 2 * PI;
  int halfwidth = width / 2;
  int halfheight = height / 2;
  int i;
  for (i = 0; i < numberOfRelays; i++) {
    elements[i] = new Relay(halfwidth+(cos(circle*i/numberOfRelays)*300), halfheight+(sin(circle*i/numberOfRelays)*300));
    if (i != 0) {
      elementsGraph[i][i-1] = true; // create the adjacency matrix.
      elementsGraph[i-1][i] = true;
    }
  }
  // Power Sources
  i--; // go back one index.
  
  // additional elements
  elements[++i] = new SEL451(300, 700, sel_img);
  elementsGraph[5][i] = elementsGraph[i][5] = true;
  elements[++i] = new SEL451(700, 200, sel_img);
  elementsGraph[numberOfRelays-1][i] = elementsGraph[i][numberOfRelays-1] = true;
  ((SEL451)elements[i]).setRemoteSEL((SEL451)elements[i-1]);
  ((SEL451)elements[i-1]).setRemoteSEL((SEL451)elements[i]);
  powerSources[0] = ++i;
  elements[powerSources[0]] = new PowerSource(800, 20, powerstation_img);
  elementsGraph[powerSources[0]][i-numberOfSources] = elementsGraph[i-numberOfSources][powerSources[0]] = true;
  powerSources[1] = ++i;
  elements[powerSources[1]] = new PowerSource(90, 700, powerstation_img);
  elementsGraph[powerSources[1]][i-numberOfSources] = elementsGraph[i-numberOfSources][powerSources[1]] = true;
  // connected each fuse to a relay, we will start j=0 because first 10 elements are relays.
  int xdist=15, ydist=15;
  for (int j = 0; j < numberOfFuses; j++) {
    elements[++i] = new FuseSwitch(elements[j].getX()+xdist, elements[j].getY()+ydist, fuse_img);
    elementsGraph[i][j] = elementsGraph[j][i] = true;
  }
  // connect each TXF to a fuse
  int tmp;
  for (int j = 0; j < numberOfTXF; j++) {
    tmp = ++i - numberOfFuses;
    elements[i] = new TXF(elements[tmp].getX() + xdist, elements[tmp].getY() + ydist, transformer_img);
    elementsGraph[tmp][i] = elementsGraph[i][tmp] = true;
  }
  // connect each Load to a TXF
  String loadName[] = {"load1", "load2", "load3", "load4", "load5", "load6", "load7", "load8", "load9", "load10"};
  for (int j = 0; j < numberOfLoads; j++) {
    tmp = ++i - numberOfTXF;
    elements[i] = new Load(elements[tmp].getX() + xdist, elements[tmp].getY() + ydist, load_img);
    ((Load)elements[i]).setName(loadName[j]);
    elementsGraph[tmp][i] = elementsGraph[i][tmp] = true;
  }
  // connect each TS to a TXF
  for (int j = 0; j < numberOfTS; j++) {
    tmp = ++i - numberOfLoads - numberOfTXF;
    elements[i] = new TS(elements[tmp].getX() - xdist, elements[tmp].getY() + ydist);
    elementsGraph[tmp][i] = elementsGraph[i][tmp] = true;
  }
  // connect each Backup Generator to a TS
  for (int j = 0; j < numberOfGenerators; j++) {
    tmp = ++i - numberOfTS;
    elements[i] = new Generator(elements[tmp].getX() - xdist, elements[tmp].getY(), backupgen_img);
    elementsGraph[tmp][i] = elementsGraph[i][tmp] = true;
    powerGenerators[j] = i;
  }
  // Add the arrow
  elements[++i] = new Arrow(600, 600);
  elementsGraph[i][0] = elementsGraph[0][i] = true;
  
  // Try to load previous work
  loadFile();
}