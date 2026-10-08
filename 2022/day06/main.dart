import 'dart:io';

void main() async {
  String input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw";

  try {
    input = File("day6.input").readAsStringSync();
  } catch (e) {}

  int part1 = getFirstUniqueSectionEnd(input);
  print("Part 1: $part1");
  int part2 = getFirstUniqueSectionEnd(input, sectionLength: 14);
  print("Part 2: $part2");
}

int getFirstUniqueSectionEnd(String input, {int sectionLength = 4}) {
  List<String> splits = input.split("");
  for (int i = 0; (i + sectionLength) < splits.length; i++) {
    if (isAllDifferent(splits.getRange(i, i + sectionLength).join())) {
      return i + sectionLength;
    }
  }
  return -1;
}

bool isAllDifferent(String input) =>
    (input
        .split("")
        .toSet()
        .length == input.length);
