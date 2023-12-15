import 'dart:io';
import 'package:day14/day14.dart' as day14;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day14.getLoad(input)}");
  print("Part 2: ${day14.getLoad(input, withCycles: true)}");
}
