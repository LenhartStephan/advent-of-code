int reflectionSum(String input, {int errorTolerance = 0}) {
  List<List<List<String>>> mirrorImages =
      input.split("\n\n").map((e) => e.split("\n").map((e) => e.split("")).toList()).toList();
  int sum = 0;

  for (List<List<String>> image in mirrorImages) {
    int? mirrorValue;
    for (int i = 1; i < image.first.length; i++) {
      if (columnsEqual(image, i - 1, i, errorTolerance: errorTolerance) &&
          checkCandidate(image, i - 1, horizontal: false, errorTolerance: errorTolerance)) {
        mirrorValue = i;
        break;
      }
    }

    for (int i = 1; i < image.length; i++) {
      if (rowsEqual(image, i - 1, i, errorTolerance: errorTolerance) &&
          checkCandidate(image, i - 1, errorTolerance: errorTolerance)) {
        if (mirrorValue == null || mirrorValue > i) {
          mirrorValue = i * 100;
        }
        break;
      }
    }
    sum += mirrorValue ?? 0;
  }

  return sum;
}

bool checkCandidate(List<List<String>> grid, int lowerBorder, {bool horizontal = true, int errorTolerance = 0}) {
  int c = 0;
  while (lowerBorder - c >= 0 && lowerBorder + 1 + c < (horizontal ? grid.length : grid.first.length)) {
    if (!(horizontal
        ? rowsEqual(grid, lowerBorder - c, lowerBorder + 1 + c)
        : columnsEqual(grid, lowerBorder - c, lowerBorder + 1 + c))) {
      if (errorTolerance == 0) {
        return false;
      } else {
        errorTolerance--;
      }
    }
    c++;
  }

  return errorTolerance == 0;
}

bool columnsEqual(List<List<String>> grid, int column1, int column2, {int errorTolerance = 0}) {
  for (int i = 0; i < grid.length; i++) {
    if (grid[i][column1] != grid[i][column2]) {
      if (errorTolerance == 0) {
        return false;
      } else {
        errorTolerance--;
      }
    }
  }
  return true;
}

bool rowsEqual(List<List<String>> grid, int column1, int column2, {int errorTolerance = 0}) {
  for (int i = 0; i < grid[column1].length; i++) {
    if (grid[column1][i] != grid[column2][i]) {
      if (errorTolerance == 0) {
        return false;
      } else {
        errorTolerance--;
      }
    }
  }
  return true;
}
