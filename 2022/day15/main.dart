import 'dart:math';
import 'dart:io';

import 'package:tuple/tuple.dart';

void main() async {
  String input = """Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
""";

  try {
    input = File("day15.input").readAsStringSync();
  } catch (e) {}

  var sensorList = getSensorList(input);
  int blocked = getBlockedTiles(sensorList, y: 2000000);
  print("Part 1: $blocked");

  int frequency = tuningFrequency(sensorList, maxCord: 4000000);
  print("Part 2: $frequency");
}

int manhattenDistance(Point<int> from, Point<int> to) =>
    (from.x - to.x).abs() + (from.y - to.y).abs();

List<Tuple2<Point<int>, Point<int>>> getSensorList(String input) {
  List<String> splits = input.split("\n");
  if (splits.last
      .trim()
      .isEmpty) splits.removeLast();
  List<Tuple2<Point<int>, Point<int>>> list = [];
  for (String split in splits) {
    List<String> components = split.split(":");
    components[0] = components[0]
        .replaceFirst("Sensor at ", "")
        .replaceFirst("x=", "")
        .replaceFirst("y=", "");
    components[1] = components[1]
        .replaceFirst(" closest beacon is at ", "")
        .replaceFirst("x=", "")
        .replaceFirst("y=", "");
    Point<int> one = Point(int.parse(components[0].split(", ")[0]),
        int.parse(components[0].split(", ")[1]));
    Point<int> two = Point(int.parse(components[1].split(", ")[0]),
        int.parse(components[1].split(", ")[1]));
    list.add(Tuple2(one, two));
  }

  return list;
}

bool isInRange(Point<int> point,
    {required Point<int> center, required Point<int> to}) {
  return manhattenDistance(point, center) <= manhattenDistance(center, to);
}

int getMinX(List<Tuple2<Point<int>, Point<int>>> sensors) {
  int minX = sensors.first.item1.x -
      manhattenDistance(sensors.first.item1, sensors.first.item2);
  for (var sensor in sensors) {
    int x = sensor.item1.x - manhattenDistance(sensor.item1, sensor.item2);
    if (x < minX) minX = x;
  }
  return minX;
}

int getMaxX(List<Tuple2<Point<int>, Point<int>>> sensors) {
  int maxX = sensors.first.item1.x +
      manhattenDistance(sensors.first.item1, sensors.first.item2);
  for (var sensor in sensors) {
    int x = sensor.item1.x + manhattenDistance(sensor.item1, sensor.item2);
    if (x > maxX) maxX = x;
  }
  return maxX;
}

int getBlockedTiles(List<Tuple2<Point<int>, Point<int>>> sensors,
    {required int y}) {
  int minX = getMinX(sensors);
  int maxX = getMaxX(sensors);
  int blocked = 0;
  for (int x = minX; x <= maxX; x++) {
    Point<int> point = Point(x, y);
    for (Tuple2<Point<int>, Point<int>> sensor in sensors) {
      if (isInRange(point, center: sensor.item1, to: sensor.item2) &&
          sensor.item2 != point) {
        blocked++;
        break;
      }
    }
  }
  return blocked;
}

Point<int> findBeacon(List<Tuple2<Point<int>, Point<int>>> sensors,
    {required int maxCord}) {
  for (var sensor in sensors) {
    var perimeter = getSensorPerimeter(sensor);
    for (var point in perimeter) {
      if (checkBeaconPoint(sensors, point: point) &&
          point.x <= maxCord &&
          point.y <= maxCord) return point;
    }
  }

  return Point(-1, -1);
}

bool checkBeaconPoint(List<Tuple2<Point<int>, Point<int>>> sensors,
    {required Point<int> point}) {
  bool allOuta = true;
  for (Tuple2<Point<int>, Point<int>> sensor in sensors) {
    if (isInRange(point, center: sensor.item1, to: sensor.item2)) {
      allOuta = false;
      break;
    }
  }
  return (allOuta);
}

List<Point<int>> getSensorPerimeter(Tuple2<Point<int>, Point<int>> sensor) {
  int distance = manhattenDistance(sensor.item1, sensor.item2) + 1;
  List<Point<int>> list = [];
  for (int i = 0; i < distance; i++) {
    var s = Point(sensor.item1.x, sensor.item1.y);
    list.add(s + Point(distance - i, i));
    list.add(s + Point(i, distance - i));
    list.add(s + Point(i, i + distance));
    list.add(s + Point(i + distance, i));
  }
  return list;
}

int tuningFrequency(List<Tuple2<Point<int>, Point<int>>> sensors,
    {int maxCord = 20}) {
  Point<int> point = findBeacon(sensors, maxCord: maxCord);
  return point.x * 4000000 + point.y;
}
