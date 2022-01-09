void setup() {
  print(getOS());
}

String getOS() {
  String raw = System.getProperty("os.name").toLowerCase();

  if (raw.contains("win"))
    return "Windows";
  else if (raw.contains("mac"))
    return "macOS";
  else if (raw.contains("nix") || raw.contains("nux") || raw.contains("aix"))
    return "Linux/Unix";
  else
    return raw;
}
