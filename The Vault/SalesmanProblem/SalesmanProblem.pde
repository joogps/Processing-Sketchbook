PVector[] points;
int[] order;

float winnerDistance;
int[] winnerOrder;

void setup() {
  size(640, 360);

  points = new PVector[4];
  for (int i = 0; i < points.length; i++)
    points[i] = new PVector(random(width), random(height));

  order = new int[points.length];
  for (int i = 0; i < order.length; i++)
    order[i] = i;

  winnerOrder = null;
}

void draw() {
  background(0);

  if (frameCount <= factorial(order.length)) {
    float distance = 0;

    stroke(255);
    for (int i = 0; i < order.length-1; i++) {
      line(points[order[i]].x, points[order[i]].y, points[order[i+1]].x, points[order[i+1]].y);
      distance+= dist(points[order[i]].x, points[order[i]].y, points[order[i+1]].x, points[order[i+1]].y);
    }

    if (distance < winnerDistance || winnerOrder == null) {
      if (winnerOrder == null)
        winnerOrder = new int[order.length];

      arrayCopy(order, winnerOrder);
      winnerDistance = distance;
    }

    order = lexicographic(order);
  } else {
    stroke(0, 0, 255);
    for (int i = 0; i < winnerOrder.length-1; i++)
      line(points[winnerOrder[i]].x, points[winnerOrder[i]].y, points[winnerOrder[i+1]].x, points[winnerOrder[i+1]].y);
  }

  for (int i = 0; i < points.length; i++)
    circle(points[i].x, points[i].y, 30);
}

int[] lexicographic(int[] nums) {
  int x = 0;
  boolean found = false;

  for (int i = nums.length-2; i >= 0; i--) {
    if (nums[i] < nums[i+1]) {
      x = i;
      found = true;
      break;
    }
  }

  if (found) {

    int y = 0;

    for (int i = x+1; i < nums.length; i++) {
      if (nums[x] < nums[i] && i > y)
        y = i;
    }

    int[] swappedNums = new int[nums.length];
    arrayCopy(nums, swappedNums);

    swappedNums[x] = nums[y];
    swappedNums[y] = nums[x];

    arrayCopy(swappedNums, nums);

    nums = concat(subset(nums, 0, x+1), reverse(subset(nums, x+1, nums.length-x-1)));
  }

  return nums;
}

int factorial (int n) {
  if (n == 1)
    return n;
  else return n*factorial(n-1);
}
