import 'dart:io';
import 'package:day4/day4.dart' as day4;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day4.cardValue(input)}");
  print("Part 2: ${day4.cardValue(input, withCardMultiplier: true)}");
}
