class UFO {
  private int numOfFrames;
  private PShape[] shapes;
  private PShape[] teleport;
  private PShape victim;
  PVector pos;
  private PVector posVictim;
  private int frame;
  private int framerate;
  private int currFrame;
  private int startY;
  private int theta, action, actionTime;
  boolean isLit;
  private int velocity;
  private PApplet parent;
  
  public UFO(PImage im, int[] dimensions, PApplet m) { //<>// //<>//
    parent = m;
    numOfFrames = dimensions.length / 4; //<>// //<>//
    startY = 2000;
    // Set position vectors.
    posVictim = new PVector();
    pos = new PVector();
    pos.x = 4000;
    pos.y = -600;
    pos.z = startY;
    // create frames from image.
    //frames = new PImage[numOfFrames];
    shapes = new PShape[numOfFrames];
    // initialize all frames.
    int index;
    for (int i = 0; i < numOfFrames; i++) {
      index = i * 4;
      PImage frames = im.get(dimensions[index], dimensions[index + 1], dimensions[index + 2], dimensions[index + 3]);
      frames.resize(0, 200);
      shapes[i] = createShape();
      shapes[i].beginShape();
      shapes[i].textureMode(IMAGE);
      shapes[i].texture(frames);
      shapes[i].vertex(0, 0, 0, 0);
      shapes[i].vertex(frames.width, 0, frames.width, 0);
      shapes[i].vertex(frames.width, frames.height, frames.width, frames.height);
      shapes[i].vertex(0, frames.height, 0, frames.height);
      shapes[i].endShape();
    }
    // create teleport animation
    frame = 0;
    teleport = new PShape[16];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int tw = teleportImg.width / 4, th = teleportImg.height / 4;
        PImage tmp = teleportImg.get(j * tw, i * th, tw, th);
        tmp.resize(300,0);
        teleport[frame] = createShape();
        teleport[frame].beginShape();
        teleport[frame].texture(tmp);
        teleport[frame].vertex(0, 0, 0, 0);
        teleport[frame].vertex(tmp.width, 0, tmp.width, 0);
        teleport[frame].vertex(tmp.width, tmp.height, tmp.width, tmp.height);
        teleport[frame].vertex(0, tmp.height, 0, tmp.height);
        teleport[frame++].endShape();
      }
    }
    framerate = 2;
    frame = 0;
    theta = 0;
    action = 0;
    actionTime = 0;
    isLit = true;
    velocity = 30;
  }
  
  public void draw() {
    pushMatrix();
    updatePos();
    translate(pos.x, pos.y, pos.z); //<>// //<>//
    //if(isLit) pointLight(100, 255, 100, pos.x, pos.y, pos.z+10);
    if (currFrame++ > framerate) {
      currFrame = 0;
      frame = (frame + 1) % numOfFrames; //<>// //<>//
    }
    shape(shapes[frame]);
    popMatrix();
  }
  
  private void updatePos() {
    if (pos.x < -4000) {
      pos.x = -4000;
      velocity = (int)random(20, 40);
    }
    if (pos.x > 4000) { 
      pos.x = 4000;
      velocity *= -(int)random(20, 40);
    }
    if (action == 0) { // flying around
      pos.x += velocity;
      pos.z = sin(radians(theta)) * 2000;
      pos.y = -1400 + (pos.z / 2);
      theta = (theta + 1) % 360;
    }
    else if (action == 1) { // abduction animation
      // move into position
      if (pos.x < -500) pos.x += 20;
      if (pos.x > 500) pos.x -= 20;
      if (pos.y < -900) pos.y += 20;
      if (pos.z < 2000) pos.z += 60;
      if (actionTime < 5) {
        // send to tractor beam animation
        actionTime = 500;
        action = -2;
      }
    }
    else if (action == -2) { // the tractor beam animation
      if (victim == null) {
        loadNewVictim();
      }
      pushMatrix();
      translate(posVictim.x, posVictim.y--, posVictim.z);
      //lights();
      pointLight(255, 255, 255, posVictim.x, posVictim.y, posVictim.z + 5);
      noStroke();
      shape(victim);
      popMatrix();
      pushMatrix();
      translate(pos.x, pos.y + 150, pos.z);
      shape(teleport[frameCount % 16]);
      popMatrix();
      if (actionTime == 1) { // reset the victim.
        action = -1;
        victim = null;
      }
    }
    else { // fly away animation
      isLit = true;
      //pos.y += -50; // 
      pos.z += -50;
      if (pos.z < -5000) {
        isLit = false;
        action = -1;
      }
      else pos.x += (-600 - pos.x) / 5;
      //action = 5; // make do nothing
    } // do nothing
    if (actionTime-- == 0) {
      actionTime = 500;
      action = (int)random(20);
      if (action < 2) isLit = true;
      else isLit = false;
    }
  }
  
  /**
    For the tractor beam animation.
  */
  void loadNewVictim() {
    PImage img = null;
    posVictim.x = pos.x + 100;
    posVictim.z = pos.z - 30;
    posVictim.y = pos.y + 600;
    int picked = (int)random(20);
    if (picked == 0) {
      img = totoroImg;
    }
    else if (picked == 1) {
      img = slendermanImg;
    }
    else if (picked == 2) {
      img = burgerImg;
    }
    else if (picked == 3) {
      // get random animals image.
      img = animals.get((int)random(12) * (animals.width / 12), (int)random(8) * (animals.height / 8), animals.width / 12, animals.height / 8);
    }
    else if (picked == 4) {
      img = smokinggirlImg;
    }
    else if (picked == 5) {
      img = barwaitressImg;
    }
    else if (picked == 6) {
      img = pinupgirl01Img;
    }
    else if (picked == 7) {
      img = cheshiresmileImg;
    }
    else if (picked == 8) {
      img = pedobearImg;
    }
    else if (picked == 9) {
      img = nessImg;
    }
    else if (picked == 10) {
      img = boobImg;
    }
    else if (picked == 11) {
      img = fuImg;
    }
    else if (picked == 12) {
      img = sexyesImg;
    }
    else if (picked == 13) {
      img = sexyfairyImg;
    }
    else {
      // get random animals image.
      img = animals.get((int)random(12) * (animals.width / 12), (int)random(8) * (animals.height / 8), animals.width / 12, animals.height / 8);
    }
    //// create the shape.
    img.resize(0, 180); // seems like this is conflicting with transparency.
    victim = createShape();
    victim.beginShape();
    victim.texture(img);
    victim.vertex(0, 0, 0, 0);
    victim.vertex(img.width, 0, img.width, 0);
    victim.vertex(img.width, img.height, img.width, img.height);
    victim.vertex(0, img.height, 0, img.height);
    victim.endShape();
  }
}