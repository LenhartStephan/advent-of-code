abstract class FilesystemEntry {
  FilesystemEntry({required this.name});

  factory FilesystemEntry.fromLogLine(String line) =>
      line.startsWith("dir")
          ? SantaFolder(name: line
          .split(" ")
          .last)
          : SantaFile(
          name: line
              .split(" ")
              .last, size: int.parse(line
          .split(" ")
          .first));
  String name;

  @override
  String toString() {
    return "FilesystemEntry($name)";
  }

  int size() => 0;
}

class SantaFile extends FilesystemEntry {
  int _size;

  SantaFile({required size, required super.name}) : _size = size;

  @override
  String toString() {
    return "File($name, $_size)";
  }

  @override
  int size() => _size;

  @override
  bool operator ==(Object other) =>
      other is SantaFile &&
          other.runtimeType == runtimeType &&
          other.name == name;
}

class SantaFolder extends FilesystemEntry {
  final Set<FilesystemEntry> _children = {};

  SantaFolder({required super.name});

  bool contains(FilesystemEntry entry) {
    for (FilesystemEntry item in _children) {
      if (item.name == entry.name &&
          ((item is SantaFile && entry is SantaFile) ||
              (item is SantaFolder && entry is SantaFolder))) return true;
    }
    return false;
  }

  void addChild(FilesystemEntry entry) {
    _children.add(entry);
  }

  addFromPath(String path, FilesystemEntry entry) {
    if (path.startsWith("/")) path = path.replaceFirst("/", "");
    List<String> pathSegments =
    path
        .trim()
        .isNotEmpty ? path.trim().split("/") : [];
    if (pathSegments.isNotEmpty) {
      String currentSegment = pathSegments.removeAt(0);
      String remainingPath =
      pathSegments.isNotEmpty ? pathSegments.join("/") : "";
      if (contains(SantaFolder(name: currentSegment))) {
        _children
            .whereType<SantaFolder>()
            .where((element) => element.name == currentSegment)
            .first
            .addFromPath(remainingPath, entry);
      } else {
        SantaFolder newFolder = SantaFolder(name: currentSegment);
        newFolder.addFromPath(remainingPath, entry);
        addChild(newFolder);
      }
    } else {
      _children.add(entry);
    }
  }

  Set<FilesystemEntry> getChildren() => _children;

  @override
  int size() {
    int size = 0;
    for (FilesystemEntry child in _children) {
      if (child is SantaFile) {
        size += child.size();
      } else if (child is SantaFolder) {
        size += child.size();
      }
    }
    return size;
  }

  String tree() {
    List<String> childTrees = [];
    for (FilesystemEntry entry in _children) {
      String child = ((entry is SantaFolder)
          ? entry.tree()
          : (entry is SantaFile)
          ? "- ${entry.name} (file, size=${entry.size()})"
          : entry.name);
      child = child.replaceAll("\n", "\n  ");
      childTrees.add(child);
    }

    String children =
    childTrees.isNotEmpty ? "\n   ${childTrees.join("\n   ")}" : "";
    return "- $name (dir, size=${size()})   $children";
  }

  @override
  String toString() {
    String children = "";
    for (var child in _children) {
      children = "$children $child";
    }
    children = children.replaceFirst(",", "");
    return "Folder(name: $name, [$children])";
  }

  @override
  bool operator ==(Object other) {
    return other is SantaFolder &&
        other.runtimeType == runtimeType &&
        other.name == name &&
        other.toString() == toString();
  }
}
