import 'dart:math';
import 'dart:io';

void main() async {
  String input = """1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
""";

  try {
    input = File("day25.input").readAsStringSync();
  } catch (e) {}

  int answer1 = snafuSum(toList(input));
  print("Part 1: ${numToSnafu(answer1)} ($answer1 in decimal)");
}

List<String> toList(String input) {
  List<String> list = input.split("\n");
  if (list.last
      .trim()
      .isEmpty) list.removeLast();
  return list;
}

int snafuCharValue(String snafuChar) =>
    ["=", "-", "0", "1", "2"].indexOf(snafuChar) - 2;

String toSnafuChar(int num) => ["0", "1", "2", "=", "-"].elementAt(num);

int snafuToNum(String snafu) {
  int num = 0;
  List<String> charList = snafu
      .split("")
      .reversed
      .toList();
  for (int i = 0; i < charList.length; i++) {
    num += (pow(5, i) * snafuCharValue(charList[i])).toInt();
  }
  return num;
}

String numToSnafu(int num) {
  String snafu = "";
  while (num > 0) {
    int mod = num % 5;
    snafu = toSnafuChar(mod) + snafu;
    num ~/= 5;
    if (mod > 2) {
      num++;
    }
  }
  return snafu;
}

snafuSum(List<String> snafuList) {
  int sum = 0;
  for (var snafu in snafuList) {
    sum += snafuToNum(snafu);
  }
  return sum;
}
