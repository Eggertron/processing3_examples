/*
  author: Edgar H. Han
  version: 20161103
  
  Simple camera setup class to prepare it in an object.
*/
class CameraController {
  // constant variables
  private float eyeCenterX, eyeCenterY, eyeCenterZ;
  private float sceneCenterX, sceneCenterY, sceneCenterZ;
  private float upCenterX, upCenterY, upCenterZ;
  
  private float eyeX, eyeY, eyeZ;
  private float camX, camY, camZ;
  private float upX, upY, upZ;
  
  private int _mouseZ;
  int xMax, xMax2, xVel;
  private int rot;
  private PApplet parent;
  private CaptureWebcam cw;
  private PVector pos, aim;
  
  float xPos;
  
  public CameraController(PApplet main, CaptureWebcam c) {
    parent = main;
    cw = c;
    eyeCenterX = 4000;
    //eyeCenterY = parent.height/10;
    eyeCenterY = 580;
    //eyeCenterZ = (parent.height/2) / tan(PI/6);
    eyeCenterZ = 3000;
    sceneCenterX = 0;
    sceneCenterY = 0;
    sceneCenterZ = -3000;
    upCenterX = 0;
    upCenterY = 1;
    upCenterZ = 0;
  
    eyeX = eyeCenterX;
    eyeY = eyeCenterY;
    eyeZ = eyeCenterZ;
    camX = sceneCenterX;
    camY = sceneCenterY;
    camZ = sceneCenterZ;
    upX = upCenterX;
    upY = upCenterY;
    upZ = upCenterZ;
    
    rot = 0;
    xMax = (int)(width * .1);
    xMax2 = xMax * 2;
    xPos = 0;
    parent.mouseX = xMax;
    xVel = 1;
    
    pos = new PVector();
    pos.x = eyeCenterX;
    pos.y = -eyeCenterY;
    pos.z = eyeCenterZ;
    
    aim = new PVector();
    aim.x = 0;
    aim.y = 0;
    aim.z = 0;
  }
  
  void updateXPos() {
    // use mouseX
    if (cw == null) {
      xPos = ((mouseX / (float)parent.width) * xMax2) - xMax;
    }
    else {
      float tmp = cw.getLocation();
      //if (tmp != -1) xPos = (tmp * xMax2) - xMax; // get the camera data.
      if (tmp != -1) xPos = xMax - (tmp * xMax2); // If camera data is reversed.
      //println(tmp);
    }
    //println(xPos);
    if (xPos > xMax) xPos = xMax;
    if (xPos < -xMax) xPos = -xMax;
  }
  
  void updateCamera() {
    int mode = 5;
    int scale = 1;
    updateXPos();
    if (mode == 0)
      parent.camera(xPos, eyeCenterY + _mouseZ, (eyeCenterZ + (parent.mouseY - (parent.height * 0.5))) * 2 * scale,
                    sceneCenterX, camY, camZ, 
                    upX, upY, upZ);
    else if (mode == 1) {
      parent.camera(rot++, eyeY + _mouseZ, eyeCenterZ ,
                    sceneCenterX, camY, camZ, 
                    upX, upY, upZ);
    }
    else if (mode == 2)
      parent.camera(xPos, -eyeY, eyeZ,
                    0, 0, 0, 
                    upX, upY, upZ);
    else if (mode == 3) {
      //xPos += xVel;
      parent.mouseX += xVel;
      if (parent.mouseX > xMax) xVel = -1;
      if (parent.mouseX < -xMax) xVel = 1;
      parent.camera((parent.mouseX - (parent.width * 0.5)) * scale, eyeCenterY + _mouseZ, (eyeCenterZ + parent.height * 0.75) * 2,
                    sceneCenterX, camY, camZ, 
                    upX, upY, upZ);
    }
    else if (mode == 4)
      parent.camera(xPos, -mouseY, eyeZ,
                    0, 0, 0, 
                    upX, upY, upZ);
    else if (mode == 5) {
      if (keyPressed) {
        if (keyCode == UP) {
          pos.z -= 10;
        }
        if (keyCode == DOWN) {
          pos.z += 10;
        }
        if (keyCode == LEFT) {
          pos.x -= 10;
        }
        if (keyCode == RIGHT) {
          pos.x += 10;
        }
      }
      parent.camera(pos.x, pos.y, pos.z,
                    0, 0, 0, 
                    upX, upY, upZ);
    }
  }
}