import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';

List<Wall> createBoundaries(Forge2DGame game) {
  /*final Vector2 topLeft = Vector2.zero();*/
  final Vector2 topLeft = Vector2(0,0);
  final Vector2 bottomRight = Vector2(200,-100);
  final Vector2 topRight = Vector2(bottomRight.x, topLeft.y);
  final Vector2 bottomLeft = Vector2(topLeft.x, bottomRight.y);

  print('bottomRight: ${bottomRight}');

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end) : super(paint: BasicPalette.white.paint());

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..friction = 0.3;

    final bodyDef = BodyDef()
      ..userData = this // To be able to determine object in collision
      ..position = Vector2.zero()
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
