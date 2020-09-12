class Rabbit {
  PImage move1, move2, wait;
  PShape smove1, smove2, swait;
  PVector pos, vel;
  int actionTimer, framecount, action, xboundary;
  
  public Rabbit(PImage i1, PImage i2, PImage i3) {
    move1 = i1;
    move2 = i2;
    wait = i3;
    //move1.resize(move1.width * 3, 0);
    //move2.resize(move2.width * 3, 0);
    //wait.resize(wait.width * 3, 0);
    
    smove1 = createShape();
    smove1.beginShape();
    smove1.textureMode(NORMAL);
    smove1.texture(i1);
    smove1.vertex(0, 0, 0, 0);
    smove1.vertex(i1.width, 0, 1, 0);
    smove1.vertex(i1.width, i1.height, 1, 1);
    smove1.vertex(0, i1.height, 0, 1);
    smove1.endShape();
    
    smove2 = createShape();
    smove2.beginShape();
    smove2.textureMode(NORMAL);
    smove2.texture(i2);
    smove2.vertex(0, 0, 0, 0);
    smove2.vertex(i2.width, 0, 1, 0);
    smove2.vertex(i2.width, i2.height, 1, 1);
    smove2.vertex(0, i2.height, 0, 1);
    smove2.endShape();
    
    swait = createShape();
    swait.beginShape();
    swait.textureMode(NORMAL);
    swait.texture(i3);
    swait.vertex(0, 0, 0, 0);
    swait.vertex(i3.width, 0, 1, 0);
    swait.vertex(i3.width, i3.height, 1, 1);
    swait.vertex(0, i3.height, 0, 1);
    swait.endShape();
    
    pos = new PVector();
    pos.y = -move1.height;
    pos.z = 0;
    vel = new PVector();
    vel.x = vel.y = vel.z = 1;
    actionTimer = 0;
    framecount = 0;
    action = 0;
    xboundary = 1000;
  }
  
  public void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    if (actionTimer-- < 1) {
      action = (int)random(2);
      actionTimer = (int)random(100, 400);
    }
      
    if (action == 1) { // waiting
      shape(swait);
    }
    else if (action == 0) {
      if (pos.x > xboundary) vel.x = -1;
      else if (pos.x < -xboundary) vel.x = 1;
      if (pos.z > 3500) vel.z = -1;
      else if (pos.z < 0) vel.z = 1;
      pos.x += vel.x;
      pos.z += vel.z;
      if (framecount++ < 25)
        if (vel.x > 0)
          shape(smove1);
        else
          shape(smove1, move1.width, 0, -move1.width, move1.height);
      else
        if (vel.x > 0)
          shape(smove2);
        else
          shape(smove2, move2.width, 0, -move2.width, move2.height);
      if (framecount > 50) {
        framecount = 0;
        vel.x += random(-1, 1);
        vel.z += random(-1, 1);
      }
    }
    popMatrix();
  }
}