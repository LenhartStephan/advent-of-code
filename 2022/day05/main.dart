import 'dart:io';

void main() async {
  String input = """    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""";

  try {
    input = File("day05.input").readAsStringSync();
  } catch (e) {}

  String part1 = getTopStacks(rearrangementProcedure(input));
  print("Part 1: $part1");
  String part2 =
  getTopStacks(rearrangementProcedure(input, isCreateMover9001: true));
  print("Part 2: $part2");
}

String getTopStacks(List<List<String>> stacks) {
  List<String> tops = [];
  for (List<String> stack in stacks) {
    tops.add(stack.first);
  }
  return tops.join();
}

List<List<String>> rearrangementProcedure(String input,
    {bool isCreateMover9001 = false}) {
  List<String> parts = input.split("\n\n");
  List<List<String>> stacks = getStacks(parts.first);

  List<String> steps = parts.last.split("\n");
  for (String step in steps) {
    if (step.isNotEmpty) {
      stacks = makeMove(stacks, step, isCreateMover9001: isCreateMover9001);
    }
  }

  return stacks;
}

List<List<String>> getStacks(String input) {
  List<String> splits = input.split("\n");
  List<List<String>> stacks = [];
  for (int i = 0; i < splits.first.length; i += 4) {
    stacks.add([]);
  }
  for (String split in splits) {
    int stackNumber = 0;
    if (split.contains("[")) {
      for (var i = 0; i < split.length; i += 4) {
        String stackItem = split.substring(i + 1, i + 2);
        if (stackItem
            .trim()
            .isNotEmpty) stacks[stackNumber].add(stackItem);
        stackNumber++;
      }
    } else {
      break;
    }
  }
  return stacks;
}

List<List<String>> makeMove(List<List<String>> stacks, String moveAction,
    {bool isCreateMover9001 = false}) {
  List<String> splits = moveAction.split(" ");

  int moveCounter = int.parse(splits[1]);
  int fromIndex = int.parse(splits[3]) - 1;
  int toIndex = int.parse(splits[5]) - 1;

  List<String> movingCrates = stacks[fromIndex].sublist(0, moveCounter);

  stacks[toIndex]
      .insertAll(0, isCreateMover9001 ? movingCrates : movingCrates.reversed);
  stacks[fromIndex].removeRange(0, moveCounter);
  return stacks;
}
