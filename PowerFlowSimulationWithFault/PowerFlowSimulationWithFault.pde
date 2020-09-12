/*  Author: Edgar Han
    Date: Feb 1, 2018
*/
   
final float VERSION = 0.5;

// GLOBAL VARIABLES
final String filename = "savedata";
final int MAXSIZE = 100;
final color RED    = color(255, 0, 0),
            GREEN  = color(0, 255, 0),
            BLUE   = color(0, 0, 255),
            YELLOW = color(255, 255, 0),
            PURPLE = color(255, 0, 255);
boolean isObjectPressed;
boolean isUpdated;
boolean elementsGraph[][];
boolean elementsGraphVisited[][];
int backgroundColor;
int numberOfElements;
ArrayList<Integer> powerSources;
ArrayList<Integer> meters;
ArrayList<Integer> nodes;
ArrayList<Integer> generators;
ArrayList<Integer> faults;
ArrayList<Integer> mainFaults;
ArrayList<Integer> secondaryFaults;
ArrayList<Integer> secondaryBreakers;
PImage _img_generator, _img_load, _img_powerstation, _img_transformer;
BaseObject elements[];
ControlBox controlBox;

void setup() {
  fullScreen();
  init();
}

void draw() {
  controlBox.update();
  if(isUpdated) {
    isUpdated = false;
    //controlBox.update();
    background(backgroundColor);
    
    // Draw Colored Edges
    drawEdges();
    
    // Update Meters
    //for ( int x : meters ) {
    //  ((Meter)elements[x]).update(x);
    //}
    
    // Draw each elements
    strokeWeight(0);
    for (int i = 0; i < elements.length; i++) {
      elements[i].draw();
    }
    
    // auto save
    saveFile();
  }
  
  // check for mouse over Meter
  for (int i : meters)
    ((Meter)elements[i]).onMouseOver();
}

void mouseClicked() {
  for (int i = 0; i < elements.length; i++)
    elements[i].onClick();
}

void mouseDragged() {
  for (int i = 0; i < elements.length; i++)
    elements[i].onDrag();
}

void mouseReleased() {
  for (int i = 0; i < elements.length; i++)
    elements[i].onReleased();
}

void mousePressed() {
  for (int i = 0; i < elements.length; i++)
    elements[i].onPressed();
}

void saveFile() {
  JSONObject json, item;
  String id;
  json = new JSONObject();
  json.setFloat("VERSION", VERSION);
  for (int i = 0; i < numberOfElements; i++) {
    item = new JSONObject();
    item.setInt("x", (int)elements[i].getX());
    item.setInt("y", (int)elements[i].getY());
    //item.setBoolean("isPowered", elements[i].isPowered());
    item.setInt("halfsize", elements[i].getHalfSize());
    id = "element"+i;
    json.setJSONObject(id, item);
  }
  saveJSONObject(json, filename);
}

void loadFile() {
  // Loading will not matter since all elements will always
  // be in the same array and order.
  JSONObject json, tmp;
  String id;
  int halfsize;
  try {
    json = loadJSONObject(filename);
    // check version
    float fileversion = json.getFloat("VERSION");
    if (fileversion != VERSION)
      throw new Exception("Version does not match.");
    for (int i = 0; i < numberOfElements; i++) {
      id = "element"+i;
      tmp = json.getJSONObject(id);
      halfsize = tmp.getInt("halfsize");
      //elements[i].setIsPowered(tmp.getBoolean("isPowered"));
      elements[i].setX((float)tmp.getInt("x")-halfsize);
      if (elements[i].getX() > width)
        elements[i].setX(width - halfsize);
      elements[i].setY((float)tmp.getInt("y")-halfsize);
      if (elements[i].getY() > height)
        elements[i].setY(height - halfsize);
    }
  }
  catch (Exception e) {
    println(e);
    background(255,0,0);
  }
}

void drawEdges() {
  drawEdgesGreen();      // all connected
  drawEdgesRed();        // only powered
  drawEdgesYellow();     // only deactivated nodes
  drawEdgesBlue();       // only for generators
}

