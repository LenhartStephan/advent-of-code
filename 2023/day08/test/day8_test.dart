import 'package:day8/day8.dart';
import 'package:test/test.dart';

void main() {
  String testInput1 = """RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)""";

  String testInput2 = """LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)""";

  String testInput3 = """LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)""";

  test('part-one', () {
    expect(minSteps(testInput1), 2);
    expect(minSteps(testInput2), 6);
  });

  test('part-two', () {
    expect(minSteps(testInput3, asGhost: true), 6);
  });
}
