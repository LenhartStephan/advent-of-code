import "dart:math" as math;

int cardValue(String input, {bool withCardMultiplier = false}) {
  List<String> lines = input.replaceAll(RegExp(r"Card +\d+: "), "").replaceAll(RegExp(r"  +"), " ").split("\n");
  int value = 0;
  int maxCardNumber = 0;
  Map<int, int> multiplier = {};
  for (var MapEntry(key: cardNumber, value: line) in lines.asMap().entries) {
    Set<int> winningNumbers = {};
    Set<int> drawnNumbers = {};

    List<String> parts = line.trim().split(" | ");
    winningNumbers = parts.first.split(" ").map((e) => int.parse(e)).toSet();
    drawnNumbers = parts.last.split(" ").map((e) => int.parse(e)).toSet();
    int winningCards = winningNumbers.intersection(drawnNumbers).length;
    maxCardNumber = cardNumber;
    if (withCardMultiplier) {
      multiplier.putIfAbsent(cardNumber, () => 1);
      for (int i = 1; i < (winningCards + 1); i++) {
        multiplier[cardNumber + i] = (multiplier[cardNumber + i] ?? 1) + 1 * (multiplier[cardNumber] ?? 1);
      }
    } else {
      if (winningCards > 0) value += math.pow(2, winningCards - 1).toInt();
    }
  }
  if (withCardMultiplier) value = multiplier.values.take(maxCardNumber + 1).reduce((v, e) => v + e);

  return value;
}
