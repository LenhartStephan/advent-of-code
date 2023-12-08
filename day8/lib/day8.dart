int minSteps(String input, {bool asGhost = false}) {
  List<String> parts = input.split("\n\n");
  List<String> moveConfig = parts.first.split("");
  Map<String, (String, String)> moveMap = {
    for (var e in parts.last.split("\n").map((e) {
      List<String> parts = e.split(" = ");
      List<String> moveTargets = parts.last.replaceAll(RegExp(r"[()]"), "").split(", ");
      return (parts.first, (moveTargets.first, moveTargets.last));
    }))
      e.$1: e.$2
  };

  if (asGhost) {
    List<String> starts = moveMap.keys.where((e) => e.endsWith("A")).toList();
    int lcmSteps = 1;
    for (var start in starts) {
      lcmSteps = lcm(
          goUntil(start: start, isDestination: (pos) => pos.endsWith("Z"), moveConfig: moveConfig, moveMap: moveMap),
          lcmSteps);
    }
    return lcmSteps;
  } else {
    return goUntil(start: "AAA", isDestination: (pos) => (pos == "ZZZ"), moveConfig: moveConfig, moveMap: moveMap);
  }
}

/// Returns the number of steps to reach a position that satisfies [isDestination].
int goUntil({
  required String start,
  required bool Function(String) isDestination,
  required List<String> moveConfig,
  required Map<String, (String, String)> moveMap,
}) {
  String currentPosition = start;
  int steps = 0;
  while (!isDestination.call(currentPosition)) {
    String nextMove = moveConfig[steps % moveConfig.length];
    var (left, right) = moveMap[currentPosition]!;
    currentPosition = (nextMove == "L") ? left : right;
    steps++;
  }
  return steps;
}

/// Returns the least common multiple of a and b
int lcm(int a, int b) => ((a == 0) || (b == 0)) ? 0 : ((a ~/ a.gcd(b)) * b).abs();
