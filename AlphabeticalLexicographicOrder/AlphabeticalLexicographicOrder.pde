String alphabet = "abcdefghijklmnopqrstuvwxyz";
String[] letters = {"a", "b", "c", "d"};

void setup() {
  for (int l = 0; l < factorial(letters.length); l++) {
    println(join(letters, ", "));

    int x = 0;
    boolean found = false;

    for (int i = letters.length-2; i >= 0; i--) {
      if (alphabet.indexOf(letters[i]) < alphabet.indexOf(letters[i+1])) {
        x = i;
        found = true;
        break;
      }
    }

    if (!found) 
      break;

    int y = 0;

    for (int i = x+1; i < letters.length; i++) {
      if (alphabet.indexOf(letters[x]) < alphabet.indexOf(letters[i]) && i > y)
        y = i;
    }

    String[] swappedletters = new String[letters.length];
    arrayCopy(letters, swappedletters);

    swappedletters[x] = letters[y];
    swappedletters[y] = letters[x];

    arrayCopy(swappedletters, letters);

    letters = concat(subset(letters, 0, x+1), reverse(subset(letters, x+1, letters.length-x-1)));
  }
}

int factorial (int n) {
  if (n == 1)
    return n;
  else return n*factorial(n-1);
}
