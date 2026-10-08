import 'dart:io';

void main() async {
  String input = """addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
""";

  try {
    input = File("day10.input").readAsStringSync();
  } catch (e) {}

  List<int> registerLog = runProgram(toCommandList(input));
  int signal = getSignalStrength(registerLog);
  print("Part 1: $signal");

  print("Part 2:");
  print(drawImage(registerLog));
}

List<String> toCommandList(String input) {
  List<String> commands = input.split("\n");
  if (commands.last.isEmpty) commands.removeLast();
  return commands;
}

List<int> runProgram(List<String> commands) {
  int register = 1;
  List<String> cycleCommands = commandsToCycleCommands(commands);
  List<int> registerLog = [register];
  for (String cycle in cycleCommands) {
    register = runCycle(cycle, register);
    registerLog.add(register);
  }
  return registerLog;
}

int runCycle(String command, int register) {
  List<String> split = command.split(" ");
  switch (split.first) {
    case "addx":
      return register += int.parse(split.last);
    case "noop":
      return register;
  }
  return register;
}

List<String> commandsToCycleCommands(List<String> commands) {
  List<String> cycleCommands = [];
  for (String command in commands) {
    List<String> split = command.split(" ");
    switch (split.first) {
      case "addx":
        cycleCommands.add("noop");
        cycleCommands.add(split.join(" "));
        break;
      case "noop":
        cycleCommands.add("noop");
        break;
    }
  }
  return cycleCommands;
}

int getSignalStrength(List<int> registerLog) {
  int signal = 0;
  for (int i = 20; i < registerLog.length; i += 40) {
    signal += registerLog[i - 1] * (i);
  }
  return signal;
}

String drawImage(List<int> registerLog) {
  String image = "";
  for (int i = 1; i < registerLog.length; i++) {
    int register = registerLog[i - 1];
    int pointer = (i % 40 == 0) ? 40 : i % 40;
    bool onSprite = pointer == register ||
        pointer == register + 1 ||
        pointer == register + 2;
    image += (onSprite) ? "#" : " ";
    if (i % 40 == 0 && i != 0 && ((i + 1) < registerLog.length)) image += "\n";
  }
  return image;
}
