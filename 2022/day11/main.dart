import 'dart:io';
import 'monkey.dart';

void main() async {
  String input = """Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
""";

  try {
    input = File("day11.input").readAsStringSync();
  } catch (e) {}

  int part1 = getMonkeyBusinessLevel(getMonkeyList(input), rounds: 20);
  print("Part 1: $part1");

  var monkeys = getMonkeyList(input);
  int moduloProduct = 1;
  for (var monkey in monkeys) {
    moduloProduct *= monkey.modulo;
  }
  int part2 = getMonkeyBusinessLevel(monkeys,
      rounds: 10000, withRelief: false, moduloProduct: moduloProduct);
  print("Part 2: $part2");
}

List<Monkey> getMonkeyList(String input) {
  List<String> monkeyStrings = input.split("\n\n");
  List<Monkey> monkeys = [];
  for (String monkeyString in monkeyStrings) {
    List<String> splits = monkeyString.split("\n");
    List<int> items = List.from(splits[1]
        .trim()
        .replaceFirst("Starting items: ", "")
        .split(", ")
        .map((e) => int.parse(e)));
    String operation = splits[2].trim().replaceFirst("Operation: new = ", "");
    List<String> operationParts = operation.split(" ");

    int test =
    int.parse(splits[3].trim().replaceFirst("Test: divisible by ", ""));
    int monkeyTrue = int.parse(
        splits[4].trim().replaceFirst("If true: throw to monkey ", ""));
    int monkeyFalse = int.parse(
        splits[5].trim().replaceFirst("If false: throw to monkey ", ""));
    monkeys.add(Monkey(
        items: items,
        updateWorry: (old) {
          if (operationParts.length == 3) {
            int first = int.tryParse(operationParts[0]) ?? old;
            int second = int.tryParse(operationParts[2]) ?? old;
            switch (operationParts[1]) {
              case "+":
                return first + second;
              case "-":
                return first - second;
              case "*":
                return first * second;
              case "/":
                return (first / second).floor();
            }
            throw Exception("Could not build worry function");
          }
          return old;
        },
        modulo: test,
        throwTarget: (value) => value % test == 0 ? monkeyTrue : monkeyFalse));
  }
  return monkeys;
}

List<Monkey> runRound(List<Monkey> monkeys,
    {bool withRelief = true, int moduloProduct = 1}) {
  for (Monkey monkey in monkeys) {
    for (int item in monkey.items) {
      item = monkey.updateWorry(item);
      monkey.inspection++;
      item = withRelief ? (item / 3).floor() : (item % moduloProduct);
      int monkeyId = monkey.throwTarget(item);
      monkeys[monkeyId].items.add(item);
    }
    monkey.items = [];
  }
  return monkeys;
}

int getMonkeyBusinessLevel(List<Monkey> monkeys,
    {int rounds = 20, bool withRelief = true, int moduloProduct = 1}) {
  for (int round = 1; round <= rounds; round++) {
    monkeys =
        runRound(monkeys, withRelief: withRelief, moduloProduct: moduloProduct);
  }
  int max1 = 0;
  int max2 = 0;
  for (Monkey monkey in monkeys) {
    if (monkey.inspection > max1) {
      max2 = max1;
      max1 = monkey.inspection;
    } else if (monkey.inspection > max2) {
      max2 = monkey.inspection;
    }
  }
  return max1 * max2;
}
