import 'dart:io';

void main() async {
  String input = """30373
25512
65332
33549
35390
""";

  try {
    input = File("day08.input").readAsStringSync();
  } catch (e) {}

  List<List<int>> grid = toGridList(input.trim());
  int result1 = getVisibleCount(grid);
  print("Part 1: $result1");

  int result2 = getMaxScenicScore(grid);
  print("Part 2: $result2");
}

List<List<int>> toGridList(String input) {
  List<String> columns = input.split("\n");
  return List<List<int>>.from(columns
      .map((e) => List<int>.from(e.split("").map<int>((e) => int.parse(e)))));
}

int getVisibleCount(List<List<int>> grid) {
  int counter = 0;
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      if (isVisible(grid, x: x, y: y)) counter++;
    }
  }
  return counter;
}

int getMaxScenicScore(List<List<int>> grid) {
  int maxScore = 0;
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      int score = getScenicScore(grid, x: x, y: y);
      if (score > maxScore) maxScore = score;
    }
  }
  return maxScore;
}

/// Returns whether the tree a [x],[y] is visible from at least one side.
bool isVisible(List<List<int>> grid, {required int x, required int y}) {
  int selected = grid[x][y];

  List<int> sublistL = getSublist(grid, direction: Direction.left, x: x, y: y);
  bool left = visibleInRow(selected, sublistL);
  if (left) return true;

  List<int> sublistR = getSublist(grid, direction: Direction.right, x: x, y: y);
  bool right = visibleInRow(selected, sublistR);
  if (right) return true;

  List<int> sublistT = getSublist(grid, direction: Direction.top, x: x, y: y);
  bool top = visibleInRow(selected, sublistT);
  if (top) return true;

  List<int> sublistB =
  getSublist(grid, direction: Direction.bottom, x: x, y: y);
  bool bottom = visibleInRow(selected, sublistB);
  if (bottom) return true;
  return false;
}

enum Direction { top, bottom, left, right }

List<int> getSublist(List<List<int>> grid,
    {required Direction direction, required int x, required int y}) {
  switch (direction) {
    case Direction.top:
      return List.from(grid[x].sublist(0, y));
    case Direction.bottom:
      return List.from(grid[x].sublist(y + 1, grid.first.length));
    case Direction.left:
      return List.from(grid.sublist(0, x).map((e) => e[y]));
    case Direction.right:
      return List.from(grid.sublist(x + 1, grid.length).map((e) => e[y]));
  }
}

int getScenicScore(List<List<int>> grid, {required int x, required int y}) {
  int element = grid[x][y];
  int scoreLeft = getVisibleTrees(
      element,
      List.from(
          getSublist(grid, direction: Direction.left, x: x, y: y).reversed));
  int scoreRight = getVisibleTrees(
      element, getSublist(grid, direction: Direction.right, x: x, y: y));
  int scoreTop = getVisibleTrees(
      element,
      List.from(
          getSublist(grid, direction: Direction.top, x: x, y: y).reversed));
  int scoreBottom = getVisibleTrees(
      element, getSublist(grid, direction: Direction.bottom, x: x, y: y));
  return scoreLeft * scoreRight * scoreBottom * scoreTop;
}

/// Returns whether [element] is larger than all [others]
bool visibleInRow(int element, List<int> others) =>
    others.every((other) => other < element);

// Returns the number of trees visible from left to right
int getVisibleTrees(int element, List<int> trees) {
  if (trees.length > 1) {
    int count = 1;
    for (int i = 0; i < (trees.length - 1); i++) {
      if (trees[i] < element) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }
  return trees.length;
}
