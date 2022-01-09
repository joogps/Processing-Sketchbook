int[] nums = {1, 2, 3, 4};

void setup() {
  for (int l = 0; l < factorial(nums.length); l++) {
    println(join(nf(nums, 0), ", "));
    nums = lexicographic(nums);
  }
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
