int hashSum(String input) {
  List<String> parts = input.split(",");
  int sum = 0;
  for (String part in parts) {
    sum += holidayAsciiStringHelper(part);
  }
  return sum;
}

int hashmapSum(String input) {
  List<String> parts = input.split(",");
  Map<int, List<Lens>> map = {};

  for (String part in parts) {
    map = holidayASCIIStringHelperManualArrangementProcedure(part, map);
  }
  int sum = 0;
  for (var MapEntry(key: boxNum, value: value) in map.entries) {
    if (value.isNotEmpty) {
      sum += value.indexed.map((e) {
        return ((boxNum + 1) * (e.$1 + 1) * e.$2.focalLength!).toInt();
      }).reduce((v, e) => v + e);
    }
  }
  return sum;
}

int holidayAsciiStringHelper(String input) =>
    [0, ...input.codeUnits].reduce((value, element) => ((value + element) * 17) % 256);

Map<int, List<Lens>> holidayASCIIStringHelperManualArrangementProcedure(String input, Map<int, List<Lens>> map) {
  List<String> parts = input.split(RegExp(r"-|="));
  Lens lens = Lens(parts.first, int.tryParse(parts.lastOrNull ?? ""));
  if (lens.focalLength != null) {
    map.update(lens.box, (value) {
      int lensIndex = value.indexWhere((e) => e.label == lens.label);
      lensIndex >= 0 ? value[lensIndex] = lens : value.add(lens);
      return value;
    }, ifAbsent: () => [lens]);
  } else {
    map.update(lens.box, (value) => value.where((e) => e.label != lens.label).toList(), ifAbsent: () => []);
  }
  return map;
}

class Lens {
  final String label;
  final int? focalLength;
  Lens(this.label, this.focalLength);
  int get box => holidayAsciiStringHelper(label);
  @override
  String toString() => "Lens($label, $focalLength)";
}
