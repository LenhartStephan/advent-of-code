import 'dart:math';

int shortestPathSums(String input, {int growFactor = 1}) {
  List<List<String>> grid = input.split("\n").map((e) => e.split("")).toList();
  var (growRowIndices, growColumnIndices) = growUniverseIndices(grid);
  if (growFactor > 1) growFactor--;

  List<Point<int>> galaxyCords = [];
  for (var (y, row) in grid.indexed) {
    for (var (x, field) in row.indexed) {
      if (field == "#") {
        galaxyCords.add(Point(x + growColumnIndices.where((e) => e < x).length * growFactor,
            y + growRowIndices.where((e) => e < y).length * growFactor));
      }
    }
  }

  int sum = 0;
  for (int i = 0; i < galaxyCords.length; i++) {
    for (int j = i; j < galaxyCords.length; j++) {
      sum += manhattenDistance(galaxyCords[i], galaxyCords[j]);
    }
  }
  return sum;
}

(List<int>, List<int>) growUniverseIndices(List<List<String>> grid, {int fillSize = 1}) {
  List<int> rows = [];
  List<int> columns = [];
  for (int y = 0; y < grid.length; y++) {
    if (grid[y].every((element) => element == ".")) {
      rows.add(y);
    }
  }
  for (int x = 0; x < grid[0].length; x++) {
    List<String> column = List.generate(grid.length, (row) => grid[row][x]);
    if (column.every((element) => element == ".")) {
      columns.add(x);
    }
  }
  return (rows, columns);
}

int manhattenDistance(Point<int> a, Point<int> b) => ((a.x - b.x).abs() + (a.y - b.y).abs());
