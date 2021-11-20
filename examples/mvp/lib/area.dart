import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flame_forge2d/body_component.dart';

class Area extends BodyComponent {
  bool forDestruction = false;
  final Vector2 _position;
  final double radius;
  final Paint _blue = BasicPalette.blue.paint();

  Area(this._position, {this.radius = 20}) {
    paint = _blue;
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.4;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..angularDamping = 0.8
      ..position = _position
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  Vector2 position() {
    return _position;
  }
}
