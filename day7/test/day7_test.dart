import 'package:day7/day7.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483""";

  test('part-one', () {
    expect(CardHand("KK677") > CardHand("KTJJT"), true);
    expect(CardHand("T55J5") < CardHand("QQQJA"), true);
    expect(CardHand("KK677") > CardHand("32T3K"), true);
    expect(winningSum(testInput), 6440);
  });

  test('part-two', () {
    expect(CardHand("KK677", withJoker: true) < CardHand("KTJJT", withJoker: true), true);
    expect(CardHand("KK677", withJoker: true) < CardHand("JJJJJ", withJoker: true), true);
    expect(CardHand("JJJJJ", withJoker: true) < CardHand("KKKKK", withJoker: true), true);
    expect(winningSum(testInput, withJoker: true), 5905);
  });
}