/*  Draws red for HOT lines
    This means that power is flowing and
    the line is LIVE.
*/
void drawEdgesRed() {
  strokeWeight(10);
  stroke(RED);
  resetVisitedGraph();
  
  // reset all meters first
  for (int x : meters)
    ((Meter)elements[x]).update();
    
  for (int x : powerSources) {
    drawEdgesRedRecursive(x); // it's all connected anyways
  }
}

void drawEdgesRedRecursive(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (a == i) continue;
    else if (elementsGraph[a][i] && elements[a].isPowered() && elements[i].isPowered() && !elementsGraphVisited[a][i]) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      if (elements[i].getClass() != Generator.class && elements[a].getClass() != Generator.class)
        line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      if (elements[a].isPowered()) {
        elements[a].setColor(RED);
      }
      else if (elements[i].isPowered()) {
        elements[i].setColor(RED);
      }
      drawEdgesRedRecursive(i);
      if (elements[i].getClass() == Generator.class)
        elements[i].setIsPowered(false);
      if (elements[i].getClass() == Meter.class)
        ((Meter)elements[i]).update(i);
    }
    else if (elementsGraph[a][i] && (elements[a].isPowered() || elements[i].isPowered()) && !elementsGraphVisited[a][i] ) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      if (elements[i].getClass() != Generator.class && elements[a].getClass() != Generator.class)
        line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      if (elements[a].isPowered()) {
        elements[a].setColor(RED);
      }
      if (elements[i].isPowered()) {
        elements[i].setColor(RED);
      }
    }
  }
}

void drawEdgesGreen() {
  strokeWeight(10);
  stroke(GREEN);
  resetVisitedGraph();
  drawEdgesGreenRecurisve(1);
}

void drawEdgesGreenRecurisve(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (a == i)
      continue;
    else if (elementsGraph[a][i] && !elementsGraphVisited[a][i]) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      elements[a].setColor(GREEN);
      elements[i].setColor(GREEN);
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      drawEdgesGreenRecurisve(i);
    }
  }
}

void drawEdgesYellow() {
  strokeWeight(10);
  stroke(YELLOW);
  resetVisitedGraph();
  for (int i : nodes)
    drawEdgesYellowHelper(i);
  for (int i : faults)
    drawEdgesYellowHelper(i);
}

void drawEdgesYellowHelper(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (elementsGraph[a][i] && !elements[a].isPowered()) {
      elements[a].setColor(YELLOW);
      elements[i].setColor(YELLOW);
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
    }
  }
}

void drawEdgesBlue() {
  strokeWeight(10);
  stroke(BLUE);
  resetVisitedGraph();
  for (int i : generators)
    drawEdgesBlueRecursive(i); // just reuse this code
}

void drawEdgesBlueRecursive(int a) {
  for (int i = 0; i < numberOfElements; i++) {
    if (a == i) continue;
    else if (elementsGraph[a][i] && elements[a].isPowered() && elements[i].isPowered() && !elementsGraphVisited[a][i] && (elements[i].getClass() != Fault.class) && (elements[i].getClass() != Meter.class)) {
      elementsGraphVisited[a][i] = elementsGraphVisited[i][a] = true;
      line(elements[a].getX(), elements[a].getY(), elements[i].getX(), elements[i].getY());
      drawEdgesBlueRecursive(i);
    }
  }
}

void resetVisitedGraph() {
  for (int i = 0; i < numberOfElements; i++)
    for (int j = 0; j < numberOfElements; j++)
      elementsGraphVisited[i][j] = false;
}

boolean isMainFault() {
  return isFault(mainFaults);
}

boolean isNodeFault() {
  return isFault(nodes);
}

boolean isSecondaryFault() {
  return isFault(secondaryFaults);
}

boolean isSecondaryBreaker() {
  return isFault(secondaryBreakers);
}
  
boolean isFault(ArrayList<Integer> list) {
  for (int i : list)
    if (!elements[i].isPowered())
      return true;
  return false;
}

