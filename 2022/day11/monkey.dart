class Monkey {
  int modulo;
  List<int> items;
  int inspection = 0;
  int Function(int old) updateWorry;
  int Function(int value) throwTarget;

  Monkey({required this.items,
    required this.updateWorry,
    required this.throwTarget,
    required this.modulo});

  @override
  String toString() {
    return "Monkey ($inspection): $items";
  }
}
