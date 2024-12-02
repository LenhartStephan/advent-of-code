import 'dart:io';
import 'package:day11/day11.dart' as day11;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day11.shortestPathSums(input)}");
  print("Part 2: ${day11.shortestPathSums(input, growFactor: 1000000)}");
}
