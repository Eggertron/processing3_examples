
/*
  Testing out some of the WebCam Capture methods
*/

import processing.video.*;

class CaptureWebcam {
  
  private Capture cam;
  float THRESHOLDVALUE = 0.8;
  int BLACK = color(0, 0, 0);
  int WHITE = color(255, 255, 255);
  int[] detection;
  int detectionHeight;
  
  public CaptureWebcam(PApplet main) {
    String[] cameras = Capture.list();
    if (cameras.length == 0) println("No Cameras Available");
    else for (int i = 0; i < cameras.length; i++) println("Camera["+i+"] is "+cameras[i]);
    //cam = new Capture(this, cameras[0]);
    cam = new Capture(main, cameras[0]);
    cam.start();
    if (cam.available()) cam.read();
  }
  
  void updateCapture() {
    if (cam.available() == true) {
      cam.read();
      if (detection == null) {
        detectionHeight = cam.height / 2; // about the center of the camera
        detection = new int[cam.width];
      }
      MotionDetection(cam);
      //printArray(detection);
      //println(getLocation());
    }
    //set(0, 0, cam); // this is faster if we just want to throw it up on screen. but does not work well with capture.
  }
  
  void MotionDetection(PImage img) {
    int y = (int)(img.height * 0.5); // half of the height;
    //img.loadPixels();
    //img.filter(THRESHOLD, THRESHOLDVALUE); // maybe don't use this, changes all the pixels, unneccessary.
    //for (int i = 0; i < detection.length; i++) detection[i] = img.pixels[detectionHeight * img.width + i] == BLACK ? 0 : 1;
    //if (img.pixels != null)  println("array size: " + img.pixels.length);
    //if (img.pixels[y * img.width + 10] > BLACK ) {
    //  println("something on the right?");
    //  println("color value: " + img.get(10, (int)(cam.height * 0.5)));
    //}
    //if (img.pixels[y * img.width + (img.width - 10)] > BLACK ) {
    //  println("something on the left?");
    //  println("color value: " + img.get(500, (int)(cam.height * 0.5)));
    //}
    //img.updatePixels();
    
    // let's try to make algorithm faster.
    PImage result = img.get(0, y, img.width, 1); // grab the first line only
    result.loadPixels();
    println("new img size: " + result.pixels.length);
    result.filter(THRESHOLD, THRESHOLDVALUE); // used on a smaller image set now.
    for (int i = 0; i < detection.length; i++) detection[i] = result.pixels[i] == BLACK ? 0 : 1;
    result.updatePixels();
    set(0, 0, result);
  }
  
  /**
    returns a value between 0 - 1 of motion detection area.
    0 = left
    1 = right
    -1 = no detection
  */
  public float getLocation() {
    if (detection == null) return -1;
    int threshLen = 10, counter = 0;
    float result = -1;
    for (int i = 0; i < detection.length; i++) {
      if (detection[i] == 1) counter++;
      else counter = 0;
      if (counter > threshLen) result = (i - threshLen) / (float)detection.length;
    }
    return result;
  }
  
  void printArray(int[] array) {
    println("Array length: " + array.length);
    for( int i = 0; i < array.length; i++) print(array[i]);
    print("\n");
  }
}