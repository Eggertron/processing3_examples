/**  A bouncing boob snake class
*/
class BouncingBoob {
  private boolean isActive;
  private PShape[] shape;
  private PVector[] pos, velocity;
  private int size, counter, drag;
  
  public BouncingBoob() {
    size = 10;
    drag = 5;
    isActive = false;
    pos = new PVector[size];
    velocity = new PVector[size];
    shape = new PShape[size];
    for (int i = 0; i < size; i++) {
      pos[i] = new PVector();
      pos[i].x = i * 5;
      pos[i].y = -300;
      pos[i].z = 1000;
      velocity[i] = new PVector();
      velocity[i].x = 35;
      velocity[i].y = -10;
      velocity[i].z = 35;
      PImage tmp = boobImg.get();
      tmp.resize(boobImg.width - (i * 15), 0);
      shape[i] = createShape();
      shape[i].beginShape();
      shape[i].texture(tmp);
      shape[i].vertex(0, 0, 0, 0);
      shape[i].vertex(tmp.width, 0, tmp.width, 0);
      shape[i].vertex(tmp.width, tmp.height, tmp.width, tmp.height);
      shape[i].vertex(0, tmp.height, 0, tmp.height);
      shape[i].endShape();
    }
  }
  
  public void draw() {
    if (isActive) {
      updatePos();
      for (int i = size - 1; i >= 0; i--) {
        pushMatrix();
        translate(pos[i].x, pos[i].y, pos[i].z);
        shapeMode(CENTER);
        shape(shape[i]);
        shapeMode(CORNER);
        popMatrix();
      }
    }
    else {
    }
    if (counter < frameCount) {
      isActive = false;
      counter = frameCount + 500;
      if ((int)random(20) == 0) isActive = true;
    }
  }
  
  private void updatePos() {
    /// shift positions down
    for (int i = size - 1; i > 0; i--) {
      pos[i].x += (pos[i - 1].x - pos[i].x) / drag;
      pos[i].y += (pos[i - 1].y - pos[i].y) / drag;
      pos[i].z += (pos[i - 1].z - pos[i].z) / drag;
      //velocity[i].y = velocity[i - 1].y;
    }
    ///// calculate the first.
    if (pos[0].y < -1500) velocity[0].y = (int)random(20, 40);
    if (pos[0].y > 0) velocity[0].y = -(int)random(20, 40);
    if (pos[0].x < -3000) velocity[0].x = (int)random(25, 45);
    if (pos[0].x > 3000) velocity[0].x = -(int)random(25, 45);
    if (pos[0].z < -3000) velocity[0].z = (int)random(25, 45);
    if (pos[0].z > 2500) velocity[0].z = -(int)random(25, 45);
    ////////
    pos[0].y += velocity[0].y;
    pos[0].x += velocity[0].x;
    pos[0].z += velocity[0].z;
  }
}