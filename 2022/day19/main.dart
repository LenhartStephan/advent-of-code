import 'dart:math';
import 'dart:io';
import 'dart:collection';

void main() async {
  String input =
  """Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
""";

  try {
    input = File("day19.input").readAsStringSync();
  } catch (e) {}

  int part1 = getQualityLevel(getBlueprints(input));
  print("Part 1: $part1");

  print("Part 2: TODO");
}

List<Blueprint> getBlueprints(String input) {
  List<String> splits = input.split("\n");
  if (splits.last
      .trim()
      .isEmpty) splits.removeLast();
  List<Blueprint> blueprints = [];
  for (String s in splits) {
    blueprints.add(Blueprint.fromString(s));
  }
  return blueprints;
}

int getQualityLevel(List<Blueprint> blueprints) {
  int quality = 0;
  int i = 1;
  for (Blueprint blueprint in blueprints) {
    print("${i++}/${blueprints.length}");
    quality += maxGeodes(blueprint) * blueprint.id;
  }
  return quality;
}

int maxGeodes(Blueprint blueprint, {int minutes = 24}) {
  Queue queue = Queue.from([State.init(minutes: minutes)]);
  Queue bestStates = Queue();
  List<State> visited = [];

  void addState(State state) {
    if (!visited.contains(state)) {
      for (State s in bestStates) {
        if (s.objectivlyBetterThan(state)) return;
      }
      bestStates.add(state);
      if (bestStates.length > 1000) bestStates.removeFirst();
      queue.add(state);
    }
  }

  int best = 0;
  while (queue.isNotEmpty) {
    final State current = queue.removeFirst();
    final State tick = current.tick();
    int nextStates = 0;
    if (tick.minutes == 0) {
      best = max(tick.geodes, best);
      continue;
    }

    if (current.ore >= blueprint.oreForGeodeRobot &&
        current.obsidian >= blueprint.obsidianForGeodeRobot) {
      addState(tick.copyWith(
        ore: tick.ore - blueprint.oreForGeodeRobot,
        obsidian: tick.obsidian - blueprint.obsidianForGeodeRobot,
        geodeRobots: tick.geodeRobots + 1,
      ));
      nextStates++;
    } else {
      if (current.ore >= blueprint.oreForObsidianRobot &&
          current.clay >= blueprint.clayForObsidianRobot &&
          current.obsidianRobots <= blueprint.maxObsidian) {
        addState(tick.copyWith(
          ore: tick.ore - blueprint.oreForObsidianRobot,
          clay: tick.clay - blueprint.clayForObsidianRobot,
          obsidianRobots: tick.obsidianRobots + 1,
        ));
        nextStates++;
      }
      if (current.ore >= blueprint.oreForOreRobot &&
          current.oreRobots <= blueprint.maxOre) {
        addState(tick.copyWith(
            ore: tick.ore - blueprint.oreForOreRobot,
            oreRobots: tick.oreRobots + 1));
        nextStates++;
      }
      if (current.ore >= blueprint.oreForClayRobot &&
          current.clayRobots <= blueprint.maxClay) {
        addState(tick.copyWith(
            ore: tick.ore - blueprint.oreForClayRobot,
            clayRobots: tick.clayRobots + 1));
        nextStates++;
      }
      if (nextStates != 4) addState(tick);
    }
  }
  return best;
}

List<State> nextSteps(State state, Blueprint blueprint) {
  State s = state.tick();
  List<State> states = [];

  if (state.ore > blueprint.oreForOreRobot &&
      state.oreRobots < blueprint.maxOre &&
      state.oreRobots * state.minutes + state.ore <
          state.minutes * blueprint.maxOre) {
    states.add(s.copyWith(
        ore: s.ore - blueprint.oreForOreRobot, oreRobots: s.oreRobots + 1));
  }
  if (state.ore > blueprint.oreForClayRobot &&
      state.clayRobots < blueprint.maxClay &&
      state.clayRobots * state.minutes + state.clay <
          state.minutes * blueprint.maxClay) {
    states.add(s.copyWith(
        ore: s.ore - blueprint.oreForClayRobot, clayRobots: s.clayRobots + 1));
  }
  if (state.ore > blueprint.oreForObsidianRobot &&
      state.clay > blueprint.clayForObsidianRobot &&
      state.obsidianRobots < blueprint.maxObsidian) {
    states.add(s.copyWith(
        ore: s.ore - blueprint.oreForObsidianRobot,
        clay: s.clay - blueprint.clayForObsidianRobot,
        obsidianRobots: s.obsidianRobots + 1));
  }
  if (state.ore > blueprint.oreForGeodeRobot &&
      state.obsidian > blueprint.obsidianForGeodeRobot) {
    states.add(s.copyWith(
      ore: s.ore - blueprint.oreForGeodeRobot,
      obsidian: s.obsidian - blueprint.obsidianForGeodeRobot,
      geodeRobots: s.geodeRobots + 1,
    ));
  }
  if (states.length < 4) states.add(s);
  return states;
}

class Blueprint {
  final int id;
  final int oreForOreRobot;
  final int oreForClayRobot;
  final int oreForObsidianRobot;
  final int clayForObsidianRobot;
  final int oreForGeodeRobot;
  final int obsidianForGeodeRobot;

  final int maxOre;
  final int maxClay;
  final int maxObsidian;

