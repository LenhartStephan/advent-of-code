import 'package:day15/day15.dart';
import 'package:test/test.dart';

void main() {
  String testInput1 = "HASH";
  String testInput2 = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7";

  test('part-one', () {
    expect(hashSum(testInput1), 52);
    expect(hashSum(testInput2), 1320);
  });

  test('part-two', () {
    expect(hashmapSum(testInput2), 145);
  });
}
