PVector[] points;
int[] order;

void setup() {
  size(640, 360);

  points = new PVector[4];
  for (int i = 0; i < points.length; i++)
    points[i] = new PVector(random(width), random(height));

  order = new int[points.length];
  for (int i = 0; i < order.length; i++)
    order[i] = i+1;
}

void draw() {
  frameRate(2);

  background(0);
  for (int i = 0; i < points.length; i++)
    circle(points[i].x, points[i].y, 30);

  println(join(nf(order, 0), ", "));

  int x = 0;
  boolean found = false;

  for (int i = order.length-2; i >= 0; i--) {
    if (order[i] < order[i+1]) {
      x = i;
      found = true;
      break;
    }
  }

  if (found) {
    int y = 0;

    for (int i = x+1; i < order.length; i++) {
      if (order[x] < order[i] && i > y)
        y = i;
    }

    int[] swappedNums = new int[order.length];
    arrayCopy(order, swappedNums);

    swappedNums[x] = order[y];
    swappedNums[y] = order[x];

    arrayCopy(swappedNums, order);

    order = concat(subset(order, 0, x+1), reverse(subset(order, x+1, order.length-x-1)));
  }
}

int factorial (int n) {
  if (n == 1)
    return n;
  else return n*factorial(n-1);
}
