import 'dart:io';
import 'dart:convert';

void main() async {
  String input = """[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
""";

  try {
    input = File("day13.input").readAsStringSync();
  } catch (e) {}

  int part1 = orderIndicesSum(input);
  print("Part 1: $part1");

  int part2 = getDecoderKey(input);
  print("Part 2: $part2");
}

List getSignalData(String input) {
  List<String> splits = input.split("\n\n");
  List list = [];
  for (String split in splits) {
    List<String> s = split.split("\n");
    dynamic first = toPacket(s[0]);
    dynamic second = toPacket(s[1]);
    list.addAll([first, second]);
  }
  return list;
}

int orderIndicesSum(String input) {
  List data = getSignalData(input);
  int sum = 0;
  for (int i = 0; i < data.length; i += 2) {
    if (packetsRightOrder(left: data[i], right: data[i + 1])) {
      (sum += (i / 2).floor() + 1);
    }
  }
  return sum;
}

int getDecoderKey(String input) {
  List data = getSignalData(input);
  var divider1 = [
    [2]
  ];
  var divider2 = [
    [6]
  ];
  data.addAll([divider1, divider2]);
  bool changed = false;
  do {
    changed = false;
    for (int i = 0; i < data.length - 1; i++) {
      if (!packetsRightOrder(left: data[i], right: data[i + 1])) {
        var temp = data[i];
        data[i] = data[i + 1];
        data[i + 1] = temp;
        changed = true;
      }
    }
  } while (changed);
  int index1 = data.indexOf(divider1) + 1;
  int index2 = data.indexOf(divider2) + 1;
  return index1 * index2;
}

dynamic toPacket(String input) => jsonDecode(input);

bool packetsRightOrder({required dynamic left, required dynamic right}) =>
    _packetsRightOrder(left: left, right: right) == PacketOrder.right;

PacketOrder _packetsRightOrder({required dynamic left, required dynamic right}) {
  if (left is int && right is int) {
    return (left < right)
        ? PacketOrder.right
        : (left > right)
        ? PacketOrder.wrong
        : PacketOrder.checkNext;
  } else if (left is List && right is List) {
    if (left.isNotEmpty && right.isNotEmpty) {
      PacketOrder order =
      _packetsRightOrder(left: left.first, right: right.first);
      return (order == PacketOrder.checkNext)
          ? _packetsRightOrder(
          left: List.from(left.getRange(1, left.length)),
          right: List.from(right.getRange(1, right.length)))
          : order;
    } else {
      return (left.length < right.length)
          ? PacketOrder.right
          : (left.length > right.length)
          ? PacketOrder.wrong
          : PacketOrder.checkNext;
    }
  } else {
    if (left is int) {
      return _packetsRightOrder(left: [left], right: right);
    } else if (right is int) {
      return _packetsRightOrder(left: left, right: [right]);
    }
  }
  throw Exception(
      "Unknown Error while reading packets (left: $left, right: $right");
}

enum PacketOrder { right, wrong, checkNext }
