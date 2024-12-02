import 'dart:io';
import 'package:day10/day10.dart' as day10;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day10.longestPathSteps(input)}");
  print("Part 2: ${day10.enclosedTiles(input)}");
}
