import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/sprite_body_component.dart';
import 'package:forge2d/forge2d.dart';

class Avatar extends SpriteBodyComponent {
  final Vector2 _position;
  final Vector2 _angle;

  Avatar(this._position, this._angle, Sprite sprite)
      : super(sprite, Vector2(66, 33));

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();

    final vertices = [
      Vector2(-size.x / 2, -size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(0, size.y / 2),
    ];
    shape.set(vertices);

    final fixtureDef = FixtureDef(shape)
      ..userData = this // To be able to determine object in collision
      ..restitution = 0.3
      ..density = 1.0
      ..friction = 0.2;

    final bodyDef = BodyDef()
      ..position = _position
      ..angle = (_angle.x + _angle.y) / 2 * 3.14
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  // Based on https://github.com/flame-engine/flame_forge2d/blob/main/example/lib/draggable_sample.dart#L37
  void move(Vector2 game) {
    final worldDelta = Vector2(1, -1)..multiply(game);
    body.applyLinearImpulse(worldDelta * 1000);
    print('Velocity: ${body.linearVelocity}');
  }
}
