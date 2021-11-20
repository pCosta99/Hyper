import 'package:flame/game.dart';

Vector2 getCenter(Vector2 size) {
  var center = size.clone();
  center.multiply(Vector2(0.5, -0.5));
  return center;
}
