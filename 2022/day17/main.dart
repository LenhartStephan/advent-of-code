import 'dart:math';
import 'dart:io';

void main() async {
  String input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>";

  try {
    input = File("day17.input").readAsStringSync();
  } catch (e) {}

  List<Tetris> stack = runGame(toMoveList(input), steps: 2022);
  print("Part 1: ${getStackHeight(stack)}");

  //List<Tetris> stack2 = runGame(toMoveList(input), steps: 1000000000000);
  //print("Part 2: ${getStackHeight(stack2)}");
  print("Part 2: TODO");
}

int moveListIndex = 0;

List<Move> toMoveList(String input) {
  List<String> characters = input.split("");
  List<Move> list = [];
  for (String char in characters) {
    switch (char) {
      case "<":
        list.add(Move.left);
        break;
      case ">":
        list.add(Move.right);
        break;
    }
  }
  return list;
}

List<Tetris> runGame(List<Move> moveList, {int steps = 2022}) {
  List<Tetris> stack = [];
  //List<Tetris>? pattern;
  for (int i = 1; i <= steps; i++) {
    int height = getStackHeight(stack);
    Tetris currentBlock =
    Tetris.nextBlock(i).copyWith(position: Point(2, height + 3));
    List<Tetris> subStack = (stack.length < 150)
        ? stack
        : List.from(stack.getRange(stack.length - 150, stack.length));
    stack.add(dropTetris(currentBlock, stack, moveList));
    //pattern = findPattern(stack);
    //if (i % 1000 == 0) printStack(stack);
  }
  return stack;
}

int getStackHeight(List<Tetris> stack) {
  stack.sort(((a, b) => a.boundingBox.bottom.compareTo(b.boundingBox.bottom)));
  return stack.isNotEmpty ? (stack.last.boundingBox.bottom) : 0;
}

List<Tetris>? findPattern(List<Tetris> stack) {
  int matches = 0;
  for (int i = 1; i < stack.length ~/ 2; i++) {
    List<Tetris> s1 = List.from(stack.getRange(stack.length - i, stack.length));
    matches = 0;
    for (int j = stack.length; j > 0; j -= s1.length) {
      bool allMatches = true;
      for (int k = s1.length; k > 0; k--) {
        if (stack[j + k] != s1[k]) {
          allMatches = false;
          break;
        }
      }
      if (allMatches) {
        matches++;
      } else {
        break;
      }
    }
    if (matches > 5) return s1;
  }
  return null;
}

Tetris dropTetris(Tetris t, List<Tetris> stack, List<Move> moveList) {
  int i = 0;
  while (i < 999) {
    Move currentMove = moveList[moveListIndex];
    (moveListIndex < moveList.length - 1) ? moveListIndex++ : moveListIndex = 0;
    t = updateTetris(t, currentMove, stack);
    Tetris temp = updateTetris(t, Move.down, stack);
    if (temp.position != t.position) {
      t = temp;
    } else {
      //print("\n");
      return t;
    }
    i++;
  }
  throw Exception("Movement overflow");
}

updateTetris(Tetris block, Move move, List<Tetris> stack) {
  bool collide = false;
  //printStack(stack, block: block);
  //print("Rock moved $move");
  Tetris temp = block.copyWith(
      position: Point((block.position.x + move.direction.x),
          block.position.y + move.direction.y));
  if (temp.boundingBox.left < 0 ||
      temp.boundingBox.right > 7 ||
      temp.boundingBox.top < 0) {
    //print(" |=> But nothing happens");
    return block;
  }
  for (Tetris t in stack) {
    if (t.boundingBox.intersects(temp.boundingBox)) {
      if (t.collide(temp)) collide = true;
    }
  }
  //if (collide) print(" |=> But nothing happens");
  return (collide) ? block : temp;
}

