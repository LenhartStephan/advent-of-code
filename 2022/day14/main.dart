import 'dart:math';
import 'dart:io';

void main() async {
  String input = """498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""";

  try {
    input = File("day14.input").readAsStringSync();
  } catch (e) {}

  int part1 = getSandList(toRockList(input)).length;
  print("Part 1: $part1");

  int part2 = getSandList(toRockList(input, hasFloor: true)).length;
  print("Part 2: $part2");
}

List<List<int>> toRockList(String input, {bool hasFloor = false}) {
  List<String> splits = input.split("\n");
  if (splits.last
      .trim()
      .isEmpty) splits.removeLast();
  List<List<int>> rocks =
  List.generate(675, (index) => List.generate(175, ((index) => 0)));
  int maxY = 0;
  for (String split in splits) {
    List<String> pnts = split.split(" -> ");
    Point<int>? lastPoint;
    for (String p in pnts) {
      List<int> cords = List.from(p.split(",").map((e) => int.parse(e)));
      Point<int> point = Point(cords[0], cords[1]);
      rocks[point.x][point.y] = 1;
      if (lastPoint != null) {
        bool horizontal = (point.y == lastPoint.y);
        bool positive = (lastPoint.x < point.x) || (lastPoint.y < point.y);
        while (point != lastPoint) {
          if (lastPoint!.y > maxY) maxY = lastPoint.y;
          lastPoint = lastPoint +
              (horizontal
                  ? Point(positive ? 1 : -1, 0)
                  : Point(0, positive ? 1 : -1));
          rocks[lastPoint.x][lastPoint.y] = 1;
        }
      }
      lastPoint = point;
    }
    lastPoint = null;
  }

  for (int x = 0; x < rocks.length; x++) {
    if (hasFloor) rocks[x][maxY + 2] = 1;
    rocks[x].removeRange(maxY + 4, rocks[x].length);
  }
  return rocks;
}

List<Point<int>> getSandList(List<List<int>> rocks) {
  Point<int>? sand = Point(500, 0);
  Point<int> lastSand = Point(0, 0);
  List<Point<int>> sandList = [];
  while (true) {
    sand = Point(500, 0);
    while (sand != null && sand != lastSand) {
      lastSand = sand;
      sand = singleStep(rocks, sand);
    }
    if (sand != null && (!sandList.contains(sand))) {
      sandList.add(sand);
      rocks[sand.x][sand.y] = 2;
    } else {
      break;
    }
  }
  //printRockList(rocks);
  return sandList;
}

Point<int>? singleStep(List<List<int>> rocks, Point<int> sand) {
  if (sand.y + 1 >= rocks.first.length) {
    return null;
  } else if (rocks[sand.x][sand.y + 1] == 0) {
    return sand + Point(0, 1);
  } else if (rocks[sand.x - 1][sand.y + 1] == 0) {
    return sand + Point(-1, 1);
  } else if (rocks[sand.x + 1][sand.y + 1] == 0) {
    return sand + Point(1, 1);
  }
  return sand;
}

void printRockList(List<List<int>> r, {Point<int>? point}) {
  List<List<int>> rocks = List.generate(r.length, (i) => (List.from(r[i])));
  if (point != null) rocks[point.x][point.y] = 3;
  String output = "";
  for (int x = 0; x < rocks.length; x++) {
    if (rocks[x].contains(1) || rocks[x].contains(2) || rocks[x].contains(3)) {
      for (int y = 0; y < rocks[x].length; y++) {
        output += (rocks[x][y]).toString();
      }
      output += "\n";
    }
  }
  // 0 = nothing, 1 = rock, 2 = setteled sand, 3 = falling sand
  print(output
      .replaceAll("0", ".")
      .replaceAll("1", "#")
      .replaceAll("2", "o")
      .replaceAll("3", "+"));
}
