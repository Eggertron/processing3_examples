// Edgar Han
// superformula
float counter;
SuperFormula sf;

void setup() {
  size(800, 800);
  background(255);
  counter = 0;
  sf = new SuperFormula();
}

void draw() {
  sf.superformula(radians(counter += 0.1));
}

void mouseClicked() {}

void mouseDragged() {}



class SuperFormula {
  // values below should be changed to create different natural shapes.
  float _a, _b, _m1, _m2, _n1, _n2, _n3;
  
  SuperFormula() {
    // initialized default values
    _a = 1;
    _b = 1;
    _m1 = 2;
    _m2 = 44;
    _n1 = -0.2;
    _n2 = 1;
    _n3 = 1;
  }
  // superformula
  float r(float phi, float a, float b, float m1, float m2, float n1, float n2, float n3) {
    return pow(pow(abs(cos((m1 * phi)/4)/a),n2) + pow(abs(sin((m2 * phi)/4)/b),n3),(-1/n1));
  }

  void superformula(float phi) {
    float r = (width/8) * r(phi, _a, _b, _m1, _m2, _n1, _n2, _n3);
    float x = r * cos(phi) + (width / 3);
    float y = r * sin(phi) + (height / 3);
    ellipse(x, y, 2, 2);
  }
}