printStack(List<Tetris> stack, {Tetris? block}) {
  int height = max(getStackHeight(stack), block?.boundingBox.bottom ?? 0) + 2;
  List<List<String>> list =
  List.generate(height, (index) => List.generate(7, (index) => "."));
  for (Tetris tetris in ((block != null) ? [...stack, block] : stack)) {
    for (Point<int> point in tetris.shape) {
      Point<int> p = point + tetris.position;
      list[p.y][p.x] = list[p.y][p.x] == "#" ? "X" : "#";
    }
  }

  List<String> printList = [];
  for (List sublist in list.reversed) {
    printList.add("|${sublist.join("")}|");
  }
  printList.add("+-------+");
  String s = printList.join("\n");
  print(s);
}

class Tetris {
  final List<Point<int>> shape;
  Point<int> position;
  late Rectangle<int> boundingBox;

  Tetris({required this.shape, this.position = const Point(0, 0)}) {
    int maxX = 0;
    int maxY = 0;
    for (Point<int> point in shape) {
      if (point.x > maxX) maxX = point.x;
      if (point.y > maxY) maxY = point.y;
    }
    int x = position.x;
    int y = position.y;
    boundingBox = Rectangle.fromPoints(
        Point<int>(x + 0, y + 0), Point<int>(x + maxX + 1, y + maxY + 1));
  }

  List<Point<int>> absolutePoints() {
    List<Point<int>> list = [];
    for (Point<int> point in shape) {
      list.add(point + position);
    }
    return list;
  }

  bool collide(Tetris other) {
    List<Point<int>> abs = absolutePoints();
    List<Point<int>> absOther = other.absolutePoints();

    for (Point<int> p in abs) {
      for (Point<int> q in absOther) {
        if (p == q) return true;
      }
    }

    return false;
  }

  @override
  operator ==(Object other) {
    bool allEqual = false;
    if (other is Tetris && shape.length == other.shape.length) {
      allEqual = true;
      for (int i = 0; i < shape.length; i++) {
        if (shape[i] != other.shape[i]) allEqual = false;
      }
    }
    return allEqual;
  }

  @override
  String toString() {
    List<List<String>> l1 = List.generate(boundingBox.height,
            (index) => List.generate(boundingBox.width, (index) => "."));
    for (Point<int> p in shape) {
      l1[p.y][p.x] = "#";
    }
    List<String> l2 = [];
    for (List<String> l in l1) {
      l2.add(l.join(""));
    }
    return l2.join("\n");
  }

  copyWith({List<Point<int>>? shape, Point<int>? position}) {
    return Tetris(
        shape: shape ?? List.from(this.shape),
        position: position ?? this.position);
  }

  static Tetris nextBlock(int block) {
    switch (block % 5) {
      case 1:
        return Tetris(
            shape: [Point(0, 0), Point(1, 0), Point(2, 0), Point(3, 0)]);
      case 2:
        return Tetris(shape: [
          Point(1, 0),
          Point(0, 1),
          Point(1, 1),
          Point(2, 1),
          Point(1, 2)
        ]);
      case 3:
        return Tetris(shape: [
          Point(0, 0),
          Point(1, 0),
          Point(2, 0),
          Point(2, 1),
          Point(2, 2)
        ]);
      case 4:
        return Tetris(
            shape: [Point(0, 0), Point(0, 1), Point(0, 2), Point(0, 3)]);
      default:
        return Tetris(
            shape: [Point(0, 0), Point(1, 0), Point(1, 1), Point(0, 1)]);
    }
  }

  @override
  int get hashCode {
    int hash = 0;
    for (var p in shape) {
      hash += p.hashCode;
    }
    return hash;
  }
}

enum Move { left, right, down }

extension MovePoint on Move {
  Point<int> get direction {
    switch (this) {
      case Move.left:
        return Point(-1, 0);
      case Move.right:
        return Point(1, 0);
      case Move.down:
        return Point(0, -1);
    }
  }
}
