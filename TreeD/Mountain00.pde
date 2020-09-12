class Mountain00 {
  PImage img;
  PShape shape;
  PVector pos;
  int offsetX, offsetY, imgW, imgH;
  float speed;
  
  public Mountain00(PImage img) {
    this.img = img;
    pos = new PVector();
    shape = createShape();
    shape.beginShape();
    shape.noStroke();
    shape.textureMode(NORMAL);
    shape.texture(img);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(img.width, 0, 1, 0);
    shape.vertex(img.width, img.height, 1, 1);
    shape.vertex(0, img.height, 0, 1);
    shape.endShape();
    speed = 0.05;
    offsetX = (int)(width * speed);
    offsetY = (int)(height - (img.height * 0.8));
  }
  
  public void draw() {
    pushMatrix();
    translate(mouseX * speed, 0, 0);
    noStroke();
    shape(shape, -offsetX, offsetY);
    popMatrix();
  }
}