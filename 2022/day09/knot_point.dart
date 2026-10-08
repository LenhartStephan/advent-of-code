import 'dart:math';

class KnotPoint extends Point<int> {
  KnotPoint(super.x, super.y);

  factory KnotPoint.from(Point<int> point) => KnotPoint(point.x, point.y);

  /// Returns whether both points are direct or diagonal neighbors to each other
  isAdjacent(Point<int> other) =>
      distanceTo(other) == 1 || distanceTo(other) == sqrt(2);

  /// Returns true, if both points have the same x and y coordinates
  isOverlapping(Point other) => other == this;

  // Returns whether both points are direct or diagonal neighbors or overlapping
  isTouching(Point<int> other) => isAdjacent(other) || isOverlapping(other);
}
