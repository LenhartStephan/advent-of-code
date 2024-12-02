import 'package:day12/day12.dart';
import 'package:test/test.dart';

void main() {
  String testInput = """???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1""";

  test('part-one', () {
    expect(combinationSum(testInput), 21);
  });

  test('part-two', () {
    expect(combinationSum(testInput, folded: true), 525152);
  });
}
