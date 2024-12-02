import 'dart:io';
import 'package:day15/day15.dart' as day15;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day15.hashSum(input)}");
  print("Part 2: ${day15.hashmapSum(input)}");
}
