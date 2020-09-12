class HUDObj {
  private int numOfBoxes;
  private int mouseZ;
  
  void updateMouseZ(int x) {
    mouseZ = x;
  }
  
  void updateNumOfBoxes(int x) {
    numOfBoxes = x;
  }
  
  void drawHUD() {
    int varTextSize = 24;
    int locTextY = 60;
    camera();    // reset the camera view
    noLights();
    textSize(varTextSize);
    fill(0);
    stroke(0);
    text("mouseX: " + mouseX, 0, locTextY);
    locTextY += varTextSize;
    text("mouseY: " + mouseY, 0, locTextY);
    locTextY += varTextSize;
    text("number of boxes: " + numOfBoxes, 0, locTextY);
    locTextY += varTextSize;
    text("mouse scroll offset: " + mouseZ, 0, locTextY);
  }
}