import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flame_forge2d/position_body_component.dart';

class Avatar extends PositionBodyComponent {
  final Vector2 _angle;
  final SpriteAnimation _running;
  final SpriteAnimationComponent _comp;

  Avatar(this._angle, _size, this._comp, this._running)
      : super(_comp, _size);

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    // TODO: Make a better fit with the body but it's alright for now
    final vertices = [
      Vector2(-size.x / 8, -size.y / 2), //bottom left
      Vector2(size.x / 8, -size.y / 2), //bottom right
      Vector2(size.x / 8, size.y / 8), //upper left
      Vector2(-size.x / 8, size.y / 8), //upper right
    ];
    shape.set(vertices);

    final fixtureDef = FixtureDef(shape)
      ..userData = this // To be able to determine object in collision
      ..restitution = 0.3
      ..density = 1.0
      ..friction = 0.2;

    final bodyDef = BodyDef()
      ..userData = this
      ..position = _comp.position
      ..angle = (_angle.x + _angle.y) / 2 * 3.14
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  // Based on https://github.com/flame-engine/flame_forge2d/blob/main/example/lib/draggable_sample.dart#L37
  void push(Vector2 game) {
    final worldDelta = Vector2(1, -1)..multiply(game);
    body.applyLinearImpulse(worldDelta * 1000);
    _comp.animation = _running;
  }

  void invertDirection() {
    body.linearVelocity = body.linearVelocity.gr;
  }
}
