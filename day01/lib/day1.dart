/// Returns the number from the combination of the first and last digits of a single line of text.
int valueFromLine(String input) {
  if (input.isEmpty) return 0;
  input = input.replaceAll(RegExp(r'[^1-9]'), "");
  Iterable<int> numbers = input.split("").map((e) => int.parse(e));
  return numbers.first * 10 + numbers.last;
}

/// Returns the number from the combination of the first and last digits of a single line of text.
/// Digits written as words are also considered.
int valueFromSpelledLine(String input) {
  List<String> wordList = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
  for (var MapEntry(key: index, value: word) in wordList.asMap().entries) {
    input = input.replaceAll(word, "$word${index + 1}$word");
  }
  return valueFromLine(input);
}

/// Returns the sum of adding [valueFromLine] of each line from [input].
/// If [withSpelledDigits] is set, the first and last number word will be replaced by its corresponding value
int calibrationSum(String input, {bool withSpelledDigits = false}) {
  int output = 0;
  input.split("\n").forEach((element) {
    if (element.isNotEmpty) output += withSpelledDigits ? valueFromSpelledLine(element) : valueFromLine(element);
  });
  return output;
}
