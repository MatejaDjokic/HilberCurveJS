
int order = 9;
int N = int(pow(2, order));
int total = N * N;

PVector[] path = new PVector[total];

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 255, 255);
  for(int i = 0; i < total; i++) {
    path[i] = hilbert(i);
    float len = width / N;
    path[i].mult(len);
    path[i].add(len / 2, len / 2);
  }
}

int counter = 0;
void draw() {
  background(0);
  
  stroke(255);  
  strokeWeight(2);  
  noFill();
  
  beginShape();
  for(int i = 1; i <= counter; i++) {
    float h = map(i, 0, path.length, 0, 360);
    stroke(h, 255, 255);
    line(path[i].x, path[i].y, path[i - 1].x, path[i - 1].y);
  }
  endShape();

  int add = 100;
  counter += add;
  if(counter >= path.length + add) {
    counter = 0;
  }
//  strokeWeight(4);
//  for(int i = 0; i < path.length; i++) {
//    point(path[i].x, path[i].y);
//    text(i, path[i].x + 5, path[i].y - 5);
//  }
}

PVector hilbert(int i) {
 PVector[] points = {
  new PVector(0, 0),
  new PVector(0, 1),
  new PVector(1, 1),
  new PVector(1, 0),
  };
  
  int index = i & 3;
  PVector v = points[index];
  
  for(int j = 1; j <= order; j++) {
    i = i >>> 2;
    index = i & 3;

    float len = pow(2, j);
    if(index == 0) {
       float temp = v.x;
       v.x = v.y;
       v.y = temp;
    } 
    else if(index == 1) {
      v.y += len;
    } 
    else if(index == 2) {
      v.x += len;
      v.y += len;
    } 
    else if(index == 3) {
      float temp = len - 1 - v.y; 
      v.y = len - 1 - v.x;
      v.x = temp;
      v.x += len;
    }
  }
  return v;
}
