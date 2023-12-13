import 'dart:io';
import 'package:day2/day2.dart' as day2;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day2.possibleGames(input)}");
  print("Part 2: ${day2.minPossibleGames(input)}");
}
