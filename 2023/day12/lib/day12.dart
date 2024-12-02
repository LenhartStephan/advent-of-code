int combinationSum(String input, {bool folded = false}) {
  List<(List<String>, List<int>)> data = input.split("\n").map((e) {
    var parts = e.split(" ");
    return (parts.first.split(""), parts.last.split(",").map((e) => int.parse(e)).toList());
  }).toList();
  int sum = 0;
  for (var (springs, mapping) in data) {
    List<String> s = springs;
    List<int> m = mapping;
    for (int i = 0; i < (folded ? 4 : 0); i++) {
      s += ["?"] + springs;
      m += mapping;
    }
    sum += combinations(s, m);
  }
  return sum;
}

Map<String, int> memory = {};

int combinations(List<String> springs, List<int> blockConfig) {
  if (springs.isEmpty) return blockConfig.isEmpty ? 1 : 0;
  if (blockConfig.isEmpty && springs.isNotEmpty) return springs.contains("#") ? 0 : 1;
  String key = "${springs.join()} ${blockConfig.join(",")}";
  if (memory.containsKey(key)) return memory[key]!;

  int sum = 0;
  List<String> nextBlock = (("#" * blockConfig.first) + (blockConfig.length > 1 ? "." : "")).split("").toList();
  for (var i = 0; i <= springs.length - nextBlock.length; i++) {
    var list = springs.sublist(i, i + nextBlock.length);
    if (blockFitsInList(nextBlock, list)) {
      sum += combinations(springs.sublist(i + nextBlock.length), blockConfig.sublist(1));
    }
    if (springs[i] == "#") break;
  }
  memory[key] = sum;
  return sum;
}

bool blockFitsInList(List<String> block, List<String> list) {
  for (var (index, _) in block.indexed) {
    if (!(list[index] == '?' || list[index] == block[index])) return false;
  }
  return true;
}
