class Bird {
  PVector pos, dir, vel;
  PImage img, img2;
  PShape shape, shape2;
  int animation, counter, paddingX, upperY, lowerY;
  
  public Bird(PImage img, PImage img2) {
    this.img = img;
    if ((int)random(9) == 0) {
      img = sexyfairyImg;
      img.resize(100, 0);
      img2 = sexyfairyImg;
      img2.resize(100, 0);
    }
    pos = new PVector();
    dir = new PVector();
    vel = new PVector();
    shape = createShape(); // simple 2 frame flapping animation of bird using 2 images.
    shape.beginShape();
    shape.noStroke();
    shape.textureMode(NORMAL);
    shape.texture(img);
    shape.vertex(0, 0, 0, 0);
    shape.vertex(img.width, 0, 1, 0);
    shape.vertex(img.width, img.height, 1, 1);
    shape.vertex(0, img.height, 0, 1);
    shape.endShape();
    
    shape2 = createShape();
    shape2.beginShape();
    shape2.noStroke();
    shape2.textureMode(NORMAL);
    shape2.texture(img2);
    shape2.vertex(0, 0, 0, 0);
    shape2.vertex(img2.width, 0, 1, 0);
    shape2.vertex(img2.width, img2.height, 1, 1);
    shape2.vertex(0, img2.height, 0, 1);
    shape2.endShape();
    
    animation = 1;
    counter = 0;
    pos.x = 0;
    pos.y = 0;
    dir.x = 1;
    dir.y = 1;
    paddingX = 3500 - img.width;
    lowerY = -img.height * 2;
    upperY = -3500;
  }
  
  public void draw() {
    pushMatrix();
    if (pos.x < -paddingX) {
      dir.x = 1;
    }
    else if (pos.x > paddingX) {
      dir.x = -1;
    }
    if (pos.y < upperY) {
      dir.y = 1;
    }
    else if (pos.y > lowerY) {
      dir.y = -1;
    }
    if (pos.z < -paddingX) {
      dir.z = 1;
    }
    else if (pos.z > 0) {
      dir.z = -1;
    }
    dir.x += random(-1, 1);
    dir.y += random(-1, 1);
    dir.z += random(-1, 1);
    pos.x += dir.x;
    pos.y += dir.y;
    pos.z += dir.z;
    translate(pos.x, pos.y, pos.z);
    if (animation > 0) { // which frame to draw.
      if (dir.x > 0) // does the image need to be flipped to match the direction?
        shape(shape, img.width, 0, -img.width, img.height);
      else
        shape(shape, 0, 0);
    }
    else {
      if (dir.x > 0)
        shape(shape2, img.width, 0, -img.width, img.height);
      else
        shape(shape2, 0, 0);
    }
    popMatrix();
    if (counter++ > 15) { // counter before changing animation frame.
      counter = 0;
      animation *= -1;
    }
  }
}