import 'dart:io';
import 'package:day6/day6.dart' as day6;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day6.calculate(input)}");
  print("Part 2: ${day6.calculate(input, badKerning: true)}");
}
