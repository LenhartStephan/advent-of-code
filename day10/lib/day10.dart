import 'dart:math';

int longestPathSteps(String input) {
  return (getLoopPoints(input).length / 2).floor();
}

List<Point<int>> getLoopPoints(String input) {
  final List<List<String>> grid = input.split("\n").map((e) => e.split("")).toList();
  var (Point<int> startPos, String startReplace) = getHiddenStartTile(grid);
  grid[startPos.y][startPos.x] = startReplace;
  Point<int> next = Point(startPos.x, startPos.y);
  List<Point<int>> visited = [next];
  next = nextPoint(grid, next);
  visited.add(next);
  while (next != startPos) {
    next = nextPoint(grid, visited[visited.length - 1], last: visited[visited.length - 2]);
    visited.add(next);
  }
  return visited;
}

Point<int> nextPoint(List<List<String>> grid, Point<int> current, {Point<int>? last}) {
  bool inFromTop = (last?.y ?? current.y) < current.y;
  bool inFromLeft = (last?.x ?? current.x) < current.x;
  bool inFromRight = (last?.x ?? current.x) > current.x;

  switch (grid[current.y][current.x]) {
    case "|": // ║
      return Point(current.x, current.y + (inFromTop ? 1 : -1));
    case "-": // ═
      return Point(current.x + (inFromLeft ? 1 : -1), current.y);
    case "L": // ╚
      return inFromRight ? Point(current.x, current.y - 1) : Point(current.x + 1, current.y);
    case "J": // ╝
      return inFromLeft ? Point(current.x, current.y - 1) : Point(current.x - 1, current.y);
    case "7": // ╗
      return inFromLeft ? Point(current.x, current.y + 1) : Point(current.x - 1, current.y);
    case "F": // ╔
      return inFromRight ? Point(current.x, current.y + 1) : Point(current.x + 1, current.y);
  }
  throw StateError("Current tile does not match any pipe type");
}

(Point<int>, String) getHiddenStartTile(List<List<String>> grid) {
  int sY = grid.indexWhere((element) => element.contains("S"));
  int sX = grid[sY].indexOf("S");
  bool conncetedTop = (sY - 1) >= 0 && (["|", "7", "F"].contains(grid[sY - 1][sX]));
  bool conncetedBottom = (sY + 1) < grid.length && (["|", "L", "J"].contains(grid[sY + 1][sX]));
  bool conncetedLeft = sX - 1 >= 0 && (["-", "L", "F"].contains(grid[sY][sX - 1]));
  return (
    Point(sX, sY),
    conncetedTop
        ? conncetedBottom
            ? "|"
            : conncetedLeft
                ? "J"
                : "L"
        : conncetedLeft && conncetedBottom
            ? "7"
            : conncetedLeft
                ? "-"
                : "F"
  );
}

int enclosedTiles(String input) {
  final List<List<String>> grid = input.split("\n").map((e) => e.split("")).toList();
  List<Point<int>> points = getLoopPoints(input);
  var (Point<int> startPos, String startReplace) = getHiddenStartTile(grid);
  grid[startPos.y][startPos.x] = startReplace;
  int enclosed = 0;
  for (var (y, row) in grid.indexed) {
    int rowBorders = 0;
    bool onPipeF = false;
    bool onPipeL = false;
    for (var (x, tile) in row.indexed) {
      if (points.contains(Point(x, y))) {
        switch (tile) {
          case "|":
            rowBorders++;
          case "L":
            onPipeL = true;
            rowBorders++;
          case "F":
            onPipeF = true;
            rowBorders++;
          case "J":
            if (!onPipeF) rowBorders++;
            onPipeF = false;
            onPipeL = false;
          case "7":
            if (!onPipeL) rowBorders++;
            onPipeF = false;
            onPipeL = false;
        }
      } else if (rowBorders.isOdd) {
        enclosed++;
      }
    }
  }
  return enclosed;
}
