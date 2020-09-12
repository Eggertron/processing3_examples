class Background {
  private PImage img;
  private PShape background;
  private int posX,
              imgW,
              imgH;
  
  public Background(PImage img) {
    this.img = img;
    background = createShape();
    background.beginShape();
    background.noStroke();
    background.textureMode(NORMAL);
    background.texture(img);
    background.vertex(0, 0, 0, 0);
    background.vertex(img.width, 0, 1, 0);
    background.vertex(img.width, img.height, 1, .8);
    background.vertex(0, img.height, 0, .8);
    background.endShape();
    float ratio = img.width / width;
    if (ratio < 1)
      ratio = width / img.width;
    imgW = (int)(img.width * ratio * 2);
    imgH = (int)(img.height * ratio * 2);
  }
  
  public void draw() {
    pushMatrix();
    translate(mouseX * 0.03, 0, 0);
    shape(background, -50, 0, imgW, imgH);
    popMatrix();
  }
}