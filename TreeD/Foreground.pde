class Foreground {
  PImage img;
  PShape shape;
  PVector pos;
  int offsetX, offsetY, shapeW, shapeH, imgW, imgH;
  float speed;
  
  public Foreground(PImage img) {
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
    speed = 0.15;
    offsetX = (int)(width * speed);
    offsetY = (int)(height - (img.height * 1));
    //int ratio = (int)(img.width / (width * 1.5));
    //shapeW = img.width * ratio;
    //shapeH = img.height * ratio;
    
    float ratio = img.width / width;
    if (ratio < 1)
      ratio = width / img.width;
    imgW = (int)(img.width * ratio * 2);
    imgH = (int)(img.height * ratio * 2);
  }
  
  // need to draw foreground from the bottom 
  public void draw() {
    pushMatrix();
    translate(mouseX * speed, 0, 0);
    noStroke();
    //shape(shape, -offsetX, offsetY, shapeW, shapeH);
    shape(shape, -offsetX, offsetY, imgW, imgH);
    popMatrix();
  }
}