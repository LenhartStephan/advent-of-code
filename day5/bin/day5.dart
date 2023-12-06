import 'dart:io';
import 'package:day5/day5.dart' as day5;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day5.findLowestLocationNumber(input)}");
  print("Part 2: ${day5.findLowestLocationNumber(input, withSeedRange: true)}");
}
