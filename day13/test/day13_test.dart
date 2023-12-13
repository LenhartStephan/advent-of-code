import 'package:day13/day13.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#""";

  test('part-one', () {
    expect(reflectionSum(testInput), 405);
  });

  test('part-two', () {
    expect(reflectionSum(testInput, errorTolerance: 1), 400);
  });
}
