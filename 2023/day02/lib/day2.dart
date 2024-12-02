int possibleGames(String input) {
  final maxRed = 12;
  final maxGreen = 13;
  final maxBlue = 14;
  int gameSum = 0;

  input = input.replaceAll(RegExp(r"Game [0-9]+\: "), "");
  List<String> games = input.split("\n");
  for (var MapEntry(key: gameId, value: game) in games.asMap().entries) {
    List<String> rounds = game.split(";");
    bool allValid = true;
    for (String round in rounds) {
      var (red, green, blue) = parseRound(round);
      if (red > maxRed || green > maxGreen || blue > maxBlue) {
        allValid = false;
        break;
      }
    }
    if (allValid) gameSum += (gameId + 1);
  }
  return gameSum;
}

int minPossibleGames(String input) {
  int gameSum = 0;
  input = input.replaceAll(RegExp(r"Game [0-9]+\: "), "");
  List<String> games = input.split("\n");
  for (String game in games) {
    List<String> rounds = game.split(";");
    int minRed = 0;
    int minGreen = 0;
    int minBlue = 0;
    for (String round in rounds) {
      var (red, green, blue) = parseRound(round);
      if (red > minRed) minRed = red;
      if (green > minGreen) minGreen = green;
      if (blue > minBlue) minBlue = blue;
    }
    gameSum += (minRed * minGreen * minBlue);
  }
  return gameSum;
}

(int, int, int) parseRound(String input) {
  (int, int, int) r = (0, 0, 0);
  for (String cube in input.split(",")) {
    List<String> c = cube.trim().split(" ");
    switch (c.last) {
      case "red":
        r = (int.parse(c.first), r.$2, r.$3);
      case "green":
        r = (r.$1, int.parse(c.first), r.$3);
      case "blue":
        r = (r.$1, r.$2, int.parse(c.first));
    }
  }
  return r;
}
