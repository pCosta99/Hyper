import 'package:flame/game.dart';
import 'dart:ui';
import 'wall.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';

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

List<Wall> createBoundaries(Forge2DGame game) {
  final Vector2 topLeft = Vector2.zero();
  final Vector2 bottomRight = game.size;
  bottomRight.multiply(Vector2(1,-1)); // This is needed because for some reason I need to use y negative in here (no clue?)
  final Vector2 topRight = Vector2(bottomRight.x, topLeft.y);
  final Vector2 bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}
