import 'package:flame/game.dart';
import 'dart:ui';

Vector2 getCenter(Vector2 size) {
  var center = size.clone();
  center.multiply(Vector2(0.5, -0.5));
  return center;
}

Rect cameraMaxRect(worldSize) {
  // Very very odd, but works, the width/height can't exactly match the world size
  final rect = Rect.fromLTWH(0, 0, worldSize.x + 0.1, worldSize.y + 0.1);

  return rect;
}
