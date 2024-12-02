import 'dart:io';
import 'package:day13/day13.dart' as day13;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day13.reflectionSum(input)}");
  print("Part 2: ${day13.reflectionSum(input, errorTolerance: 1)}");
}
