int extrapolationSum(String input, {bool reversed = false}) {
  int sum = 0;
  for (String line in input.split("\n")) {
    List<int> values = line.split(" ").map((e) => int.parse(e)).toList();
    sum += extrapolate((reversed ? values.reversed : values).toList());
  }
  return sum;
}

int extrapolate(List<int> input) {
  if (input.every((e) => e == 0)) return 0;
  List<int> diffs = [];
  for (int i = 0; i < input.length - 1; i++) {
    diffs.add(input[i + 1] - input[i]);
  }
  return input.last + extrapolate(diffs);
}
