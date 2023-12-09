import 'dart:io';
import 'package:day9/day9.dart' as day9;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day9.extrapolationSum(input)}");
  print("Part 2: ${day9.extrapolationSum(input, reversed: true)}");
}
