import 'dart:io';
import 'package:day3/day3.dart' as day3;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day3.partNumberSum(input)}");
  print("Part 2: ${day3.partNumberSum(input, forGearRatio: true)}");
}
