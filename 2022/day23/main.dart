import 'dart:math';
import 'dart:io';

void main() async {
  String input = """....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..
""";

  try {
    input = File("day23.input").readAsStringSync();
  } catch (e) {}

  runSimulation(toList(input));
}

List<Directions> dirOrder = [
  Directions.n,
  Directions.s,
  Directions.w,
  Directions.e
];

enum Directions { n, s, w, e }

extension DirectonPoints on Directions {
  Point<int> point(Point<int> p) {
    switch (this) {
      case Directions.n:
        return p + Point(0, -1);
      case Directions.s:
        return p + Point(0, 1);
      case Directions.w:
        return p + Point(-1, 0);
      case Directions.e:
        return p + Point(1, 0);
    }
  }

  List<Point<int>> range(Point<int> p) {
    switch (this) {
      case Directions.n:
        return [p + Point(-1, -1), p + Point(0, -1), p + Point(1, -1)];
      case Directions.s:
        return [p + Point(-1, 1), p + Point(0, 1), p + Point(1, 1)];
      case Directions.w:
        return [p + Point(-1, 1), p + Point(-1, 0), p + Point(-1, -1)];
      case Directions.e:
        return [p + Point(1, -1), p + Point(1, 0), p + Point(1, 1)];
    }
  }
}

List<Point<int>> toList(String input) {
  List<Point<int>> list = [];
  List<String> splits = input.split("\n");
  for (var i = 0; i < splits.length; i++) {
    List<String> row = splits[i].split("");
    for (var j = 0; j < row.length; j++) {
      if (row[j] == "#") list.add(Point(j, i));
    }
  }
  return list;
}

runSimulation(List<Point<int>> elves) {
  int round = 0;
  while (true) {
    Map<Point<int>, List<Point<int>>> proposals = {};
    for (Point<int> elf in elves) {
      // Only move if there are elves around
      if (hasPointInList(
          points: Directions.values
              .map((e) => e.range(elf))
              .expand((element) => element)
              .toList(),
          list: elves)) {
        // Check for every direction, if there are elves
        for (Directions dir in dirOrder) {
          if (!hasPointInList(points: dir.range(elf), list: elves)) {
            //print("$elf try moving ${dir.name} to ${dir.point(elf)}");
            proposals.update(
              dir.point(elf),
                  (value) => [...value, elf],
              ifAbsent: () => [elf],
            );
            break;
          }
        }
      }
    }

    proposals.forEach((point, candiates) {
      if (candiates.length == 1) {
        elves.remove(candiates.first);
        elves.add(point);
      }
    });
    dirOrder.add(dirOrder.removeAt(0));
    round++;
    if (round == 10) {
      Rectangle<int> rect = getEnclosingRect(elves);
      print("Part 1: ${((rect.width + 1) * (rect.height + 1)) - elves.length}");
      //printMap(elves);
    }
    if (round % 100 == 0) print("$round...");
    if (proposals.isEmpty) break;
  }
  print("Part 2: $round");
}

bool hasPointInList({required List<Point<int>> points, required List<Point<int>> list}) {
  for (var element in list) {
    if (points.contains(element)) return true;
  }
  return false;
}

printMap(List<Point<int>> list) {
  Rectangle<int> rect = getEnclosingRect(list);
  List<List<String>> map = List.generate(
      rect.height + 1, (yi) => List.generate(rect.width + 1, (xi) => "."));
  for (var p in list) {
    map[rect.top * -1 + p.y][rect.left * -1 + p.x] = "#";
  }
  print(map.map((e) => e.join("")).join("\n"));
}

Rectangle<int> getEnclosingRect(List<Point<int>> list) {
  list.sort(((a, b) => a.x.compareTo(b.x)));
  int minX = list.first.x;
  int maxX = list.last.x;
  list.sort(((a, b) => a.y.compareTo(b.y)));
  int minY = list.first.y;
  int maxY = list.last.y;
  Rectangle<int> rect =
  Rectangle.fromPoints(Point(maxX, maxY), Point(minX, minY));
  return rect;
}
