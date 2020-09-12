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
  private PApplet parent;
  
  public CameraController(PApplet main) {
    parent = main;

    eyeCenterX = parent.width/2;
    eyeCenterY = parent.height/2;
    eyeCenterZ = (parent.height/2) / tan(PI/6);
    sceneCenterX = parent.width/2;
    sceneCenterY = parent.height/2;
    sceneCenterZ = 0;
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
  }
  
  void updateCamera() {
    int scale = 1;
    parent.camera((mouseX -(parent.width * 0.5)) * scale, eyeCenterY + _mouseZ, (eyeCenterZ + (mouseY - (parent.height * 0.5))) * 2 * scale,
                  sceneCenterX, camY, camZ, 
                  upX, upY, upZ);
  }
}