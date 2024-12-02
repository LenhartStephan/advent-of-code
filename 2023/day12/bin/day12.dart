import 'dart:io';
import 'package:day12/day12.dart' as day12;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day12.combinationSum(input)}");
  print("Part 2: ${day12.combinationSum(input, folded: true)}");
}
