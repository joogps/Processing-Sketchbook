void setup() {
  size(640, 360);

  String s = fairSharing("ab", 75);

  int[] a = new int[s.length()];
  int[] b = new int[s.length()];

  for (int i = 0; i < s.length(); i++) {
    if (s.charAt(i) == 'a') {
      for (int j = i; j < a.length; j++)
        a[j]+= s.length()-i;
    }

    if (s.charAt(i) == 'b')
      for (int j = i; j < b.length; j++)
        b[j]+= s.length()-i;
  }

  float w = width*0.75;
  float h = height*0.75;

  translate((width-w)/2, (height-h)/2);
  background(255);

  strokeWeight(5);

  stroke(255, 171, 3);
  for (int i = 0; i < a.length-1; i++)
    line(i/float(a.length)*w, h-a[i]/float(a[a.length-1])*h, (i+1)/float(a.length)*w, h-a[i+1]/float(a[a.length-1])*h);

  stroke(3, 177, 255);
  for (int i = 0; i < b.length-1; i++)
    line(i/float(b.length)*w, h-b[i]/float(b[b.length-1])*h, (i+1)/float(b.length)*w, h-b[i+1]/float(b[b.length-1])*h);
}

String fairSharing(String s, int limit) {
  if (s.length() < limit) {
    if (s.length()%2 == 0)
      return fairSharing(s+s.charAt(s.length()/2), limit);
    else {
      if (s.charAt((s.length()-1)/2) == 'a')
        return fairSharing(s+"b", limit);
      else
        return fairSharing(s+"a", limit);
    }
  }

  return s;
}
