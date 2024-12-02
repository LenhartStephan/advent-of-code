int getLoad(String input, {bool withCycles = false}) {
  List<List<String>> grid = input.split("\n").map((e) => e.split("")).toList();

  if (withCycles) {
    List<int> lastLoads = [];
    int targetCycleCount = 1000000000 - 1;

    for (int cycle = 0; cycle < targetCycleCount; cycle++) {
      for (int rotation = 0; rotation < 4; rotation++) {
        grid = simulateFall(List.from(grid));
        grid = rotate(grid);
      }

      if (lastLoads.length < 200) {
        lastLoads.add(currentLoad(grid));
      } else {
        lastLoads[cycle % 200] = currentLoad(grid);
        int? cycleLength = getCycleLength(lastLoads);
        if (cycleLength != null) {
          return lastLoads[(lastLoads.length - 1) - (cycleLength - ((targetCycleCount - cycle) % cycleLength))];
        }
      }
    }
  } else {
    grid = simulateFall(List.from(grid));
  }

  return currentLoad(grid);
}

int currentLoad(List<List<String>> grid) {
  int load = 0;
  for (var (index, line) in grid.indexed) {
    int rockCount = line.where((element) => element == "O").length;
    load += (grid.length - index) * rockCount;
  }
  return load;
}

List<List<String>> simulateFall(List<List<String>> grid) {
  for (int y = 0; y < grid.length; y++) {
    for (int x = 0; x < grid.first.length; x++) {
      if (grid[y][x] == "O" && (y - 1) >= 0 && grid[y - 1][x] == ".") {
        int above = y - 1;
        while ((above - 1) >= 0 && grid[above - 1][x] == ".") {
          above--;
        }
        grid[y][x] = ".";
        grid[above][x] = "O";
      }
    }
  }
  return grid;
}

List<List<String>> rotate(List<List<String>> grid) {
  List<List<String>> out = List.generate(grid.first.length, (_) => List.filled(grid.length, ""));
  for (int y = 0; y < grid.length; y++) {
    for (int x = 0; x < grid[y].length; x++) {
      out[x][grid.length - 1 - y] = grid[y][x];
    }
  }
  return out;
}

int? getCycleLength(List<int> values) {
  int maxCycleLength = values.length ~/ 2;
  for (int cycleLength = 1; cycleLength <= maxCycleLength; cycleLength++) {
    bool cycleFound = true;
    for (int i = 0; i < values.length - cycleLength; i++) {
      if (values[i] != values[i + cycleLength]) {
        cycleFound = false;
        break;
      }
    }
    if (cycleFound) return cycleLength;
  }

  return null;
}
