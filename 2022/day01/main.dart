import 'dart:io';

void main() async {
  String input = """1000
2000
3000

4000

5000
6000

7000
8000
9000

10000""";

  try {
    input = File("day01.input").readAsStringSync();
  } catch (e) {}

  List l = toElvesList(input);
  l.sort();
  int first = (l.reversed.toList())[0];
  int second = (l.reversed.toList())[1];
  int third = (l.reversed.toList())[2];
  print("Part 1: $first");
  print("Part 2: ${first + second + third}");
}

List<int> toElvesList(String input) {
  List<String> splits = input.split("\n");
  List<int> elves = [];

  int currentElv = 0;
  for (int i = 0; i < splits.length; i++) {
    String cSplit = splits[i];
    if (cSplit.isEmpty) {
      elves.add(currentElv);
      currentElv = 0;
    } else {
      currentElv += int.parse(cSplit);
    }
  }
  elves.add(currentElv);
  return elves;
}
