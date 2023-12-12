import 'package:day11/day11.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....""";

  test('part-one', () {
    expect(shortestPathSums(testInput), 374);
  });

  test('part-two', () {
    expect(shortestPathSums(testInput, growFactor: 10), 1030);
    expect(shortestPathSums(testInput, growFactor: 100), 8410);
  });
}
