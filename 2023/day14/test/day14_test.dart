import 'package:day14/day14.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....""";

  test('part-one', () {
    expect(getLoad(testInput), 136);
  });

  test('part-two', () {
    expect(getLoad(testInput, withCycles: true), 64);
  });
}
