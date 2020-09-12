/*
  Requires GStreamer-based video library for Processing
  Download the Video Library
*/

import processing.video.*;

class CaptureCam {
  Capture cam;
  private PApplet parent;

  public CaptureCam(PApplet main) {
    parent = main;
    String[] cameras = Capture.list();
  
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
    
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      //cam = new Capture(obj, 800, 600, cameras[0]);
      cam = new Capture(parent, cameras[0]);
      cam.start();     
    }      
  }

  public void draw() {
    if (cam.available() == true) {
      cam.read();
    }
    image(cam, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(0, 0, cam);
  }
  
}