import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';

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