void loadGroups() {
  int index = 1, tmp;
  // first add the control box so that the purple lines are behind.
  elements[0] = controlBox;
  tmp = index = loadGroupB(index, "Sub1");
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 300);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  controlBox.addNode((Node)elements[tmp]);  // add to control box sync
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 1500);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 1500);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 1000);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 1500);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 3000);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 3000);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 750);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 1000);
  elementsGraph[index][tmp] = elementsGraph[tmp][index] = true;
  tmp = index = loadGroupC(index);
  elementsGraph[index][index-1] = elementsGraph[index-1][index] = true;
  index = loadGroupA(index, 500);
  controlBox.addNode((Node)elements[tmp]);  // add to control box sync
  int index2 = tmp;
  int index3 = loadGroupB(index, "Sub2") - 1;
  elementsGraph[index2][index3] = elementsGraph[index3][index2] = true;
}

/*  Loading group A consists of:
    Node-Breaker-Fault-Meter-Transformer-Load-TrasferSwitch-Generator
    Total of 8 objects.
*/
int loadGroupA(int i, int loadSize) {
  nodes.add(i);
  elements[i++] = new Node();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  secondaryBreakers.add(i);
  elements[i++] = new Breaker();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  faults.add(i);
  secondaryFaults.add(i);
  elements[i++] = new Fault();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  meters.add(i);
  elements[i++] = new Meter();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  int transformer_i = i;
  elements[i++] = new Transformer();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  elements[i++] = new Load(loadSize);
  elementsGraph[i][transformer_i] = elementsGraph[transformer_i][i] = true; // connect it back to the transformer
  elements[i++] = new TransferSwitch();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  generators.add(i);
  elements[i++] = new Generator();
  return i;
}

/*  Loading group B consists of:
    PowerSource-Meter-Breaker-Fault-Sectionalizer
    Total of 5 objects.
*/
int loadGroupB(int i, String subName) {
  powerSources.add(i);
  elements[i++] = new PowerSource(subName);
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  meters.add(i);
  elements[i++] = new Meter();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  elements[i++] = new Breaker();
  controlBox.addBreaker((Breaker)elements[i - 1]);
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  faults.add(i);
  mainFaults.add(i);
  elements[i++] = new Fault();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  controlBox.addFault((Fault)elements[i - 1]);
  elements[i++] = new Sectionalizer();
  return i;
}

/*  Loading group C consits of:
    Sectionalizer-Fault-Sectionalizer
    Total of 3 objects
*/
int loadGroupC(int i) {
  elements[i++] = new Sectionalizer();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  faults.add(i);
  mainFaults.add(i);
  elements[i++] = new Fault();
  elementsGraph[i][i-1] = elementsGraph[i-1][i] = true;
  elements[i++] = new Sectionalizer();
  return i;
}

void init() {
  isUpdated               = true;
  isObjectPressed         = false;
  backgroundColor         = 0;
  
  // Load Images
  _img_load               = loadImage("load.png");
  _img_generator          = loadImage("backupgenerator.png");
  _img_powerstation       = loadImage("powerstation.png");
  _img_transformer        = loadImage("transformer.png");
  
  // Load elements
  numberOfElements        = 118; // TODO: fix this
  elements                = new BaseObject[numberOfElements];
  elementsGraph           = new boolean[numberOfElements][numberOfElements];
  elementsGraphVisited    = new boolean[numberOfElements][numberOfElements];
  controlBox              = new ControlBox();
  
  // init element group lists
  powerSources            = new ArrayList<Integer>();
  meters                  = new ArrayList<Integer>();
  nodes                   = new ArrayList<Integer>();
  generators              = new ArrayList<Integer>();
  faults                  = new ArrayList<Integer>();
  mainFaults              = new ArrayList<Integer>();
  secondaryFaults         = new ArrayList<Integer>();
  secondaryBreakers       = new ArrayList<Integer>();
    
  loadGroups();
  
  // attempt to load file
  loadFile();
}