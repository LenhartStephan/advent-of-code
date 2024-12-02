import 'dart:io';
import 'package:day7/day7.dart' as day7;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day7.winningSum(input)}");
  print("Part 2: ${day7.winningSum(input, withJoker: true)}");
}
