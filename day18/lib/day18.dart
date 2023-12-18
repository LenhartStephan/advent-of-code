import 'dart:math';

int lagoonVolume(String input, {bool withHex = false}) {
  List<(String, int, String)> digPlan = input.split("\n").map((e) {
    List<String> splits = e.split(" ");
    return (splits.first, int.parse(splits[1]), splits.last.replaceAll(RegExp(r"[\(\)#]"), ""));
  }).toList();

  var (List<Point<int>> perimeter, int perimeterLength) = parseDigPlan(digPlan, withHex: withHex);
  int area = shoelace(perimeter).floor();

  return (area - perimeterLength / 2 + 1).floor() + perimeterLength;
}

(List<Point<int>>, int) parseDigPlan(List<(String, int, String)> plan, {bool withHex = false}) {
  List<Point<int>> points = [Point(0, 0)];
  Point<int> point = Point(0, 0);
  int perimeterLength = 0;
  for (var (direction, steps, hex) in plan) {
    if (withHex) {
      steps = int.parse(hex.substring(0, 5), radix: 16);
      direction = hex.substring(5);
    }
    Point<int> move = switch (direction) {
      "1" || "D" => Point(0, 1),
      "2" || "L" => Point(-1, 0),
      "3" || "U" => Point(0, -1),
      _ => Point(1, 0)
    };

    point += move * steps;
    points.add(point);
    perimeterLength += steps;
  }
  return (points, perimeterLength);
}

double shoelace(List<Point> perimeter) {
  double area = 0;
  for (int i = 0; i < perimeter.length - 1; i++) {
    Point currentPoint = perimeter[i];
    Point nextPoint = perimeter[i + 1];
    area += 0.5 * (currentPoint.y + nextPoint.y) * (nextPoint.x - currentPoint.x);
  }
  area += 0.5 * (perimeter.last.y + perimeter.first.y) * (perimeter.first.x - perimeter.last.x);
  return area.abs();
}
