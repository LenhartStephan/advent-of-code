import 'dart:math';

int partNumberSum(String input, {bool forGearRatio = false}) {
  var (symbols, partNumbers) = parseSchematic(input);
  int sum = 0;
  for (var (Point<int> p, symbol) in symbols) {
    var touchingPartNumbers = partNumbers.where((e) =>
        e.$1.containsPoint(Point(p.x - 1, p.y)) ||
        e.$1.containsPoint(Point(p.x + 1, p.y)) ||
        e.$1.containsPoint(Point(p.x, p.y - 1)) ||
        e.$1.containsPoint(Point(p.x, p.y + 1)) ||
        e.$1.containsPoint(Point(p.x + 1, p.y + 1)) ||
        e.$1.containsPoint(Point(p.x + 1, p.y - 1)) ||
        e.$1.containsPoint(Point(p.x - 1, p.y - 1)) ||
        e.$1.containsPoint(Point(p.x - 1, p.y + 1)));
    if (forGearRatio) {
      if (symbol == "*" && touchingPartNumbers.length == 2) {
        sum += touchingPartNumbers.map((e) => e.$2).reduce((value, element) => value * element);
      }
    } else {
      sum += touchingPartNumbers.map((e) => e.$2).reduce((value, element) => value + element);
    }
  }
  return sum;
}

/// Returns the tuple of (1) the symbol and its position and (2) the list of numbers and their positions.
/// Example: [((Point(1,1), "*"), [Rectangle(1,1,0,2), 247])]
(List<(Point<int>, String)>, List<(Rectangle<int>, int)>) parseSchematic(String input) {
  List<(Point<int>, String)> symbols = [];
  List<(Rectangle<int>, int)> partNumbers = [];
  List<String> lines = input.split("\n");
  for (var MapEntry(key: lineNumber, value: line) in lines.asMap().entries) {
    int? potentialPartNumber;
    for (var MapEntry(key: charIndex, value: char) in line.split("").asMap().entries) {
      switch (char) {
        case ".":
          if (potentialPartNumber != null) {
            partNumbers.add((
              Rectangle.fromPoints(Point(lineNumber + 1, charIndex - (potentialPartNumber.toString().length - 1)),
                  Point(lineNumber + 1, charIndex)),
              potentialPartNumber
            ));
          }
          potentialPartNumber = null;
          break;
        case _ when int.tryParse(char) != null:
          potentialPartNumber = int.parse((potentialPartNumber?.toString() ?? "") + char);
          break;
        default:
          if (potentialPartNumber != null) {
            partNumbers.add((
              Rectangle.fromPoints(Point(lineNumber + 1, charIndex - (potentialPartNumber.toString().length - 1)),
                  Point(lineNumber + 1, charIndex)),
              potentialPartNumber
            ));
          }
          potentialPartNumber = null;
          symbols.add((Point(lineNumber + 1, charIndex + 1), char));
      }
    }
    if (potentialPartNumber != null) {
      partNumbers.add((
        Rectangle.fromPoints(Point(lineNumber + 1, line.length - (potentialPartNumber.toString().length - 1)),
            Point(lineNumber + 1, line.length)),
        potentialPartNumber
      ));
    }
  }
  return (symbols, partNumbers);
}
