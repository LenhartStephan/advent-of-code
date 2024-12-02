import 'dart:math';

int findLowestLocationNumber(String input, {bool withSeedRange = false}) {
  List<String> parts = input.replaceAll(RegExp(r"\n.+-to-.+map:"), "").split("\n\n");
  List<(int, int)> seeds =
      parts.removeAt(0).replaceAll("seeds: ", "").split(" ").map((e) => (int.parse(e), int.parse(e))).toList();

  if (withSeedRange) {
    List<(int, int)> newSeeds = [];
    for (int i = 0; i < seeds.length; i += 2) {
      newSeeds.add((seeds[i].$1, seeds[i].$1 + seeds[i + 1].$1 - 1));
    }
    seeds = newSeeds;
  }

  final List<List<(int, int, int)>> mapping = parts
      .map((e) => e.split("\n").map((e) {
            List<int> list = e.split(" ").map((e) => int.parse(e)).toList();
            return (list[0], list[1], list[2]);
          }).toList())
      .toList();

  int? minLocation;
  for (var seedRange in seeds) {
    int location = applyMapping(seedRange, List.from(mapping));
    if (minLocation == null || location < minLocation) {
      minLocation = location;
    }
  }

  return minLocation ?? -1;
}

(int, int)? findOverlap((int, int) range1, (int, int) range2) {
  var (int start1, int end1) = range1;
  var (int start2, int end2) = range2;

  if (end1 >= start2 && end2 >= start1) {
    return (max(start1, start2), min(end1, end2));
  }
  return null;
}

int applyMapping((int, int) seedRange, List<List<(int, int, int)>> mappingList) {
  var (int seedStart, int seedEnd) = seedRange;
  List<int> resultList = [];

  while (mappingList.isNotEmpty) {
    var mappings = mappingList.removeAt(0);

    for (var (destination, source, length) in mappings) {
      var overlap = findOverlap((seedStart, seedEnd), (source, source + length - 1));

      if (overlap != null) {
        int overlapStart = overlap.$1;
        int overlapEnd = overlap.$2;
        int frontOffset = overlap.$1 - seedStart;
        int endOffset = seedEnd - overlap.$2;

        if (frontOffset > 0) {
          resultList.add(applyMapping((seedStart, seedStart + frontOffset - 1), [mappings, ...List.from(mappingList)]));
        }
        if (endOffset > 0) {
          resultList.add(
              applyMapping((overlapEnd + 1, overlapEnd + 1 + endOffset - 1), [mappings, ...List.from(mappingList)]));
        }

        seedEnd = destination + (overlapEnd - overlapStart) + (seedStart - source);
        seedStart = destination + frontOffset + (seedStart - source);
        break;
      }
    }
  }

  resultList.add(seedStart);
  resultList.sort((a, b) => a.compareTo(b));
  return resultList.first;
}
