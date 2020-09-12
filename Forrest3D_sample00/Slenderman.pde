class Slenderman {
  private PShape shape;
  private PVector pos;
  private boolean isNoticed;
  private CameraController cam;
  private float xCenter, radius;
  private int xOffset;
  
  public Slenderman(PImage img, CameraController c) {
    cam = c;
    isNoticed = false;
    pos = new PVector();
    img.resize(0, 700);
    shape = createShape();
    shape.beginShape();
    shape.textureMode(IMAGE);
    shape.texture(img);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(img.width, 0, img.width, 0);
    shape.vertex(img.width, img.height, img.width, img.height);
    shape.vertex(0, img.height, 0, img.height);
    shape.endShape();
    shape.translate(-(img.width/2), -img.height, 0);
    radius = img.width / 2;
    xOffset = 4;
  }
  
  public void draw() {
    pushMatrix();
    updatePos();
    translate(pos.x * xOffset, pos.y, pos.z);
    shape(shape);
    popMatrix();
  }
  
  private void updatePos() {
    if (isNoticed) {
      isNoticed = false;
      pos.z += 500;
      pos.x = random(-cam.xMax, cam.xMax);
      println(pos.x);
    } else {
      if (pow(pos.x - cam.xPos, 2) < radius) isNoticed = true;
    }
    if (pos.z > 3000) pos.z = 0;
  }
}