import 'package:day10/day10.dart';
import 'package:test/test.dart';

void main() {
  String testInput1 = """.....
.S-7.
.|.|.
.L-J.
.....""";

  String testInput2 = """..F7.
.FJ|.
SJ.L7
|F--J
LJ...""";

  String testInput3 = """...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........""";

  String testInput4 = """FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L""";

  test('part-one', () {
    expect(longestPathSteps(testInput1), 4);
    expect(longestPathSteps(testInput2), 8);
  });

  test('part-two', () {
    expect(enclosedTiles(testInput3), 4);
    expect(enclosedTiles(testInput4), 10);
  });
}
