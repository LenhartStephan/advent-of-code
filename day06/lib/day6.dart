import 'dart:math';

int calculate(String input, {bool badKerning = false}) {
  List<String> parts = input.replaceAll(RegExp(r".+: "), "").replaceAll(RegExp(r"  +"), " ").split("\n");
  List<int> times = parts.first.trim().split(" ").map((e) => int.parse(e)).toList();
  List<int> distances = parts.last.trim().split(" ").map((e) => int.parse(e)).toList();
  if (badKerning) {
    times = [int.parse(times.join())];
    distances = [int.parse(distances.join())];
  }
  List<int> waysToWin = [];

  for (int i = 0; i < times.length; i++) {
    int t = times[i];
    int d = distances[i];
    int lower = (0.5 * (t - sqrt(pow(t, 2) - 4 * (d + 1)))).ceil();
    int upper = (0.5 * (sqrt(pow(t, 2) - 4 * (d + 1)) + t)).floor();
    waysToWin.add(upper - lower + 1);
  }

  return waysToWin.reduce((value, element) => value * element);
}
