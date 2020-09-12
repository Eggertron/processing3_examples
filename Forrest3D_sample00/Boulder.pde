class Boulder {
  PImage img;
  PShape shape;
  PVector location;
  
  public Boulder(PImage im, int x, int y, int z, int h, int b, int s) {
    img = im;
    location = new PVector();
    location.x = x;
    location.y = y;
    location.z = z;

    //int quadrant = 360 / s;
    int quadrant = 360 / 3;
    shape = createShape();
    // TOP
    shape.beginShape();
    shape.textureMode(NORMAL);
    shape.texture(img);
    for (int i = 0; i <= 360; i += quadrant) {
      shape.vertex(cos(radians(i)) * b * .5, -h, sin(radians(i)) * b * .5, cos(radians(i)), sin(radians(i)));
    }
    // SIDE
    for (int i = 0; i <= 360; i += quadrant) {
      shape.vertex(cos(radians(i)) * b * .5,  -h, sin(radians(i)) * b * .5, i/360, 1);
      shape.vertex(cos(radians(i)) * b,        0, sin(radians(i)) * b,      i/360, 0);
    }
    // BOTTOM
    for (int i = 0; i <= 360; i += quadrant) {
      shape.vertex(cos(radians(i)) * b, 0, sin(radians(i)) * b, cos(radians(i)), sin(radians(i)));
    }
    shape.endShape();
    shape.rotateY(random(radians(-180)));
    shape.translate(location.x, location.y, location.z);
  }
  
  public void draw() {
    shape(shape);
  }
}