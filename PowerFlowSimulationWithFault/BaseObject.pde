/* Each BaseObject is a Node in this graph
*/
interface BaseObject {
  void update(); // needed prior to draw function
  void draw(); // needed to display updated object
  void onClick(); // this is to check if object was clicked
  void onDrag();
  void onReleased();
  void onPressed();
  float getX();
  float getY();
  boolean isPowered();
  void setIsPowered(boolean status);
  void setX(float _x);
  void setY(float _y);
  void setHalfSize(int s);
  int getHalfSize();
  void setColor(color c);
}