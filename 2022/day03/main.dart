import 'dart:io';

void main() async {
  String input = """vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""";

  try {
    input = File("day03.input").readAsStringSync();
  } catch (e) {}

  int sum = getPrioritySumFromRucksacks(input);
  print("Part 1: $sum");
  int sum2 = getBadgeSumFromRucksacks(input);
  print("Part 2: $sum2");
}

int getPrioritySumFromRucksacks(String rucksacks) {
  List<String> rucksackList = rucksacks.split("\n");
  int sum = 0;
  for (String rucksack in rucksackList) {
    if (rucksack.isNotEmpty) {
      List<String> compartments = getCompartmentsFromRucksack(rucksack);
      String item = findMatchingItem(compartments.first, compartments.last);
      sum += getPriorityFromItem(item);
    }
  }
  return sum;
}

int getBadgeSumFromRucksacks(String rucksacks) {
  List<String> rucksackList = rucksacks.split("\n");
  rucksackList.removeLast();
  int sum = 0;

  for (int i = 0; i < rucksackList.length; i += 3) {
    String commonBadge = getBadgeFromElfGroup(
        [rucksackList[i], rucksackList[i + 1], rucksackList[i + 2]]);
    sum += getPriorityFromItem(commonBadge);
  }

  return sum;
}

String getBadgeFromElfGroup(List<String> elfGroup) {
  Set<String> commonElements = elfGroup.first.split("").toSet();
  for (var elf in elfGroup) {
    Set s = elf.split("").toSet();
    commonElements = commonElements.intersection(s);
  }
  return commonElements.first;
}

List<String> getCompartmentsFromRucksack(String rucksack) {
  return [
    rucksack.substring(0, (rucksack.length ~/ 2)),
    rucksack.substring((rucksack.length ~/ 2))
  ];
}

String findMatchingItem(String first, String second) {
  List<String> split1 = first.split("");
  List<String> split2 = second.split("");

  for (String item in split1) {
    if (split2.contains(item)) {
      return item;
    }
  }
  throw Exception("No matches within $first and $second");
}

int getPriorityFromItem(String item) {
  String proirityIndex = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  int priority = (proirityIndex.indexOf(item) + 1);
  if (priority < 1) throw Exception("$item is not a valid Input");
  return priority;
}
