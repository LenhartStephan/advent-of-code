import 'filesystem.dart';
import 'dart:io';

void main() async {
  String input = r"""$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
""";

  try {
    input = File("day07.input").readAsStringSync();
  } catch (e) {}

  SantaFolder folder = logToFolder(input);
  int part1 = folderSizes(folder);
  print("Part 1: $part1");
  int totalSpace = 70000000;
  int requiredSize = 30000000;
  int usedSpace = folder.size();
  int unusedSpace = totalSpace - usedSpace;
  int neededSpace = requiredSize - unusedSpace;
  SantaFolder? f2 = findSmallestDirGreaterThan(folder, neededSpace);
  print("Part 2: ${f2!.size()}");
}

bool isCommand(String line) => line.startsWith("\$ ");

bool isAbsolutePath(String path) => path.startsWith("/");

bool isMoveUp(String path) => path.startsWith("..");

SantaFolder logToFolder(String log) {
  List<String> logList = log.split("\n");
  String currentDir = "/";
  SantaFolder root = SantaFolder(name: "/");
  for (String line in logList) {
    if (line
        .trim()
        .isNotEmpty) {
      if (isCommand(line)) {
        currentDir = dirFromCommand(line, currentDir: currentDir);
      } else {
        root.addFromPath(currentDir, FilesystemEntry.fromLogLine(line));
      }
    }
  }

  return root;
}

int folderSizes(SantaFolder folder, {int threshold = 100000}) {
  Set<FilesystemEntry> set = folder.getChildren();
  int sizes = 0;
  for (var item in set) {
    if (item is SantaFolder) {
      int size = item.size();
      if (size <= threshold) sizes += size;
      sizes += folderSizes(item, threshold: threshold);
    }
  }
  return sizes;
}

SantaFolder? findSmallestDirGreaterThan(SantaFolder folder, int requiredSpace) {
  SantaFolder smallestFit = folder;
  int smallestSize = folder.size();

  for (FilesystemEntry entry in folder.getChildren()) {
    if (entry is SantaFolder) {
      int entrySize = entry.size();
      if (entrySize > requiredSpace) {
        if (entrySize < smallestSize) {
          smallestFit = entry;
          smallestSize = entrySize;
        }
        SantaFolder? child = findSmallestDirGreaterThan(entry, requiredSpace);
        int childSize = child?.size() ?? 0;
        if (child != null && childSize < smallestSize) {
          smallestFit = child;
          smallestSize = childSize;
        }
      }
    }
  }

  return (smallestSize > requiredSpace) ? smallestFit : null;
}

List getFoldersGreaterThan(SantaFolder folder, int greaterThan) {
  Set set = folder.getChildren();
  List l = [];
  for (var item in set) {
    if (item.size() > greaterThan && item is SantaFolder) l.add(item);
  }
  return l;
}

String dirFromCommand(String line, {String currentDir = "/"}) {
  if (isCommand(line)) {
    List<String> splits = line.replaceFirst("\$ ", "").split(" ");
    switch (splits.first) {
      case "cd":
        return changeDir(currentPath: currentDir, changeTo: splits.last);
      case "ls":
        return currentDir;
    }
  }
  throw Exception("Line was not a a valid command.");
}

String changeDir({required String currentPath, required changeTo}) {
  if (isAbsolutePath(changeTo)) {
    return changeTo;
  } else if (isMoveUp(changeTo)) {
    if (!currentPath.endsWith("/")) throw Exception("Invalid path notation!");
    currentPath = currentPath.replaceFirst("/", "", (currentPath.length - 1));

    List<String> pathSegments = currentPath.split("/");
    pathSegments.removeLast();
    return "${pathSegments.join("/")}/";
  } else {
    return "$currentPath$changeTo/";
  }
}
