import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'sprite.dart';
import 'boundaries.dart';

class MyGame extends Forge2DGame with MultiTouchDragDetector {
  late Avatar avatar;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sheet = SpriteSheet(
        image: await images.load('avatar.png'), srcSize: Vector2(224, 112));

    final _sprite = sheet.getSprite(0, 1);
    avatar = Avatar(Vector2(100, -25), Vector2(0, 0), _sprite);
    add(avatar);
    addAll(createBoundaries(this));
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    print('Update ${info.delta.game}');
    avatar.move(info.delta.game);
    return true;
  }

  // Use onDragEnd and onDragStart to block dragging. The objective is to only allow swipping the sprite around.
  @override
  void onDragEnd(int pointerId, DragEndInfo info) {
    print('End ${info.velocity}');
  }

  @override
  void onDragStart(int pointerId, DragStartInfo info) {
    print('Start ${info.eventPosition.game}');
  }
}
