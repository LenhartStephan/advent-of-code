import 'dart:io';
import 'package:day18/day18.dart' as day18;

void main(List<String> arguments) async {
  File inputFile = File("input.txt");
  String input = inputFile.readAsStringSync().trim();

  print("Part 1: ${day18.lagoonVolume(input)}");
  print("Part 2: ${day18.lagoonVolume(input, withHex: true)}");
}
