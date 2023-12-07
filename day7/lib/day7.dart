int winningSum(String input, {bool withJoker = false}) {
  List<(CardHand, int)> gameData = input.split("\n").map((e) {
    var splits = e.split(" ");
    return (CardHand(splits.first, withJoker: withJoker), int.parse(splits.last));
  }).toList();
  gameData.sort((a, b) => a.$1.compareTo(b.$1));
  int sum = 0;
  for (var MapEntry(key: i, value: (_, bet)) in gameData.asMap().entries) {
    sum += bet * (i + 1);
  }
  return sum;
}

class CardHand implements Comparable {
  List<String> cards;
  final Map<String, int> _groupedCards = {};
  final List<String> _cardValues = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"];
  final bool withJoker;

  CardHand(String cards, {this.withJoker = false}) : cards = cards.split("") {
    for (String card in this.cards) {
      _groupedCards.update(card, (val) => val + 1, ifAbsent: () => 1);
    }
    if (withJoker) {
      _cardValues.remove("J");
      _cardValues.insert(0, "J");
      if (_groupedCards.length > 1) {
        int jokers = _groupedCards.remove("J") ?? 0;
        if (_groupedCards.isNotEmpty) {
          List<MapEntry> cardGroup = _groupedCards.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
          _groupedCards.update(cardGroup.last.key, (value) => value + jokers);
        }
      }
    }
  }

  bool operator <(CardHand other) {
    if (type != other.type) return type < other.type;
    for (int i = 0; i < cards.length; i++) {
      if (cardValue(i) != other.cardValue(i)) {
        return cardValue(i) < other.cardValue(i);
      }
    }
    return false;
  }

  bool operator >(CardHand other) {
    if (type != other.type) return type > other.type;
    for (int i = 0; i < cards.length; i++) {
      if (cardValue(i) != other.cardValue(i)) {
        return cardValue(i) > other.cardValue(i);
      }
    }
    return false;
  }

  int cardValue(int cardIndex) => _cardValues.indexOf(cards[cardIndex]);

  @override
  bool operator ==(Object other) => other is CardHand && cards.join() == other.cards.join();

  @override
  int get hashCode => cards.hashCode;

  CardHandType get type {
    List<int> counts = _groupedCards.values.toList()..sort((a, b) => a.compareTo(b));
    if (counts.last == 5) {
      return CardHandType.fiveOfAKind;
    } else if (counts.last == 4) {
      return CardHandType.fourOfAKind;
    } else if (counts.last == 3 && counts.first == 2) {
      return CardHandType.fullHouse;
    } else if (counts.last == 3) {
      return CardHandType.threeOfAKind;
    } else if (counts.length == 3 && counts[2] == 2 && counts[1] == 2) {
      return CardHandType.twoPair;
    } else if (counts.last == 2) {
      return CardHandType.onePair;
    }
    return CardHandType.highCard;
  }

  @override
  int compareTo(other) => (this > other)
      ? 1
      : (this < other)
          ? -1
          : 0;
}

enum CardHandType {
  fiveOfAKind,
  fourOfAKind,
  fullHouse,
  threeOfAKind,
  twoPair,
  onePair,
  highCard;

  bool operator <(CardHandType other) => value() < other.value();
  bool operator >(CardHandType other) => value() > other.value();

  int value() {
    return [
      CardHandType.highCard,
      CardHandType.onePair,
      CardHandType.twoPair,
      CardHandType.threeOfAKind,
      CardHandType.fullHouse,
      CardHandType.fourOfAKind,
      CardHandType.fiveOfAKind
    ].indexOf(this);
  }
}
