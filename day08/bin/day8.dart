import 'dart:io';
import 'package:day8/day8.dart' as day8;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day8.minSteps(input)}");
  print("Part 2: ${day8.minSteps(input, asGhost: true)}");
}
