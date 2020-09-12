class Skybox {
  PImage img;
  PShape shape;
  int scale;
  
  public Skybox(PImage i) {
    img = i;
    scale = 4000;
    float onethird = .34, twothird = .66,
          quarter = .25, half = .5,
          sevenfive = .75;
    shape = createShape();
    shape.scale(scale);
    shape.beginShape(QUADS);
    shape.textureMode(NORMAL);
    shape.texture(img);
    // +Z "front" face
    shape.vertex(-1, -1,  1, quarter, onethird);
    shape.vertex( 1, -1,  1, half, onethird);
    shape.vertex( 1,  1,  1, half, twothird);
    shape.vertex(-1,  1,  1, quarter, twothird);
  
    // -Z "back" face
    shape.vertex( 1, -1, -1, sevenfive, onethird);
    shape.vertex(-1, -1, -1, 1, onethird);
    shape.vertex(-1,  1, -1, 1, twothird);
    shape.vertex( 1,  1, -1, sevenfive, twothird);
  
    // +Y "bottom" face
    shape.vertex(-1,  1,  1, quarter, twothird);
    shape.vertex( 1,  1,  1, half, twothird);
    shape.vertex( 1,  1, -1, half, 1);
    shape.vertex(-1,  1, -1, quarter, 1);
  
    // -Y "top" face
    shape.vertex(-1, -1, -1, quarter, 0);
    shape.vertex( 1, -1, -1, half, 0);
    shape.vertex( 1, -1,  1, half, onethird);
    shape.vertex(-1, -1,  1, quarter, onethird);
  
    // +X "right" face
    shape.vertex( 1, -1,  1, quarter, onethird);
    shape.vertex( 1, -1, -1, sevenfive, onethird);
    shape.vertex( 1,  1, -1, sevenfive, twothird);
    shape.vertex( 1,  1,  1, quarter, twothird);
  
    // -X "left" face
    shape.vertex(-1, -1, -1, 0, onethird);
    shape.vertex(-1, -1,  1, quarter, onethird);
    shape.vertex(-1,  1,  1, quarter, twothird);
    shape.vertex(-1,  1, -1, 0, twothird);
    shape.endShape();
  }
  
  public void draw() {
    shape(shape);
  }
}