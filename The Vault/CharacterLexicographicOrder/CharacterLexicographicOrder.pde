char[] chars = {'a', 'b', 'c', 'd'};

void setup() {
  for (int l = 0; l < factorial(chars.length); l++) {
    String[] strArray = new String[chars.length];
    for (int i = 0; i < chars.length; i++)
      strArray[i] = String.valueOf(chars[i]);

    println(join(strArray, ", "));
    chars = charLexicographic(chars);
  }
}

char[] charLexicographic(char[] chars) {
  int x = 0;
  boolean found = false;

  for (int i = chars.length-2; i >= 0; i--) {
    if (int(chars[i]) < int(chars[i+1])) {
      x = i;
      found = true;
      break;
    }
  }

  if (found) {
    int y = 0;

    for (int i = x+1; i < chars.length; i++) {
      if (int(chars[x]) < int(chars[i]) && i > y)
        y = i;
    }

    char[] swappedChars = new char[chars.length];
    arrayCopy(chars, swappedChars);

    swappedChars[x] = chars[y];
    swappedChars[y] = chars[x];

    arrayCopy(swappedChars, chars);

    chars = concat(subset(chars, 0, x+1), reverse(subset(chars, x+1, chars.length-x-1)));
  }

  return chars;
}

int factorial (int n) {
  if (n == 1)
    return n;
  else return n*factorial(n-1);
}
