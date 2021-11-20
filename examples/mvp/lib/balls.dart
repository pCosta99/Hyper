import 'package:flame/palette.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flutter/material.dart';
import 'package:forge2d/forge2d.dart';

import 'wall.dart';
import 'avatar.dart';

class Ball extends BodyComponent {
  late Paint originalPaint;
  bool giveNudge = false;
  final double radius;
  final Vector2 _position;
  double _timeSinceNudge = 0.0;
  static const double _minNudgeRest = 2.0;

  final Paint _blue = BasicPalette.blue.paint();

  Ball(this._position, {this.radius = 2}) {
    originalPaint = _blue;
    paint = originalPaint;
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

  @override
  void renderCircle(Canvas c, Offset center, double radius) {
    super.renderCircle(c, center, radius);
    final lineRotation = Offset(0, radius);
    c.drawLine(center, center + lineRotation, _blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceNudge += dt;
    if (giveNudge) {
      giveNudge = false;
      if (_timeSinceNudge > _minNudgeRest) {
        body.applyLinearImpulse(Vector2(0, 1000));
        _timeSinceNudge = 0.0;
      }
    }
  }
}

void func(wall, ball) {
  wall.paint = ball.paint;
  print('got here');
}

void func2(ball, avatar) {
  avatar.paint = ball.paint;
  print('got here yuppp');
}

class BallWallContactCallback extends ContactCallback<Ball, Wall> {
  @override
  void begin(Ball ball, Wall wall, Contact contact) {
    func(wall, ball);
  }

  @override
  void end(Ball ball, Wall wall, Contact contact) {}
}

class BallAvatarContactCallback extends ContactCallback<Ball, Avatar> {
  @override
  void begin(Ball ball, Avatar avatar, Contact contact) {
    func2(ball, avatar);
  }

  @override
  void end(Ball ball, Avatar avatar, Contact contact) {}
}
