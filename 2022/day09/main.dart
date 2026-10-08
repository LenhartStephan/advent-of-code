import 'dart:io';
import 'dart:math';
import 'knot_point.dart';

void main() async {
  String input = """R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""";

  try {
    input = File("day09.input").readAsStringSync();
  } catch (e) {}

  List<String> commandList = toCommandList(input);

  int part1 = getVisitedPositions(commandList).length;
  print("Part 1: $part1");

  int part2 = getVisitedPositions(commandList, length: 10).length;
  print("Part 2: $part2");
}

List<String> toCommandList(String input) {
  List<String> list = input.split("\n");
  if (list.last
      .trim()
      .isEmpty) list.removeLast();
  return list;
}

getVisitedPositions(List<String> commands, {int length = 2}) {
  assert(length >= 2, "Length cannot be smaler than 2");
  List<KnotPoint> knots = [];
  for (int i = 0; i < length; i++) {
    knots.add(KnotPoint(0, 0));
  }

  Set<KnotPoint> visited = {};

  for (String command in commands) {
    Direction direction = directionFromCommand(command
        .split(" ")
        .first);
    int jumps = int.parse(command
        .split(" ")
        .last);
    for (int i = 0; i < jumps; i++) {
      knots.first = updateHead(head: knots.first, direction: direction);
      knots[1] = updateTail(head: knots.first, tail: knots[1]);
      for (int j = 1; j < (knots.length); j++) {
        knots[j] = updateTail(head: knots[j - 1], tail: knots[j]);
      }
      visited.add(knots.last);
    }
  }
  return visited;
}

enum Direction { up, down, left, right }

Direction directionFromCommand(String letter) {
  switch (letter) {
    case "U":
      return Direction.up;
    case "D":
      return Direction.down;
    case "L":
      return Direction.left;
    case "R":
      return Direction.right;
  }
  throw Exception("Invalid input");
}

KnotPoint updateHead({required KnotPoint head, required Direction direction}) {
  switch (direction) {
    case Direction.up:
      head = KnotPoint.from(head + Point(0, 1));
      break;
    case Direction.down:
      head = KnotPoint.from(head - Point(0, 1));
      break;
    case Direction.left:
      head = KnotPoint.from(head - Point(1, 0));
      break;
    case Direction.right:
      head = KnotPoint.from(head + Point(1, 0));
      break;
  }
  return head;
}

KnotPoint updateTail({required KnotPoint head, required KnotPoint tail}) {
  if (!head.isAdjacent(tail)) {
    if (head.x == tail.x && head.y > tail.y) {
      return KnotPoint.from(tail + Point(0, 1));
    } else if (head.x == tail.x && head.y < tail.y) {
      return KnotPoint.from(tail - Point(0, 1));
    } else if (head.y == tail.y && head.x > tail.x) {
      return KnotPoint.from(tail + Point(1, 0));
    } else if (head.y == tail.y && head.x < tail.x) {
      return KnotPoint.from(tail - Point(1, 0));
    } else if (head.x > tail.x && head.y > tail.y) {
      return KnotPoint.from(tail + Point(1, 1));
    } else if (head.x > tail.x && head.y < tail.y) {
      return KnotPoint.from(tail + Point(1, -1));
    } else if (head.x < tail.x && head.y > tail.y) {
      return KnotPoint.from(tail + Point(-1, 1));
    } else if (head.x < tail.x && head.y < tail.y) {
      return KnotPoint.from(tail + Point(-1, -1));
    }
  }

  return tail;
}
