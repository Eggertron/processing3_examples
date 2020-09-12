import java.util.Queue;
import java.util.LinkedList;

class Meter extends Clickable implements BaseObject {
  color textColor = color(0, 0, 0);
  int loadSum;
  
  Meter() {
    super();
    size = 40;
    halfSize = size / 2;
    isPowered = true;
    loadSum = 0;
    myColor = GREEN;
  }
  
  void update(int a) {
    int current;
    // reset the loadSum
    loadSum = 0;
    // Breadth First Search
    Queue<Integer> foundConnections = new LinkedList<Integer>();
    boolean[][] visitedConnections = new boolean[numberOfElements][numberOfElements];
    foundConnections.add(a);
    while (!foundConnections.isEmpty()) {
      current = foundConnections.remove();
      for (int i = 0; i < numberOfElements; i++) {
        if (current == i)
          continue;
        else if (elementsGraph[current][i] && elements[current].isPowered() && elements[i].isPowered() && !visitedConnections[current][i]) {
          visitedConnections[current][i] = visitedConnections[i][current] = true;
          if (elements[i].getClass() == Load.class) {
            loadSum = ((Load)elements[i]).load;
            return;
          }
          else if (elements[i].getClass() == Meter.class) {
            loadSum += ((Meter)elements[i]).loadSum;
          }
          else if (elements[i].getClass() == Fault.class && !elements[i].isPowered()) {
            foundConnections = new LinkedList<Integer>();
            return;
          }
          else {
            foundConnections.add(i);
          }
        }
      }
    }
  }
  
  void onMouseOver() {
    if (isMouseOver()) {
      isUpdated = true;
      fill(255);
      textSize(50);
      text(loadSum + " KVA", mouseX + 20, mouseY + 10);
      textSize(12);
    }
  }
  
  void update() {
    loadSum = 0;
  }
  
  void draw() {
    stroke(0);
    fill(myColor);
    rect(pos.x, pos.y, size, size);
    fill(textColor);
    text("M", pos.x + halfSize, pos.y + halfSize);
    text(loadSum, pos.x + halfSize, pos.y + halfSize + 9);
  }
  void onClick() {}
  
}