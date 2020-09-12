// Edgar Han
private LinkedList _ll;

void setup() {
  size(800, 800);
  _ll = new LinkedList();
}

void draw() {
  background(0);
  _ll.update();
}

void mouseClicked() {
}

void mousePressed() {}

void mouseDragged() {
  _ll.add();
}

class Ripple {
  private int _x, _y, _diameter, _counter, _velocity;
  private float _strokeWeight, _alpha;
  boolean isAlive;
  
  Ripple() {
    isAlive = true;
    _x = mouseX;
    _y = mouseY;
    _diameter = 1;
    _strokeWeight = 1;
    _alpha = 100;
    _counter = 0;
    _velocity = (int)((mouseX - pmouseX) * 0.5);
  }
  
  void update() {
    if (_diameter++ > 255)
      isAlive = false;
    noFill();
    strokeWeight(_strokeWeight += 0.1);
    stroke(255, 255, 255, _alpha -= 0.5);
    ellipse(_x += _velocity, _y -= 3, _diameter, _diameter);
  }
}

class LinkedList {
  private Node _head;
  
  LinkedList() {
    _head = null;
  }
  
  void add() {
    Node node = new Node();
    node.next = _head;
    _head = node;
  }
  
  void remove(Node n) {
    n.next = n.next.next;
    
  }
  
  void update() {
    Node trav = _head;
    
    while(trav != null) {
      if (trav.ripple.isAlive) {
        trav.ripple.update();
      }
      if (trav.next != null && !trav.next.ripple.isAlive) {
        remove(trav);
      }
      trav = trav.next;
    }
  }
  
  /////////////////////////////
  class Node {
    Ripple ripple;
    Node next;
    
    Node() {
      ripple = new Ripple();
    }
    
  }
}