class PenisRocket {
  private PVector pos;
  private PShape shape;
  private int startY, counter;
  private float rotation;
  private boolean isActive;
  
  public PenisRocket(PImage img) {
    isActive = false;
    startY = -2000;
    pos = new PVector();
    pos.z = -2500;
    pos.y = startY;
    rotation = radians(90);
    shape = createShape();
    shape.beginShape();
    shape.textureMode(IMAGE);
    shape.texture(img);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(img.width, 0, img.width, 0);
    shape.vertex(img.width, img.height, img.width, img.height);
    shape.vertex(0, img.height, 0, img.height);
    shape.endShape();
    shape.rotateZ(rotation);
    rotation = 0; // reset the rotation.
  }
  
  public void draw() {
    if (isActive) {
      pushMatrix();
      updatePos();
      translate(pos.x, pos.y, pos.z);
      shape.rotateZ(rotation);
      shape(shape);
      //shape.rotateZ(-rotation); // reset rotation.
      popMatrix();
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
    if (pos.x > 4500) { pos.x = -4500; pos.y = startY; }
    pos.x += 25;
    pos.y = startY + ((pow(pos.x / 4500,2) ) * 2000); 
    rotation = (mouseX / (float)width) * .01;
  }
}