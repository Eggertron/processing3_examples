/*  This object will control the breakers that maintains the
    flow control of the power sources.
*/
class ControlBox extends Clickable implements BaseObject {
  Breaker breaker1, breaker2;
  Fault fault1, fault2;
  Node node1, node2;
  boolean breaker1previous, breaker2previous;
  int state;
  final int nothing = 0, substation1 = 1, substation2 = 2, faults = 3;
  int nextFrame, frameSkip;
  
  ControlBox() {
    super();
    breaker1previous = true;
    breaker2previous = true;
    state = 0;
    frameSkip = 60;
    size = 50;
  }
  
  void draw() {
    // draw the purple lines
    strokeWeight(10);
    stroke(255, 0, 255);
    line(breaker1.getX(), breaker1.getY(), pos.x, pos.y);
    line(breaker2.getX(), breaker2.getY(), pos.x, pos.y);
    
    strokeWeight(0);
    fill(255, 0, 255);
    rect(pos.x, pos.y, size, size);
    fill(0);
    text("Control Box", pos.x + 10, pos.y + 10);
  }
  
  void update() {
    switch(state)
    {
      case nothing:
      {
        if (isMainFault() || isNodeFault()) {
          isUpdated = true;
          state = faults;
          nextFrame = frameCount + frameSkip; // two seconds.
        }      
        else if (breaker1.isPowered() != breaker1previous) {
          isUpdated = true;
          state = substation1;
          nextFrame = frameCount + frameSkip;
          breaker1previous = breaker1.isPowered();
        }
        else if (breaker2.isPowered() != breaker2previous) {
          isUpdated = true;
          state = substation2;
          nextFrame = frameCount + frameSkip;
          breaker2previous = breaker2.isPowered();
        }
        else if (breaker1.isPowered() && breaker2.isPowered()) {
          isUpdated = true;
          breaker1previous = breaker1.isPowered = true;
          breaker2previous = breaker2.isPowered = false;
        }
      };
      break;
      case substation1:
      {
        if (frameCount > nextFrame) {
          isUpdated = true;
          state = nothing;
          breaker2previous = breaker2.isPowered = !breaker1.isPowered();
        }
      }
      break;
      case substation2:
      {
        if (frameCount > nextFrame) {
          isUpdated = true;
          state = nothing;
          breaker1previous = breaker1.isPowered = !breaker2.isPowered();
        }
      }
      break;
      case faults:
      {
        if (frameCount > nextFrame) {
          isUpdated = true;
          state = nothing;
          breaker1previous = breaker1.isPowered = breaker2previous = breaker2.isPowered = true;
        }
      }
      break;
      default:
      break;
    }
    
  }
  
  void syncNode1() {
    fault1.isPowered = node1.isPowered;
  }
  
  void syncNode2() {
    fault2.isPowered = node2.isPowered;
  }
  
  void addBreaker(Breaker b) {
    if (breaker1 == null)
      breaker1 = b;
    else
      breaker2 = b;
  }
  
  /*  This function is can only take
      two faults and they must be loaded in
      order or this will not work. The first fault
      will communicate with the first node.
  */
  void addFault(Fault f) {
    if (fault1 == null)
      fault1 = f;
    else
      fault2 = f;
  }
  
  void addNode(Node n) {
    if (node1 == null)
      node1 = n;
    else
      node2 = n;
  }
}