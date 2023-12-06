import 'package:day6/day6.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """Time:      7  15   30
Distance:  9  40  200""";

  test('part-one', () {
    expect(calculate(testInput), 288);
  });

  test('part-two', () {
    expect(calculate(testInput, badKerning: true), 71503);
  });
}
