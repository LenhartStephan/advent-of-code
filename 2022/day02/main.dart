import 'dart:io';

void main() async {
  String input = """A Y
B X
C Z""";

  try {
    input = File("day02.input").readAsStringSync();
  } catch (e) {}

  List<String> list = input.split("\n");
  int score1 = 0;
  int score2 = 0;
  for (String round in list) {
    round = round.trim();
    if (round
        .trim()
        .isNotEmpty) {
      score1 += getRoundScore1(round);
      score2 += getRoundScore2(round);
    }
  }
  print("Part 1: $score1");
  print("Part 2: $score2");
}

int getRoundScore1(String round) {
  Rps opponent = rpsFromString(round.substring(0, 1));
  Rps own = rpsFromString(round.substring(2, 3));

  RoundResult result = own.against(opponent);

  return result.value + own.value;
}

int getRoundScore2(String round) {
  Rps opponent = rpsFromString(round.substring(0, 1));
  RoundResult result = roundResultFromString(round.substring(2, 3));

  Rps own = getOwnFromRoundResultOpponent(opponent: opponent, result: result);

  return result.value + own.value;
}

Rps getOwnFromRoundResultOpponent({
  required Rps opponent,
  required RoundResult result,
}) {
  if (result == RoundResult.draw) return opponent;
  switch (opponent) {
    case Rps.rock:
      return result == RoundResult.win ? Rps.paper : Rps.scissor;
    case Rps.paper:
      return result == RoundResult.win ? Rps.scissor : Rps.rock;
    case Rps.scissor:
      return result == RoundResult.win ? Rps.rock : Rps.paper;
  }
}

Rps rpsFromString(String shape) {
  switch (shape) {
    case "A":
    case "X":
      return Rps.rock;
    case "B":
    case "Y":
      return Rps.paper;
    case "C":
    case "Z":
      return Rps.scissor;
    default:
      throw Exception("Invalid string input. Cannot convert $shape to RPS.");
  }
}

RoundResult roundResultFromString(String round) {
  switch (round) {
    case "X":
      return RoundResult.loose;
    case "Y":
      return RoundResult.draw;
    case "Z":
      return RoundResult.win;
    default:
      throw Exception(
        "Invalid string input. Coannot convert $round to RoundResult.",
      );
  }
}

enum Rps { rock, paper, scissor }

extension RpsValues on Rps {
  int get value {
    switch (this) {
      case Rps.rock:
        return 1;
      case Rps.paper:
        return 2;
      case Rps.scissor:
        return 3;
    }
  }

  RoundResult against(Rps opponent) {
    if (this == opponent) {
      return RoundResult.draw;
    }
    switch (this) {
      case Rps.rock:
        if (opponent == Rps.scissor) return RoundResult.win;
        break;
      case Rps.paper:
        if (opponent == Rps.rock) return RoundResult.win;
        break;
      case Rps.scissor:
        if (opponent == Rps.paper) return RoundResult.win;
        break;
    }
    return RoundResult.loose;
  }
}

enum RoundResult { win, draw, loose }

extension RoundResultValue on RoundResult {
  int get value {
    switch (this) {
      case RoundResult.win:
        return 6;
      case RoundResult.draw:
        return 3;
      case RoundResult.loose:
        return 0;
    }
  }
}
