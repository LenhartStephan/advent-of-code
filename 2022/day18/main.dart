import 'dart:collection';
import 'dart:io';

void main() async {
  String input = """2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
""";

  try {
    input = File("day18.input").readAsStringSync();
  } catch (e) {}

  List<Point> points = toPointList(input);
  int part1 = getSurfaces(points);
  print("Part 1: $part1");

  int part2 = outerSurfaces(points);
  print("Part 2: $part2");
}

List<Point> toPointList(String input) {
  List<String> points = input.split("\n");
  if (points.last
      .trim()
      .isEmpty) points.removeLast();

  List<Point> list = [];

  for (String p in points) {
    List<String> pValue = p.split(",");
    list.add(Point(
        int.parse(pValue[0]), int.parse(pValue[1]), int.parse(pValue[2])));
  }
  return list;
}

int getSurfaces(Iterable<Point> points) {
  int surfaces = 0;
  for (Point p in points) {
    List<Point> neighbors = p.neighbors();
    for (Point n in neighbors) {
      if (!points.contains(n)) surfaces++;
    }
  }
  return surfaces;
}

int outerSurfaces(Iterable<Point> points) {
  Point bound = getBounds(points);
  Queue queue = Queue.from([Point(0, 0, 0)]);
  Set<Point> visited = {};
  int count = 0;

  while (queue.isNotEmpty) {
    Point point = queue.removeFirst();
    if (!visited.contains(point)) {
      visited.add(point);
      for (Point neighbor in point.neighbors()) {
        if (points.contains(neighbor)) {
          count++;
        } else if (inBounds(neighbor, bound)) {
          queue.add(neighbor);
        }
      }
    }
  }
  return count;
}

bool inBounds(Point point, Point bound) {
  return point.x < bound.x &&
      point.x >= -1 &&
      point.y < bound.y &&
      point.y >= -1 &&
      point.z < bound.z &&
      point.z >= -1;
}

Point getBounds(Iterable<Point> points) {
  Point p = Point(0, 0, 0);
  for (Point point in points) {
    if (point.x > p.x) p = p.copyWith(x: point.x);
    if (point.y > p.y) p = p.copyWith(y: point.y);
    if (point.z > p.z) p = p.copyWith(z: point.z);
  }
  return Point(p.x + 2, p.y + 2, p.z + 2);
}

class Point {
  final int x;
  final int y;
  final int z;

  Point(this.x, this.y, this.z);

  Point copyWith({int? x, int? y, int? z}) =>
      Point(x ?? this.x, y ?? this.y, z ?? this.z);

  List<Point> neighbors() {
    return [
      this + Point(0, 0, 1),
      this + Point(0, 0, -1),
      this + Point(0, 1, 0),
      this + Point(0, -1, 0),
      this + Point(1, 0, 0),
      this + Point(-1, 0, 0),
    ];
  }

  operator +(Point o) {
    return Point(x + o.x, y + o.y, z + o.z);
  }

  @override
  operator ==(Object other) {
    return other is Point && other.x == x && other.y == y && other.z == z;
  }

  @override
  int get hashCode => x.hashCode + y.hashCode + z.hashCode;

  @override
  String toString() {
    return "Point($x, $y, $z)";
  }
}
