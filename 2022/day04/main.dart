import 'dart:io';

void main() async {
  String input = """2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""";

  try {
    input = File("day04.input").readAsStringSync();
  } catch (e) {}

  int sum = getFullyContainedAssignments(input);
  print("Part 1: $sum");
  int sum2 = getHasOverlap(input);
  print("Part 2: $sum2");
}

int getFullyContainedAssignments(String input) {
  List<String> pairs = input.split("\n");
  if (pairs.last.isEmpty) pairs.removeLast();
  int redundants = 0;
  for (var pair in pairs) {
    List<Set<int>> sets = pairToSet(pair);
    if (isFullyContained(sets[0], sets[1])) redundants++;
  }
  return redundants;
}

int getHasOverlap(String input) {
  List<String> pairs = input.split("\n");
  if (pairs.last.isEmpty) pairs.removeLast();
  int overlaps = 0;
  for (var pair in pairs) {
    List<Set<int>> sets = pairToSet(pair);
    if (hasOverlap(sets[0], sets[1])) overlaps++;
  }
  return overlaps;
}

List<Set<int>> pairToSet(String pair) {
  List<String> pairs = pair.split(",");
  List<Set<int>> setList = [];
  for (String item in pairs) {
    List<String> numbers = item.split("-");
    Set<int> numSet = {};
    for (int i = int.parse(numbers.first); i <= int.parse(numbers.last); i++) {
      numSet.add(i);
    }
    setList.add(numSet);
  }
  return setList;
}

bool isFullyContained(Set<int> a, Set<int> b) {
  return b.containsAll(a) || a.containsAll(b);
}

bool hasOverlap(Set<int> a, Set<int> b) {
  return a
      .intersection(b)
      .isNotEmpty;
}
