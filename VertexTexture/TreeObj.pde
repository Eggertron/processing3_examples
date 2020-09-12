/*
  Must use P3D
*/

class TreeObj {
  PImage img;
  PVector position;
  PShape sphere;
  int imgwid, imgheight,  // the width and height of image
      swid, sheight;  // the width and height of shape
  
  public TreeObj() {
    img = loadImage("treebark.png");
    position = new PVector();
    //image properties
    imgwid = 960;
    imgheight = 720;
    swid = width / 2;
    sheight = (int)(height * 1.3);
    position.x = 0;
    position.y = 0;
    position.z = 30;
    // sphere shape
    sphere = createShape(SPHERE, 200);
    sphere.setTexture(img);
  }
  
  void draw() {
    beginShape();
    texture(img);
    vertex(position.x, position.y, -position.z, 0, 30);
    vertex(position.x + swid, position.y, -position.z, imgwid, 30);
    vertex(position.x + swid, position.y + sheight, -position.z, imgwid, imgheight);
    vertex(position.x, position.y + sheight, -position.z, 0, imgheight);
    endShape();
    
    shape(sphere, 500, 500);
  }

}