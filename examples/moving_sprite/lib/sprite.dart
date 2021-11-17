import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:forge2d/forge2d.dart';
import 'package:flame_forge2d/position_body_component.dart';

class Avatar extends PositionBodyComponent {
  final Vector2 _position;
  final Vector2 _angle;

  Avatar(this._position, this._angle, _size, SpriteAnimation animation)
  : super(SpriteAnimationComponent(size: _size, position: _position, animation: animation), _size);

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
      ..position = _position
      ..angle = (_angle.x + _angle.y) / 2 * 3.14
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  // Based on https://github.com/flame-engine/flame_forge2d/blob/main/example/lib/draggable_sample.dart#L37
  void push(Vector2 game) {
    final worldDelta = Vector2(1, -1)..multiply(game);
    body.applyLinearImpulse(worldDelta * 1000);
    print('Velocity: ${body.linearVelocity}');
  }

  void invertDirection() {
    print('At the start of invert: ${body.linearVelocity}');
    body.linearVelocity = body.linearVelocity.gr;
    print('At the end of invert: ${body.linearVelocity}');
  }
}
