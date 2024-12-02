import 'package:day3/day3.dart';
import 'package:test/test.dart';

void main() {
  String testInput = r"""467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..""";

  test('part-one', () {
    expect(partNumberSum(testInput), 4361);
  });

  test('part-two', () {
    //gearRatioSum(testInput);
    expect(partNumberSum(testInput, forGearRatio: true), 467835);
  });
}
