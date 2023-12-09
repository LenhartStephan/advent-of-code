import 'package:day9/day9.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45""";

  test('part-one', () {
    expect(extrapolate([0, 3, 6, 9, 12, 15]), 18);
    expect(extrapolationSum(testInput), 114);
  });

  test('part-two', () {
    expect(extrapolationSum(testInput, reversed: true), 2);
  });
}
