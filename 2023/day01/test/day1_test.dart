import 'package:day1/day1.dart';
import 'package:test/test.dart';

void main() {
  String testinput1 = """1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet""";
  List<String> lines1 = testinput1.split("\n");

  test('part-one', () {
    expect(valueFromLine(lines1[0]), 12);
    expect(valueFromLine(lines1[1]), 38);
    expect(valueFromLine(lines1[2]), 15);
    expect(valueFromLine(lines1[3]), 77);
    expect(calibrationSum(testinput1), 142);
  });

  String testinput2 = """two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen""";
  List<String> lines2 = testinput2.split("\n");

  test('part-two', () {
    expect(valueFromSpelledLine(lines2[0]), 29);
    expect(valueFromSpelledLine(lines2[1]), 83);
    expect(valueFromSpelledLine(lines2[2]), 13);
    expect(valueFromSpelledLine(lines2[3]), 24);
    expect(valueFromSpelledLine(lines2[4]), 42);
    expect(valueFromSpelledLine(lines2[5]), 14);
    expect(valueFromSpelledLine(lines2[6]), 76);
    expect(calibrationSum(testinput2, withSpelledDigits: true), 281);
  });

  test('manual', () {
    expect(valueFromSpelledLine("4one8twoxmvzfjzbqoneightcx"), 48);
    expect(valueFromSpelledLine("jtk2vfsqsdhcpq9eightwojsc"), 22);
  });
}
