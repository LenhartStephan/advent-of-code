import 'dart:io';
import 'package:day1/day1.dart' as day1;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day1.calibrationSum(input)}");
  print("Part 2: ${day1.calibrationSum(input, withSpelledDigits: true)}");
}