  Blueprint({
    required this.id,
    required this.oreForOreRobot,
    required this.oreForClayRobot,
    required this.oreForObsidianRobot,
    required this.clayForObsidianRobot,
    required this.oreForGeodeRobot,
    required this.obsidianForGeodeRobot,
  })
      : maxOre = max(oreForOreRobot,
      max(oreForClayRobot, max(oreForObsidianRobot, oreForGeodeRobot))),
        maxClay = clayForObsidianRobot,
        maxObsidian = obsidianForGeodeRobot;

  factory Blueprint.fromString(String input) {
    Iterable<RegExpMatch> matches = RegExp(r"(\d)+").allMatches(input);
    return Blueprint(
        id: int.parse(matches.elementAt(0).group(0)!),
        oreForOreRobot: int.parse(matches.elementAt(1).group(0)!),
        oreForClayRobot: int.parse(matches.elementAt(2).group(0)!),
        oreForObsidianRobot: int.parse(matches.elementAt(3).group(0)!),
        clayForObsidianRobot: int.parse(matches.elementAt(4).group(0)!),
        oreForGeodeRobot: int.parse(matches.elementAt(5).group(0)!),
        obsidianForGeodeRobot: int.parse(matches.elementAt(6).group(0)!));
  }

  @override
  operator ==(Object other) =>
      other is Blueprint &&
          other.id == id &&
          other.oreForOreRobot == oreForOreRobot &&
          other.oreForClayRobot == oreForClayRobot &&
          other.oreForObsidianRobot == oreForObsidianRobot &&
          other.clayForObsidianRobot == clayForObsidianRobot &&
          other.oreForGeodeRobot == oreForGeodeRobot &&
          other.obsidianForGeodeRobot == obsidianForGeodeRobot;

  @override
  int get hashCode =>
      id.hashCode +
          oreForOreRobot.hashCode +
          oreForClayRobot.hashCode +
          oreForObsidianRobot.hashCode +
          clayForObsidianRobot.hashCode +
          oreForGeodeRobot.hashCode +
          obsidianForGeodeRobot.hashCode;

  @override
  String toString() {
    return "Blueprint(id: $id, oreForOreRobot: $oreForOreRobot, oreForClayRobot: $oreForClayRobot, oreForObsidianRobot: $oreForObsidianRobot, clayForObsidianRobot: $clayForObsidianRobot, oreForGeodeRobot: $oreForGeodeRobot, obsidianForGeodeRobot: $obsidianForGeodeRobot)";
  }
}

class State {
  final int minutes;
  final int ore;
  final int clay;
  final int obsidian;
  final int geodes;
  final int oreRobots;
  final int clayRobots;
  final int obsidianRobots;
  final int geodeRobots;

  State({
    required this.minutes,
    required this.ore,
    required this.clay,
    required this.obsidian,
    required this.geodes,
    required this.oreRobots,
    required this.clayRobots,
    required this.obsidianRobots,
    required this.geodeRobots,
  });

  factory State.init({int minutes = 24}) =>
      State(
          minutes: minutes,
          ore: 0,
          clay: 0,
          obsidian: 0,
          geodes: 0,
          oreRobots: 1,
          clayRobots: 0,
          obsidianRobots: 0,
          geodeRobots: 0);

  State copyWith({
    int? minutes,
    int? ore,
    int? clay,
    int? obsidian,
    int? geodes,
    int? oreRobots,
    int? clayRobots,
    int? obsidianRobots,
    int? geodeRobots,
  }) =>
      State(
          minutes: minutes ?? this.minutes,
          ore: ore ?? this.ore,
          clay: clay ?? this.clay,
          obsidian: obsidian ?? this.obsidian,
          geodes: geodes ?? this.geodes,
          oreRobots: oreRobots ?? this.oreRobots,
          clayRobots: clayRobots ?? this.clayRobots,
          obsidianRobots: obsidianRobots ?? this.obsidianRobots,
          geodeRobots: geodeRobots ?? this.geodeRobots);

  @override
  operator ==(Object other) =>
      other is State &&
          other.minutes == minutes &&
          other.ore == ore &&
          other.clay == clay &&
          other.obsidian == obsidian &&
          other.geodes == geodes &&
          other.oreRobots == oreRobots &&
          other.clayRobots == clayRobots &&
          other.obsidianRobots == obsidianRobots &&
          other.geodeRobots == geodeRobots;

  @override
  int get hashCode =>
      minutes.hashCode +
          ore.hashCode +
          clay.hashCode +
          obsidian.hashCode +
          geodes.hashCode +
          oreRobots.hashCode +
          clayRobots.hashCode +
          obsidianRobots.hashCode +
          geodeRobots.hashCode;

  @override
  String toString() {
    return "State(minutes: $minutes, ore: $ore, clay: $clay, obsidian: $obsidian, geodes: $geodes, oreRobots: $oreRobots, clayRobots: $clayRobots, obsidianRobots: $obsidianRobots, geodeRobots: $geodeRobots)";
  }

  State tick() =>
      copyWith(
        minutes: minutes - 1,
        ore: ore + oreRobots,
        clay: clay + clayRobots,
        obsidian: obsidian + obsidianRobots,
        geodes: geodes + geodeRobots,
      );

  bool objectivlyBetterThan(State other) =>
      other.minutes == minutes &&
          other.ore >= ore &&
          other.clay >= clay &&
          other.obsidian >= obsidian &&
          other.geodes >= geodes &&
          other.oreRobots >= oreRobots &&
          other.clayRobots >= clayRobots &&
          other.obsidianRobots >= obsidianRobots &&
          other.geodeRobots >= geodeRobots;
}
